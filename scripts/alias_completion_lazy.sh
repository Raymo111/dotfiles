#!/usr/bin/env bash
# shellcheck disable=all
# Lazy alias completion: instead of building completions for every alias at
# shell startup (slow, ~450ms), install a default-completion (-D) hook that
# builds the completion for a single alias the first time you TAB it, then
# returns 124 so readline retries and completes immediately.
#
# Derived from https://superuser.com/a/437508/906542 (eager version), split so
# the per-alias work runs on demand.

# Build completion for one alias ($1). Returns 0 if a completion was installed
# (caller should return 124 to retry), 1 otherwise.
_alias_completion_one() {
    local namespace="alias_completion"
    local alias_name=$1
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # Parse just this alias into: name 'cmd' 'args' (no need to scan all aliases)
    local parsed
    parsed=$(alias "$alias_name" 2>/dev/null | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    [[ -n $parsed ]] || return 1

    local alias_tokens
    eval "alias_tokens=($parsed)" 2>/dev/null || return 1
    local alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

    # skip aliases to pipes / control structures / metacharacters
    local alias_arg_words
    eval "alias_arg_words=($alias_args)" 2>/dev/null || return 1
    read -a alias_arg_words <<< "$alias_args"

    # Ensure the target command has a completion registered; if not, force the
    # bash-completion dynamic loader to load it (it returns 124 on success).
    if ! complete -p "$alias_cmd" &>/dev/null; then
        _comp_complete_load "$alias_cmd" &>/dev/null
        complete -p "$alias_cmd" &>/dev/null || return 1
    fi

    local new_completion; new_completion="$(complete -p "$alias_cmd")"

    # Wrap to inject the alias's fixed arguments, if any.
    if [[ -n $alias_args ]]; then
        local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
        if [[ "${compl_func#_$namespace::}" == "$compl_func" ]]; then
            local compl_wrapper="_${namespace}::${alias_name}"
            eval "function $compl_wrapper {
                (( COMP_CWORD += ${#alias_arg_words[@]} ))
                COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                (( COMP_POINT -= \${#COMP_LINE} ))
                COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                (( COMP_POINT += \${#COMP_LINE} ))
                $compl_func
            }"
            new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
        fi
    fi

    # Retarget the completion at the alias name and register it.
    new_completion="${new_completion% *} $alias_name"
    eval "$new_completion" 2>/dev/null || return 1
    return 0
}

# Default (-D) completion handler: try alias-completion first, else fall back to
# bash-completion's normal dynamic loader.
_alias_completion_lazy_load() {
    local cmd=${1:-${COMP_WORDS[0]}}
    if alias "$cmd" &>/dev/null; then
        if _alias_completion_one "$cmd"; then
            return 124   # completion installed -> tell readline to retry
        fi
    fi
    # not an alias (or setup failed): defer to bash-completion's loader
    if declare -F _comp_complete_load &>/dev/null; then
        _comp_complete_load "$@"
    elif declare -F _completion_loader &>/dev/null; then
        _completion_loader "$@"
    else
        return 1
    fi
}

# Install our handler as the default, only if bash-completion is present.
if declare -F _comp_complete_load &>/dev/null || declare -F _completion_loader &>/dev/null; then
    complete -D -F _alias_completion_lazy_load
fi

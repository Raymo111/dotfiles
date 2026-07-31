#!/usr/bin/env bash
# Hard-links every tracked dotfile into $HOME.
#
#   ./install.sh            install (default): link files, backing up anything
#                           already there to ~/.dotfiles_backup/<timestamp>/
#   ./install.sh relink     re-establish links a pull/rebase severed (used by the
#                           git hooks); backs up any differing $HOME file first
#   ./install.sh reset      undo an install: remove the links we created and
#                           restore the most recent backup
#   ./install.sh --help     this help
set -euo pipefail

cd "$(dirname "$0")"   # cd to the repo root so relative paths work no matter where we're called from
REPO=$PWD

MODE=install
case ${1:-} in
	""|install)                 MODE=install ;;
	relink)                     MODE=relink ;;
	reset|--reset|uninstall)    MODE=reset ;;
	-h|--help|help)             sed -n '2,11p' "$0" | sed 's/^# \?//'; exit 0 ;;
	*) echo "unknown argument: $1 (try --help)" >&2; exit 1 ;;
esac

TS=$(date +%Y%m%d-%H%M%S)
BACKUPDIR=$HOME/.dotfiles_backup/$TS
backed_up=0

# --- manifest: run a callback over every (repo-source, $HOME-dest) pair we
#     manage. Shared by install and reset so the two can never drift. ---
for_each_target() {   # $1 = callback fn name, called as: cb <repo-rel-src> <abs-dst>
	local cb=$1 f
	# Every tracked file except repo meta and the specially-handled .aliases dir
	while IFS= read -r -d '' f; do   # -d '' pairs with `git ls-files -z` for spaces/newlines in paths
		case $f in
			.aliases/*|.githooks/*|install.sh|clone-and-install.sh|LICENSE|README.md|.gitignore|.gitattributes)
				continue ;;
		esac
		"$cb" "$f" "$HOME/$f"
	done < <(git ls-files -z)
	# aliases: bash everywhere; one OS-specific "distro" file; graphical on X11
	"$cb" .aliases/bash "$HOME/.aliases/bash"
	if [ -f /etc/arch-release ]; then                       "$cb" .aliases/arch   "$HOME/.aliases/distro"
	elif command -v termux-setup-storage &>/dev/null; then  "$cb" .aliases/termux "$HOME/.aliases/distro"
	elif [[ ${OSTYPE:-} == darwin* ]]; then                 "$cb" .aliases/mac    "$HOME/.aliases/distro"
	fi
	[[ ${XDG_SESSION_TYPE:-} == x11 ]] && "$cb" .aliases/graphical "$HOME/.aliases/graphical"
	return 0
}

# --- install callbacks ---
backup() {  # $1 = absolute path under $HOME to preserve
	local rel=${1#"$HOME"/}                # path relative to $HOME, to mirror inside the backup dir
	mkdir -p "$BACKUPDIR/$(dirname "$rel")"
	mv "$1" "$BACKUPDIR/$rel"
	backed_up=1
}

link() {  # $1 = repo-relative source, $2 = absolute dest
	local src=$REPO/$1 dst=$2
	[ -e "$src" ] || return 0
	[ -e "$dst" ] && [ "$dst" -ef "$src" ] && return 0   # -ef: same inode already, nothing to do
	[ -e "$dst" ] && backup "$dst"                        # something else is there; preserve it first
	mkdir -p "$(dirname "$dst")"
	ln -f "$src" "$dst"                                   # hard link, so edits on either side stay in sync
	echo "  linked   ~/${dst#"$HOME"/}"
}

# --- relink callback (used by the git hooks after a pull/rebase) ---
# True when the $HOME copy ($2) is just the pre-pull committed version of repo
# path ($1) — i.e. stale but recoverable from git, so no backup is needed. Any
# uncertainty (no ORIG_HEAD, path unknown there) returns false => we back up.
recoverable_from_git() {
	local rel=$1 dst=$2 have want
	have=$(git hash-object "$dst" 2>/dev/null) || return 1
	want=$(git rev-parse -q --verify "ORIG_HEAD:$rel" 2>/dev/null) || return 1
	[ "$have" = "$want" ]
}

relink_target() {  # $1 = repo-relative source, $2 = absolute dest
	local src=$REPO/$1 dst=$2
	[ -e "$src" ] || return 0
	[ "$dst" -ef "$src" ] && return 0                          # link still intact, nothing to do
	if [ -e "$dst" ] && ! diff -q "$src" "$dst" >/dev/null 2>&1 && ! recoverable_from_git "$1" "$dst"; then
		backup "$dst"                                          # genuine local divergence -> preserve before adopting repo's
		echo "  relinked ~/${dst#"$HOME"/} (\$HOME had local changes, backed up)"
	else
		echo "  relinked ~/${dst#"$HOME"/}"
	fi
	mkdir -p "$(dirname "$dst")"
	ln -f "$src" "$dst"
}

# --- reset callback ---
unlink_target() {  # $1 = repo-relative source, $2 = absolute dest
	local src=$REPO/$1 dst=$2
	if [ -e "$dst" ] && [ "$dst" -ef "$src" ]; then      # only remove files that ARE our hard links
		rm -f "$dst"
		echo "  removed  ~/${dst#"$HOME"/}"
	fi
}

latest_backup() {   # print path of the most recent backup dir, if any
	local latest
	latest=$(ls -1dt "$HOME"/.dotfiles_backup/*/ 2>/dev/null | head -1 || true)
	printf '%s' "${latest%/}"
}

restore_backup() {   # $1 = backup dir; move its contents back into place
	local latest=$1 rel dst f
	echo "Restoring backup from $latest"
	while IFS= read -r -d '' f; do
		rel=${f#"$latest"/}
		dst=$HOME/$rel
		mkdir -p "$(dirname "$dst")"
		mv -f "$f" "$dst"
		echo "  restored ~/$rel"
	done < <(find "$latest" -type f -print0)
	find "$latest" -depth -type d -empty -delete 2>/dev/null || true   # drop the now-empty backup dir
}

# ============================= relink ==============================
if [ "$MODE" = relink ]; then
	for_each_target relink_target
	if [ "$backed_up" = 1 ]; then
		echo "Some \$HOME files differed and were backed up to $BACKUPDIR"
	else
		rmdir "$BACKUPDIR" "$HOME/.dotfiles_backup" 2>/dev/null || true
	fi
	exit 0
fi

# ============================== reset ==============================
if [ "$MODE" = reset ]; then
	echo "Reverting install (removing our hard links)..."
	for_each_target unlink_target
	git config --unset core.hooksPath 2>/dev/null || true   # deactivate our git hooks
	backup_dir=$(latest_backup)
	if [ -z "$backup_dir" ]; then
		echo "No backup found; nothing to restore."
	else
		# Restoring overwrites whatever is currently in $HOME, so confirm first.
		read -r -p "Restore backup from $backup_dir? This overwrites files in \$HOME. (y/N) " ans || ans=
		case ${ans:-} in
			[Yy]*) restore_backup "$backup_dir" ;;
			*)     echo "Skipped restore; backup left intact at $backup_dir" ;;
		esac
	fi
	echo "Reset done."
	exit 0
fi

# ============================= install =============================
for_each_target link

# activate the git hooks that re-link automatically after future pulls/rebases
git config core.hooksPath .githooks

# seed the eternal-history sentinel on fresh machines: .bashrc warns
# "HISTFILE CUT SHORT" unless line 2 of the history file is the _START_ marker.
# Never clobbers existing history (marker is prepended).
HISTFILE=${HISTFILE:-$HOME/.bash_history}
if [ "$(sed '2q;d' "$HISTFILE" 2>/dev/null)" != "_START_" ]; then   # sed '2q;d' prints only line 2
	# preserve the pre-seed history (copy, not move) so `reset` can restore it
	case $HISTFILE in
		"$HOME"/*)
			if [ -f "$HISTFILE" ]; then
				hrel=${HISTFILE#"$HOME"/}
				mkdir -p "$BACKUPDIR/$(dirname "$hrel")"
				cp -a "$HISTFILE" "$BACKUPDIR/$hrel"
				backed_up=1
			fi ;;
	esac
	tmp=$(mktemp)
	printf '#%s\n_START_\n' "$(date +%s)" > "$tmp"    # #<epoch> timestamp line, then the sentinel
	[ -f "$HISTFILE" ] && cat "$HISTFILE" >> "$tmp"    # keep any existing history after the marker
	mv "$tmp" "$HISTFILE"
	echo "  seeded   history marker in $HISTFILE"
fi

if [ "$backed_up" = 1 ]; then
	echo "Existing files were backed up to $BACKUPDIR"
else
	rmdir "$BACKUPDIR" "$HOME/.dotfiles_backup" 2>/dev/null || true   # nothing backed up; drop empty dirs
fi
echo "Installation done!"

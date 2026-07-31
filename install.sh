#!/usr/bin/env bash
# Installs these dotfiles by hard-linking every tracked file into $HOME.
# Re-runnable: any existing file that isn't already the same inode is backed up
# to ~/.dotfiles_backup/<timestamp>/ before being replaced.
set -euo pipefail

cd "$(dirname "$0")"   # cd to the repo root so relative paths work no matter where we're called from
REPO=$PWD

TS=$(date +%Y%m%d-%H%M%S)
BACKUPDIR=$HOME/.dotfiles_backup/$TS
backed_up=0

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
	echo "  linked  ~/${dst#"$HOME"/}"
}

# --- generic: hard-link every tracked file into the same path under $HOME,
#     except repo meta and the .aliases dir (linked specially just below) ---
# Driving off `git ls-files` means the manifest is just "whatever is committed":
# add a file to the repo and it gets linked; .gitignore'd files never do.
while IFS= read -r -d '' f; do   # -d '' pairs with `-z` below to survive spaces/newlines in paths
	case $f in
		.aliases/*|install.sh|clone-and-install.sh|LICENSE|README.md|.gitignore|.gitattributes)
			continue ;;
	esac
	link "$f" "$HOME/$f"
done < <(git ls-files -z)

# --- aliases: bash everywhere; a single OS-specific "distro" file; graphical on X11 ---
link .aliases/bash "$HOME/.aliases/bash"
if [ -f /etc/arch-release ]; then
	echo "Arch Linux detected (btw i use arch)"; link .aliases/arch "$HOME/.aliases/distro"
elif command -v termux-setup-storage &>/dev/null; then
	echo "Termux detected"; link .aliases/termux "$HOME/.aliases/distro"
elif [[ ${OSTYPE:-} == darwin* ]]; then
	echo "macOS detected"; link .aliases/mac "$HOME/.aliases/distro"
fi
if [[ ${XDG_SESSION_TYPE:-} == x11 ]]; then
	echo "X11 detected, linking graphical aliases"; link .aliases/graphical "$HOME/.aliases/graphical"
fi

# --- seed the eternal-history sentinel on fresh machines ---
# .bashrc warns "HISTFILE CUT SHORT" unless line 2 of the history file is the
# _START_ marker. Seed it so new boxes start clean and truncation stays
# detectable. Never clobbers existing history (marker is prepended).
HISTFILE=${HISTFILE:-$HOME/.bash_history}
if [ "$(sed '2q;d' "$HISTFILE" 2>/dev/null)" != "_START_" ]; then   # sed '2q;d' prints only line 2
	tmp=$(mktemp)
	printf '#%s\n_START_\n' "$(date +%s)" > "$tmp"    # #<epoch> timestamp line, then the sentinel
	[ -f "$HISTFILE" ] && cat "$HISTFILE" >> "$tmp"    # keep any existing history after the marker
	mv "$tmp" "$HISTFILE"
	echo "  seeded history marker in $HISTFILE"
fi

# --- report ---
if [ "$backed_up" = 1 ]; then
	echo "Existing files were backed up to $BACKUPDIR"
else
	rmdir "$BACKUPDIR" "$HOME/.dotfiles_backup" 2>/dev/null || true   # nothing backed up; drop empty dirs
fi
echo "Installation done!"

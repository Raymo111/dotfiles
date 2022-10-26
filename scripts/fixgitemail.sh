#!/bin/sh
# shellcheck disable=SC2034

USER="Raymo111"
REPO="dotfiles"
OLD_EMAIL="old@email.com"
CORRECT_NAME="Raymond Li"
CORRECT_EMAIL="new@email.com"

git clone --bare "https://github.com/$USER/$REPO/"
cd "$REPO.git" || exit

git filter-branch --env-filter '

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

git push --force --tags origin 'refs/heads/*'
cd ..
rm -rf "$REPO.git"

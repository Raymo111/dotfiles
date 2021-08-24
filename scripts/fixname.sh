#!/bin/sh

REPO="Honor4x"
OLD_EMAIL="contact@raymondli.tk"
CORRECT_NAME="Raymond Li"
CORRECT_EMAIL="hi@raymond.li"

git clone --bare "https://github.com/Raymo111/$REPO/"
cd "$REPO.git"

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

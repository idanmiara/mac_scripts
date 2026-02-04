# git rebase default branch - rebasing current repo on the default branch for this repo
git fetch && \
git remote set-head origin --auto >/dev/null 2>&1 && \
b="$(git symbolic-ref --short refs/remotes/origin/HEAD)" && \
echo "Rebasing onto $b" && \
git rebase "$b"

# git merge default branch - merging current repo on the default branch for this repo
git fetch && \
git remote set-head origin --auto >/dev/null 2>&1 && \
b="$(git symbolic-ref --short refs/remotes/origin/HEAD)" && \
echo "Merging $b into the current branch" && \
git merge "$b"

echo '''
add to .git/hooks/post-commit
This script will copy memo.md to README.md and stage it for commit.
Make sure to give it execute permissions: chmod +x .git/hooks/post-commit

```#!/bin/sh
cp memo.md README.md
git add README.md
```
'''

# Contributing to the Codebase 🚀

This document shares some best practices and tips for working on our code base.

## Commit Message 📝
Write a good commit message that follows this format:

---
```
[optional emoji] [type]([optional scope]): [subject]
[BLANK LINE]
[optional body]
```
---
Where:

- `[optional emoji]` is an optional emoji that represents the type of change. You can use https://gitmoji.dev/ to find
suitable emojis for your commits. For example, you can use :bug: for fix, :sparkles: for feat, :recycle: for refactor,
etc.
- `[type]` is one of these valid types: fix, feat, refactor, docs, test, chore. These types indicate what kind of change
you made in your code. For example, fix means you fixed a bug, feat means you added a new feature, docs means you
updated the documentation, etc.
- `([optional scope])` is an optional scope that specifies what part of the code is affected by your change. For
example, you can use (etl), (api), (db) to indicate which module or component you worked on.
- `[subject]` is the message itself that briefly describes what changed and why. It should be concise and clear,
preferably less than 50 characters. It should NOT start with a capital letter and should NOT end with a period. It
should not explain how you changed the code, but what and why.
- `[BLANK LINE]` is an empty line that separates the subject from the body.
- `[optional body]` is an optional body that provides more details about your change. It should be written in
paragraphs, each separated by a blank line. It should explain the problem you solved, how you solved it, and any other relevant information. It should wrap at 72 characters.

For example:

---
```
:sparkles: feat(etl): add new data source for customer segmentation
```
---

If you have multiple commits in one merge request, you should squash them into a single commit with a suitable commit
message when merging with the main branch. The commit message should summarize what changes you made in the merge
request and why. It should also reference the issue that you resolved and include the ticket number from Jira. For
example:

---
```
:recycle: refactor(ansible): move dev machines group vars to the role vars #123
```
---

This indicates that you resolved ticket number 123, which was about refactoring the variables of development machines.


## Branching Name Convention :twisted_rightwards_arrows:

Before creating a feature or resolving a bug, it is required to create an issue on GitHub. This issue will be assigned a number, which should be included in the branch name, separated by hyphens (-). Here is an example of a valid Git branch name:
---
```bash
2-feature-add-contribution-documentation
```
---

## Git Rebase Policy :rotating_light:

We follow a Git rebase policy to keep our Git history clean and easy to understand. When you are working on a feature or bug fix, you should create a feature branch based on the latest main branch. Then, you should make your changes in this branch and commit them as usual. Once you are done with your changes and ready to merge your branch into the main branch, you should rebase your branch on the latest main branch to make sure it is up to date and has no conflicts.


---
```bash
git fetch origin
git rebase origin/main
```
---

This will fetch the latest changes from the main branch and rebase your feature branch on top of them. If there are any conflicts, you will need to resolve them manually before you can continue with the rebase.

After the rebase is complete and there are no conflicts, you can push your branch to the remote repository and create a pull request. When you create the pull request, make sure to squash your commits into a single commit with a meaningful commit message that follows the commit message format described above.

By following this Git rebase policy, we can keep our Git history clean and easy to understand, and avoid unnecessary merge commits that clutter the history.

## Feature Development 🛠️

To write a new feature, follow these steps:

1. Create an issue in Github and explain what should be done or resolved.
1. Create a pull request and a corresponding branch for the issue. Assign the task and review to appropriate people.
1. Start committing in the specified branch. You can have separate changes in different commits in this branch. At the
time of merging with the main branch, you should squash all of these commits into a single commit with an appropriate
commit message for the whole merge request.
1. After the commits, check for the running of CI which runs a lint and for some codes runs the appropriate tests. If
something fails, fix them.



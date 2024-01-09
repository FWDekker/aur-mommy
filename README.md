# aur-mommy 🔺
arch linux build files for [mommy](https://github.com/FWDekker/mommy), synchronised with the
[arch user repository](https://aur.archlinux.org/packages/mommy) (aur)~

see [mommy](https://github.com/FWDekker/mommy) for installation instructions~


## ⚗️ development
### 🚨 warnings
* **never force push**
* **commits pushed to `master` are irreversibly synced with [aur](https://aur.archlinux.org/packages/mommy)**
* **`dev` must never be behind `master`**
* **be careful when editing `.aurignore`**  
  changes to this file should never affect commits that are already in the aur.
  careless changes may cause deployment failures

### 🫒 branch management
#### 🤔 what do the branches contain?
* `aur-mommy#master` contains the released build script for building `mommy#main`, and is mirrored to the
  [aur repository](https://aur.archlinux.org/packages/mommy)
* `aur-mommy#dev` contains unreleased changes for building `mommy#dev`, and is not mirrored to the aur repository  
  (note: you can **locally** run `./update.sh <commit>` to make the build script build `mommy#<commit>`)

#### 🔍 where should i push my changes?
if your change...
* **works for both `mommy#main` and `mommy#dev`**  
  _(e.g. fixing a typo.)_  
  push it to `aur-mommy#master` and `aur-mommy#dev`
* **works for `mommy#dev` but breaks `mommy#main`**  
  _(e.g. using new parameters for `make`.)_  
  push it to `aur-mommy#dev` only.
  your change will appear in `aur-mommy#master` once `mommy#dev` is merged into `mommy#main`
* **works for `mommy#main` but does not make sense for `mommy#dev`**  
  _(e.g. fixing a typo in a line that has been removed in `aur-mommy#dev`.)_  
  push it to `aur-mommy#master` and rebase `aur-mommy#dev` onto `aur-mommy#master`
* **breaks both `aur-mommy#master` and `aur-mommy#dev`**  
  _(e.g. adding `rm -rf /` into `PKGBUILD`)_  
  don't push it~

### 📯 release
the release process is fully automatic.
no human intervention required.
below is a brief summary of how it works~

when `mommy#main` is pushed to, [its cd action](https://github.com/FWDekker/mommy/blob/main/.github/workflows/cd.yml)
1. merges `aur-mommy#dev` into `aur-mommy#master`
2. runs [`update.sh`](https://github.com/FWDekker/aur-mommy/blob/master/update.sh) on `aur-mommy#master` to bump version
   info,
3. and commits and pushes these changes to `aur-mommy#master`~

this then invokes [`aur-mommy`'s cd action](https://github.com/FWDekker/aur-mommy/blob/dev/.github/workflows/cd.yml),
which
1. removes files listed in `.aurignore` the history using
   [git filter-repo](https://github.com/newren/git-filter-repo/), so aur doesn't complain about nested directories
   and unwanted files, and
2. pushes the filtered repo to [aur](https://aur.archlinux.org/packages/mommy)~

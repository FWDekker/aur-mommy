# aur-mommy 🔺
arch linux build files for [mommy](https://github.com/FWDekker/mommy), synchronised with the
[arch user repository](https://aur.archlinux.org/packages/mommy) (aur)~

see [mommy](https://github.com/FWDekker/mommy) for installation instructions~


## development ⚗️
### warnings 🚨
* **never force push**
* pushing to `master` immediately syncs to [aur](https://aur.archlinux.org/packages/mommy).
  **this is irreversible**
* **editing `.aurignore` may cause deployment failures.**
  changes to this file should never affect commits that are already in the aur
* keep `dev` up-to-date or ahead, but never behind `master`.
  **do not push to `master` without also pushing to `dev`**

### process ⚖️
* `aur-mommy#master` sort-of mirrors [the aur repository](https://aur.archlinux.org/packages/mommy)
  (see description of the release process below)
* `aur-mommy#master` builds `mommy#main`
* `aur-mommy#dev` should build `mommy#dev` once `mommy#dev` has been merged into `mommy#main`
  * alternatively, `aur-mommy#dev` builds `mommy#dev` after running `./update.sh dev` in `aur-mommy#dev`.
    this operation should only be done locally!

in other words, if your change...
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

### release 📯
the release process is fully automatic.
no human intervention required.
below is a brief summary of how it works~

when `mommy#main` is pushed to, [its cd action](https://github.com/FWDekker/mommy/blob/main/.github/workflows/cd.yml)
automatically updates `aur-mommy` as follows:
  * sync `master` and `dev` with each other
  * bump the version information in `PKGBUILD` and `.SRCINFO` using `./update.sh <version>`
  * trigger [`aur-mommy`'s cd action](https://github.com/FWDekker/aur-mommy/blob/master/.github/workflows/cd.yml):
    * clone `aur-mommy`
    * remove files listed in `.aurignore` the history using
      [git filter-repo](https://github.com/newren/git-filter-repo/), so aur doesn't complain about nested directories
      and unwanted files
    * push the filtered repo to [aur](https://aur.archlinux.org/packages/mommy)

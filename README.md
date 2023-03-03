# aur-mommy 🔺
arch linux build files for [mommy](https://github.com/FWDekker/mommy)~

see [mommy](https://github.com/FWDekker/mommy) for installation instructions~


## development ⚗️
the build file can be updated to compile mommy version `<version>` by running `./update.sh <version>`~

when the `main` branch of the [mommy repo](https://github.com/FWDekker/mommy) is updated, the
[cd action](https://github.com/FWDekker/mommy/blob/main/.github/workflows/cd.yml) also automatically updates this repo
and [pushes changes to the aur](https://github.com/FWDekker/aur-mommy/blob/main/.github/workflows/cd.yml).
no human intervention required!


## acknowledgements 💖
this repo used [homebrew-shellspec](https://github.com/shellspec/homebrew-shellspec) as a template~

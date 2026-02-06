```shell
git clone --bare https://github.com/teatov/dotfiles "$HOME/.dotfiles"
alias dotfiles='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

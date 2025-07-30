# dotfiles

use gnu stow to manage symbolic links

from inside this dotfiles directory:
* to add symbolic links: `stow <package_name> -t $HOME`
* to delete symbolic links: `stow <package_name> -D`

*please back up any existing configuration files, if they exist.*

## notes on gnu stow arguments
```
stow <package_name> --dir=<dotfiles_path> --target=<home_path>
```
is equivalent to
```
stow <package_name> -d <dotfiles_path> -t <home_path>
```

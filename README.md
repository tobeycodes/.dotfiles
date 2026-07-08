# Dotfiles

Public dotfiles repository.

## Requirements

- macOS with Homebrew
- Arch Linux with Pacman and Paru
- Raspberry Pi OS with Apt

## Installation

```bash
git clone git@github.com:tobeycodes/.dotfiles.git ~/dotfiles
cd ~/dotfiles
brew bundle install --file=.config/homebrew/bundle # macOS
pacman -S --needed - < .config/pacman/packages.txt # Arch Linux
xargs sudo apt install -y < .config/debian/packages.txt # Raspberry Pi OS
stow .
```

## Questions

If you have any questions about my dotfiles please reach out to me on X or Telegram.

[site](https://tobey.codes) • [x](https://x.com/tobeycodes) • [telegram](https://t.me/tobeycodes) • [schedule time](https://cal.com/tobeycodes/15min) • [github](https://github.com/tobeycodes) • [twitch](https://twitch.tv/tobeycodes) • [youtube](https://youtube.com/@tobeycodes)

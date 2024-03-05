
## 1. Install Neovim in Lunix
To install Neovim version 0.9.4 on Ubuntu, you typically have to compile it from source as older versions might not be available in the default package repositories. Here's a general guide to compile and install Neovim version 0.9.4:

**- Install Prerequisites:**
```
sudo apt update
sudo apt install -y git cmake g++ pkg-config libtool libtool-bin autoconf automake ninja-build gettext
```
**- Clone Neovim**
```
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout v0.9.4
```
**-Build and Install Neovim:**
```
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

**- Verify Installation:**
After the installation is complete, you can verify the installation by running:

```
nvim --version
```

## 2. Add configs
**- Clone this repo**
```
git clone https://github.com/jamesngdev/dotenv.git
```

* Move to configs folder**

```
mv dotenv/ ~/.configs/nvim/
```

## 3. Install fonts


- Download [JetBrainsMono Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip)

- Extract to `~/.fonts/` folder.


## 4. Link config

sudo ln -s ~/dotfiles/.tmux.conf ~/
sudo ln -s ~/dotfiles/.tmux.conf.local ~/
sudo ln -s ~/dotfiles/.config/nvim ~/.config


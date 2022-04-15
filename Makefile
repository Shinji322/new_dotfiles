# Necessities on most systems

BASE_PKGS	     := filesystem gcc-libs glibc bash coreutils file findutils gawk grep procps-ng sed tar gettext 
BASE_PKGS	     += pciutils psmisc shadow util-linux bzip2 gzip xz licenses pacman 
BASE_PKGS	     += iputils iproute2 autoconf sudo automake binutils bison fakeroot flex gcc groff libtool m4 
BASE_PKGS	     += make patch pkgconf texinfo which 
BASE_PKGS        += systemd systemd-sysvcompat 
BASE_PKGS        += man-db curl entr

CLI_PACKAGES     := neovim
CLI_PACKAGES     += ripgrep fd exa fzf git-delta 
CLI_PACKAGES     += unzip unrar xclip mediainfo moreutils tar gzip
CLI_PACKAGES     += nodejs npm python-pip valgrind cronie
CLI_PACKAGES     += mpd mpc ncmpcpp mpv newsboat yt-dlp zathura zathura-pdf-mupdf ffmpeg ffmpegthumbnailer
CLI_PACKAGES     += pamixer libnotify dunst maim feh networkmanager bc
CLI_PACKAGES     += pass rsync bat sox
AUR_CLI_PACKAGES := atool task-spooler passotp lf-git

AUR_HELPER       := yay

# Packages relevant to me
PACKAGES        := calcurse syncthing qbittorrent rofi sxiv sxhkd dmenu
PACKAGES        += picom
AUR_PACKAGES    := hydrus imgbrd-grabber pixivutil2-git tachidesk


# Functions
INSTALL        := sudo pacman --noconfirm --needed -S
AUR            := yay -S --noconfirm
SYSTEMD_ENABLE := sudo systemctl --now enable
PIPINSTALL     := pip install --user
GOINSTALL      := go get 
LN             := ln -vsf
MKDIR          := mkdir -pv

# repos
DOTFILES_REPO  := https://github.com/Shinji322/new_dotfiles.git
FILE_TREE      := https://github.com/Shinji322/file-tree.git



# Necessities: Non debatable stuff
base:
	$(INSTALL) $(BASE_PKGS)	

xorg: 
	$(INSTALL) xorg-server xorg-xwininfo xorg-xinit xorg-twm xorg-xev
	$(INSTALL) xorg-xrandr xcompmgr xorg-xprop 
	$(INSTALL) xclip

aur: 
	git clone https://aur.archlinux.org/yay.git 
	cd yay
	makepkg -si
	cd $(PWD)

pacman: # Configures pacman with colors
	sudo sed -i "s/^#Color/Color/" /etc/pacman.conf

sudo: 
	sudo echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# Changable stuff
windowmanager:
	$(INSTALL) i3-gaps i3blocks

# Programming stuff
node: 
	$(INSTALL) nodejs npm

python: 
	$(INSTALL) python-pip


rust: 
	$(INSTALL) rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src
	mv .rustup $(XDG_DATA_HOME)/rustup
	$(MKDIR) $(XDG_DATA_HOME)/cargo/env

go: 
	$(INSTALL) go

programming: node python rust go 


# Programming libraries
sdl: 
	$(INSTALL) sdl sdl_image sdl_mixer 
	$(INSTALL) lib32-sdl_image lib32-sdl_mixer
raylib:
	$(INSTALL) raylib
	$(MKDIR) /usr/include/raylib_extras
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/physac.h > /usr/include/raylib_extras/physac.h
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/easings.h > /usr/include/raylib_extras/easings.h
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/raygui.h > /usr/include/raylib_extras/raygui.h
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/rmem.h > /usr/include/raylib_extras/rmem.h
rmarkdown: 
	$(INSTALL) r gcc-fortran tk
pipkgs: 
	$(PIPINSTALL) beautifulsoup4 bs4 requests lxml pipenv
monogame:
	$(INSTALl) ca-certificates
	dotnet new --install MonoGame.Templates.CSharp
	dotnet tool install --global dotnet-mgcb-editor
	mgcb-editor --register
# gopkgs: 
	# $(GOINSTALL) github.com/PuerkitoBio/goquery
	# $(GOINSTALL) -v -u github.com/gen2brain/raylib-go/raylib

libraries: pipkgs sdl raylib monogame rmarkdown



# CLI utilties
cliutils:
	$(INSTALL) $(CLI_PACKAGES)
	$(AUR) $(AUR_CLI_PACKAGES)

advcpmv: # an advanced version of cp and mv that adds a progress bar
	curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ./advcpmv/install.sh && (cd advcpmv && sh install.sh)
	sudo mv $(PWD)/advcpmv/advcp /usr/local/bin/cpg
	sudo mv $(PWD)/advcpmv/advmv /usr/local/bin/mvg

shell: 
	$(INSTALL) zsh
	$(INSTALL) zsh-autosuggestions zsh-completions
	$(AUR) zsh-fast-syntax-highlighting
	chsh -s /bin/zsh

allcli: cliutils advcpmv shell
	

# Personal
pkgs: 
	$(INSTALL) $(PACKAGES)
	$(AUR) $(AUR_PACKAGES)

terminal: 
	$(INSTALL) kitty

fonts: 
	$(INSTALL) ttf-ubuntu-font-family
	$(INSTALL) otf-ipafont
	$(AUR) ttf-fira-code

texteditor: 
	$(INSTALL) neovim
	$(AUR) sc-im-git
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

browser: 
	# just better firefox
	$(AUR) waterfox-g4-bin
	$(AUR) librewolf-bin 
	$(AUR) librewolf-ublock-origin librewolf-extension-dark-reader librewolf-extension-localcdn
	$(AUR) brave-bin

data-hoarder:
	$(AUR) gallery-dl-bin twint

gaming: 
	$(INSTALL) steam 
	$(INSTALL) wine winetricks
	$(INSTALL) lutris

emulators: 
	$(AUR) citra-qt-git

filetree:
	cd $(HOME)
	git init .
	git remote add origin $(FILE_TREE)
	git pull origin master
	rm -rf $(HOME)/.git

dotfiles:
	cd $(HOME)
	git init .
	git remote add origin $(DOTFILES_REPO)
	git pull origin main
	rm -rf $(HOME)/.git


# hardware dependent
nvidia: base pacman
	$(INSTALL) nvidia nvidia-dkms nvidia-prime 
	$(INSTALL) nvidia-settings nvidia-utils lib32-nvidia-utils

socialmedia: base pacman
	$(INSTALL) discord
	$(AUR) bilili

programs: pkgs terminal fonts texteditor browser gaming emulators  socialmedia
drivers: nvidia

# Configs
bluetooth: 
	$(INSTALL) bluez bluez-utils
	$(SYSTEMD_ENABLE) bluetooth.service

network: 
	$(INSTALL) networkmanager
	$(SYSTEMD_ENABLE) NetworkManager.service

automount: # Automount hard drives on connect
	$(INSTALL) udiskie
	$(SYSTEMD_ENABLE) udisks2.service

PTHEMES := python-qdarkstyle
ATHEMES := gtk-theme-arc-gruvbox-git orchis-theme-git
themes: 
	$(INSTALL) $(PTHEMES)
	$(AUR) $(ATHEMES)

cron: 
	$(INSTALL) cronie
	$(SYSTEMD_ENABLE) cronie.service
	cat $(XDG_CONFIG_HOME)/cron/crontab 


# main stuff
necessities: base pacman aur xorg
soystemd: bluetooth network automount
all: necessities allcliutils soystemd drivers themes programs

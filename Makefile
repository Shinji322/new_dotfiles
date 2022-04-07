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
CLI_PACKAGES     += pass rsync  bat
AUR_CLI_PACKAGES     := atool task-spooler passotp lf-git

AUR_HELPER       := yay

# Packages relevant to me
PACKAGES        := calcurse syncthing qbittorrent rofi sxiv sxhkd dmenu
AUR_PACKAGES    := hydrus imgbrd-grabber pixivutil2-git


# Functions
INSTALL        := sudo pacman --noconfirm --needed -S
AUR            := yay -S --noconfirm
SYSTEMD_ENABLE := sudo systemctl --now enable
PIPINSTALL     := pip install --user
GOINSTALL      := go get 
LN             := ln -vsf


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

pipkgs: 
	$(PIPINSTALL) beautifulsoup4 bs4 requests lxml pipenv

rust: 
	$(INSTALL) rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src
	mv .rustup $(XDG_DATA_HOME)/rustup
	mkdir -p $(XDG_DATA_HOME)/cargo/env

go: 
	$(INSTALL) go

gopkgs: 
	$(GOINSTALL) github.com/PuerkitoBio/goquery

programming: node python rust go 
pkgs: pipkgs gopkgs


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
	

# Programming libraries
sdl: 
	$(INSTALL) sdl sdl_image sdl_mixer 
	$(INSTALL) lib32-sdl_image lib32-sdl_mixer

rmarkdown: 
	$(INSTALL) r gcc-fortran tk

libraries: sdl rmarkdown

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

texteditor: base pacman 
	$(INSTALL) neovim
	$(AUR) sc-im-git
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

browser: 
	$(AUR) librewolf-bin 
	$(AUR) librewolf-ublock-origin librewolf-extension-dark-reader librewolf-extension-localcdn

gaming: base
	$(INSTALL) steam 
	$(INSTALL) wine winetricks
	$(INSTALL) lutris

emulators: 
	$(AUR) citra-qt-git

# hardware dependent
nvidia: base pacman
	$(INSTALL) nvidia nvidia-dkms nvidia-prime 
	$(INSTALL) nvidia-settings nvidia-utils lib32-nvidia-utils

socialmedia: base pacman
	$(INSTALL) discord
	$(AUR) wecase bilili

programs: pkgs terminal fonts texteditor browser gaming emulators  socialmedia
drivers: nvidia

# Configs
bluetooth: base pacman
	$(INSTALL) bluez bluez-utils
	$(SYSTEMD_ENABLE) bluetooth.service

network: base pacman
	$(INSTALL) networkmanager
	$(SYSTEMD_ENABLE) NetworkManager.service

automount: base pacman # Automount hard drives on connect
	$(INSTALL) udiskie
	$(SYSTEMD_ENABLE) udisks2.service

PTHEMES := python-qdarkstyle
ATHEMES := gtk-theme-arc-gruvbox-git orchis-theme-git
themes: base pacman 
	$(INSTALL) $(PTHEMES)
	$(AUR) $(ATHEMES)

cron: base pacman
	$(INSTALL) cronie


# main stuff
necessities: base pacman aur xorg
soystemd: bluetooth network automount
all: necessities allcliutils soystemd drivers themes programs

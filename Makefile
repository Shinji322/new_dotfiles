# Necessities on most systems

BASE_PKGS	     := filesystem gcc-libs glibc bash coreutils file findutils gawk grep procps-ng sed tar gettext 
BASE_PKGS	     += pciutils psmisc shadow util-linux bzip2 gzip xz licenses pacman 
BASE_PKGS	     += iputils iproute2 autoconf sudo automake binutils bison fakeroot flex gcc groff libtool m4 
BASE_PKGS	     += make patch pkgconf texinfo which 
BASE_PKGS        += systemd systemd-sysvcompat 
BASE_PKGS        += man-db curl entr

CLI_PACKAGES     := neovim
CLI_PACKAGES     += ripgrep fd exa fzf git-delta 
CLI_PACKAGES     += unzip unrar xclip atool mediainfo task-spooler moreutils tar untar gzip
CLI_PACKAGES     += nodedjs npm python-pip valgrind cronie
CLI_PACKAGES     += mpd mpc ncmpcpp mpv newsboat yt-dlp zathura zathura-pdf-mupdf ffmpeg ffmpegthumbnailer
CLI_PACKAGES     += pamixer libnotify dunst maim feh networkmanager
CLI_PACKAGES     += pass passotp rsync

AUR_HELPER       := yay

# Packages relevant to me
PACKAGES        := calcurse syncthing qbittorrent rofi sxiv sxhkd


# Functions
INSTALL        := sudo pacman --noconfirm --needed 
AUR            := yay -S --noconfirm
SYSTEMD_ENABLE := sudo systemctl --now enable
PIPINSTALL     := pip install --user
GOINSTALL      := go get 


# Necessities: Non debatable stuff
base:
	$(INSTALL) $(BASE_PKGS)	

xorg: 
	$(INSTALL) xorg-server xorg-xwininfo xorg-xinit xorg-twm xorg-xev
	$(INSTALL) xorg-xrandr xcompmgr xorg-xprop xorg-dpyinfo
	$(INSTALL) xclip

aur:
	cd /opt
	sudo git clone https://aur.archlinux.org/yay.git 
	cd yay
	makepkg -si
	cd $(PWD)

pacman: # Configures pacman with colors
	sudo sed -i "s/^#Color/Color/" /etc/pacman.conf


# Programming stuff
node: base pacman 
	$(INSTALL) nodejs npm

python: base pacman
	$(INSTALL) python-pip

pipkgs: python
	$(PIPINSTALL) beautifulsoup4 bs4 requests lxml pipenv

rust: base pacman
	$(INSTALL) rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src

go: base pacman
	$(INSTALL) go

gopkgs: go 
	$(GOINSTALL) github.com/PuerkitoBio/goquery

programming: node python pipkgs rust go


# CLI utilties
cliutils: base pacman
	$(INSTALL) $(CLI_PACKAGES)

advcpmv: base # an advanced version of cp and mv that adds a progress bar
	curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ./advcpmv/install.sh && (cd advcpmv && sh install.sh)
	sudo mv $(PWD)/advcpmv/advcp /usr/local/bin/cpg
	sudo mv $(PWD)/advcpmv/advmv /usr/local/bin/mvg

shell: base aur
	$(INSTALL) zsh
	$(INSTALL) zsh-autosuggestions zsh-completions
	$(AUR) zsh-fast-syntax-highlighting

allcli: cliutils advcpmv shell
	

# Programming libraries
sdl: base pacman
	$(INSTALL) sdl sdl_image sdl_mixer 
	$(INSTALL) lib32-sdl_image lib32-sdl_mixer

rmarkdown: base pacman
	$(INSTALL) r gcc-fortran tk

libraries: sdl rmarkdown

# Personal
pkgs: base pacman 
	$(INSTALL) $(PACKAGES)

terminal: base pacman
	$(INSTALL) kitty

fonts: base pacman aur
	$(INSTALL) ttf-ubuntu-font-family
	$(INSTALL) otf-ipafont
	$(AUR) ttf-fira-code

texteditor: base pacman aur
	$(INSTALL) neovim
	$(AUR) lunarvim-git
	$(AUR) sc-im-git

browser: aur
	$(AUR) librewolf-bin 
	$(AUR) librewolf-ublock-origin librewolf-extension-dark-reader librewolf-extension-loaclcdn

gaming: base
	$(INSTALL) steam 
	$(INSTALL) wine winetricks
	$(INSTALL) lutris

emulators: aur
	$(AUR) citra-qt-git

# hardware dependent
nvidia: base pacman
	$(INSTALL) nvidia nvidia-dkms nvidia-prime 
	$(INSTALL) nvidia-settings nvidia-utils lib32-nvidia-utils

socialmedia: base pacman
	$(INSTALL) discord

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
themes: base pacman aur
	$(INSTALL) $(PTHEMES)
	$(AUR) $(ATHEMES)

cron: base pacman
	$(INSTALL) cronie


# main stuff
necessities: base pacman aur xorg
soystemd: bluetooth network automount
all: necessities allcliutils soystemd drivers themes programs

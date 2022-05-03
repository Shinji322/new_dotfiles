# How to run:
	# On NVIDIA laptops: make all && make nvidia

# Packages
BASE_PKGS        := filesystem gcc-libs glibc bash coreutils file findutils gawk grep procps-ng sed tar gettext 
BASE_PKGS        += pciutils psmisc shadow util-linux bzip2 gzip xz licenses pacman 
BASE_PKGS        += iputils iproute2 autoconf sudo automake binutils bison fakeroot flex gcc groff libtool m4 
BASE_PKGS        += make patch pkgconf texinfo which 
BASE_PKGS        += systemd systemd-sysvcompat 
BASE_PKGS        += man-db curl entr

CLI_PACKAGES     := neovim
CLI_PACKAGES     += ripgrep fd exa fzf git-delta 
CLI_PACKAGES     += unzip unrar xclip mediainfo moreutils tar gzip
CLI_PACKAGES     += nodejs npm python-pip valgrind cronie
CLI_PACKAGES     += mpd mpc ncmpcpp mpv newsboat yt-dlp zathura zathura-pdf-mupdf ffmpeg ffmpegthumbnailer
CLI_PACKAGES     += pamixer libnotify dunst maim feh networkmanager bc
CLI_PACKAGES     += pass rsync bat sox pass-otp pkgfile trash-cli ueberzug
AUR_CLI_PACKAGES := atool task-spooler lf-git

AUR_HELPER       := yay

# Personal Packages relevant to me
PACKAGES         := calcurse syncthing qbittorrent rofi sxiv sxhkd dmenu
PACKAGES         += docker docker-compose
PACKAGES         += zoxide lazygit gendesk
PACKAGES         += nmap tmux
AUR_PACKAGES     := hydrus imgbrd-grabber pixivutil2-git tachidesk picom-git
AUR_PACKAGES     += safeeyes gdb-frontend-bin system-monitoring-center 
AUR_PACKAGES     += qdirstat-bin


# Functions
INSTALL          := sudo pacman --noconfirm --needed -S
AUR              := yay -S --noconfirm
SYSTEMD_ENABLE   := sudo systemctl --now enable
PIPINSTALL       := pip install --user
LN               := ln -vsf
MKDIR            := mkdir -p

# repos
DOTFILES_REPO    := https://github.com/Shinji322/new_dotfiles.git
FILE_TREE        := https://github.com/Shinji322/file-tree.git


# System related stuff
${HOME}/.local:
	$(MKDIR) $<
base:
	$(INSTALL) $(BASE_PKGS)
$(AUR_HELPER):
	git clone https://aur.archlinux.org/yay.git
	cd yay # make doesn't allow you to cd
	makepkg -si
	cd ..
install: ## Install my packages
	$(INSTALL) $(CLI_PACKAGES)
	$(AUR) $(AUR_CLI_PACKAGES)
	sudo pkgfile --update
pacman:
	sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
	sudo sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf 
	sudo echo -e "[multilib]\nInlcude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
sudo:
	sudo echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
xorg:
	$(INSTALL) xorg-server xorg-xwininfo xorg-xinit xorg-twm xorg-xev
	$(INSTALL) xorg-xrandr xcompmgr xorg-xprop 
	$(INSTALL) xclip
windowmanager:
	$(INSTALL) i3-gaps i3blocks
shell:
	$(INSTALL) zsh
	$(INSTALL) zsh-autosuggestions zsh-completions
	$(AUR) zsh-fast-syntax-highlighting
	chsh -s /bin/zsh


# Configs
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

sdl:
	$(INSTALL) sdl sdl_image sdl_mixer 
	$(INSTALL) lib32-sdl_image lib32-sdl_mixer
raylib:
	$(INSTALL) raylib
	sudo $(MKDIR) /usr/include/raylib_extras
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/physac.h > /usr/include/raylib_extras/physac.h
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/easings.h > /usr/include/raylib_extras/easings.h
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/raygui.h > /usr/include/raylib_extras/raygui.h
	curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/rmem.h > /usr/include/raylib_extras/rmem.h
rmarkdown: 
	$(INSTALL) r gcc-fortran tk
pipkgs: 
	$(PIPINSTALL) pipenv virtualenv
	$(PIPINSTALL) beautifulsoup4 bs4 requests lxml autoscraper
monogame:
	$(INSTALl) ca-certificates
	dotnet new --install MonoGame.Templates.CSharp
	dotnet tool install --global dotnet-mgcb-editor
	mgcb-editor --register

languages: node python rust go 
libraries: sdl raylib rmarkdown pipkgs monogame


# Package Installation
pkginstall:
	$(INSTALL) $(PACKAGES)
	$(AUR) $(AUR_PACKAGES)
# This actually fails because if executed as sudo, then the owner of the repo is sudo
advcpmv:
	curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ./advcpmv/install.sh && (cd advcpmv && sh install.sh)
	sudo mv $(PWD)/advcpmv/advcp /usr/local/bin/cpg
	sudo mv $(PWD)/advcpmv/advmv /usr/local/bin/mvg
terminal:
	$(INSTALL) kitty
fonts: 
	$(INSTALL) ttf-ubuntu-font-family
	$(INSTALL) otf-ipafont
	$(AUR) ttf-fira-code
text-editor: 
	$(INSTALL) neovim
	$(AUR) sc-im-git
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
browser: 
	# just better firefox
	$(AUR) waterfox-g4-bin
	$(AUR) brave-bin
	# $(AUR) librewolf-bin 
	# $(AUR) librewolf-ublock-origin librewolf-extension-dark-reader librewolf-extension-localcdn
data-hoarder:
	$(AUR) gallery-dl-bin twint
gaming: 
	$(INSTALL) steam 
	$(INSTALL) wine winetricks
	$(INSTALL) lutris
emulators: 
	$(AUR) citra-qt-git
social-media:
	$(INSTALL) discord
	$(AUR) bilili
searx:
	docker pull searx/searx
PTHEMES := python-qdarkstyle
ATHEMES := gtk-theme-arc-gruvbox-git orchis-theme-git
themes: 
	$(INSTALL) $(PTHEMES)
	$(AUR) $(ATHEMES)



# Systemd
bluetooth: 
	$(INSTALL) bluez bluez-utils
	$(SYSTEMD_ENABLE) bluetooth.service
network: 
	$(INSTALL) networkmanager
	$(SYSTEMD_ENABLE) NetworkManager.service
automount: # Automount hard drives on connect
	$(INSTALL) udiskie
	$(SYSTEMD_ENABLE) udisks2.service
cron: 
	$(INSTALL) cronie
	$(SYSTEMD_ENABLE) cronie.service
	cat $(XDG_CONFIG_HOME)/cron/crontab#Fix this 
docker:
	$(INSTALL) docker docker-compose
	$(SYSTEMD_ENABLE) docker.service
	sudo groupadd docker
	sudo usermod -aG docker $(USER)

# Hardware dependent
nvidia:
	$(INSTALL) nvidia nvidia-dkms nvidia-prime 
	$(INSTALL) nvidia-settings nvidia-utils lib32-nvidia-utils
amd_gpu:
	$(INSTALL) mesa lib32-mesa 
	$(INSTALL) xf86-video-amdgpu
	$(INSTALL) vulkan-radeon amdvlk lib32-vulkan-radeon lib32-amdvlk
# Microcode
amd_cpu:
	$(INSTALL) amd-ucode
	grub-mkconfig -o /boot/grub/grub.cfg# Let's assume we use grub
intel_cpu:
	$(INSTALL) intel-ucode
	grub-mkconfig -o /boot/grub/grub.cfg# Let's assume grub



# Final words
.PHONY: basic configs programming systemd packages all

basic: base install $(AUR_HELPER) pacman shell sudo xorg windowmanager
configs: filetree dotfiles
programming: languages libraries
systemd: bluetooth network automount cron
packages: pkginstall advcpmv terminal fonts text-editor browser social-media themes data-hoarder gaming emulators 
all: basic configs programming systemd packages

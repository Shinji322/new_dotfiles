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
CLI_PACKAGES     += unzip unrar xclip mediainfo moreutils tar gzip lesspipe
CLI_PACKAGES     += nodejs npm python-pip valgrind cronie
CLI_PACKAGES     += mpd mpc ncmpcpp mpv newsboat yt-dlp zathura zathura-pdf-mupdf ffmpeg ffmpegthumbnailer
CLI_PACKAGES     += pamixer libnotify dunst maim feh networkmanager bc acpi
CLI_PACKAGES     += pass rsync bat sox pass-otp pkgfile trash-cli ueberzug mlocate xdotool aria2 xdo
AUR_CLI_PACKAGES := atool task-spooler lf-git

AUR_HELPER       := yay

# Personal Packages relevant to me
# sxiv is archived so we use nsxiv instead
PACKAGES         := calcurse syncthing qbittorrent rofi sxhkd dmenu
PACKAGES         += docker docker-compose
PACKAGES         += zoxide lazygit gendesk flameshot pandoc
PACKAGES         += nmap tmux jq redshift htmlq glow tealdeer dust bottom difftastic figlet
# glow: tui Markdown Previewer
# tealdeer: A very fast implementation of tldr in Rust: Simplified, example based and community-driven man pages. 
# dust: du on steroids
# bottom: system monitoring tool
# kalker-git a powerful cli calculator written in rust
PACKAGES         += exfat-utils streamlink sysstat figlet-fonts
AUR_PACKAGES     := hydrus imgbrd-grabber pixivutil2-git tachidesk picom-git
AUR_PACKAGES     += safeeyes gdb-frontend-bin system-monitoring-center zap-bin
AUR_PACKAGES     += dragon-drop nsxiv kalker-git
#AUR_PACKAGES     += qdirstat-bin


# Functions
INSTALL          := sudo pacman --noconfirm --needed -S
AUR              := yay -S --noconfirm
SYSTEMD_ENABLE   := sudo systemctl --now enable
PIPINSTALL       := pip install --user
NPM              := npm install -g
LN               := ln -vsf
MKDIR            := mkdir -p

# repos
DOTFILES_REPO    := https://github.com/Shinji322/new_dotfiles.git
FILE_TREE        := https://github.com/Shinji322/file-tree.git
USER := mokou


# System related stuff
${HOME}/.local:
	$(MKDIR) $<
	$(MKDIR) $</src
	$(MKDIR) $</share
	$(MKDIR) $</repos
base:
	$(INSTALL) $(BASE_PKGS)
$(AUR_HELPER):
	git clone https://aur.archlinux.org/$(AUR_HELPER).git
	cd $(AUR_HELPER) # make doesn't allow you to cd
	makepkg -si --noconfirm --needed
	cd ..
install: ## Install my packages
	$(INSTALL) $(CLI_PACKAGES)
	$(AUR) $(AUR_CLI_PACKAGES)
	sudo pkgfile --update
pacman:
	sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
	sudo sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
	sudo echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
sudo:
	sudo echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
xorg:
	$(INSTALL) xorg-server xorg-xwininfo xorg-xinit xorg-twm xorg-xev
	$(INSTALL) xorg-xrandr xcompmgr xorg-xprop
	$(INSTALL) xclip xcolor xsel
i3:
	$(INSTALL) i3-gaps i3blocks
awesomewm:
	$(INSTALL) dex rlwrap vicious
	$(AUR) awesome-git
	# Config depends
	$(INSTALL) rofi lm_sensors acpid redshift mpd mpc maim inotify-tools xdotool
	$(AUR) light-git
	$(SYSTEMD_ENABLE) acpid.service
shell:
	$(INSTALL) zsh
	$(INSTALL) zsh-autosuggestions zsh-completions
	$(AUR) zsh-fast-syntax-highlighting
	chsh -s /bin/zsh
	$(MKDIR) $(XDG_CACHE_HOME)/zsh
	touch $(XDG_CACHE_HOME)/zsh/history
date: # Used to set date and time properly
	$(INSTALL) ntp
	sudo ntpdate ntp.ubuntu.com
	sudo hwclock -w

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
dotrepos:
	cd $(HOME)
	git init --bare ~/.dotfiles
	alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
	config config status.showUntrackedFiles no
gpg:
	$(INSTALL) gpg-tui pass pass-otp
	$(MKDIR) $(HOME)/.local/share/gnupg


# Programming stuff
node: 
	$(INSTALL) nodejs npm
web-dev:
	$(INSTALL) sassc
	$(AUR) vue-cli
	npm install -D sass-loader node-sass typescript
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
	sudo curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/physac.h > /usr/include/raylib_extras/physac.h
	sudo curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/easings.h > /usr/include/raylib_extras/easings.h
	sudo curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/raygui.h > /usr/include/raylib_extras/raygui.h
	sudo curl https://raw.githubusercontent.com/raysan5/raylib/master/src/extras/rmem.h > /usr/include/raylib_extras/rmem.h
rmarkdown:
	$(INSTALL) r gcc-fortran tk
pipkgs:
	$(PIPINSTALL) pipenv virtualenv
	$(PIPINSTALL) rnnoise-cli
	$(PIPINSTALL) beautifulsoup4 bs4 requests httpx lxml autoscraper
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
	tldr --update
# It worked actually for some reason (maybe because I'm a part of the wheel group now?)
advcpmv:
	curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ./advcpmv/install.sh && (cd advcpmv && sh install.sh)
	sudo mv $(PWD)/advcpmv/advcp /usr/local/bin/cpg
	sudo mv $(PWD)/advcpmv/advmv /usr/local/bin/mvg
	rm -rf advcpmv
terminal:
	$(INSTALL) kitty
fonts:
	# Latin script
	$(INSTALL) ttf-ubuntu-font-family ttf-croscore ttf-fira-code
	# Japanese
	$(INSTALL) otf-ipafont
	# Chinese
	$(INSTALL) adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts # Simplified
	$(INSTALL) adobe-source-han-sans-tw-fonts adobe-source-han-serif-tw-fonts # Traditional
	# Korean
	$(INSTALL) adobe-source-han-sans-kr-fonts ttf-baekmuk
	# Nerd
	$(AUR) ttf-nerd-fonts-symbols
	# $(AUR) nerd-fonts-noto-sans-regular-complete
	# Emoji
	$(INSTALL) noto-fonts-emoji
	# Aesthetic fonts
	$(AUR) cozette-ttf # nice bitmap font
# dap: # For vim debugging
# 	$(INSTALL) python-debugpy
# 	$(MKDIR) $(XDG_DATA_HOME)/virtualenvs
# 	python -m venv $(XDG_DATA_HOME)/virtualenvs/debugpy
# 	$(XDG_DATA_HOME)/virtualenvs/debugpy/bin/python -m pip install debugpy
lunarvim:
	$(INSTALL) neovim
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y # needs to be installed after node, rust, and python
	$(NPM) bash-language-server # Lsp Install doesn't work for some reason
	$(INSTALL) luacheck shellcheck
	$(AUR) vale-git
	lvim +PackerSync +LvimSyncCorePlugins
	# lvim -c ":PackerSync | q"
	# lvim -c ":LvimSyncCorePlugins | q"
text-editor: lunarvim
	$(AUR) sc-im-git
browser:
	# just better firefox
	$(AUR) waterfox-g4-bin
	$(AUR) brave-bin
	# $(AUR) librewolf-bin
	# $(AUR) librewolf-ublock-origin librewolf-extension-dark-reader librewolf-extension-localcdn
data-hoarder:
	$(INSTALL) beets
	$(MKDIR) $(XDG_DATA_HOME)/beets
	touch $(XDG_DATA_HOME)/beets/library.db
	$(AUR) gallery-dl-bin twint
	$(AUR) cyberdropdownloader
wine:
	$(INSTALL) wine winetricks
	$(MKDIR) $(XDG_DATA_HOME)/wineprefixes
	$(AUR) bottles-git
	# These aren't included as dependencies for bottles for whatever reason
	$(INSTALL) python-markdown gtk4 gtksourceview4
# proton-ge:
# 	$(AUR) protonup-git
# 	$(MKDIR) ~/.steam/root/compatibilitytools.d
# 	protonup -y
gaming: wine
	$(INSTALL) steam
	$(INSTALL) lutris
emulators:
	$(AUR) citra-qt-git
social-media:
	$(INSTALL) discord
	$(AUR) bilili
PTHEMES := python-qdarkstyle
ATHEMES := gtk-theme-arc-gruvbox-git orchis-theme-git paper-icon-theme-git candy-icons-git
themes:
	$(INSTALL) $(PTHEMES)
	$(AUR) $(ATHEMES)
mpd:
	$(INSTALL) mpd timidity++
	#touch ~/.cache/mpd.db
	$(MKDIR) $(XDG_DATA_HOME)/mpd
	$(MKDIR) $(XDG_DATA_HOME)/mpd/playlists
	touch $(XDG_DATA_HOME)/mpd/database
	touch $(XDG_DATA_HOME)/mpd/state
musikcube:
	$(AUR) musikcube
codecs:
	# Audio codecs
	$(INSTALL) flac wavpack opus libamd libvorbis
	# Video codecs
	$(INSTALL) xvidcore x264 x265 libmpeg2 aom libvpx libtheora libdv schroedinger
mkv: # Episode 6 of Cardcaptor Sakura had subtitles exactly 1.05 seconds off (subtitles were timed with the English Dub rather than the japanese dub)
	$(AUR) mkvtoolnix-gui # This tool helped me fix that

# Local servers
searx:
	docker pull searx/searx
# This sets up danbooru with grabber configs
danbooru:
	# Fix this
	curl -LO https://bionus.github.io/imgbrd-grabber/docs/commands/danbooru.js $(XDG_CONFIG_HOME)/Bionus/grabber/danbooru.js
	npm install -g axios form-data open

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
	cat $(XDG_CONFIG_HOME)/cron/crontab # Fix this 
docker:
	$(INSTALL) docker docker-compose
	$(SYSTEMD_ENABLE) docker.service
	# Idk if this will work
	[ -z "$(groups | grep docker)" ] && sudo groupadd docker
	sudo usermod -aG docker $(USER) # Gimme docker perms
crypto:
	$(INSTALL) monero-gui
	$(AUR) xmrig-bin


# Hardware dependent
nvidia:
	$(INSTALL) nvidia nvidia-dkms nvidia-prime
	$(INSTALL) nvidia-settings nvidia-utils lib32-nvidia-utils
amd_gpu:
	$(INSTALL) mesa lib32-mesa
	$(INSTALL) xf86-video-amdgpu
	$(INSTALL) vulkan-radeon amdvlk lib32-vulkan-radeon lib32-amdvlk
	$(INSTALL) vulkan-tools vulkan-mesa-layers
# Microcode
amd_cpu:
	$(INSTALL) amd-ucode
	grub-mkconfig -o /boot/grub/grub.cfg # Let's assume we use grub
intel_cpu:
	$(INSTALL) intel-ucode
	grub-mkconfig -o /boot/grub/grub.cfg # Let's assume grub
intel_gpu:
	$(INSTALL) vulkan-intel lib32-vulkan-intel
dual_boot:
	$(INSTALL) os-prober
	$(INSTALL) ntfs-3g nfs-utils
	sudo grub-mkconfig -o /boot/grub/grub.cfg # Let's assume grub
asus_rog:
	echo -e "[g14]\nSigLevel = DatabaseNever Optional TrustAll\nServer = https://arch.asus-linux.org" >> /etc/pacman.conf
	pacman -Syu
	$(INSTALL) asusctl supergfxctl
	$(SYSTEMD_ENABLE) power-profiles-daemon.service
	$(SYSTEMD_ENABLE) supergfxd
android:
	$(INSTALL) android-tools mtpfs
backlight:
	# By default, xbacklight doesn't work on AMD Gpus for some reason so I have to use my own script
	sudo groupadd video # returns exit code 9 if group exists
	sudo usermod -a -G $(MOKOU)


# Final words
.PHONY: basic configs programming systemd packages all

basic: base install $(AUR_HELPER) pacman shell sudo xorg windowmanager
configs: filetree dotfiles
programming: languages libraries
systemd: bluetooth network automount cron
packages: pkginstall advcpmv terminal fonts text-editor browser social-media themes data-hoarder gaming emulators 
all: basic configs programming systemd packages

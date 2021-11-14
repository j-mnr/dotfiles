# [Arch Linux Install](https://wiki.archlinux.org/index.php/Installation_guide)

## [USB ISO](https://wiki.archlinux.org/title/USB_flash_installation_medium)

### Interwebs

```sh
iwctl
[iwd]# help
[iwd]# device list
[iwd]# station DEVICE scan
[iwd]# station DEVICE get-networks
[iwd]# station DEVICE connect SSID
[iwd]# exit
ping -c1 archlinux.org
```

### Time

```sh
timedatectl set-ntp true
timedatectl status
```

### Partition the disk

```sh
fdisk -l
fdisk /dev/HARD_DRIVE_NAME
Command (m for help): m
Command (m for help): d # delete past partitions
Command (m for help): g # create new label GPT (Linux) table
Command (m for help): n # create partition start with EFI
Command (m for help): t # choose partitions types 1, 19 20
Command (m for help): w # once complete write to disk
```

| Mount Point | Partition | Partition type | Suggested size |
|:-:|:-:|:-:|:-:|
| */mnt/boot* **or** */mnt/efi* | /dev/EFI_SYSTEM_PARTITION | [EFI system partition](https://wiki.archlinux.org/index.php/EFI_system_partition) | +550M |
| [SWAP] | /dev/SWAP_PARTITION | Linux Swap | +2G |
| */mnt* | /dev/ROOT_PARTITION | Linux File System | Everything else |

### Format the partitions

```sh
mkfs.fat -F32 /dev/EFI_SYSTEM_PARTITION
mkswap /dev/SWAP_PARTITION
mkfs.ext4 /dev/ROOT_PARTITION
```

### Configure the partitions

#### 1. Swap

  `swapon /dev/SWAP_PARTITION`

#### 2. Root

```sh
mount /dev/ROOT_PARTITION /mnt
pacstrap /mnt base linux-lts linux-lts-headers linux-firmware sudo vim
genfstab -U /mnt >> /mnt/etc/fstab
```

#### `arch-chroot /mnt` You are now in your system

```sh
ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime
hwclock --systohc
vim /etc/locale.gen # uncomment en_US.UTF-8
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'CHOOSE_YOUR_HOSTNAME' > /etc/hostname # OldLaptop
```

`vim /etc/hosts` write and exit

```vim
127.0.0.1 localhost
::1       localhost
127.0.1.1 CHOOSE_YOUR_HOSTNAME.localdomain CHOOSE_YOUR_HOSTNAME
```

```sh
passwd # Create password for root
useradd -m CHOOSE_YOUR_USERNAME # jay
passwd CHOOSE_YOUR_USERNAME
usermod -aG wheel,audio,video,optical,storage CHOOSE_YOUR_USERNAME
EDITOR=vim visudo # uncomment %wheel ALL=(ALL) ALL
```

#### 3. Boot/EFI

```sh
pacman -S grub efibootmgr # **AND** either amd-ucode or intel-ucode
# https://wiki.archlinux.org/title/Microcode for more info
# possible editions: dosfstools os-prober mtools
mkdir /boot/EFI # this is actually called EFI not a choice.
mount /dev/EFI_SYSTEM_PARTITION /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
```

### Almost Home

```sh
pacman -S git networkmanager
sudo systemctl enable NetworkManager
reboot # and remove the USB
# After the system has rebooted you won't have interwebs but that's what
# installing and enabling NetworkManager was for.
nmtui # Must have interwebs to continue
git clone https://github.com/JayMonari/dotfiles
mv dotfiles .config && cd .config/arch
xargs pacman -S --needed --noconfirm < pac
git clone https://aur.archlinux.org/yay-git
makepkg -is # --install --syncdeps
xargs yay -S --needed --noconfirm < aur
```

### System configurations

Look into /etc/xdg/picom.conf, /etc/X11/xinit/xinitrc

### Neovim

```sh
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c "PlugInstall | qa"
nvim -c "CocInstall -sync coc-css coc-pyright coc-html coc-emmet coc-tag coc-omni coc-emoji coc-git coc-yaml coc-tsserver coc-prettier coc-java coc-markmap | qa" && nvim -c "CocInstall -sync coc-markdownlint coc-lua coc-java-lombok coc-gitignore coc-github coc-fzf-preview coc-cmake coc-clangd coc-angular coc-vetur coc-json | qa" && nvim -c "TSInstall all" && nvim -c CocUpdate
```

### Readings

* [General Recommendations](https://wiki.archlinux.org/title/General_recommendations)
* [Pacman Tips and Tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)
* [ALL the Apps](https://wiki.archlinux.org/title/List_of_applications)
* [Rosetta Stone of Linux Package Managers](https://wiki.archlinux.org/title/Pacman/Rosetta)

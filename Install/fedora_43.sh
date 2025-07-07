#!/data/data/com.termux/files/usr/bin/bash
####
#
# IF ANYNONE FIND THIS BE WARNED: IT WAS NOT TESTED
# but I believe  it's ok
####
pkg install root-repo x11-repo
pkg install proot neofetch pulseaudio -y
#termux-setup-storage
echo ""
fedora=43
build=20250706
neofetch --ascii_distro Fedora -L
folder=fedora-${fedora}-${build}
if [ -d "$folder" ]; then
         first=1
         echo "Skipping Downloading."
fi
tarball="fedora-rootfs.tar"
if [ "$first" != 1 ];then
         "if [ ! -f $tarball ]; then
               echo "Download Rootfs, this may take a while base on your internet speed."
               case `dpkg --print-architecture` in
               aarch64)
                       archurl="aarch64" ;;
               #arm*)
                       #archurl="armhfp" ;;
               #i386)
		       #archurl="x86" ;;
               x86_64)
                       archurl="x86_64" ;;
               *)
                       echo "Unknown Architecture."; exit 1 ;;
               esac
            #wget "https://github.com/fedora-cloud/docker-brew-fedora/raw/${fedora}/${archurl}/fedora-${build}.tar" -O $tarball
         fi"
         wget "https://github.com/fedora-cloud/docker-brew-fedora/raw/${fedora}/aarch64/fedora-${build}.tar" -O $tarball
         mkdir -p $folder
         mkdir -p $folder/binds
         echo "Decompressing Rootfs, please be patient."
         proot --link2symlink tar -xpf ~/${tarball} -C ~/$folder/ --exclude='dev' ||:
    fi
    echo ""
    echo "localhost" > $folder/etc/hostname
    echo "127.0.0.1 localhost" > $folder/etc/hosts
    echo "nameserver 8.8.8.8" > $folder/etc/resolv.conf
bin=.fedora
linux=fedora
echo "Writing launch script"
cat > $bin <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
cd \$(dirname \$0)
## Start pulseaudio
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
## Unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" --kill-on-exit"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A $folder/binds)" ]; then
   for f in $folder/binds/* ;do
       . \$f
   done
fi
command+=" -b /dev"
command+=" -b /dev/urandom:/dev/random"
command+=" -b /dev/null:/proc/sys/kernel/cap_last_cap"
command+=" -b /proc"
command+=" -b /proc/self/fd:/dev/fd"
command+=" -b /proc/self/fd/0:/dev/stdin"
command+=" -b /proc/self/fd/1:/dev/stdout"
command+=" -b /proc/self/fd/2:/dev/stderr"
command+=" -b /sys"
command+=" -b /data/data/com.termux"
command+=" -b $folder/tmp:/dev/shm"
## Uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## Uncomment the following line to mount /sdcard directly to /
command+=" -b /sdcard"
command+=" -b /mnt"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
command+=" TERM=\$TERM"
command+=" LC_ALL=C"
command+=" LANG=pt_BR.UTF-8"
command+=" LANGUAGE=pt_BR"
command+=" /bin/bash --login"
com=" \$@"
if [ -z "\$1" ];then
   exec \$command
else
   \$command -c "\$com"
fi
EOM
     echo ""
     echo "Fixing shebang of $linux"
     termux-fix-shebang $bin
     echo "Making $linux executable"
     chmod +x $bin
     echo "Fixing permissions for $linux"
     chmod -R 755 $folder
     echo "Removing image for some space"
     rm $tarball
echo ""
echo "" > $folder/root/.hushlogin
echo "TZ='America/Sao_Paulo'; export TZ" >> $folder/root/.profile
echo "export PULSE_SERVER=127.0.0.1" >> $folder/etc/skel/.bashrc
echo 'bash .fedora' > $PREFIX/bin/$linux
chmod +x $PREFIX/bin/$linux
     echo ""
     echo "Updating Package,.."
     echo ""
echo "#!/bin/bash
dnf update -y ; dnf upgrade -y
dnf install dialog nano sudo ncurses tzdata -y
cp .bashrc .bashrc.bak ; cp /etc/skel/.bashrc .
rm -rf ~/.bash_profile
exit" > $folder/root/.bash_profile
bash $bin
     echo ""
     echo "You can login to Linux with 'fedora' script next time"
     echo ""
     rm fedora_43.sh
#
## Script edited by 'WaHaSa', Script revision-5.
## Adapted to Fedora 43 on 07/07/2025
#

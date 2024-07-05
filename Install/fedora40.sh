#!/data/data/com.termux/files/usr/bin/bash
pkg install root-repo x11-repo
pkg install proot xz-utils pulseaudio -y
termux-setup-storage
fedora=40
folder=fedora-fs
if [ -d "$folder" ]; then
        first=1
        echo "Skipping Downloading"
fi
tarball="fedora-rootfs.tar"
if [ "$first" != 1 ];then
        if [ ! -f $tarball ]; then
                echo "Download Rootfs, this may take a while base on your internet speed."
                case `dpkg --print-architecture` in
                aarch64)
                        archurl="aarch64" ;;
                #arm*)
                #       archurl="armhf" ;;
                ppc64le)
                        archurl="ppc64le" ;;
                x86_64)
                        archurl="x86_64" ;;
                *)
                        echo "Unknown Architecture"; exit 1 ;;
                esac
		wget "https://github.com/fedora-cloud/docker-brew-fedora/raw/${fedora}/${archurl}/layer.tar" -O $tarball
        fi
        cur=`pwd`
        mkdir -p "$folder"
	mkdir -p $folder/binds
        cd "$folder"
        echo "Decompressing Rootfs, please be patient."
        proot --link2symlink tar -xf ${cur}/${tarball}||:
        cd "$cur"
   fi
   echo "fedora" > ~/"$folder"/etc/hostname
   echo "127.0.0.1 localhost" > ~/"$folder"/etc/hosts
   echo "nameserver 8.8.8.8" > ~/"$folder"/etc/resolv.conf
mkdir -p $folder/binds
bin=.fedora
linux=fedora
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
pulseaudio --start \
    --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" \
    --exit-idle-time=-1
cd \$(dirname \$0)
## Unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --kill-on-exit"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A $folder/binds)" ]; then
    for f in $folder/binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /dev/null:/proc/sys/kernel/cap_last_cap"
command+=" -b /proc"
command+=" -b /data/data/com.termux/files/usr/tmp:/tmp"
command+=" -b $folder/root:/dev/shm"
## Uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
## Uncomment the following line to mount /sdcard directly to /
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM
   #echo "Fixing shebang of $linux"
   termux-fix-shebang $bin
   #echo "Making $linux executable"
   chmod +x $bin
   #echo "Fixing permissions for $linux"
   chmod -R 755 $folder
   #echo "Removing image for some space"
   #rm $tarball
echo "export PULSE_SERVER=127.0.0.1" >> $folder/etc/skel/.bashrc
echo '#!/bin/bash
bash .fedora' > $PREFIX/bin/$linux
chmod +x $PREFIX/bin/$linux
   clear
   echo ""
   echo "Add Fedora Package,.."
   echo ""
echo "#!/bin/bash
dnf install ncurses nano sudo -y
cp /etc/skel/.bashrc .
rm -rf ~/.bash_profile
exit" > $folder/root/.bash_profile
bash $linux
   clear
   echo ""
   echo "You can login to Fedora with 'fedora' script next time"
   echo ""
   #rm fedora40.sh

#
## Script edited by 'WaHaSa', Script V3-revision.
#

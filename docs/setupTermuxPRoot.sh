#!/data/data/com.termux/files/usr/bin/sh 
# Copyright 2017 (c) all rights reserved \
# by SDRausty https://sdrausty.github.io/TermuxPRoot
# Contributors @Soph1a7 (locale-gen, printf, quiet et al.), et al.
# Change mirror to your desired geographic mirror location.
#####################################################################

set -e

bin=startArch.sh

# Detected Architectures 
#--------------------------------------------------------------------

aarch64Android ()
{
file=ArchLinuxARM-aarch64-latest.tar.gz
mirror=os.archlinuxarm.org
path=/os/
makeSystem 
}

armv7lAndroid  ()
{
file=ArchLinuxARM-armv7-latest.tar.gz 
mirror=os.archlinuxarm.org
path=/os/
makeSystem 
}

armv7lChrome ()
{
file=ArchLinuxARM-armv7-chromebook-latest.tar.gz
mirror=os.archlinuxarm.org
path=/os/
makeSystem 
}

x86_64Chrome ()
{
file=archlinux-bootstrap-2017.10.01-x86_64.tar.gz
mirror=mirrors.evowise.com
path=/archlinux/iso/2017.10.01/
makeSystem 
}

# Please add to these Architectures.
#--------------------------------------------------------------------

depend ()
{
apt-get -qq update && apt-get -qq upgrade -y
apt-get -qq install --yes proot wget bsdtar
mkdir -p $HOME/arch
}

fixArch ()
{
cat > $bin <<- EOM
#!/data/data/com.termux/files/usr/bin/sh 
set -e
proot --link2symlink -0 -r $HOME/arch -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM
chmod 700 $bin
rm etc/resolv*
cat > etc/resolv.conf <<- EOM
nameserver 8.8.8.8
nameserver 8.8.4.4
EOM
cat >  etc/locale.gen <<- EOM
en_US.UTF-8 UTF-8 
EOM
cp $HOME/.bash* root/ 
rm *.tar.gz *.tar.gz.md5
}

system ()
{
cd $HOME/arch
if [ "$(uname -o)" = "Android" ];then
	printf "\n\033[32;1mDetected Android.\033[0m\n"
	if [ "$(uname -m)" = "aarch64" ];then
	mo=aarch64Android 
	aarch64Android 
	elif [ "$(uname -m)" = "armv7l" ];then
	mo=armv7lAndroid 
	armv7lAndroid 
	else
	mismatch
	fi
elif [ "$(uname -o)" = "GNU/Linux" ];then
	printf "\n\033[32;1mDetected Chrome OS.\033[0m\n"
	if [ "$(uname -m)" = "armv7l" ];then
	mo=armv7lChrome 
	armv7lChrome 
	elif [ "$(uname -m)" = "x86_64" ];then
	mo=x86_64Chrome 
	x86_64Chrome 
	else
	mismatch
	fi
else 
	printf "\n\033[31;1mDid not detect your architecture. \033[0m\n\n\033[31;1mDid not detect your operating system. \033[0m\n"
	mismatch
fi
}

makeSystem ()
{
downloading 
if [ "$mo" = "x86_64Chrome" ];then
wget -c -q --show-progress http://$mirror${path}md5sums.txt
sed '2q;d' md5sums.txt > $file.md5
wget -c -q --show-progress http://$mirror$path$file
md5check
else
wget -c -q --show-progress http://$mirror$path$file.md5
wget -c -q --show-progress http://$mirror$path$file
md5check
fi
if md5sum -c $file.md5; then
md5success
proot --link2symlink bsdtar -xpf $file 2>/dev/null||:
else
md5error
rm -rf $HOME/arch
exit 0
fi
}

# Printout statement subroutines
#--------------------------------------------------------------------

downloading ()
{
printf "\n\033[32;1mNow downloading \033[33;1m\`$file\`\033[0m ✨\n\n\033[32;1mThis may take a long time depending on your Internet speed; Be patient ⏳\033[0m\n"
}

header ()
{
printf '\033]2;Thank you for using `setupTermuxPRoot.sh` 💎 \007'"\n\033[32;1mThis setup script will attempt to set Arch Linux up in your Termux environment.\n"
sleep 3
printf "\nWhen successfully completed, you will be at the bash prompt in Arch Linux in Termux.\n"
sleep 2
printf "\nUpdating and installing the required tools for Arch Linux installation if necessary.\033[0m\n"
sleep 1
}

footer ()
{
printf "\n\033[32;1mUse \033[33;1m\`pacman -Syu\`\033[32;1m to update your Arch Linux in Termux distribution.  Adjust your /etc/pacman.d/mirrorlist file in accordance with your geographic location 🌎\n\nRun \033[33;1m\`locale-gen\`\033[32;1m to generate the en_US.UTF-8 locale. Edit /etc/locale.gen if you want other locales. Uncomment your preferred locale and run \033[33;1m\`locale-gen\`\033[32;1m again to update. \n\n\033[32;1mUse \033[33;1m\`./arch/$bin\`\033[32;1m from your \033[33;1m\`\$HOME\`\033[32;1m directory to launch Arch Linux in Termux for future sessions. \n\nThank you for using \033[33;1m\`setupTermuxPRoot.sh\`\033[32;1m to install Arch Linux in Termux \033[0m ✨\n\n"
}

md5check ()
{
printf "\n\033[32;1mChecking md5sum. This may take a while; Please be patient ⏳\033[0m\n\n"
}

md5error ()
{
printf "\n⛔\033[31;1m md5sum mismatch! The download was corrupt. Removing failed download.\033[0m\n\n\033[33;1mPlease run \`setupTermuxPRoot.sh\` again!\n\n\033[32;1mSee https://sdrausty.github.io/TermuxPRoot/md5sums for more information.\nIf this keeps repeating, please change your mirror with an editor like vi.\n\033[32;1mSee https://sdrausty.github.io/TermuxPRoot/mirrors for more information.\033[0m\n\n\033[31;1mExiting...\033[0m\n"
}

md5success ()
{
printf "\n\033[32;1mNow uncompressing \033[33;1m\`$file\`\033[0m ✨\n\n\033[32;1mThis will take \033[33;1mmuch longer;\033[32;1m Please be patient ⏳\033[0m\n"
}

mismatch ()
{
printf "\n⛔\033[31;1m ERROR Unknown architecture!\033[0m\033[32;1m  There still is hope.\n\n\033[33;1mCheck for other available architectures\033[32;1m at http://mirror.archlinuxarm.org/os/ and see if any match your device.\n\nIf you find a match, then please submit a pull request at https://github.com/sdrausty/TermuxPRoot/pulls with script modifications.\n\nAlternatively, \033[33;1msubmit a modification request\033[32;1m at https://github.com/sdrausty/TermuxPRoot/issues if you find an architecture match.  Please include output from \033[33;1m\`uname -mo\`\033[32;1m on the device in order to expand architecture autodetection for \033[33;1m\`setupTermuxPRoot.sh\`\033[32;1m.\033[0m\n\n\033[32;1mSee https://sdrausty.github.io/TermuxPRoot/architectures for more information.\n\n\033[31;1mExiting...\033[0m\n"
exit 0
}

tail ()
{
printf "\n\033[32;1mUse \033[33;1m\`./arch/$bin\`\033[32;1m from your \033[33;1m\`\$HOME\`\033[32;1m directory to launch Arch Linux in Termux for future sessions. \n\nThis can be abbreviated to \033[33;1m\`!.\`\033[32;1m at the bash prompt after login into Termux. \n\nThank you for using \033[33;1m\`setupTermuxPRoot.sh\`\033[32;1m to install Arch Linux in Termux \033[0m ✨\n\n"'\033]2;Thank you for using `setupTermuxPRoot.sh` 💎 \007'
}

# Main Block
#--------------------------------------------------------------------

header
depend
system
fixArch
footer
$HOME/arch/$bin
tail

# -rwxrwx--- [setupTermuxPRoot.sh](https://raw.githubusercontent.com/sdrausty/TermuxPRoot/master/setupTermuxPRoot.sh)

# There are many ways to run this setup script on device. Here are some methods:

* `setupTermuxPRoot.sh` can be installed by tapping [this link](https://sdrausty.github.io/TermuxPRoot/setupTermuxPRoot.sh) which should download `setupTermuxPRoot.sh` into your `/sdcard/Download/` directory on your smartphone and tablet.  Then execute this script by running:

```
sh /sdcard/Download/setupTermuxPRoot.sh

```  

* Copying and pasting the following command lines into your Termux command shell is another way to get Linux on device. Hint, copy and paste the following:

```
pkg install wget
wget https://sdrausty.github.io/TermuxPRoot/setupTermuxPRoot.sh
sh setupTermuxPRoot.sh

```

* Run the following command lines to install Linux in Termux on your device. Hint, copy and paste the following into the Termux window: 

```
pkg install git
cd ~ && git clone https://github.com/sdrausty/TermuxPRoot
./TermuxPRoot/setupTermuxPRoot.sh

```
  Should you choose this option, clone to native space on device when you can. See, ["Does Anyone Want to Have More Native Space on Device?"](https://github.com/termux/termux-packages/issues/1176) for more information. 

![Linux on Android](https://s1.postimg.org/1aeg5aatvj/Screenshot_2017-10-18-06-09-29-831_com.termux.png)

This setup script will attempt to set Linux up in your Termux.  When successfully completed, you will be at a bash prompt in Linux in [Termux](https://wiki.termux.com/) using an Android smartphone, tablet or a Chromebook.

[![Community at Termux](https://termux.com/favicon.ico)](https://wiki.termux.com/wiki/Community)

[![Join the chat at https://gitter.im/termux/termux](https://badges.gitter.im/termux/termux.svg)](https://gitter.im/termux/termux)

* Comments are welcome [here](https://github.com/sdrausty/TermuxPRoot/issues) ✍

* Pull requests are welcome [here](https://github.com/sdrausty/TermuxPRoot/pulls) ✍

Thanks for making this project work; Please contribute 🔆 

Please visit the [Termux wiki website](https://wiki.termux.com/) for more information about Linux on device with Termux.

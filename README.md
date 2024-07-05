
<p align="center">My Channel</br><b>
| <a href="https://discord.gg/GCehyym">Discord</a> | <a href="https://youtube.com/channel/UC3sLb7eZCu72iv3G1yUhUHQ">YouTube</a> |</b></p>

---
## Fedora on Termux Android
![fedora](https://github.com/wahasa/Project/assets/69626847/186d4196-5c66-41de-80bd-90ef6e012c5d)

---
• Install Apps on Android
- [x] [Termux](https://play.google.com/store/apps/details?id=com.termux)
- [x] [Vnc Viewer](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android)

## Installation
Copy and paste this commands to Termux
> pkg update

<details><summary><b><code>Install Fedora</code></b></summary>

#### Fedora 41 (Pre-release)
Rootfs : Arm64, Amd64
```
pkg install wget -y ; wget https://raw.githubusercontent.com/wahasa/Fedora/main/Install/fedora41.sh ; chmod +x fedora41.sh ; ./fedora41.sh
```

#### Fedora 36 (Container Image)
Rootfs : Armhf, Arm64, Amd64
```
pkg install wget -y ; wget https://raw.githubusercontent.com/wahasa/Fedora/main/Install/fedora36.sh ; chmod +x fedora36.sh ; ./fedora36.sh
```

#### List Fedora | [Click Here >](https://github.com/wahasa/Fedora/tree/main/Install)

---
</details>

* Start Fedora
```
fedora
```

* Stop Fedora
```
exit
```

* Delete Fedora
```
chmod -R 775 fedora-fs ; rm -rf fedora-fs .fedora $PREFIX/bin/fedora
```

---
Basic commands Fedora
> dnf update : Update list package.</br>
> dnf upgrade : Upgrade package.</br>
> dnf search (pkg) : Search package.</br>
> dnf install (pkg) : Install package.</br>
> dnf autoremove (pkg) : Delete pkg.</br>
> dnf -h : Help all commands.

---
## Desktop Environments
on Fedora, run this commands
> dnf update

<details><summary><b><code>Install Xfce Desktop</code></b></summary>

![Screenshot_2024-03-13-16-58-38-267_com realvnc viewer android](https://github.com/wahasa/Fedora/assets/69626847/c023e776-889b-4570-8b14-024a70707321)
```
dnf install wget -y ; wget https://raw.githubusercontent.com/wahasa/Fedora/main/Desktop/de-xfce.sh ; chmod +x de-xfce.sh ; ./de-xfce.sh
```
</details>

<details><summary><b><code>Install Lxde Desktop</code></b></summary>

![Screenshot_2024-03-17-09-22-31-146_com realvnc viewer android](https://github.com/wahasa/Fedora/assets/69626847/d0cab67d-f069-4a79-8ef3-fd499ea6574f)
```
dnf install wget -y ; wget https://raw.githubusercontent.com/wahasa/Fedora/main/Desktop/de-lxde.sh ; chmod +x de-lxde.sh ; ./de-lxde.sh
```
</details>

<details><summary><b><code>Install Lxqt Desktop</code></b></summary>

![Screenshot_2024-03-12-16-49-08-489_com realvnc viewer android](https://github.com/wahasa/Fedora/assets/69626847/aab406f5-b039-4071-b8c0-0e7d4ecb52a2)
```
dnf install wget -y ; wget https://raw.githubusercontent.com/wahasa/Fedora/main/Desktop/de-lxqt.sh ; chmod +x de-lxqt.sh ; ./de-lxqt.sh
```
</details>

<details><summary><b><code>Install Kde Desktop</code></b></summary>

![kde](https://github.com/wahasa/Fedora/assets/69626847/f9cae4c0-669b-40f4-9200-40c64e0f2800)
```
There is a problem
```
</details>

---
Feature
- [x] Fixed Sound
- [x] Access to Sdcard
- [x] Access to Termux-x11
- [x] Fixed Browser Crash  | [Click Here >](https://github.com/wahasa/Fedora/tree/main/Note)
- [x] Install Applications | [Click Here >](https://github.com/wahasa/Fedora/tree/main/Apps)

Visit problems now in : [Issues](https://github.com/wahasa/Fedora/issues)

---
## VNC Viewer
<details></br>
<summary><b><code>VNC Viewer Android</code></b></summary>

* Start VNC Server

In Fedora, run this command to start
```
vnc-start
```

* Open Vnc Viewer

Add (+) VNC Client to connect, fill with :

Address
```
localhost:1
```

Name
```
Fedora Desktop
```

To disconnect VNC Client, click (X) on the right.

* Stop VNC Server

In Fedora, run this command to stop
```
vnc-stop
```
</details>

---
## Termux-x11
<details></br>
<summary><b><code>Termux-x11 Android</code></b></summary>

[> Click Here <](https://github.com/wahasa/Fedora/blob/main/Note/Termux-x11fix.md)
</details>
</br>

---
<p align="center">Good Luck</p>

---

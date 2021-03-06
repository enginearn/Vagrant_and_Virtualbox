# Vagrant_and_Virtualbox

VagrantとVirtualbox (Box: ubuntu/impish64)

## 環境

| | Description |
| --- | :---: |
| Vagrant Version | [2.2.19](https://www.vagrantup.com/) |
| HOST | Windows 10 |
| SSH | [Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/releases) |
| Hyper-V | ON |
| Docker Desktop | Installed, but not running |
| Console | PowerShell |
| VirtualBox | 6.1 |
| GUEST | Ubuntu 21.10 (Box: [ubuntu/impish64](https://app.vagrantup.com/ubuntu/boxes/impish64)) |

## 起動手順

vagrantをインストール後、任意のフォルダで以下を実行

```$ vagrant init ubuntu/impish64```

[他のBOXはここから検索できる: Discover Vagrant Boxes](https://app.vagrantup.com/boxes/search).

```$ vagrant up```

```$ vagrant ssh```

# Trouble Shoot

```vagrant up```後に以下エラーが発生した場合、```vagrant plugin repair```を実行

```
The guest machine entered an invalid state while waiting for it
to boot. Valid states are 'starting, running'. The machine is in the
'unknown' state. Please verify everything is configured
properly and try again.

If the provider you're using has a GUI that comes with it,
it is often helpful to open that and watch the machine, since the
GUI often has more helpful error messages than Vagrant can retrieve.
For example, if you're using VirtualBox, run `vagrant up` while the
VirtualBox GUI is open.

The primary issue for this error is that the provider you're using
is not properly configured. This is very rarely a Vagrant issue.
PS C:\Users\nagar\Development\Vagrant\ubuntu\21.10> vagrant plugin repair
Repairing currently installed global plugins. This may take a few minutes...
Installed plugins successfully repaired!
```

```
# HOST: Windows PowerShell
$ vagrant plugin repair
Repairing currently installed global plugins. This may take a few minutes...
Installed plugins successfully repaired!
```

一度、環境を壊す
```
# HOST: Windows PowerShell
$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```

```vagrant up```を再度実行。うまくいっているぽい。

```
# HOST: Windows PowerShell
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'ubuntu/impish64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/impish64' version '20220506.0.0' is up to date...
==> default: Setting the name of the VM: 2110_default_1652322045480_87600
==> default: Clearing any previously set network interfaces...
==> default: Available bridged network interfaces:
1) Intel(R) Dual Band Wireless-AC 7265
2) Hyper-V Virtual Ethernet Adapter
3) Npcap Loopback Adapter
==> default: When choosing an interface, it is usually the one that is
==> default: being used to connect to the internet.
==> default:
    default: Which interface should the network bridge to? 1
.
.
.

```

```vagrant ssh```でguest OSに接続

```
# HOST: Windows PowerShell
$ vagrant ssh
Welcome to Ubuntu 21.10 (GNU/Linux 5.13.0-41-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu May 12 02:47:59 UTC 2022

  System load:  0.15              Users logged in:         1
  Usage of /:   7.6% of 39.86GB   IPv4 address for enp0s3: 10.0.2.15
  Memory usage: 25%               IPv4 address for enp0s8: 192.168.33.10
  Swap usage:   0%                IPv4 address for enp0s9: 192.168.1.27
  Processes:    117
  
# GUEST: Ubuntu 21.10 bash
vagrant@ubuntu-impish:~$
```

以下のエラーが発生した場合、

```
An error occurred in the underlying SSH library that Vagrant uses. The error message is shown below. 
In many cases, errors from this library are caused by ssh-agent issues. 
Try disabling your SSH agent or removing some keys and try again.
```

以下のエラーが発生した場合、rubyのプロセスが残ってしまっていることが原因なので、

タスクマネージャーで```Ruby Interpreter (CUI)```をKillする

```
An action 'up' was attempted on the machine 'default',
but another process is already executing an action on the machine.  
Vagrant locks each machine for access by only one process at a time.
Please wait until the other Vagrant process finishes modifying this 
machine, then try again.

If you believe this message is in error, please check the process   
listing for any "ruby" or "vagrant" processes and kill them. Then   
try again.
```

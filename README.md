# Spark

Spark is an [Ansible][1] playbook meant to provision a personal machine running
[Arch Linux][2]. It is intended to run locally on a fresh Arch install (ie,
taking the place of any [post-installation][3]), but due to Ansible's
idempotent nature it may also be run on top of an already configured machine.

Spark assumes it will be run on a laptop and performs some configuration based
on this assumption. This behaviour may be changed by removing the `laptop` role
from the playbook or by skipping the `laptop` tag.

If Spark is run on either a ThinkPad or a MacBook, it will detect this and
execute platform-specific tasks.

## Running

First, sync mirrors and install Ansible:

    $ pacman -Syy python2-passlib ansible
    
Run the playbook and provide root password.

    $ ./run.sh

## SSH

By default, Ansible will attempt to install the private SSH key for the user. The
key should be available at the path specified in the `ssh.user_key` variable.
Removing this variable will cause the key installation task to be skipped.

### SSHD

If `ssh.enable_sshd` is set to `True` the [systemd socket service][4] will be
enabled. By default, sshd is configured but not enabled.

## Dotfiles

Ansible expects that the user wishes to clone dotfiles via the git repository
specified via the `dotfiles.url` variable and install them with [rcm][5]. The
destination to clone the repository to is defined by the `dotfiles.destination`
variable. This is relative the user's home directory.

These tasks will be skipped if the `dotfiles` variable is not defined.

## Tagging

All tasks are tagged with their role, allowing them to be skipped by tag in
addition to modifying `playbook.yml`.

## AUR

All tasks involving the [AUR][6] are tagged `aur`. To provision an AUR-free
system, pass this tag to ansible's `--skip-tag`.

AUR packages are installed via the [ansible-aur][7] module. Note that while
[aura][8], an [AUR helper][9], is installed by default, it will *not* be used
during any of the provisioning.

## MAC Spoofing

By default, the MAC address of all network interfaces is spoofed at boot,
before any network services are brought up. This is done with [macchiato][11],
which uses legitimate OUI prefixes to make the spoofing less recognizable.

MAC spoofing is desirable for greater privacy on public networks, but may be
inconvenient on home or corporate networks where a consistent (if not real) MAC
address is wanted for authentication. To work around this, allow `macchiato` to
randomize the MAC on boot, but tell NetworkManager to clone the real (or a fake
but consistent) MAC address in its profile for the trusted networks. This can
be done in the GUI by populating the "Cloned MAC address" field for the
appropriate profiles, or by setting the `cloned-mac-address` property in the
profile file at `/etc/NetworkManager/system-connections/`.

Spoofing may be disabled entirely by setting the `network.spoof_mac` variable
to `False`.

[1]: http://www.ansible.com
[2]: https://www.archlinux.org
[3]: https://wiki.archlinux.org/index.php/Installation_guide#Post-installation
[4]: https://wiki.archlinux.org/index.php/Secure_Shell#Managing_the_sshd_daemon
[5]: https://thoughtbot.github.io/rcm/
[6]: https://aur.archlinux.org
[7]: https://github.com/pigmonkey/ansible-aur
[8]: https://github.com/aurapm/aura
[9]: https://wiki.archlinux.org/index.php/AUR_helpers
[10]: https://firejail.wordpress.com/
[11]: https://github.com/EtiennePerot/macchiato
[12]: https://github.com/pigmonkey/nmtrust
[13]: http://isync.sourceforge.net/
[14]: http://offlineimap.org/
[15]: http://msmtp.sourceforge.net/
[16]: http://sourceforge.net/p/msmtp/code/ci/master/tree/scripts/msmtpq/README.msmtpq
[17]: https://github.com/pimutils/vdirsyncer
[18]: https://wiki.archlinux.org/index.php/Systemd/Timers
[19]: https://www.tarsnap.com/
[20]: https://www.tarsnap.com/gettingstarted.html
[21]: https://github.com/miracle2k/tarsnapper
[22]: https://github.com/pigmonkey/backitup
[23]: https://www.torproject.org/
[24]: https://github.com/EtiennePerot/parcimonie.sh
[25]: https://www.bitlbee.org/main.php/news.r.html
[26]: https://weechat.org/
[27]: https://git-annex.branchable.com/
[28]: http://www.postgresql.org/
[29]: https://github.com/boramalper/himawaripy
[30]: https://en.wikipedia.org/wiki/Himawari_8

# Backup-CloudPanel-Nextcloud
*BorgBackup Script - CloudPanel, Nextcloud*

[![foxly.de](https://foxly.de/media/223-github-logo-png/)](https://foxly.de)

<div align=center>

[![Commits](https://img.shields.io/github/last-commit/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/commits/main) [![GitHub release](https://img.shields.io/github/release/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/releases) [![GitHub license](https://img.shields.io/github/license/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square&color=lightgray)](LICENSE.md) [![GitHub file size in bytes](https://img.shields.io/github/size/foxly-it/Backup-CloudPanel-Nextcloud/backup.sh?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/blob/main/Backup-CloudPanel-Nextcloud.sh)
---
[![foxly.de](https://foxly.de/media/232-png-bild-png/)](https://foxly.de)
---
</div>

This script is designed for [CloudPanel](CloudPanel.io). It backs up all data located in ```/home/cloudpanel``` to a Borgbackup repository. Furthermore, before the actual backup process, all databases that are specified are backed up and stored in ```/home/cloudpanel/backup```. In the script itself you have to define which database is used, e.g. MySQL/MariaDB or PostgreSQL. Adjustments that need to be changed in the script are marked with TODO.
In the script a Nextcloud instance is also considered, should this function not be used, it can simply be commented out.

Of course, this script can be adapted to other systems.

---
## Usage

In order to back up data, a repository must first be created. This can be created locally or on a remote computer via ssh.

*local:*
```
  borg init --encryption=repokey /path/to/backup
```
*remote*
```
  borg init --encryption=repokey user@server.ip.or.domain:/path/to/backup
```
---
---

## Features

* MariaDB/MySQL support
* PostgreSQL support
* Nextcloud support

---

### Operating System

#### Recommended

* Ubuntu 20.04 (__Focal__ Fossa)
* Debian 10 (__Buster__)
* Raspbian 10 (__Buster__)

<div align=center>
  
# Backup-CloudPanel-Nextcloud
#### BorgBackup Script - CloudPanel, Nextcloud

[![Commits](https://img.shields.io/github/last-commit/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/commits/main) [![GitHub release](https://img.shields.io/github/release/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/releases) [![GitHub license](https://img.shields.io/github/license/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square&color=lightgray)](LICENSE.md) [![GitHub file size in bytes](https://img.shields.io/github/size/foxly-it/Backup-CloudPanel-Nextcloud/backup.sh?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/blob/main/Backup-CloudPanel-Nextcloud.sh)
---
[![foxly.de](https://foxly.de/media/232-png-bild-png/)](https://foxly.de)
---
</div>

This script is designed for [CloudPanel v2](CloudPanel.io). It backs up all data located in ````/home/```` to a BorgBackup repository. All databases that need to be backed up must be specified in the script. Adjustments that need to be changed in the script are marked with TODO.
A Nextcloud instance is also considered in the script; if this function is not used, it can simply be commented out.

Of course, this script can be adapted to other systems.

CloudPanel v1 is obsolete and is no longer supported.

---
## Usage

In order to back up data, a repository must first be created. This can be created locally or on a remote computer via ssh.

*local:*
```
  borg init --encryption=repokey /path/to/backup
```
*remote:*
```
  borg init --encryption=repokey user@server.ip.or.domain:/path/to/backup
```

---

## Features

* MariaDB/MySQL support
* Nextcloud support

---

### Operating System

#### Recommended

* Debian 12 (__bookworm__)
* Ubuntu 24.04 (__Noble Numbat__)

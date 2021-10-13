# Backup-CloudPanel-Nextcloud
*BorgBackup Script - CloudPanel, Nextcloud*

[![foxly.de](https://foxly.de/media/223-github-logo-png/)](https://foxly.de)

[![Blog](https://img.shields.io/static/v1.svg?color=FF6C54&labelColor=55555&logoColor=ffffff&style=for-the-badge&label=Foxly.de&message=IT-Blog)](https://foxly.de "How-To guides, opinions and much more!")
[![GitHub](https://img.shields.io/static/v1.svg?color=FF6C54&labelColor=55555&logoColor=ffffff&style=for-the-badge&label=Foxly.de&message=GitHub)](https://github.com/foxly-it "view the source for all of our repositories.")
[![CloudPanel](https://img.shields.io/static/v1.svg?color=398fdb&labelColor=55555&logoColor=ffffff&style=for-the-badge&label=CloudPanel.io&message=Nextcloud)](https://foxly.de/category-article-list/5-nextcloud/ "Installation Guides.")

[![Commits](https://img.shields.io/github/last-commit/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/commits/main) [![GitHub release](https://img.shields.io/github/release/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/releases) [![GitHub license](https://img.shields.io/github/license/foxly-it/Backup-CloudPanel-Nextcloud?style=flat-square&color=lightgray)](LICENSE.md) [![GitHub file size in bytes](https://img.shields.io/github/size/foxly-it/Backup-CloudPanel-Nextcloud/Backup-CloudPanel-Nextcloud.sh?style=flat-square)](https://github.com/foxly-it/Backup-CloudPanel-Nextcloud/blob/main/Backup-CloudPanel-Nextcloud.sh)

This backupscript is designed to be simple. It is adapted for [CloudPanel](CloudPanel.io). Of course there is also a focus on Nextcloud.

It backs up both the databases and the files.

## Usage

First, a BorgBackup repository must be created. 

```
  borg init --encryption=repokey /path/to/backup
```

Now you can adjust the script to your needs.

[![foxly.de](https://foxly.de/media/232-png-bild-png/)](https://foxly.de)

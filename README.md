# Backup-CloudPanel-Nextcloud
*BorgBackup Script - CloudPanel, Nextcloud
[![foxly.de](https://foxly.de/media/223-github-logo-png/)](https://foxly.de)

[![Blog](https://img.shields.io/static/v1.svg?color=FF6C54&labelColor=55555&logoColor=ffffff&style=for-the-badge&label=Foxly.de&message=IT-Blog)](https://foxly.de "How-To guides, opinions and much more!")
[![GitHub](https://img.shields.io/static/v1.svg?color=FF6C54&labelColor=55555&logoColor=ffffff&style=for-the-badge&label=Foxly.de&message=GitHub)](https://github.com/foxly-it "view the source for all of our repositories.")
[![CloudPanel](https://img.shields.io/static/v1.svg?color=398fdb&labelColor=55555&logoColor=ffffff&style=for-the-badge&label=CloudPanel.io&message=Nextcloud)](https://foxly.de/category-article-list/5-nextcloud/ "Installation Guides.")


This backupscript is designed to be simple. It is adapted for [CloudPanel](CloudPanel.io). Of course there is also a focus on Nextcloud.

It backs up both the databases and the files.

## Usage

First, a BorgBackup repository must be created. 

```
  borg init --encryption=repokey /path/to/backup
```

Now you can adjust the script to your needs.

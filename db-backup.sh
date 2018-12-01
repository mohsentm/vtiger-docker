# Docker image for Vtiger 7 CRM


[Vtiger CRM](https://www.vtiger.com) is online software that helps 300000+ businesses grow sales, improve marketing ROI, and deliver great customer service.

Vtiger CRM Version: 7.1.0


## Change default port

Vtiger default port is 8080. if this port is reserved on your server or wants to use other port, before start the docker you must change the `web service` port on `docker-composer.yml`. e.g. default port `8080:80` change to `4000:80`  
```
[...]
services:
  web:
    image: mohsentm/vtiger
    ports:
      - "4000:80"
	[...]
[...]
```
    
## Quick start

__IMPORTANT NOTE :__ `vitgercrm` directory owner must be `www-data`. Before start the docker, check the `vitgercrm` directory owner. if owner of directory and files is not `www-data` change the owner
```
$ chown -R www-data:www-data vtigercrm
```

The easiest way to start Vtiger with MySQL is using [Docker Compose](https://docs.docker.com/compose/). Just clone this repo and run following command in the root directory. The default `docker-compose.yml` uses MySQL and phpMyAdmin.

```
$ docker-compose up -d
```

For database username and password, please refer to the file `env`. You can also update the file `env` to update those configurations. Below are the default configurations.

```
MYSQL_HOST=db
MYSQL_ROOT_PASSWORD=6k*&lj@;!
MYSQL_USER=becovtiguser
MYSQL_PASSWORD=5g#k@&k2p
MYSQL_DATABASE=becovtig

BASE_URL=http://127.0.0.1
```

For example, if you want to change the mysql username and password , just update the variable `MYSQL_USER`, e.g. `MYSQL_USER=newdbuser25`.


## Installation

After starting the container, you'll see the setup page of Vtiger. Read `env` file for get the database configuration information.


### Database

The default `docker-compose.yml` uses MySQL as the database and starts [phpMyAdmin](https://www.phpmyadmin.net/). The default URL for phpMyAdmin is `http://localhost:8583`. Use MySQL username and password to log in.

## Backup Configuration

Vtiger files exist on `vitgercrm` directory and database file will store on `db/mysql` directory.
for get database and full backup you can use this bash script (`db-backup.sh`,`full-backup.sh`). set cron for get automatically backup.

__NOTE:__ Default directory for save the back file is `/home/test/CRM_Backup`. for change the default directory edit this bash script and change the `BACKUP_DIR` values. e.p. `BACKUP_DIR:"YOUR_PATH"`
```
# database backup once a day
0 0 * * * PROJECT_PATH/db-backup.sh

# full backup once a week
0 1 * * 0 ROJECT_PATH/full-backup.sh
```


## FAQ

### Where is the database?

Vtiger 7 cannot run with a database. This image is for Vtiger 7 only. It doesn't contain MySQL server. MySQL server should be started in another container and linked with Vtiger 7 container. It's recommended to use Docker Compose to start both containers. You can also use [Kubernetes](https://kubernetes.io/) or other tools.


### Why getting access denied error after changing the default DB password?

If you change the default DB password in `env` file and get the access denied error when installing Vtiger.


## Contribute

Would you like to help with this project?  Great!  You don't have to be a developer, either.  If you've found a bug or have an idea for an improvement, please open an [issue](https://github.com/mohsentm/vtiger-docker/issues) and tell us about it.

If you *are* a developer wanting contribute an enhancement, bug fix or other patch to this project, please fork this repository and submit a pull request detailing your changes. We review all PRs!

This open source project is released under the [Apache 2.0 license](https://opensource.org/licenses/Apache-2.0) which means if you would like to use this project's code in your own project you are free to do so.  Speaking of, if you have used our code in a cool new project we would like to hear about it!  [Please send us an email](mailto:hosseini.m1370@gmail.com).

## License

Please refer to the [LICENSE](https://opensource.org/licenses/Apache-2.0) file that came with this project.

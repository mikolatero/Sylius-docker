#!/bin/bash
/etc/init.d/mysql start
php /opt/sylius/app/console server:run 0.0.0.0:8000

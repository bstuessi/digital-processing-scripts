#!/bin/bash

timestamp=$(date "+%Y-%m-%dT%H_%M")
db=digital_appraisal_new
pg_dump -Fc $db > $HOME/Desktop/appraisal_db_backups/${db}_${timestamp}.dump

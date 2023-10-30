#!/bin/bash

timestamp=$(date "+%Y-%m-%dT%H_%M")
db=digital_appraisal
pg_dump -Fc $db > /Users/mkf26/Desktop/appraisal_db_backups/${db}_${timestamp}.dump

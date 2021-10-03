LOG_FILE_PATH="./log.txt"

getCurrentDate() {
 echo "$(date +"%D") - $(date +"%X")"
}

log() {
 if [ $# -gt 1 ]; then
   echo "Incorrect parameters passed"
 else
   if [ ! -f "$LOG_FILE_PATH" ]; then
     echo "touch $LOG_FILE_PATH"
     echo "[$(getCurrentDate)] - Log file has been created because it is not existed before" >> "$LOG_FILE_PATH"
     echo "[$(getCurrentDate)] - $1" >> "$LOG_FILE_PATH"
   else
     echo "[$(getCurrentDate)] - $1" >> "$LOG_FILE_PATH"
   fi
 fi
}


check_script_initial_arguments() {
 if [ $# -eq 0 ]; then
   echo "ERROR: No path to archive"
   $(log "Executed with no arguments")
   exit 1
 else
   $(log "Executed with argument path=$1")
 fi
}

check_is_folder_exists() {
 if [ ! -d "$1" ]; then
   echo "Folder is not found"
   $(log "Folder $1 is not found, script killed")
   exit 1
 fi
}

create_archive() {
 $(log "Starting archiving for path=$1")
 zip -r "$1/../archive.zip" $1
 $(log "Folder with path=$1 archived successfully")
}

main() {
 check_script_initial_arguments $1
 check_is_folder_exists $1

 create_archive $1
 exit 0
}

(main $1)

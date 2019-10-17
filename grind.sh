#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -d "$DIR" ]]; then
    echo "$DIR does not exist. Please provide the path to the folder to process. Job terminated."
    exit 1
fi

if [[ ! -d "$OUT" ]]; then
    echo "$OUT does not exist. Directory created"
    mkdir $OUT
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run grind
#

PROG="01-run-grind"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

echo "launch run_grind.sh"
JOB_ID=`qsub $ARGS -v WORKER_DIR,BIN_SIZE,NB_BIN_PER_GENOMES,SUBSET,DIR,REPLICATE,SIZE_CONTIGS,STEP,OUT,STDERR_DIR,STDOUT_DIR -N run_grind -e "$STDERR_DIR" -o "$STDOUT_DIR" $SCRIPT_DIR/run_grind.sh`

if [ "${JOB_ID}x" != "x" ]; then
   echo Job: \"$JOB_ID\"
   PREV_JOB_ID=$JOB_ID  
else
   echo Problem submitting job. Job terminated
fi

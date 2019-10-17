export CWD=$PWD
# where the original genomes are stored
export DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/mock_lichen/mock3/genomes/phages"
# parameters for the mock community creation
export SIZE_CONTIGS=500
export STEP=500
export BIN_SIZE=10
export REPLICATE=10
export SUBSET=1000
export NB_BIN_PER_GENOMES=5
# output directory
export OUT="$DIR/grind2_$SIZE_CONTIGS"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}

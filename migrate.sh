#!/bin/bash

#github author: @italojs

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m' 
NC='\033[0m' # No Color

INFO(){
    MESSAGE=$1
    echo ${GREEN}[INFO] - $MESSAGE ${NC}
}

LOG(){
    MESSAGE=$1
    echo "${CYAN}> $MESSAGE ${NC}"
}

ERROR(){
    MESSAGE=$1
    echo "${RED}[ERROR] - $MESSAGE ${NC}"
}

MIGRATE()
{
    FROM=$1
    TO=$2

    # Git clone
    GIT_FOLDER=$(basename "$FROM")
    LOG "git clone $FROM $GIT_FOLDER"
    git clone $FROM $GIT_FOLDER

    # cd git_clone_folder
    LOG "cd "$GIT_FOLDER""
    cd "$GIT_FOLDER"
    git fetch

    # Dowloanding/tracking all branches
    for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
        LOG "git branch --track ${branch##*/} $branch;"
        git branch --track "${branch##*/}" "$branch"; 
    done

    # for each local/tracked branch
    for branch in $(git branch --all | grep -v '^\s*remotes' ); do
        # get back to original remote
        LOG "git remote set-url origin $FROM"
        git remote set-url origin $FROM

        existsBranch=$(git branch -a | grep $branch)
        if [ ! -n "$existsBranch" ]; then
            ERROR "Branch $branch do not exist";
            continue;
        fi

        # git checkout to branch that you will upload
        LOG "git checkout $branch"
        git checkout $branch
        echo ""
        
        # update this branch
        LOG "git pull output"
        git pull origin $branch
        echo""

        # update remote to destination remote
        LOG "git remote set-url origin $TO"
        git remote set-url origin $TO
        #git push
        LOG "git push -u origin $branch"
        git push -u origin $branch

        echo 
        echo ------------------------------------------------------------------------
        echo  

    done

    INFO "--------------FINISHED------------------"
}

FROM=$1
TO=$2

INFO "Migrating repository from ${NC}$FROM${GREEN} to ${NC}$TO"

MIGRATE $FROM $TO


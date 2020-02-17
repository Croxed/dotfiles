#! /usr/bin/env zsh

compdef _git-remove-merged git-remove-merged

_git-remove-merged() {
    _arguments \
        '*:Branch to ignore:__branch_names'
}

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'

# Function to verify user wants to do something accepting "y" or "n" as a response
verify() {
    local PROMPT=${1:-"Are you sure? (y/n)"}

    while  true ; do
        echo $PROMPT
        read RESPONSE
        if [ "$RESPONSE" = "y" ]; then
            return 0
        elif [ "$RESPONSE" = "n" ]; then
            return 1
        else
            echo "Please enter valid response."
        fi
    done
}

__command_successful () {
  if (( ${#pipestatus:#0} > 0 )); then
    _message 'not a git repository'
    return 1
  fi
  return 0
}


# Pulled function from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git-extras/git-extras.plugin.zsh
__branch_names() {
    local expl
    declare -a branch_names
    branch_names=(${${(f)"$(_call_program branchrefs git for-each-ref --format='"%(refname)"' refs/heads 2>/dev/null)"}#refs/heads/})
    __command_successful || return
    _wanted branch-names expl branch-name compadd $* - $branch_names
}

function git-remove-merged() {
    # Define functions that will only be used here locally
    local function deleteLocal()
    {
        local COMMAND="git branch -d $@"
        eval $COMMAND
    }

    # Do actual work
    local CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

    local EXCLUDE_STRING="master"
    if [ "$CURRENT_BRANCH" != "master" ]; then
        # Add the base branch to exclude pattern with master
        EXCLUDE_STRING="master\|$CURRENT_BRANCH"
    fi

    for i in $@
    do
        EXCLUDE_STRING="$EXCLUDE_STRING\|$i"
    done

    # Build the command to get the names of branches that have been merged into the base, excluding those in the EXCLUDE_STRING
    local COMMAND="git branch --merged $CURRENT_BRANCH | grep -v '^[ *]*$EXCLUDE_STRING$'"

    # Get branches from running COMMAND
    local BRANCHES_TO_DELETE=($(eval $COMMAND))
    if [ ! "$BRANCHES_TO_DELETE" ]; then
        echo "No branches to delete"
        return
    fi

    # Parse branches to array of values and print them for the user
    echo "Branches to be deleted:"
    print -l ${BRANCHES_TO_DELETE[*]}

    if ! verify "Are you sure you would like to delete these? (y/n)"; then
        return
    fi

    # Convert array back to " " seperated string
    BRANCHES_TO_DELETE=${BRANCHES_TO_DELETE[*]}
    deleteLocal $BRANCHES_TO_DELETE
}

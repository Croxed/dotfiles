#!/usr/bin/zsh

# shell helper functions
# mostly written by Nathaniel Maia, some pilfered from around the web

# better ls and cd
unalias ls >/dev/null 2>&1
ls()
{
    command ls --color=auto -F "$@"
}

unalias cd >/dev/null 2>&1
if command -v zoxide &>/dev/null; then
    cd()
    {
        z "$@" && command ls
    }
else
    cd()
    {
        builtin cd "$@" && command ls
    }
fi

por()
{
    local orphans
    orphans="$(pacman -Qtdq 2>/dev/null)"
    [[ -z $orphans ]] && printf "System has no orphaned packages\n" || sudo pacman -Rns $orphans
}

pss()
{
    PS3=$'\n'"Enter a package number to install, Ctrl-C to exit"$'\n\n'">> "
    select pkg in $(pacman -Ssq "$1"); do sudo pacman -S $pkg; break; done
}

pacsearch()
{
    echo -e "$(pacman -Ss "$@" | sed \
        -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
        -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
        -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
        -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g')"
}

tmuxx()
{
    session="${1:-main}"
    if ! grep -q "$session" <<< "$(tmux ls 2>/dev/null | awk -F':' '{print $1}')"; then
        tmux new -d -s "$session"
        tmux neww
        tmux neww
        tmux splitw -h
        tmux selectw -t 1
        tmux -2 attach -d
    elif [[ -z $TMUX ]]; then
        session_id="$(date +%Y%m%d%H%M%S)"
        tmux new-session -d -t "$session" -s "$session_id"
        tmux attach-session -t "$session_id" \; set-option destroy-unattached
    fi
}

surfs()
{
    if ! hash surf-open tabbed surf >/dev/null 2>&1; then
        local reqs="tabbed, surf, surf-open (shell script provided with surf)"
        printf "error: this requires the following installed\n\n\t%s\n" "$reqs"
        return 1
    fi

    declare -a urls
    if (( $# == 0 )); then
        local main="https://www.google.com"
        urls=("https://www.youtube.com"
        "https://forum.archlabslinux.com"
        "https://bitbucket.org"
        "https://suckless.org"
        )
    else
        local main="$1"
        shift
        for arg in "$@"; do
            urls+=("$arg")
        done
    fi

    (
        surf-open "$main" &
        sleep 0.1
        for url in "${urls[@]}"; do
            surf-open "$url" &
        done
    ) & disown
}

flac_to_mp3()
{
    for i in "${1:-.}"/*.flac; do
        [[ -e "${1:-.}/$(basename "$i" | sed 's/.flac/.mp3/g')" ]] || ffmpeg -i "$i" -qscale:a 0 "${i/%flac/mp3}"
    done
}

deadsym()
{
    for i in **/*; do [[ -h $i && ! -e $(readlink -fn "$i") ]] && rm -rfv "$i"; done
}

gitpr()
{
    github="pull/$1/head:$2"
    _fetchpr $github $2 $3
}

bitpr()
{
    bitbucket="refs/pull-requests/$1/from:$2"
    _fetchpr $bitbucket $2 $3
}

_fetchpr()
{
    # shellcheck disable=2154
    [[ $ZSH_VERSION ]] && program=${funcstack#_fetchpr} || program='_fetchpr'
    if (( $# != 2 && $# != 3 )); then
        printf "usage: %s <id> <branch> [remote]" "$program"
        return 1
    else
        ref=$1
        branch=$2
        origin=${3:-origin}
        if git rev-parse --git-dir &> /dev/null; then
            git fetch $origin $ref && git checkout $branch
        else
            echo 'error: not in git repo'
        fi
    fi
}

sloc()
{
    [[ $# -eq 1 && -r $1 ]] || { printf "Usage: sloc <file>"; return 1; }
    if [[ $1 == *.vim ]]; then
        awk '!/^[[:blank:]]*("|^$)/' "$1" | wc -l
    elif [[ $1 =~ (\.c|\.h|\.j) ]]; then
        awk '!/^[[:blank:]]*(\/\/|\*|\/\*|^$)/' "$1" | wc -l
    else
        awk '!/^[[:blank:]]*(\/\/|#|\*|\/\*|^$)/' "$1" | wc -l
    fi
}

nh()
{
    nohup "$@" &>/dev/null &
}

hex2dec()
{
    awk 'BEGIN { printf "%d\n",0x$1}'
}

dec2hex()
{
    awk 'BEGIN { printf "%x\n",$1}'
}

gr()
{
    git rebase -i HEAD~${1:-10}
}

mktar()
{
    tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"
}

mkzip()
{
    zip -r "${1%%/}.zip" "$1"
}

sanitize()
{
    chmod -R u=rwX,g=rX,o= "$@"
}

mp()
{
    ps "$@" -u $USER -o pid,%cpu,%mem,bsdtime,command
}

pp()
{
    mp "-f" | awk '!/awk/ && $0~var' var=${1:-".*"}
}

ff()
{
    find . -type f -iname '*'"$*"'*' -ls
}

fe()
{
    find . -type f -iname '*'"${1:-}"'*' -exec ${2:-file} {} \;
}

ranger()
{
    local dir tmpf
    [[ $RANGER_LEVEL && $RANGER_LEVEL -gt 2 ]] && exit 0
    local rcmd="command ranger"
    [[ $TERM == 'linux' ]] && rcmd="command ranger --cmd='set colorscheme default'"
    tmpf="$(mktemp -t tmp.XXXXXX)"
    eval "$rcmd --choosedir='$tmpf' '${*:-$(pwd)}'"
    [[ -f $tmpf ]] && dir="$(cat "$tmpf")"
    [[ -e $tmpf ]] && rm -f "$tmpf"
    [[ -z $dir || $dir == "$PWD" ]] || builtin cd "${dir}" || return 0
}

resize()
{
    hash convert >/dev/null 2>&1 || { printf "This function requires imagemagick\n"; return 1; }
    local size="$1"; shift
    if [[ $size =~ [1-9]*x[1-9] && $# -ge 1 ]]; then
        if [[ $# -gt 1 || -d "$1" ]]; then
            if [[ -d "$1" ]]; then
                for i in "$1"/*; do
                    [[ $i =~ (.jpg|.png) ]] && convert "$i" -resize "$1" "$i"
                done
            else
                for i in "$@"; do
                    [[ -f $i && $i =~ (.jpg|.png) ]] && convert "$i" -resize "$1" "$i"
                done
            fi
        else
            [[ -f $1 && $1 =~ (.jpg|.png) ]] && convert "$1" -resize "$1" "$1"
        fi
    else
        printf "Usage: resize [size] [directory or file(s)]\n\n%s\n" \
            "When given a directory, all images within will be converted"
    fi
}

fstr()
{
    OPTIND=1
    local case=""
    local usage='Usage: fstr [-i] "pattern" ["filename pattern"]'
    while getopts :it opt; do case "$opt" in
        i) case="-i " ;;
        *) printf "%s" "$usage"; return ;;
    esac done
    shift $((OPTIND - 1))
    [[ $# -lt 1 ]] && printf "fstr: find string in files.\n%s" "$usage"
    find . -type f -name "${2:-*}" -print0 | xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more
}

swap()
{ # Swap 2 filenames around, if they exist
    local tmpf=tmp.$$
    [[ $# -ne 2 ]] && printf "swap: takes 2 arguments\n" && return 1
    [[ ! -e $1 ]] && printf "swap: %s does not exist\n" "$1" && return 1
    [[ ! -e $2 ]] && printf "swap: %s does not exist\n" "$2" && return 1
    mv "$1" $tmpf && mv "$2" "$1" && mv $tmpf "$2"
}

take()
{
    mkdir -p "$1"
    cd "$1" || return
}

csrc()
{
    [[ $1 ]] || { printf "Missing operand" >&2; return 1; }
    [[ -r $1 ]] || { printf "File %s does not exist or is not readable\n" "$1" >&2; return 1; }
    local out=${TMPDIR:-/tmp}/${1##*/}
    gcc "$1" -o "$out" && "$out"
    rm "$out"
    return 0
}

hr()
{
  local start=$'\e(0' end=$'\e(B' line='qqqqqqqqqqqqqqqq'
  local cols=${COLUMNS:-$(tput cols)}
  while ((${#line} < cols)); do line+="$line"; done
  printf '%s%s%s\n' "$start" "${line:0:cols}" "$end"
}

arc()
{
    arg="$1"; shift
    case $arg in
        -e|--extract)
            if [[ $1 && -e $1 ]]; then
                case $1 in
                    *.tbz2|*.tar.bz2) tar xvjf "$1" ;;
                    *.tgz|*.tar.gz) tar xvzf "$1" ;;
                    *.tar.xz) tar xpvf "$1" ;;
                    *.tar) tar xvf "$1" ;;
                    *.gz) gunzip "$1" ;;
                    *.zip) unzip "$1" ;;
                    *.bz2) bunzip2 "$1" ;;
                    *.7zip) 7za e "$1" ;;
                    *.rar) unrar x "$1" ;;
                    *) printf "'%s' cannot be extracted" "$1"
                esac
            else
                printf "'%s' is not a valid file" "$1"
            fi ;;
        -n|--new)
            case $1 in
                *.tar.*)
                    name="${1%.*}"
                    ext="${1#*.tar}"; shift
                    tar cvf "$name" "$@"
                    case $ext in
                        .gz) gzip -9r "$name" ;;
                        .bz2) bzip2 -9zv "$name"
                    esac ;;
                *.gz) shift; gzip -9rk "$@" ;;
                *.zip) zip -9r "$@" ;;
                *.7z) 7z a -mx9 "$@" ;;
                *) printf "bad/unsupported extension"
            esac ;;
        *) printf "invalid argument '%s'" "$arg"
    esac
}

vbump()
{
    [[ -f PKGBUILD ]] || return 1
    # shellcheck disable=1091
    . PKGBUILD
    # shellcheck disable=2154
    new=$((pkgrel + 1))
    sed -i "s/^pkgrel=.*/pkgrel=$new/" PKGBUILD
    printf ">>>  Old pkgrel was: %s .. Updated to: %s\n" "$pkgrel" "$new"
}

killp()
{
    local pid name sig="-TERM"   # default signal
    [[ $# -lt 1 || $# -gt 2 ]] && printf "Usage: killp [-SIGNAL] pattern" && return 1
    [[ $# -eq 2 ]] && sig=$1
    for pid in $(mp | awk '!/awk/ && $0~pat { print $1 }' pat=${!#}); do
        name=$(mp | awk '$1~var { print $5 }' var=$pid)
        ask "Kill process $pid <$name> with signal $sig?" && kill $sig $pid
    done
}

mdf()
{
    local cols
    cols=$(( ${COLUMNS:-$(tput cols)} / 3 ))
    for fs in "$@"; do
        [[ ! -d $fs ]] && printf "%s :No such file or directory" "$fs" && continue
        local info=($(command df -P $fs | awk 'END{ print $2,$3,$5 }'))
        local free=($(command df -Pkh $fs | awk 'END{ print $4 }'))
        local nbstars=$((cols * info[1] / info[0]))
        local out="["
        for ((i=0; i<cols; i++)); do
            [[ $i -lt $nbstars ]] && out=$out"*" || out=$out"-"
        done
        out="${info[2]} $out] (${free[*]} free on $fs)"
        printf "%s" "$out"
    done
}

mip()
{
    local localip
    localip="$(ip route get 1 | awk -F'src ' '/src / { print $2}')"
    printf "%s" "${localip:-Not connected}"
}

ii()
{
    echo -e "\nYou are logged on \e[1;31m$HOSTNAME"
    echo -e "\n\e[1;31mAdditionnal information:\e[m " ; uname -a
    echo -e "\n\e[1;31mUsers logged on:\e[m "         ; w -hi | awk '{print $1}' | sort | uniq
    echo -e "\n\e[1;31mCurrent date:\e[m "            ; date
    echo -e "\n\e[1;31mMachine stats:\e[m "           ; uptime
    echo -e "\n\e[1;31mMemory stats:\e[m "            ; free
    #echo -e "\n\e[1;31mDiskspace:\e[m "               ; mdf / $HOME
    echo -e "\n\e[1;31mLocal IP Address:\e[m"         ; mip
    echo
}

rep()
{
    local max=$1
    shift
    for (( i=0; i<max; i++ )); do
        eval "$@"
    done
}

ask()
{
    printf "$@" '[y/N] '; read -r ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1
    esac
}

fast_chr()
{
    local __octal
    local __char
    printf -v __octal '%03o' $1
    printf -v __char \\$__octal
    REPLY=$__char
}

unichr()
{
    if [[ $# -lt 1 || $1 =~ (-h|--help) ]]; then
        cat << EOF
Usage example:

        for (( i=0x2500; i<0x2600; i++ )); do
            unichr $i
        done

EOF
    fi

    local c=$1  # Ordinal of char
    local l=0   # Byte ctr
    local o=63  # Ceiling
    local p=128 # Accum. bits
    local s=''  # Output string

    (( c < 0x80 )) && { fast_chr "$c"; echo -n "$REPLY"; return; }

    while (( c > o )); do
        fast_chr $(( t = 0x80 | c & 0x3f ))
        s="$REPLY$s"
        (( c >>= 6, l++, p += o + 1, o >>= 1 ))
    done

    # shellcheck disable=2034
    fast_chr $(( t = p | c ))
    echo -n "$REPLY$s"
}

# reloads the shell
reload () {
    exec $SHELL $SHELL_ARGS "$@"
}

genecho()
{
    # on the fly echo script generation with quoting
    {
        printf "#!/bin/bash\n\n"
        printf "echo "
        for arg; do
            arg=${arg/\'/\'\\\'\'}
            printf "'%s' " "${arg}"
        done
        printf "\n"
    } >s2
}

e()
{
    if [ -z "$1" ]; then
        nvim "$(fzf)"
    else
        nvim "$1"
    fi
}

# just type '...' to get '../..'
rationalise-dot()
{
    local MATCH
    if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
        LBUFFER+=/
        zle self-insert
        zle self-insert
    else
        zle self-insert
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
## without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

# Function for fetching information regarding a specific process
function ppgrep()
{
    pgrep "$@" | xargs ps -f -p
}

# Change wallpaper on macOS
function wallpaper() {
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$1'" && killall Dock
}


docker-ssh ()
{
    if [ -z "$1" ]; then
        echo "No container specified"
    fi
    # Get containerID from an active container
    containerid=$(docker ps -f "name=$1" | awk 'END { print $1 }')
    if [ -z "$containerid" ]; then
        echo "Container not found"
    fi

    # SSH into given container
    docker exec -i -t "$containerid" /bin/bash
}

git_current_branch() {
    git rev-parse --abbrev-ref HEAD
}

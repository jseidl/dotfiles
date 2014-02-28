######################################################################
#           jseidl's zshrc file v0.2.1 , based on:
#		      jdong's zshrc file, v0.2.1
######################################################################

# --------------------------------------------------------------------
# Options
# --------------------------------------------------------------------
setopt INC_APPEND_HISTORY SHARE_HISTORY # share history across sessions
setopt APPEND_HISTORY
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt MENUCOMPLETE
setopt ALL_EXPORT

# --------------------------------------------------------------------
# Set/unset  shell options
# --------------------------------------------------------------------
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# --------------------------------------------------------------------
# Autoload zsh modules when they are referenced
# --------------------------------------------------------------------
zmodload -a zsh/stat stat 2>/dev/null
zmodload -a zsh/zpty zpty 2>/dev/null
zmodload -a zsh/zprof zprof 2>/dev/null
zmodload -ap zsh/mapfile mapfile 2>/dev/null

# --------------------------------------------------------------------
# Parameters.  See zshparam(1)
# --------------------------------------------------------------------

# export TMOUT=300

# Extensions to ignore for completion.
FIGNORE=".o:~"
# Where to save my command history
HISTFILE=~/.zsh_history
# Remember the last 5000 commands.
HISTSIZE=5000
# Only ask if completion listing would scroll off screen
LISTMAX=0
# Check for logins/logouts every 5 minutes
LOGCHECK=300
# Never look at my mail spool.
MAILCHECK=0
# Give timing statistics for programs that take longer than a minute to
# run.
REPORTTIME=60
# Save the last 3000 commands.
SAVEHIST=5000
# Report on any log(in|out)s not from my username on systems that I administer.
case `hostname` in
    mustang)
       WATCH=notme
esac
# Format to use for watch messages.
WATCHFMT='%n %a %l from %m at %T.'

PATH="/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
TZ="America/Sao_Paulo"

HOSTNAME="`hostname`"

export DISPLAY

# Default pager
export PAGER='less'

# Vim rules
export EDITOR='vim'
export MUTT_EDITOR=vim

# --------------------------------------------------------------------
# Colors
# --------------------------------------------------------------------

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done

PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="[$PR_BLUE%n$PR_WHITE@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"

# --------------------------------------------------------------------
# Language
# --------------------------------------------------------------------
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

unsetopt ALL_EXPORT

# --------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------

alias beep="echo -en \"\\007\""
alias man='LC_ALL=C LANG=C man'
alias f=finger
alias ll='ls -al'
alias ls='ls --color=auto '
alias svim="sudo vim"

autoload -U compinit
compinit

# --------------------------------------------------------------------
# Key Bindings
# --------------------------------------------------------------------
bindkey "^?" backward-delete-char

# New bind keys for home and end on gnome-terminal ubuntu

typeset -g -A key
bindkey '^?' backward-delete-char
bindkey "^H" backward-delete-word
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 

# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for gnome-terminal
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line


# Delete char
bindkey    "^[[3~"          delete-char

bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# --------------------------------------------------------------------
# Completion Styles
# --------------------------------------------------------------------

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# These were added sometime after 3.0.6, based on empirical evidence.
if [[ $ZSH_VERSION > 3.0.6 ]]; then
    # Print hex numbers like 0x7F instead of 16#7F
    setopt c_bases
    # Only the newest of a set of duplicates (regardless of sequence) is saved
    # to file.
    setopt hist_save_no_dups
    # Commands are added to the history file as they are entered.
    setopt inc_append_history
    # Use variable width columns for completion options
    setopt list_packed
    # print octal numbers like 037 instead of 8#37
    setopt octal_zeroes
fi

# --------------------------------------------------------------------
# Prompt
# --------------------------------------------------------------------

[ "$TERM" = "dumb" ] || . ~/.zshprompt

# ---
# ENVS
# ---
JAVA_HOME="/usr/lib/jvm/java-6-sun"; export JAVA_HOME;

# ----------
# Screen Autolock
# ----------

export PERIOD=60
export TMOUT=600

function TRAPALRM() { vlock }

function periodic() {
    echo "\n===> $(uptime) <===\n"
}

# ---------
# Change PWD Hook
# ---------
function chpwd() {
    print -Pn "\e]2;%n@%M: %~\a"
    TMOUT=600
}

# --- 
# Go Home
# ---

cd

# ---
# Lockdown
# ---
vlock

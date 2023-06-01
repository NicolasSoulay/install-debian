# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='exa -lah --grid --icons --group-directories-first --sort=ext'
    alias lst='exa -lah --tree --icons --group-directories-first'
    alias lsd='exa -lah --grid --icons --group-directories-first --sort=mod' 
    alias lss='exa -lah --grid --icons --group-directories-first --sort=size'
   fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias v='nvim'
 
alias jbuild='javac -d ./out/ ./src/**/*.java'
alias jrun='java -cp out:./out:'

alias jproject='jproject.sh'

#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

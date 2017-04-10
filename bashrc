# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# SSH mounting
alias mmsi="sshfs hine0116@login.msi.umn.edu:/home/pankrat2/hine0116/ /home/hinerm/mnt/msi/"
alias agent="ssh-add /home/hinerm/.ssh/id_msi"
alias mntpk="sudo sshfs -o allow_other,IdentityFile=/home/hinerm/.ssh/id_msi hine0116@login.msi.umn.edu:/home/pankrat2/ /mnt/pkr"
alias mntscr="sudo sshfs -o allow_other,IdentityFile=/home/hinerm/.ssh/id_msi hine0116@login.msi.umn.edu:/scratch.global/ /mnt/scr"
alias mntsi="sudo sshfs -o allow_other,IdentityFile=/home/hinerm/.ssh/id_msi hine0116@login.msi.umn.edu:/home/pankrat2/shared /mnt/msi"
alias mntsol="sudo sshfs -o allow_other,IdentityFile=/home/hinerm/.ssh/id_msi hine0116@login.msi.umn.edu:/scratch.global/cole0482/SoL/ /mnt/sol"
alias mntpnt="sudo sshfs -o allow_other,IdentityFile=/home/hinerm/.ssh/id_msi hine0116@login.msi.umn.edu:/home/poynterj/ /mnt/poynt"
alias umsi="fusermount -u /home/hinerm/mnt/msi"
alias mntvb="sudo mount -t vboxsf host /mnt/host/"
alias jvisvm="~/visualvm_139/bin/visualvm"
alias scpgen="scp /home/hinerm/genvisis/genvisis.jar hine0116@msi:/home/pankrat2/hine0116/"

# Remote debug
alias gendr="java -agentlib:jdwp=server=y,suspend=y,transport=dt_socket,address=localhost:8000 -jar ~/genvisis/genvisis.jar"

function debug() {
	java -agentlib:jdwp=server=y,suspend=y,transport=dt_socket,address=localhost:8000 -jar $@

}

export -f debug

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# path to Homebrew (if installed)
which brew > /dev/null 2>&1 && export BREW=$(brew --prefix)

# --== bash completion ==--

if [ -f /etc/bash_completion ]; then
	# Ubuntu Linux
	. /etc/bash_completion

	# NB: Workaround for environment variable expansion bug in bash 4.2+.
	# See: http://askubuntu.com/q/41891
	if ((BASH_VERSINFO[0] >= 4)) && \
		((BASH_VERSINFO[1] >= 2)) && \
		((BASH_VERSINFO[2] >= 29))
	then
		shopt -s direxpand
	fi
fi
if [ -f "$BREW/etc/bash_completion" ]; then
	# Mac OS X with Homebrew ("brew install bash-completion")
	. "$BREW/etc/bash_completion"
fi

# --== git ==--

# enable bash completion of git commands
if [ -f /etc/bash_completion.d/git-prompt ]; then
	# newer Ubuntu Linux ("sudo aptitude install bash-completion")
	. /etc/bash_completion.d/git-prompt # in case of no /etc/bash_completion
	export GIT_COMPLETION=1
elif [ -f /etc/bash_completion.d/git ]; then
	# older Ubuntu Linux ("sudo aptitude install bash-completion")
	. /etc/bash_completion.d/git # in case of no /etc/bash_completion
	export GIT_COMPLETION=1
fi
if [ -f "$BREW/etc/bash_completion.d/git-completion.bash" ]; then
	# Mac OS X with Homebrew ("brew install git bash-completion")
	export GIT_COMPLETION=1
fi

# --== shell prompt ==--

SHELL_PROMPT=': ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@${HOSTNAME}\[\033[00m\] \[\033[01;34m\]\w'

if [ "$GIT_COMPLETION" ]; then
	# make shell prompt reflect current git status+branch
	PS1="$SHELL_PROMPT"'\[\033[01;32m\]$(__git_ps1)\[\033[00m\]\n'
else
	PS1="$SHELL_PROMPT"'\[\033[00m\]\n'
fi

# --== bash ==--

# use vi commands for advanced editing (hit ESC to enter command mode)
set -o vi

alias gomsi='ssh -X msi'

# --== hub (http://hub.github.com/) ==--

command -v hub >/dev/null 2>&1 && \
	alias git='hub'

# --== shell plugins ==--

for f in $DOTFILES/plugins/*.sh
do
	source $f
done

# --== Git-Mediawiki (https://github.com/moy/Git-Mediawiki/wiki) ==--

# Install prerequisites:
# cpan MediaWiki::API
# cpan DateTime::Format::ISO8601

# Put git-remote-mediawiki and git-mw somewhere on your PATH:
# ln -s "$CODE_GIT/contrib/mw-to-git/git-remote-mediawiki.perl" \
#       ~/bin/git-remote-mediawiki
# ln -s "$CODE_GIT/contrib/mw-to-git/git-mw" ~/bin

export PERL5LIB="$CODE_GIT/perl:$CODE_GIT/contrib/mw-to-git"

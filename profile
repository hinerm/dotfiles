# ~/.profile or ~/.bashrc

# On Mac OS X, alias to ~/.profile or ~/.bash_profile.

# On Ubuntu, alias to ~/.bashrc.
# See /usr/share/doc/bash/examples/startup-files
# (in the package bash-doc) for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@${HOSTNAME}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# programmatic completion features
if [ -f /etc/bash_completion ]; then
  # Ubuntu Linux
  . /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
  # Mac OS X with MacPorts ("sudo port install bash-completion" first)
  . /opt/local/etc/bash_completion
fi

# update terminal title as appropriate
case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
  *)
    ;;
esac

# setup - operating system (Darwin, Linux, etc.)
export OS_NAME=`uname`

# setup - CVS/SVN
export CVS_RSH=ssh
export EDITOR=vi
export VISUAL=$EDITOR

# useful dirs
export HOME_JAVA=~/code/Home/java
export LOCI_JAVA=~/code/LOCI/java
export IJ_HOME=~/code/LOCI/imagej
export IMGLIB_HOME=~/code/LOCI/imglib
export FIJI_HOME=~/code/Fiji/fiji
export CELLPROFILER_HOME=~/code/Other/CellProfiler/CellProfiler
export VISAD=~/code/Other/VisAD
export BF_CPP_DIR=$LOCI_JAVA/components/native/bf-cpp
export BF_ITK_DIR=$LOCI_JAVA/components/native/bf-itk
export FARSIGHT_DIR=~/code/Other/farsight
export NUCLEUS_DIR=$FARSIGHT_DIR/build/ftk/NuclearSegmentation/NucleusEditor
export CONFIG_DIR=~/code/LOCI/misc/curtis/config
export LOCI_TRUNK=http://skyking.microscopy.wisc.edu/svn/java/trunk

# setup - Bio-Formats ITK plugin
#export ITK_AUTOLOAD_PATH=$BF_ITK_DIR/build/lib/ITKFactories

# setup - OME perl
export OME=~/code/OME/ome
export OMEJAVA=$OME/src/java
export PERL5LIB=$OME/src/perl2

# setup - WrapITK
export DYLD_LIBRARY_PATH=/usr/lib/InsightToolkit/:$DYLD_LIBRARY_PATH
export PYTHONPATH=\
/Users/curtis/code/Other/CellProfiler/CellProfiler:\
/usr/lib/InsightToolkit/WrapITK/Python/:\
$PYTHONPATH

# setup - Java
if [ "$OS_NAME" == "Darwin" ]; then
  export JAVA_HOME=/Library/Java/Home
elif [ "$OS_NAME" == "Linux" ]; then
  export JAVA_HOME=/usr/lib/jvm/java-6-sun
fi

# setup - Java classpath
unset CLASSPATH
export CP=\
~/java:\
$HOME_JAVA:\
$LOCI_$HOME_JAVA/utils:\
$LOCI_JAVA/utils
for dir in $LOCI_JAVA/components/*/utils
do
  export CP=$CP:$dir
done
for jar in $LOCI_JAVA/artifacts/*.jar
do
  if [ ${jar: -14} != 'loci_tools.jar' ] && [ ${jar: -13} != 'ome_tools.jar' ]
  then
    export CP=$CP:$jar
  fi
done
#export CP=$CP:$VISAD

# setup - path
export PATH=\
$JAVA_HOME/bin:\
~/bin:\
~/code/LOCI/misc/curtis/bin:\
$LOCI_JAVA/tools:\
$FIJI_HOME/bin:\
/usr/local/bin:\
$PATH

# setup - MacPorts
if [ "$OS_NAME" == "Darwin" ]; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/share/man:$MANPATH
fi

# setup - jikes
#export JRELIB=/System/Library/Frameworks/JavaVM.framework/Classes
#export JREEXTLIB=/System/Library/Java/Extensions
#export BOOTCLASSPATH=\
#$JRELIB/classes.jar:\
#$JRELIB/ui.jar:\
#$JREEXTLIB/j3dcore.jar:\
#$JREEXTLIB/j3dutils.jar:\
#$JREEXTLIB/vecmath.jar
#export JIKESARGS='-target 1.4 -source 1.4 +Pmodifier-order +Predundant-modifiers +Pnaming-convention +Pno-effective-java +Punused-type-imports +Punused-package-imports'
#alias jc='jikes $JIKESARGS'

# setup - jmp
#export LD_LIBRARY_PATH=/usr/local/lib
#alias jmp='java -Xrunjmp'

# setup - jni
#export C_INCLUDE_PATH=$JAVA_HOME/include
#export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH

# setup - MeVisLab + Bio-Formats module
#source /home/curtis/apps/MeVisLab/bin/init.sh
#export MLAB_JNI_LIB=$JAVA_HOME/jre/lib/i386/server/libjvm.so

# setup - ls
if [ "$OS_NAME" == "Linux" ]; then
  alias ls='ls -AF --color=auto'
else
  alias ls='ls -AFG'
fi
#export LSCOLORS="GxGxFxdxCxDxDxhbadGxGx";

# useful functions
goto() { cd $(dirname "`find . -name $*`"); }
govi() { vi "`find . -name $*`"; }

# useful aliases - Java
alias j='java -cp $CP:.'
alias jc='javac -cp $CP:.'

# useful aliases - shell
alias mv='mv -i'
alias cls='clear;pwd;ls'
alias cdiff='colordiff 2> /dev/null'
alias grep='grep --colour=auto'
alias rgrep='grep -IR --exclude="*\.svn*"'

# useful aliases - start
if [ "$OS_NAME" == "Darwin" ]; then
  alias start='open'
elif [ "$OS_NAME" == "Linux" ]; then
  alias start='nautilus'
fi

# useful aliases - ldd
if [ ! -x "`which ldd`" ]; then
  alias ldd='otool -L'
fi

# useful aliases - hex editor
if [ "$OS_NAME" == "Darwin" ]; then
  alias hex='/Applications/Hex\ Fiend.app/Contents/MacOS/Hex\ Fiend'
else
  alias hex='ghex2'
fi

# useful aliases - LOCI apps
alias slim='j -mx512m loci.slim.SlimPlotter'
alias visbio='j -mx1024m -Dswing.defaultlaf=com.jgoodies.plaf.plastic.Plastic3DLookAndFeel loci.visbio.VisBio'

# useful aliases - navigation
alias up='cd ..'
alias up2='cd ../..'
alias up3='cd ../../..'
alias up4='cd ../../../..'
alias up5='cd ../../../../..'
alias up6='cd ../../../../../..'
alias up7='cd ../../../../../../..'
alias up8='cd ../../../../../../../..'
alias go='cd $LOCI_JAVA'
alias goa='cd $LOCI_JAVA/components/autogen/src'
alias goc='cd $LOCI_JAVA/components/common/src/loci/common'
alias gof='cd $LOCI_JAVA/components/bio-formats/src/loci/formats'
alias gon='cd $LOCI_JAVA/components/legacy/ome-notes/src/loci/ome/notes'
alias goo='cd $LOCI_JAVA/components/ome-plugins/src/loci/plugins/ome'
alias gop='cd $LOCI_JAVA/components/loci-plugins/src/loci/plugins'
alias gos='cd $LOCI_JAVA/components/slim-plotter/src/loci/slim'
alias got='cd $LOCI_JAVA/components/test-suite/src/loci/tests/testng'
alias gov='cd $LOCI_JAVA/components/visbio/src/loci/visbio'
alias gox='cd $LOCI_JAVA/components/ome-xml/src/ome/xml'
alias gobfcpp='cd $BF_CPP_DIR'
alias god='cd ~/data'
alias goij='cd $IJ_HOME'
alias goil='cd $IMGLIB_HOME'
alias gofi='cd $FIJI_HOME'
alias gocp='cd $CELLPROFILER_HOME'
alias goconfig='cd $CONFIG_DIR'
alias gen='cd $LOCI_JAVA && svn up && ant dev-clean dev-compile clean tools'

# useful aliases - machines
alias drupal='ssh drupal@skynet.loci.wisc.edu'
alias ome='ssh open.microscopy.wisc.edu'
alias pacific='ssh rueden@pacific.mpi-cbg.de'
alias server='ssh server.microscopy.wisc.edu'
alias skynet='ssh skynet.loci.wisc.edu'

# useful aliases - OME
#alias ome-backup='cd ~ && sudo ome data backup -q -a OME-backup && cd -'
#alias ome-restore='cd ~ && sudo apache2ctl restart && sudo ome data restore -a OME-backup.tar && cd -'
# Without the q flag, it will backup OMEIS (which will take quite some time).
# You can back that up separately. OMEIS doesn't care how many back-ends use it
# as a repository (it never reuses its IDs, so there's no possibility of
# conflict). The -a flag is used to specify the archive file.
#alias ome-update='cd ~/cvs && sudo rm -rf OME && cvs -d :ext:ctrueden@cvs.openmicroscopy.org.uk:/home/cvs/ome co OME && cd OME'

# setup - Fiji (Fake fails if JAVA_HOME is set)
unset JAVA_HOME

#export LOCI_DEVEL=1 # for LOCI command line tools

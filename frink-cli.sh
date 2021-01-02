#!/bin/sh

# Shell file to start frink in command-line mode.
# This version allows you to optionally use rlwrap to use up/down arrows to
# repeat calculations and even do name and function completion with the tab
# key.

# Change this to the path to your frink.jar file
# Hint:  download frink.jar from  https://frinklang.org/frinkjar/frink.jar
jar=/home/eliasen/prog/frinknew/jar/frink.jar

# Change this to the path to your java interpreter.
java=/etc/alternatives/java

# If you are using rlwrap, adjust these to be the paths to the names of the
# units and functions for automatic completion.
# The current versions of these can be downloaded from:
#   https://frinklang.org/frinkjar/unitnames.txt
#   https://frinklang.org/frinkjar/functionnames.txt
#
# If you want to generate these wordlists yourself, (say, if you load your
# own custom units or functions,) they are generated by:
#   https://frinklang.org/frinksamp/listUnits.frink
#   https://frinklang.org/frinksamp/listFunctions.frink
#
unitsfile="/home/eliasen/prog/frink/jar/unitnames.txt"
functionsfile="/home/eliasen/prog/frink/jar/functionnames.txt"

classpath=$jar

# rlwrap allows you to use up/down arrows and stuff to edit and repeat
# previous calculations.  However, it doesn't work right inside emacs, so the
# following line detects if it's running inside emacs or Xemacs.  If the
# executable isn't available, this just skips using it.
#
# You can install rlwrap on Fedora using (as root)
#   dnf install rlwrap
rlwrap=""
rlwrapflags1=""
rlwrapflags2=""
if [ -x "/usr/bin/rlwrap" ]  && [ -z ${INSIDE_EMACS+x} ] && [ -z ${EMACS+x} ]
   then rlwrap="/usr/bin/rlwrap"
   if [ -f "$unitsfile" ]
      then rlwrapflags1="-f $unitsfile"
   fi

   if [ -f "$functionsfile" ]
      then rlwrapflags2="-b '$' -f $functionsfile"
   fi
fi

flags=

# Set flags to empty if we're running interactively, otherwise allow
# greater use of memory if running a program.
# In addition, use the "server" virtual machine if we're running a program.
# This increases startup time, but makes programs run about twice as fast
# in the long run.  Note that the server JVM may only ship with the full
# Sun Java Development Kit (JDK), and not the JRE.
# These flags are appropriate for the Sun JVM, and may need to be changed
# for other JVMs.
# The -Xss flag increases stack space.
# The -Xmx flag increases maximum heap size
#
# Adding the flag
#  -Dsun.java2d.opengl=true
# works on Linux to use the GPU for faster graphics rendering but you have
# to have proper OpenGL drivers.  Also, on some broken implementations, this
# may cause garbage in your Java UI, especially after suspending.
# You can change "true" to "True" with a capital T to get debug information
# indicating if OpenGL was actually used successfully.
if [ $# -eq 0 ]
   then flags=
   else flags="-server -Xss10M -Xmx2000M"
fi

$rlwrap $rlwrapflags1 $rlwrapflags2 "$java" $flags -classpath "$classpath" frink.gui.FrinkStarter "$@"
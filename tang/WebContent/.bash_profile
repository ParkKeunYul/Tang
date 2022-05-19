# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

JAVA_HOME=/usr/local/jdk1.7.0_80
export JAVA_HOME
export LANG=ko_KR.eucKR
PATH=/bin:$JAVA_HOME/bin:/usr/bin:/usr/local/mysql/bin
export PATH
CATALINA_HOME=/www/jsherb_com/tomcat
export CATALINA_HOME
CATALINA_BASE=/www/jsherb_com/tomcat
export CATALINA_BASE
CLASSPATH=./:$JAVA_HOME/lib/tools.jar:$CATALINA_HOME/common/lib/servlet-api.jar
export CLASSPATH

export PATH
unset USERNAME


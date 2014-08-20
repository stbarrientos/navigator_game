#! /bin/bash


FILE=~/.bash_profile
echo "Appending $FILE"
echo -e "\nalias assassinate=\"ruby ~/hazardous_material/dummy/path/for/finder/to/traverse/looking/for/the/target/assassin.rb\"\n" >> $FILE
echo -e "parse_git_branch() {\n" >> $FILE
echo -e "\tgit rev-parse --abbrev-ref HEAD 2> /dev/null | sed 's/^/ /'\n" >> $FILE
CURSOR="➠"
echo -e "export PS1=\"\h: \W\[\\033[33m\]\$(parse_git_branch)\[\\033[00m\] $CURSOR  \"\n" >> $FILE
echo -e "$FILE has been successfully edited."
#! /usr/bin/sh


RUNNING_CHANCE=7

# if random number in range 1-100 is greater then the 
# `RUNNING_CHANCE` then we should not run
[ $(($RANDOM % 100)) -gt $RUNNING_CHANCE ] && exit 0;


die() {
    echo $1
    exit 1
}


BIBLE_CSV="$(dirname $(readlink -f $0))/bible.csv"
[ ! -f $BIBLE_CSV ] && die "couldn't find bible csv at \`${BIBLE_CSV}\`"

BIBLE_LINES=$(wc -l $BIBLE_CSV | awk '{printf $1}')
SELECTED_LINE=$(($RANDOM % $BIBLE_LINES))

# better optimize the file reading
if [[ $SELECTED_LINE -lt $(($BIBLE_LINES / 2)) ]]
then
    LINE=$(head -n $SELECTED_LINE $BIBLE_CSV | tail -n 1);
else
    LINE=$(tail -n $SELECTED_LINE $BIBLE_CSV | head -n 1);
fi

ANSI_ESCAPE="27"
ANSI_BOLD="\e[1m"

# read the csv columns and assign each one to a variable
IFS="," read -r VERSE_ID BOOK_NAME BOOK_NUMBER CHAPTER VERSE TEXT <<< $LINE

echo -e "${ANSI_BOLD}${TEXT}"
echo -e " - ${BOOK_NAME}:${CHAPTER}:${VERSE}"
echo ""

#!/bin/bash

OUTDIR="toaplan2"

mkdir -p "$OUTDIR"
mkdir -p "${OUTDIR}/$ALTD"

if [ ! -d xml ]; then
  mkdir xml
fi

function mra {
    local GAME=$1
    local ALT=${2//[:]/}
    local BUTSTR="$3"
    local DIP="$4"

    if [ ! -e xml/$GAME.xml ]; then
        if [ ! -f $GAME.xml ]; then
            ./mamefilter $GAME
        fi
        mv $GAME.xml xml/
    fi

    ALTD=_alt/_"$ALT"
    mkdir -p $OUTDIR/"$ALTD"

    echo -----------------------------------------------
    echo "Dumping $GAME"
    ./mame2dip xml/$GAME.xml -rbf toaplan2 -outdir $OUTDIR -altfolder "$ALTD" \
        -order maincpu gp9001_0 oki1 \
        -dipbase 8                   \
        -start maincpu    0x0        \
        -start gp9001_0   0x80000    \
        -start oki1       0x280000   \
        -setword maincpu  16         \
        -setword gp9001_0 16 reverse \
        -frac 1 gp9001_0 2           \
        -order-roms gp9001_0 0 1     \
        -dipdef $DIP                 \
        -corebuttons 3               \
        -buttons $BUTSTR
}

mra  truxton2 "Truxton II"  "Shot,Bomb,Kill Player" "00,00,F0"

exit 0

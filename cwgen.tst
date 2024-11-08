#!/bin/bash
# Script to generate XML animated code key for use with Windows Movie Maker
# Usage: cwgen < Morse code characters > | < Text characters >
# Examples: 
# Use / for word space
# cwgen "-.-. --.- / -.. . / .-- .- .---- --. --- ...-"
# Output XML, redirect to .wlmp file for input to the WMM app.
# Output will also be decoded in the file cwgen.decoded
# Or:
# cwgen "CQ DE WA1GOV"
# Output will be Morse code in the file cwgen.code
#
usage()
{
    echo "Usage: $0 < Morse code characters >"
    echo "Examples: cwgen \"-.-. --.- / -.. . / .-- .- .---- --. --- ...-\" > cq.wlmp"
    echo "          cwgen \"CQ DE WA1GOV\" > cq.wlmp"
    echo "Text marquee options:"
    echo "    -t     text default options (-top -mid -red 30 char line)"
    echo "    -top   text on top"
    echo "    -bot   text on bottom"
    echo "    -half  text line 20 characters"
    echo "    -full  text line 40 characters"
    echo "    -ext   text line 60 characters"
    echo "    -mini  text size mini"
    echo "    -small text size medium"
    echo "    -mid   display text on center"
    echo "    -right display text on right"
    echo "    -purp  purple text"
    echo "    -red   red text"
    echo "    -green green text"
    echo "    -blue  blue text"
    echo "    -white white text"
    echo "    -black black text"
    echo "    -orange orange text"
    echo "    -yellow yellow text"
    echo "    -low   Frequency = 360hz"
    echo "    -high  Frequency = 750hz"
    echo "    -cup   Special CW Mug settings"
    echo "    -h     display this help"
    echo "Examples: cwgen -t \"CQ DE WA1GOV\" > cq.wlmp"
    echo "          cwgen -bot -right \"CQ DE WA1GOV\" > cq.wlmp"
}
KeyUp() 
{
    echo -n "
    <ImageClip extentID=\"$extID\" gapBefore=\"0\" mediaItemID=\"1\" duration=\"0.$dur\">"
    echo -n "$Ibod"
    GAP=`echo "$GAP + 0.$dur" | bc` 
    extID=$(($extID + 1))
}
KeyDown()
{
    echo -n "
    <ImageClip extentID=\"$extID\" gapBefore=\"0\" mediaItemID=\"2\" duration=\"0.$dur\">"
    echo -n "$Ibod"
    GAP=`echo "$GAP + 0.$dur" | bc` 
    extID=$(($extID + 1))
}
Textit()
{
    echo -n "
    <TitleClip extentID=\"$extID\" gapBefore=\"$GAP\" duration=\"2\">"
    echo -n "$TextTop"
    if [ `cat $HOME/cwgen.decoded | wc -c` -gt $SZ ]
    then
        MSG=`cut -c${CH}- $HOME/cwgen.decoded` 
        CH=$(($CH + 1))
    else
        MSG=`cat $HOME/cwgen.decoded`
    fi
    echo -n " 
             <BoundPropertyStringElement Value=\"$MSG\" />"
    echo -n "$TextBot"
    echo "$extID" >> $HOME/cwgen.TextID
    extID=$(($extID + 1))
}
Translate()
{
    case ${CODEA[$i]} in
        " ")      echo -n "/ " >> cwgen.code ;;
        a|A)     echo -n ".- " >> cwgen.code ;;
        b|B)   echo -n "-... " >> cwgen.code ;;
        c|C)   echo -n "-.-. " >> cwgen.code ;;
        d|D)    echo -n "-.. " >> cwgen.code ;;
        e|E)      echo -n ". " >> cwgen.code ;;
        f|F)   echo -n "..-. " >> cwgen.code ;;
        g|G)    echo -n "--. " >> cwgen.code ;;
        h|H)   echo -n ".... " >> cwgen.code ;;
        i|I)     echo -n ".. " >> cwgen.code ;;
        j|J)   echo -n ".--- " >> cwgen.code ;;
        k|K)    echo -n "-.- " >> cwgen.code ;;
        l|L)   echo -n ".-.. " >> cwgen.code ;;
        m|M)     echo -n "-- " >> cwgen.code ;;
        n|N)     echo -n "-. " >> cwgen.code ;;
        o|O)    echo -n "--- " >> cwgen.code ;;
        p|P)   echo -n ".--. " >> cwgen.code ;;
        q|Q)   echo -n "--.- " >> cwgen.code ;;
        r|R)    echo -n ".-. " >> cwgen.code ;;
        s|S)    echo -n "... " >> cwgen.code ;;
        t|T)      echo -n "- " >> cwgen.code ;;
        u|U)    echo -n "..- " >> cwgen.code ;;
        v|V)   echo -n "...- " >> cwgen.code ;;
        w|W)    echo -n ".-- " >> cwgen.code ;;
        x|X)   echo -n "-..- " >> cwgen.code ;;
        y|Y)   echo -n "-.-- " >> cwgen.code ;;
        z|Z)   echo -n "--.. " >> cwgen.code ;;
        "0")  echo -n "----- " >> cwgen.code ;;
        "1")  echo -n ".---- " >> cwgen.code ;;
        "2")  echo -n "..--- " >> cwgen.code ;;
        "3")  echo -n "...-- " >> cwgen.code ;;
        "4")  echo -n "....- " >> cwgen.code ;;
        "5")  echo -n "..... " >> cwgen.code ;;
        "6")  echo -n "-.... " >> cwgen.code ;;
        "7")  echo -n "--... " >> cwgen.code ;;
        "8")  echo -n "---.. " >> cwgen.code ;;
        "9")  echo -n "----. " >> cwgen.code ;;
        "?") echo -n "..--.. " >> cwgen.code ;;
        ",") echo -n "--..-- " >> cwgen.code ;;
        "-")  echo -n "-....- " >> cwgen.code ;;
        ".") echo -n ".-.-.- " >> cwgen.code ;;
        "=") echo -n "-...- " >> cwgen.code ;;
        "'") echo -n ".----. " >> cwgen.code ;;
        "/")  echo -n "-..-. " >> cwgen.code ;;
        "!")  echo -n "-.-.-- " >> cwgen.code ;;
        "(")  echo -n "-.--. " >> cwgen.code ;;
        ":")  echo -n "---... " >> cwgen.code ;;
        *) ;;
    esac
}
#
# Decode and create XML
#
Decode()
{
    case ${CODEA[$i]} in
        "/") echo -n " " >> cwgen.decoded
                dur=4
                KeyUp
                ;;
        ".-") echo -n "A" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        "-...") echo -n "B"  >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "-.-.") echo -n "C"  >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "-..") echo -n "D" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        ".") echo -n "E"  >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                ;;
        "..-.") echo -n "F"  >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "--.") echo -n "G" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "....") echo -n "H" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "..") echo -n "I" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                ;;
        ".---") echo -n "J" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "-.-") echo -n "K" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        ".-..") echo -n "L" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "--") echo -n "M" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "-.") echo -n "N" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "---") echo -n "O" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        ".--.") echo -n "P" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "--.-") echo -n "Q" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        ".-.") echo -n "R" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "...") echo -n "S" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "-") echo -n "T" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                ;;
        "..-") echo -n "U" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        "...-") echo -n "V" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        ".--") echo -n "W" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "-..-") echo -n "X" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        "-.--") echo -n "Y" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "--..") echo -n "Z" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "-----") echo -n "0" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        ".----") echo -n "1" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "..---") echo -n "2" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "...--") echo -n "3" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "....-") echo -n "4" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        ".....") echo -n "5" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "-....") echo -n "6" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "--...") echo -n "7" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "---..") echo -n "8" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "----.") echo -n "9" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "..--..") echo -n "?" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                ;;
        "---...") echo -n ":" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
		KeyUp
		dur=3
		KeyDown
		dur=1
		KeyUp
		KeyDown
		KeyUp
		KeyDown
		KeyUp
		KeyDown
		;;
        "--..--") echo -n "," >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
        "-....-") echo -n "-" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        "-...-") echo -n "=" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        ".-.-.-") echo -n "." >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                ;;
        ".-..-.") echo -n "\"" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        ".----.") echo -n "'" >> cwgen.decoded
                dur=3
                KeyUp
                dur=1
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "-..-.") echo -n "/" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                ;;
        "-.--.") echo -n "(" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
		dur=3
		KeyDown
		dur=1
		KeyUp
		KeyDown
		;;
        "-.-.--") echo -n "!" >> cwgen.decoded
                dur=3
                KeyUp
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                KeyDown
                KeyUp
                dur=3
                KeyDown
                dur=1
                KeyUp
                dur=3
                KeyDown
                ;;
              *) ;;
    esac
}
######################## MAIN #########################
#
# check usage
#
if [ $# -eq 0 ]
then
    usage
    exit
fi
#
# variable assignments
#
TEXT=0
TextSize=0.46
TextVert=3.0
TextHor=0
GAP=0
CH=2 # cut characters > $SZ for text marqee 
SZ=30
FQ=550
CO1=1  # Red 100, Green 010, Black 000, White 111, blue 001, purple 101
       # Orange 1/.5/0 Yellow 110
CO2=0
CO3=0
#
# check args
#
while [[ $# -gt 0 ]]
    do
        case $1 in
	-white)                #White Text
		CO1=1
		CO2=1
		CO3=1
		TEXT=1
		shift
		;;
	-black)                #Black Text
		CO1=0
		CO2=0
		CO3=0
		TEXT=1
		shift
		;;
	-purp)                 #Purple Text
		CO1=1
		CO2=0
		CO3=1
		TEXT=1
		shift
		;;
	-red)                  #Red Text
		CO1=1
		CO2=0
		CO3=0
		TEXT=1
		shift
		;;
	-green)                #Green Text
		CO1=0
		CO2=1
		CO3=0
		TEXT=1
		shift
		;;
	 -blue)                #Blue Text
		CO1=0
		CO2=0
		CO3=1
		TEXT=1
		shift
		;;
       -orange)                #Orange Text
		CO1=1
		CO2=.5
		CO3=0
		TEXT=1
		shift
		;;
       -yellow)                #Yellow Text
		CO1=1
		CO2=1
		CO3=0
		TEXT=1
		shift
		;;
	-half)                 #Text 20 character line
		SZ=20
		TEXT=1
		shift
		;;
	-full)                 #Text 40 character line
		SZ=40
		TEXT=1
		shift
		;;
	-ext)                  #Text 60 character line
		SZ=60
		TEXT=1
		shift
		;;
	-mini)                 #Text size mini
		TextSize=0.20
		TEXT=1
		shift
		;;
	-small)                #Text size small
		TextSize=0.30
		TEXT=1
		shift
		;;
	-top)                  #Text on the top
                TextVert=2.6
                TEXT=1
                shift
                ;;
        -bot)                  #Text on the bottom
                TextVert=-2.3
                TEXT=1
                shift
                ;;
        -t)
		TEXT=1         #Default values (top,left)
                shift
                ;;
        -h)
                usage
                exit
                ;;
        -right)                #Start text at right edge
                TextHor=4.6
                TEXT=1
                shift
                ;;
        -mid)                  #Start text in the middle
                TextHor=0
                TEXT=1
                shift
                ;;
        -low)                  #Frequency = 360hz
                FQ=360
                shift
                ;;
        -high)                  #Frequency = 750hz
                FQ=750
                shift
                ;;
        -cup)                  
                TextHor=-0.5
                TextVert=1.0
                SZ=6
                TEXT=1
                shift
                ;;
        *)
		if [ $# -eq 1 ]
		then
                    CODE="$1"
                    shift
                    shift
	        else           #Ignore invalid args
		    shift
	        fi
                ;;
        esac
done
CODEA=($CODE)      #create array
LEN=$((${#CODEA[@]} - 1))
media=1
extID=5
dur=1
if [ -d ./morsewav.py ]
then
    AUDIO=1
fi
Ibod="
      <Effects />
      <Transitions />
      <BoundProperties>
        <BoundPropertyInt Name=\"rotateStepNinety\" Value=\"0\" />
      </BoundProperties>
    </ImageClip>"
TextTop="
      <Effects>
        <TextEffect effectTemplateID=\"TextEffectTemplate\" TextScriptId=\"0\">
          <BoundProperties>
            <BoundPropertyBool Name=\"automatic\" Value=\"false\" />
            <BoundPropertyFloatSet Name=\"color\">
              <BoundPropertyFloatElement Value=\"$CO1\" />
              <BoundPropertyFloatElement Value=\"$CO2\" />
              <BoundPropertyFloatElement Value=\"$CO3\" />
            </BoundPropertyFloatSet>
            <BoundPropertyStringSet Name=\"family\">
              <BoundPropertyStringElement Value=\"Segoe UI\" />
            </BoundPropertyStringSet>
            <BoundPropertyBool Name=\"horizontal\" Value=\"true\" />
            <BoundPropertyStringSet Name=\"justify\">
              <BoundPropertyStringElement Value=\"MIDDLE\" />
            </BoundPropertyStringSet>
            <BoundPropertyBool Name=\"leftToRight\" Value=\"true\" />
            <BoundPropertyFloatSet Name=\"length\">
              <BoundPropertyFloatElement Value=\"4.1\" />
              <BoundPropertyFloatElement Value=\"5.2\" />
            </BoundPropertyFloatSet>
            <BoundPropertyFloat Name=\"maxExtent\" Value=\"5\" />
            <BoundPropertyFloatSet Name=\"outlineColor\">
              <BoundPropertyFloatElement Value=\"0.65\" />
              <BoundPropertyFloatElement Value=\"0.65\" />
              <BoundPropertyFloatElement Value=\"0.65\" />
            </BoundPropertyFloatSet>
            <BoundPropertyInt Name=\"outlineSizeIndex\" Value=\"0\" />
            <BoundPropertyFloatSet Name=\"position\">
              <BoundPropertyFloatElement Value=\"$TextHor\" />
              <BoundPropertyFloatElement Value=\"$TextVert\" />
              <BoundPropertyFloatElement Value=\".025\" />
            </BoundPropertyFloatSet>
            <BoundPropertyFloat Name=\"size\" Value=\"$TextSize\" />
            <BoundPropertyStringSet Name=\"string\">"
TextBot="
            </BoundPropertyStringSet>
            <BoundPropertyString Name=\"style\" Value=\"Bold\" />
            <BoundPropertyFloat Name=\"transparency\" Value=\"0\" />
          </BoundProperties>
        </TextEffect>
      </Effects>
      <Transitions />
      <BoundProperties>
        <BoundPropertyFloatSet Name=\"diffuseColor\">
          <BoundPropertyFloatElement Value=\"0.75\" />
          <BoundPropertyFloatElement Value=\"1\" />
          <BoundPropertyFloatElement Value=\"0\" />
        </BoundPropertyFloatSet>
        <BoundPropertyFloat Name=\"transparency\" Value=\"1\" />
      </BoundProperties>
    </TitleClip>"
#
# Decode incoming Morse
cp /dev/null cwgen.decoded
cp /dev/null cwgen.code
cp /dev/null cwgen.TextID
#
# Start with header
#
echo -n "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<Project name=\"cwgen\" themeId=\"0\" version=\"65540\" templateID=\"SimpleProjectTemplate\">
  <MediaItems>
    <MediaItem id=\"1\" filePath=\"C:\\cygwin64\\home\\Art\\key up.jpg\" arWidth=\"300\" arHeight=\"176\" duration=\"0\" songTitle=\"\" songArtist=\"\" songAlbum=\"\" songCopyrightUrl=\"\" songArtistUrl=\"\" songAudioFileUrl=\"\" stabilizationMode=\"0\" mediaItemType=\"2\" />
    <MediaItem id=\"2\" filePath=\"C:\\cygwin64\\home\\Art\\key down.jpg\" arWidth=\"300\" arHeight=\"176\" duration=\"0\" songTitle=\"\" songArtist=\"\" songAlbum=\"\" songCopyrightUrl=\"\" songArtistUrl=\"\" songAudioFileUrl=\"\" stabilizationMode=\"0\" mediaItemType=\"2\" />"
if [ $AUDIO -eq 1 ]
then
    echo -n "
    <MediaItem id=\"3\" filePath=\"C:\\cygwin64\\home\\Art\\cwgen.wav\" arWidth=\"0\" arHeight=\"0\" duration=\"0\" songTitle=\"\" songArtist=\"\" songAlbum=\"\" songCopyrightUrl=\"\" songArtistUrl=\"\" songAudioFileUrl=\"\" stabilizationMode=\"0\" mediaItemType=\"3\" />"
fi
    echo -n "
  </MediaItems>
  <Extents>"
# Generic middle code
#
if [[ "${CODEA[0]}" =~ ^[[:alnum:]] ]]
then
    for i in `seq 0 $LEN`
    do
        SUBTEXT=`echo ${CODEA[$i]} | grep -o .`
        for x in `echo $SUBTEXT`
        do
            CODEA[$i]=$x
            Translate
            CODEA[$i]=`awk '{print $NF}' ./cwgen.code`
            Decode
	    if [ $TEXT -eq 1 ]
	    then
                Textit
	        GAP=-2
	    fi
        done
        if [ $i -ne $LEN ]
        then
            CODEA[$i]=" "
            Translate
            CODEA[$i]=`awk '{print $NF}' ./cwgen.code`
            Decode
        fi
    done
else
    for i in `seq 0 $LEN`
    do
        Decode
	if [ $TEXT -eq 1 ]
	then
            Textit
	    GAP=-2
	fi
    done
fi
KeyUp
# Generate Audio extent
#
if [ $AUDIO -eq 1 ]
then
    echo -n "
    <AudioClip extentID=\"$extID\" gapBefore=\"0\" mediaItemID=\"3\" inTime=\"0.21\" outTime=\"0\" speed=\"1\">
      <Effects />
      <Transitions />
      <BoundProperties>
        <BoundPropertyBool Name=\"Mute\" Value=\"false\" />
        <BoundPropertyFloat Name=\"Volume\" Value=\"1\" />
      </BoundProperties>
    </AudioClip>"
fi
extID=$(($extID - 1))
echo -n "
    <ExtentSelector extentID=\"1\" gapBefore=\"0\" primaryTrack=\"true\">
      <Effects />
      <Transitions />
      <BoundProperties />"
#
# Create the correct number of ExtentRefs
#
echo -n "
    <ExtentRefs>"
for i in `seq 5 $extID`
do
    grep -w $i $HOME/cwgen.TextID > /dev/null
    if [ $? -ne 0 ]
    then
        echo -n "
       <ExtentRef id=\"$i\" />"
    fi
done
echo -n "
    </ExtentRefs>"
#
# End with standard trailer
#
echo -n "
    </ExtentSelector>
    <ExtentSelector extentID=\"2\" gapBefore=\"0\" primaryTrack=\"false\">
      <Effects />
      <Transitions />
      <BoundProperties />"
if [ $AUDIO -eq 1 ]
then
    echo -n "
      <ExtentRefs>
        <ExtentRef id=\"$(($extID + 1))\" />
      </ExtentRefs>"
else
    echo -n "
      <ExtentRefs />"
fi
if [ $AUDIO -eq 1 ]
then
    ./morsewav.py/morsewav.py -o cwgen.wav -f $FQ -w 12 -l 25 `cat $HOME/cwgen.decoded`
fi
echo -n "
    </ExtentSelector>
    <ExtentSelector extentID=\"3\" gapBefore=\"0\" primaryTrack=\"false\">
      <Effects />
      <Transitions />
      <BoundProperties />
      <ExtentRefs />
    </ExtentSelector>
    <ExtentSelector extentID=\"4\" gapBefore=\"0\" primaryTrack=\"false\">
      <Effects />
      <Transitions />
      <BoundProperties />"
if [ $TEXT -eq 1 ]
then
    echo -n "
      <ExtentRefs>"
    for t in `cat $HOME/cwgen.TextID`
    do
        echo -n "
            <ExtentRef id=\"$t\" />"
    done
    echo -n "
      </ExtentRefs>"
else
    echo -n "
      <ExtentRefs />"
fi
echo -n "
    </ExtentSelector>
  </Extents>
  <BoundPlaceholders>
    <BoundPlaceholder placeholderID=\"SingleExtentView\" extentID=\"0\" />
    <BoundPlaceholder placeholderID=\"Main\" extentID=\"1\" />
    <BoundPlaceholder placeholderID=\"SoundTrack\" extentID=\"2\" />
    <BoundPlaceholder placeholderID=\"Text\" extentID=\"4\" />
    <BoundPlaceholder placeholderID=\"Narration\" extentID=\"3\" />
  </BoundPlaceholders>
  <BoundProperties>
    <BoundPropertyFloatSet Name=\"AspectRatio\">
      <BoundPropertyFloatElement Value=\"1.7777776718139648\" />
    </BoundPropertyFloatSet>
    <BoundPropertyFloat Name=\"DuckedNarrationAndSoundTrackMix\" Value=\"0.5\" />
    <BoundPropertyFloat Name=\"DuckedVideoAndNarrationMix\" Value=\"0.5\" />
    <BoundPropertyFloat Name=\"DuckedVideoAndSoundTrackMix\" Value=\"0.5\" />
    <BoundPropertyFloat Name=\"SoundTrackMix\" Value=\"0.5\" />
  </BoundProperties>
  <ThemeOperationLog themeID=\"0\">
    <MonolithicThemeOperations />
  </ThemeOperationLog>
  <AudioDuckingProperties emphasisPlaceholderID=\"Narration\" />
</Project>" 

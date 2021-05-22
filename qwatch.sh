#!/bin/bash

SLEEP_TIME=1
QC_f=""
QC_v=""
QC_h=""
QC_b=""
CLEAR=""

QUEERCAT="queercat"
SCRIPT_NAME="$0"
SHOW_FLAGS=false

FLAG_STR="
##########################################
##########################################
##########################################
##########################################
##########################################
"

usage()
{
  echo "Usage: $SCRIPT_NAME [options] <COMMAND>"
  echo "$SCRIPT_NAME --help for more details"
  exit 2
}

full_usage()
{
	echo "Usage: $SCRIPT_NAME [options][$QUEERCAT options] <COMMAND>"
	echo ""
	echo "*note: the options order does not matter"
	echo ""
	echo ""
	echo "loop on COMMAND and pipe the output into $QUEERCAT:"
	echo "    COMMAND | $QUEERCAT <options>"
	echo ""
	echo ""
	echo "options:"
	echo "    -c | --clear                     clear the screen before each COMMAND"
	echo "    -n [=1]                          time to sleep bitween commands"
	echo "    --help                           display this message"
	echo ""
	echo ""
	echo "$QUEERCAT options:"
	echo "    -f | --flag [=1]                 Choose color pattern(flag) to use, -1 to loop on all"
	echo "    -h | --horizontal-frequency      Horizontal rainbow frequency (default: 0.23)"
	echo "    -v | --vertical-frequency        Vertical rainbow frequency (default: 0.1)"
	echo "    -b | --24bit                     Output in 24-bit 'true' RGB mode (slower and not supported by all terminals)"
	echo "                                     *try to use -h 0.5-1 when using 24bit mode"
	echo ""
	echo ""
	echo "color patterns(flags):"
	echo "    0: rainbow"
	echo "    1: trans"
	echo "    2: non-binary"
	echo "    3: lesbians"
	echo "    4: gay"
	echo "    5: pan"
	echo "    6: bi"
	echo "    7: gender fluid"

	exit 0
}

print_flags()
{
	echo "0: rainbow      $FLAG_STR"| $QUEERCAT -f 0 $QC_b $QC_v $QC_h
	echo "1: trans        $FLAG_STR"| $QUEERCAT -f 1 $QC_b $QC_v $QC_h
	echo "2: non-binary   $FLAG_STR"| $QUEERCAT -f 2 $QC_b $QC_v $QC_h
	echo "3: lesbians     $FLAG_STR"| $QUEERCAT -f 3 $QC_b $QC_v $QC_h
	echo "4: gay          $FLAG_STR"| $QUEERCAT -f 4 $QC_b $QC_v $QC_h
	echo "5: pan          $FLAG_STR"| $QUEERCAT -f 5 $QC_b $QC_v $QC_h
	echo "6: bi           $FLAG_STR"| $QUEERCAT -f 6 $QC_b $QC_v $QC_h
	echo "7: gender fluid $FLAG_STR"| $QUEERCAT -f 7 $QC_b $QC_v $QC_h

	exit 0
}

PARSED_ARGUMENTS=$(getopt -a -n "$SCRIPT_NAME" -o cbaf:h:v:n: --long clear,help,flag:,all-flags,24bit,vertical-frequency:,horizontal-frequency: -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
	case "$1" in
		-c | --clear)
			CLEAR="clear"
			shift 1
			;;
		-n)
			SLEEP_TIME=$2
			shift 2
			;;
		-b | --24bit)
	    		QC_b="-b"
    	    		shift 1
	    		;;
    		-f | --flag)
	    		QC_f="-f $2"
	    		shift 2 
	    		;;
    		-h | --horizontal-frequency)
	    		QC_h="-h $2"
	    		shift 2
	    		;;
    		-v | --vertical-frequency)
	    		QC_v="-v $2"
	    		shift 2
	    		;;
		-a | --all-flags)
			SHOW_FLAGS=true
			shift 1
			;;
    		--help)
			full_usage
			;;
   		--)
	    		shift 1
	    		break
	    		;;
    		*)
	    		echo "Unexpected option: $1"
	    		usage
	    		;;
	esac
done

if $SHOW_FLAGS
then
	print_flags
fi

COMMAND=$@

if [ "$COMMAND" = "" ]
then
	echo not enough  arguments
	usage
fi

while true; do
	if [ "$QC_f" = "-f -1" ]
	then
		for flag in {0..7}
		do
			$CLEAR
			$COMMAND | $QUEERCAT $QC_b $QC_v $QC_h -f $flag
			sleep $SLEEP_TIME
		done
	else
		$CLEAR
		$COMMAND | $QUEERCAT $QC_b $QC_v $QC_h $QC_f
		sleep $SLEEP_TIME 
	fi
done

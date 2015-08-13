#!/bin/bash


# GLOBAL VARIABLES
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 6)
NORMAL=$(tput sgr0)
col1=3 # Num of columns
col2=30 # Num of columns
finished=false


while [ $finished == false ]; do # loop until user is done

	count=1
	status=false

	if [[ ! $maxcount ]]; then
		maxcount=1  # The default amount of chances to get number
	fi

	if [[ ! $maxnum ]]; then
		maxnum=100  # The default maxium number allowed
	fi

	clear
	inputstatus=false
	while [ $inputstatus == 'false' ]; do
		echo "Chose a random number and press [ENTER]:"
		read num

		re='^[0-9]+$'
		if [[ $num =~ $re ]] && [ $num -le $maxnum ] && [ $num != 0 ]; then
		   inputstatus=true
		else
			clear
			echo "Please type in a number between 1 and $maxnum"
		fi
		# The opponents number:
		opponentnumber=$((RANDOM%$maxnum+1)) # resets opponent num everytime user changes theirs
	done


	echo
	echo "Guess the correct number"
	echo "--------------------------------------"
	printf '%s%*s%s' "$BLUE" $col1 "YOU:" "$NORMAL"
  printf '%s%*s%s' "$RED" $col2 "OPPONENT:" "$NORMAL"
  echo


  anwser=$((RANDOM%$maxnum+1))  # Generate random anwser

	  # USER & OPPONENT
		if [ $num == $anwser ] && [ $opponentnumber == $anwser ]; then
		  printf '%s%*s%s' "$BLUE" $col1 "*** $num ***" "$NORMAL"
		  printf '%s%*s%s' "$RED" $col2 "*** $opponentnumber ***" "$NORMAL"
		  echo
		  win="tie"

		# USER
		elif [ $num == $anwser ]; then
		  printf '%s%*s%s' "$BLUE" $col1 "*** $num ***" "$NORMAL"
		  printf '%s%*s%s' "$RED" $col2 "$opponentnumber" "$NORMAL"
		  echo
		  win=true

		# COMPUTER
		elif [ $opponentnumber == $anwser ]; then
		  printf '%s%*s%s' "$BLUE" $col1 "$num" "$NORMAL"
		  printf '%s%*s%s' "$RED" $col2 "*** $opponentnumber ***" "$NORMAL"
		  echo
		  win="opponent"

		 # NO ONE
		else
		  printf '%s%*s%s' "$BLUE" $col1 "$num" "$NORMAL"
		  printf '%s%*s%s' "$RED" $col2 "$opponentnumber" "$NORMAL"
		  echo
	  	win=false
		fi

	echo "--------------------------------------"


	# status:  win, lose, or tie
	if [ $win == true ]; then
		echo "You win! You guessed $anwser"
		echo "Would you like to play again? [Yes] or [No]"

	elif [ $win == "opponent" ]; then
		echo "You lose! Your opponent guessed $anwser"
		echo "Would you like to play again? [Yes] or [No]"

	elif [ $win == "tie" ]; then
		echo "You tied! You and your opponent guessed $anwser"
		echo "Would you like to play again? [Yes] or [No]"

	else
		echo "You lose! The number was $anwser. Would you like to try again? [Yes] or [No]"
	fi
	echo "Type [S] for settings"


	# play again, kill process, or go to settings:
	read again
	if [ $again = 'y' ] || [ $again = 'yes' ]; then
		clear
		$finished =false
	elif [ $again = 'n' ] || [ $again = 'no' ]; then
		clear
		$finished =true
		exit 0
	elif [ $again = 's' ] || [ $again = 'settings' ]; then
		# maxnum
		inputstatus=false
		while [ $inputstatus == 'false' ]; do
			clear
			echo "What is the highest number allowed? Current: 1-$maxnum"
			read setting

			re='^[0-9]+$'
			inputstatus=false
			if [[ $setting =~ $re ]] ; then
				maxnum=$setting
				inputstatus=true
			fi
		done

	fi


done # end while loop
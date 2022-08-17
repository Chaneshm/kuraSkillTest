#!/bin/bash


# -------------------------------------------------------------------------------------------------------------
# Objective: Run through a 3 week Kura Labs gauntlet
# Components of application: 
#	i. 3 "week" files containing question/answer pairs
#	ii. a function to parse the quesion/answer library. used when prompting / testing user's Kura knowledge
#	iii. a function to record a user's game state 
#	     [level of difficulty, stage in the game, questions asked:answered correctly (future)
# -------------------------------------------------------------------------------------------------------------

# 1. Welcome user to the Kura "life" challenge
# 2. Prompt user for level of difficulty they wish to play [1=Noob, 2=Experienced, 3=Veteran]
# 	>> if "difficulty = 1"
#	- User must get 1/3 answers correct to advance to next level [pass=1/3, fail=0/3] at ALL STAGES [week1, week2, week3]
#	>> if "difficulty = 2"
#	- User must get 2/3 answers correct to advance
#	>> if "difficulty = 3"
#	- User must get 3/3 answers correct to advance
# 3. Play Level 1
#	i. Call "questions" function to grab 3 quesion/answer pairs from "week1.txt" 
#		- function must ensure uniqueness of question/answer pairs
#	ii. Prompt user with each question:
#		- record whether user answered correctly
#		- if after 3 questions, user has met or surpassed minimum required grade to advance 
#			--> congratulate them 
#			--> update user's state [recordState function]
#			--> begin next level by  calling "questions" function for the next week file [week2.txt]
#		- if after 3 questions, user has failed to meet minimum required grade to advance
#			--> ask if they wish to try again 
#				- if yes --> restart current "week" by calling "questions" function on same week1.txt file
#				- if no --> exit gracefully
# 4. Repeat #3 for each stage [week1, week2, week3]
# 5. Celebrate the user if they successfully graduate Kura Cohort 3
# 	- record their name in the "winners" file

# Default values that must be initialized
qRight=0
userLevel=1
usrDifficulty=0

q1=""
q2=""
q3=""
a1=""
a2=""
a3=""

source ./test.sh
#The following function will provide 3 unique random questions and their respective answers from a file of questions based on week level




# Function Name: recordState
# Description: This function will create a new file and add the users current info on the game to the file.
# args: N/A
# Name: Biki Gurung
recordState(){
	# Create a User File for each user
	touch "$file"
	# Append User Game Information:
	json_data='{"name":"'$userName'","level":"'$userLevel'","gamemode":"'$usrDifficulty'","result":"'$userResult'","score":"'$userScore'"}'
	echo $json_data | cat > "$file"
}

# Function name: readState
# Description: This function will read the file if it exists and then set the variables for the user.
# args: N/A
# Name: Biki Gurung
readState(){
	if [ -f "$file" ]
	then
        clear
        if [[ $(jq -r '.level' $file) > 3 ]]
        then
            echo "Welcome back alumni"
            echo "Would you like to retake Kura? y/n"
            read option
            case ${option,,} in
                y) echo "Have fun!."
                sleep 1s
                userLevel=1
                usrDifficulty=0
                recordState
                ;;
                n) echo "Maybe next time, keep studying!"
                sleep 2s
                recordState
                exit 0
                ;;
            esac
        else
            echo "Nice to see you again $userName"
            # echo "$file"
            userLevel=($(jq -r '.level' $file))
            usrDifficulty=($(jq -r '.gamemode' $file))
            userResult=($(jq -r '.result' $file))
            userScore=($(jq -r '.score' $file))
        fi

		# echo "$userLevel", "$usrDifficulty", "$userResult", "$userScore"
	else
        clear
   		echo "You seem new here!"
	fi
}
getDiff(){
echo "What difficulty would you like?"
echo "1. Beginner"
echo "2. Intermediate"
echo "3. Expert"
read usrDifficulty
}
pDiff(){
    case $usrDifficulty in 
        1) required=1
        ;;
        2) required=2
        ;;
        3) required=3
        ;;
    esac
}
test(){
    if [[ $usrDifficulty -eq 0 ]]
    then
        getDiff
        pDiff
    fi
    pDiff
    clear
    qNum=1
    questions
    echo "Welcome to KuraLabs week $userLevel diagnostic test"
    echo "I hope you studied!"
    sleep 2s
    while [[ $qNum -le 3 ]]
    do
        case $qNum in 
            1) echo $q1
                # echo $a1
                read ans
                ans=${ans,,}
                if [[ $ans == ${a1,,} ]]
                    then
                        echo "Correct! Keep it up!"
                        echo
                        qRight=$(( $qRight + 1 ))
                        qNum=$(( $qNum + 1 ))
                    else   
                        echo "Sorry but that answer is incorrect"
                        echo "The correct answer is $a1"
                        echo
                        qNum=$(( $qNum + 1 ))
                fi
            ;;
            2) echo $q2
                # echo $a2
                read ans
                ans=${ans,,}
                if [[ $ans == ${a2,,} ]]
                    then
                        echo "Correct! Keep it up!"
                        echo
                        qRight=$(( $qRight + 1 ))
                        qNum=$(( $qNum + 1 ))
                    else   
                        echo "Sorry but that answer is incorrect"
                        echo "The correct answer is $a2"
                        echo
                        qNum=$(( $qNum + 1 ))
                fi
            ;;
            3) echo $q3
                # echo $a3
                read ans
                ans=${ans,,}
                if [[ $ans == ${a3,,} ]]
                    then
                        echo "Correct! Keep it up!"
                        echo
                        qRight=$(( $qRight + 1 ))
                        qNum=$(( $qNum + 1 ))
                    else   
                        echo "Sorry but that answer is incorrect"
                        echo "The correct answer is $a3"
                        echo
                        qNum=$(( $qNum + 1 ))
                fi
            ;;
        esac
    done
    echo "That brings us to the end of this weeks diagnostic"
    sleep 0.5s
    echo "You got $qRight questions right."
    if [[ $qRight < $required ]]
    then
        echo "Sorry but you failed this test. Better luck next time"
        qRight=0
        recordState
        menu
    else
        echo "Congrats you passed the diagnostic!"
        qRight=0
        userLevel=$(( $userLevel + 1 ))
        recordState
        if [[ $userLevel -le 3 ]]
        then
        menu
        else
            echo "Congratulations on graduating KuraLabs. We hope you stay in touch."
            echo "Goodbye!"
            sleep 3s
            gnome-terminal -- curl parrot.live
        fi
    fi
    qRight=0
    sleep 3s
}
menu(){
    echo "Welcome to week $userLevel of KuraLabs"
    echo "We hope you are enjoying the bootcamp so far"
    echo "That being said, are you ready for this weeks diagnostic? y/n"
    read option
    case ${option,,} in
        y) echo "Get ready."
        sleep 1s
        test 
        ;;
        n) echo "Maybe next time, keep studying!"
        sleep 2s
        recordState
        exit 0
        ;;
    esac
}

echo "Welcome to KuraLabs!"
echo "What is your name?"
read userName
file="${userName,,}.json"
readState
menu
recordState

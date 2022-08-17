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

echo "it seems like I needed to add a non-comment line to commit"
=======
# Creation of logic for the test

echo test

#The following function will provide 3 unique random questions and their respective answers from a file of questions based on week level

function questions() {

	if [ userLevel -eq 1 ];
	then shuf -n 3 week1.txt;
	q1=(cut -d'????' -f1| {print $1;exit});
	a1=(cut -d'????' -f2| {print $1;exit});
	q2=(cut -d'????' -f1| {print $2;exit});
	a2=(cut -d'????' -f2| {print $2;exit});
	q3=(cut -d'????' -f1| {print $3;exit});
	a3=(cut -d'????' -f2| {print $3;exit});
	fi

	if [ userLevel -eq 2 ];
	then shuf -n 3 week2.txt;
	q1=(cut -d'????' -f1| {print $1;exit});
	a1=(cut -d'????' -f2| {print $1;exit});
	q2=(cut -d'????' -f1| {print $2;exit});
	a2=(cut -d'????' -f2| {print $2;exit});
	q3=(cut -d'????' -f1| {print $3;exit});
	a3=(cut -d'????' -f2| {print $3;exit});
	fi

	if [ userLevel -eq 3 ];
	then shuf -n 3 week3.txt;
	q1=(cut -d'????' -f1| {print $1;exit});
	a1=(cut -d'????' -f2| {print $1;exit});
	q2=(cut -d'????' -f1| {print $2;exit});
	a2=(cut -d'????' -f2| {print $2;exit});
	q3=(cut -d'????' -f1| {print $3;exit});
	a3=(cut -d'????' -f2| {print $3;exit});
	fi

;}


userName="BikiGurung"
userLevel=1
userGameMode="easy"
userResult="Pass"
userScore=5


file="$userName.json"

# Function Name: recordState
# Description: This function will create a new file and add the users current info on the game to the file.
# args: N/A
# Name: Biki Gurung
recordState(){
	# Create a User File for each user
	touch "$file"
	# Append User Game Information:
	json_data='{"name":"'$userName'","level":"'$userLevel'","gamemode":"'$userGameMode'","result":"'$userResult'","score":"'$userScore'"}'
	echo $json_data | cat > "$file"
}

# Function name: readState
# Description: This function will read the file if it exists and then set the variables for the user.
# args: N/A
# Name: Biki Gurung
readState(){
	if [ -f "$file" ]
	then
		echo "File is found"
		echo "$file"
		userLevel=($(jq -r '.level' $file))
		userGameMode=($(jq -r '.gamemode' $file))
		userResult=($(jq -r '.result' $file))
		userScore=($(jq -r '.score' $file))

		echo "$userLevel", "$userGameMode", "$userResult", "$userScore"
	else
   		echo "File is not found"
	fi
}

recordState
readState
>>>>>>> a1c2e0d36b760fdf678d28f9aef41894f9c4757d

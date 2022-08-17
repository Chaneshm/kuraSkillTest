# KuraLabsSkillsTest [KST]
# Version 1.0
# 8.17.22 
-------------------------------------------------------------------------------------------------------------
# Potentional Breaks:
#	The user cannot insert a name with spaces.
#	The user cannot insert answers to questions with any extra spaces as it may not match stored answers.
#	Variables holding questions and answers are not dynamic, the max question and answer count is 3 for each week. Therefore, if additional questions would like to be added you would have to add new variable manually.  
-----------------------------------------------------------------------------------------
# Collaborators:
#	Biki G. - Leader
#	Yariel A. - Documenter 
#	Nicole N. - Documenter
#	Randall D. - Supervisor
#	Chanesh M. - Presenter
# -------------------------------------------------------------------------------------------------------------
# Objective: 
#	In this project, you will be able to test your Kura Labs knowledge gained. 
#	Run through a 3 week Kura Labs gauntlet if you dare!
# ---------------------------------------------------------------------------
# Requirements:
#	sudo apt install jq
#	sudo apt install curl
#	sudo apt install gnome-terminal
# -------------------------------------------------------------------------------
# Application Components:
#	Week Files:
#		There are 3 "week" files containing question/answer pairs
#	JSON User Data Files:
#		A collection of files to store user data as they pass each stage.
#	Week File Parser:
#		A function to parse the quesion/answer library of files. It is used when prompting the user
#	User State Recorder:
#		A function to record a user's game state 
#	     	Stored Info May Include: [level of difficulty, stage in the game, questions asked:answered correctly (future)
# -------------------------------------------------------------------------------------------------------------
# Application Process Flow:
# Step 1.
#	"KST" will welcome the user to the Kura "life" challenge
# Step 2.
#	"KST" will prompt user for level of difficulty they wish to play [1=Beginner, 2=Intermediate, 3=Expert]
# 	>> if "difficulty == 1"
#		- User must get 1/3 answers correct to advance to the next level [pass=1/3, fail=0/3] at ALL STAGES of the game [week1, week2, week3]
#	>> if "difficulty == 2"
#		- User must get 2/3 answers correct to advance [see above for more detail]
#	>> if "difficulty == 3"
#		- User must get 3/3 answers correct to advance [see above for more detail]
#
#	NOTE: 
#		The current Max question count per stage is set to 3.
#		A shortcut was taken when introducing variables to hold Question and Answer Pairs, limiting these pairs to 3.
#		This introduces a scalability problem as the code must be altered to add more variables to increase the potential difficulty of the game.
#		Future iterations could employ the use of dynamic variables to facilitate auto-scaling.
#
# Step 3. 
#	"Playing the Game"
#	The game will identify you by your name. [You will be prompted at the start] 
#	As a new player, you will begin at Week 1
#	If you have played previously and left the game in an incomplete state, you will be allowed to restart at the difficulty and level where you left off.
#	----
#	"Working Details" - This section outlines the process flow after your introductory variables [name, difficulty level] have been accepted.
#
#	[Before Continuing] The Game Will:
#	i. Call the "readState" function to determine whether the user is a "First Time Player" or must start off in an advanced position.
#
#	[As a first time player] The Game Will Now:
#	i. Call the "questions" function to grab 3 quesion/answer pairs from "week1.txt"....our week1 library 
#		- The function must ensure uniqueness of question/answer pairs
#	ii. Prompt user with each question [already knowing what the answers are]
#		- Compare the user's answer to the known corret answer
#		- Alert the user to whether or not they answered correctly
#			if correct --> increase their score for this stage
#			if incorrect --> score remains the same
#			NOTE:
#				Answer comparisons are case insensitive. 
#				However, if user input contains additional spaces [even if in correct locations for spaces], 
#				the exact match algorithm may fail that answer.
#		- If after 3 questions, the user has met or surpassed the minimum required score to advance 
#			--> update user's state by calling the ["recordState" function]
#			--> Congratulate them on completing the stage and begin the next level by calling the "questions" function for the next week file [week2.txt] 
#				[or]
#			    Winner, winner. Chicken Dinner! Congratulate the user for successfully completing the Kura Skills Test!!!
#		- if after 3 questions, the user has failed to meet the minimum required score to advance
#			--> ask if they wish to try again 
#				- if yes --> restart current "week" by calling the "questions" function on same week file
#				- if no --> exit gracefully
#
# Step 4. Repeat Step #3 for each stage [week1, week2, week3] until the user completes the test or declines to continue.
#
# *** Potential Future Add-On ***
# Record the user's name in the "winners" file forever!


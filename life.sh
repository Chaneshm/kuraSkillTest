#!/bin/bash

# Creation of logic for the test
q1="this is a test question"
q2="this is another test question"
q3="This is the third question"
a1="ans1"
a2="ans2"
a3="ans3"
diagnostic=1
qRight=0
level=1
echo "What difficulty would you like?"
read diff
# if [ $ans -eq $a1 ]
# then
#     echo "Correct! Keep it up!"
#     qRight = ( $qRight + 1 )
# fi
pDiff(){
    case $diff in 
        1) required=1
        ;;
        2) required=2
        ;;
        3) required=3
        ;;
    esac
}
questions(){
    $1
}

test(){
    qNum=1
    questions $level
    while [[ $qNum -le 3 ]]
    do
        case $qNum in 
            1) echo $q1
                read ans
                if [[ $ans == $a1 ]]
                    then
                        echo "Correct! Keep it up!"
                        qRight=$(( $qRight + 1 ))
                        qNum=$(( $qNum + 1 ))
                    else   
                        echo "Sorry but that answer is incorrect"
                        qNum=$(( $qNum + 1 ))
                fi
            ;;
            2) echo $q2
                read ans
                if [[ $ans == $a2 ]]
                    then
                        echo "Correct! Keep it up!"
                        qRight=$(( $qRight + 1 ))
                        qNum=$(( $qNum + 1 ))
                    else   
                        echo "Sorry but that answer is incorrect"
                        qNum=$(( $qNum + 1 ))
                fi
            ;;
            3) echo $q3
                read ans
                if [[ $ans == $a3 ]]
                    then
                        echo "Correct! Keep it up!"
                        qRight=$(( $qRight + 1 ))
                        qNum=$(( $qNum + 1 ))
                    else   
                        echo "Sorry but that answer is incorrect"
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
    else
        echo "Congrats you passed the diagnostic!"
        level=$(( $level + 1 ))
    fi

    sleep 3s
}
echo hello

pDiff
test
count=3

while [ $count -gt 0 ]
do
    read -p "please enter your username : " username
    read -sp "please enter your password : " pass
    echo

    if [[ -z $username || -z $pass ]] 
    then
        echo "input is empty!"
    else
        echo "welcome to our service"
        exit
    fi

    ((count--))
    if [[ $count -eq 0 ]]
    then
        echo "you run out of attempts"
        exit
    fi
done




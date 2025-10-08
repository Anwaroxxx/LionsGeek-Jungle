# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~#users infos~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
user1=mehdi
user2=sara

pass1=1234
pass2=abcd

balance1=1000
balance2=500

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~attemps to try~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
count=3

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Main function~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

while [ $count -gt 0 ]
do
    read -p "please enter your username : " username
    read -p "please enter your password : " pass
    echo

    if [[ -z $username || -z $pass ]] 
    then
        echo "input is empty!"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~MEHDI'S SECTION~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    elif [[ $username == $user1 && $pass == $pass1 ]] 
    then

   # ~~~~~~~~~~~~~~~~~~~using the option command to display a choosable menu~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        echo "welcome to our service MEHDI"
        PS3='please select an option :  '
        echo
        options=(
        " Check balance" 
        " Deposit money"
        " Withdraw money" 
        " Exit")
        select opt in "${options[@]}"
        do
            case $opt in
                " Check balance")
                    echo "$balance1"
                    ;;
                " Deposit money")
                    read -p "Enter amount to deposit: " amount
                    balance1=$((balance1 + amount))
                    echo "New balance: $balance1"
                    ;;
                " Withdraw money")
                    read -p "Enter amount to withdraw: " amount
                    if [ $amount -le $balance1 ]
                     then
                        balance1=$((balance1 - amount))
                        echo "New balance: $balance1"
                    else
                        echo "Insufficient funds"
                    fi
                    ;;
                " Exit")
                    exit
                    ;;
                *)
                    echo "Invalid option"
                    ;;
            esac
        done
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~SARA'S SECTION~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        elif [[ $username == $user2 && $pass == $pass2 ]] 
    then
        echo "welcome to our service SARA"
        PS3='please select an option :  '
        options=(
        " Check balance" 
        " Deposit money"
        " Withdraw money" 
        " Exit")
        select opt in "${options[@]}"
        do
            case $opt in
                " Check balance")
                    echo "$balance2"
                    ;;
                " Deposit money")
                    read -p "Enter amount to deposit: " amount
                    balance2=$((balance2 + amount))
                    echo "New balance: $balance2"
                    ;;
                " Withdraw money")
                    read -p "Enter amount to withdraw: " amount
                    if [ $amount -le $balance2 ]
                     then
                        balance2=$((balance2 - amount))
                        echo "New balance: $balance2"
                    else
                        echo "Insufficient funds"
                    fi
                    ;;
                " Exit")
                    exit
                    ;;
                *)
                    echo "Invalid option"
                    ;;
            esac
        done

    fi

    ((count--))
    if [[ $count -eq 0 ]]
    then
        echo "you run out of attempts"
        exit
    fi
done






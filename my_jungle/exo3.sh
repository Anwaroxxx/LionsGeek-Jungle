room=5
level=1
gold=300
health=100

while [ $room -gt 0 ]
do
    read -p "please enter your username : " username
    echo

    if [[ -z $username ]]
    then
        echo "input is empty!"
        echo
    elif [[ -n $username ]]
    then
        echo "welcome to the jungle game $username !!"
        echo

        PS3="a random level gonna be choosed (room $level) : "
        options=("fight a monster" "claim a treasure" "get rekt on a trap")
        random=$((RANDOM % ${#options[@]}))
        selected="${options[$random]}"

        echo "The jungle judged you to : $selected"
        echo

        select opt in "${options[@]}"
        do
            if [[ $selected == "fight a monster" ]]
            then
                echo "A monster appeared!"
                options=("attack" "run away")
                select fight in "${options[@]}"
                do
                    case $fight in
                        "attack")
                            dmg=$((RANDOM % 30 + 10))
                            health=$((health - dmg))
                            echo "You fought bravely but lost $dmg HP, health left: $health"
                            ;;
                        "run away")
                            echo "You ran away but survived."
                            ;;
                        *)
                            echo "invalid choice"
                            ;;
                    esac
                    break
                done
                ((room--))
                ((level++))
                break
            fi

            if [[ $selected == "claim a treasure" ]]
            then
                gain=$((RANDOM % 50 + 10))
                gold=$((gold + gain))
                echo "You found $gain gold! total gold: $gold"
                ((room--))
                ((level++))
                break
            fi

            if [[ $selected == "get rekt on a trap" ]]
            then
                options=("u lost ur -25 of health" "u lost -50 of ur health" "u lost all ur health")
                random_health=$((RANDOM % ${#options[@]}))
                damage="${options[$random_health]}"
                echo "Trap triggered: $damage"

                case $damage in
                    "u lost all ur health")
                        echo "GAME OVER!"
                        exit
                        ;;
                    "u lost ur -25 of health")
                        health=$((health - 25))
                        echo "you have $health health left"
                        ;;
                    "u lost -50 of ur health")
                        health=$((health - 50))
                        echo "you have $health health left"
                        ;;
                esac
                ((room--))
                ((level++))
                break
            fi
        done

        if [[ $room -eq 0 ]]
        then
            echo
            echo "You survived the jungle but COACH MEHDI blocks the way and said:"
            echo "\"listen here you little warrior, your journey has ended.\""
            echo

            PS3="Choose your path warrior : "
            options=(
                "gimme a 50 gold bash ndir 3in mika"
                "fight me"
                "a 50% chance to sneak past me if not you gonna DIE"
            )

            select opt in "${options[@]}"
            do
                case $opt in
                    "gimme a 50 gold bash ndir 3in mika")
                        if (( gold >= 50 )); then
                            gold=$((gold - 50))
                            echo "You bribed the coach with 50 gold."
                            echo "Congrats, you won!"
                            exit
                        else
                            echo "Not enough gold. The coach finished you."
                            exit
                        fi
                        ;;
                    "fight me")
                        coach=$((RANDOM % 80 + 20))
                        if ((health > coach)); then
                            echo "You actually defeated Coach Mehdi."
                            echo "Victory!"
                        else
                            echo "Coach Mehdi defeated you."
                        fi
                        exit
                        ;;
                    "a 50% chance to sneak past me if not you gonna DIE")
                        chance=$((RANDOM % 2))
                        if ((chance == 0)); then
                            echo "You sneaked past him successfully."
                            echo "You win!"
                        else
                            echo "Coach Mehdi caught you. Game over."
                        fi
                        exit
                        ;;
                    *)
                        echo "invalid choice"
                        ;;
                esac
            done
        fi
    fi
done

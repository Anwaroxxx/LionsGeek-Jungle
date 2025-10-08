#!/bin/bash

# === Signup & Login ===
declare -A users
users=( ["mehdi"]="1234" ["sara"]="abcd" )

attempts=3
logged_in=false

while [ $attempts -gt 0 ]; do
    read -p "Username: " username
    read -sp "Password: " password
    echo
    if [[ ${users[$username]} == "$password" ]]; then
        echo "Welcome, $username!"
        logged_in=true
        break
    else
        echo "Invalid login. Try again."
        ((attempts--))
    fi
done

if ! $logged_in; then
    echo "Too many failed attempts. Exiting..."
    exit 1
fi

# === Game setup ===
health=100
gold=0
rooms=5
history=()

echo "You enter the jungle... Health=$health, Gold=$gold"

for ((i=1; i<=rooms; i++)); do
    echo
    echo "---- Room $i ----"
    event=$((RANDOM % 3)) 

    case $event in
        0) # Monster
            echo "A wild monster appears!"
            read -p "Do you want to fight or run? (fight/run): " choice
            if [[ $choice == "fight" ]]; then
                player_dmg=$((RANDOM % 30 + 1))
                monster_dmg=$((RANDOM % 30 + 1))
                health=$((health - monster_dmg))
                echo "You dealt $player_dmg damage but lost $monster_dmg HP."
                if ((health <= 0)); then
                    history+=("Room $i: Fought monster → Died")
                    echo "GAME OVER! "
                    exit
                else
                    history+=("Room $i: Fought monster → Survived with $health HP")
                fi
            else
                history+=("Room $i: Ran away from monster")
                echo "You escaped safely."
            fi
            ;;
        1) # Treasure
            gold_found=$((RANDOM % 50 + 10))
            gold=$((gold + gold_found))
            echo "You found $gold_found gold! Total gold: $gold"
            history+=("Room $i: Found $gold_found gold (Total=$gold)")
            ;;
        2) # Trap
            trap_dmg=$((RANDOM % 30 + 10))
            health=$((health - trap_dmg))
            echo "A trap! You lost $trap_dmg HP. Remaining HP=$health"
            if ((health <= 0)); then
                history+=("Room $i: Trap killed you")
                echo "GAME OVER! "
                exit
            else
                history+=("Room $i: Trap → Lost $trap_dmg HP, HP=$health")
            fi
            ;;
    esac
done

# === Final Boss ===
echo
echo "You survived all rooms... but a GUARD blocks your path!"
echo "Options:"
echo "a) Bribe the guard (50 gold)"
echo "b) Fight the guard"
echo "c) Sneak past (50% chance)"

read -p "Choose your action (a/b/c): " action
case $action in
    a)
        if ((gold >= 50)); then
            echo "You bribed the guard with 50 gold. You win! "
            history+=("Bribed guard with 50 gold → Victory")
        else
            echo "Not enough gold! The guard kills you. "
            history+=("Tried to bribe guard but failed → Death")
        fi
        ;;
    b)
        guard_hp=$((RANDOM % 50 + 50))
        if ((health > guard_hp)); then
            echo "You fought bravely and defeated the guard! "
            history+=("Fought guard (HP=$guard_hp) → Victory")
        else
            echo "The guard was too strong. You died. "
            history+=("Fought guard (HP=$guard_hp) → Death")
        fi
        ;;
    c)
        chance=$((RANDOM % 2))
        if ((chance == 0)); then
            echo "You snuck past the guard successfully!"
            history+=("Sneaked past guard → Victory")
        else
            echo "You got caught sneaking. The guard kills you."
            history+=("Sneak attempt failed → Death")
        fi
        ;;
    *)
        echo "Invalid choice. The guard kills you. "
        history+=("Invalid guard choice → Death")
        ;;
esac

# === Show History ===
echo
echo "===== Adventure History ====="
for entry in "${history[@]}"; do
    echo "$entry"
done
#!/bin/bash

min_word_length=4
max_word_length=6
password_word_count=5
dice_number=""

function dice2int {
    dice_base=6

    i=0
    number=0

    for current_dice_digit in $(fold -w1 <<< "$(echo "$1" | rev)"); do
        current_dice_digit_index=$((current_dice_digit - 1))
        number=$(("$number" + "$current_dice_digit_index" * "$dice_base" ** "$i"))
        i=$(("$i"+1))
    done

    echo $number
}

function show_help {
    echo
    echo "diceware"
    echo
    echo " --dice (-d)"
    echo " --min (-n) sets minimum number of characters in the words"
    echo " --max (-m) sets maximum number of characters in the words"
    echo " --count (-c) sets how many word the password will contain"
    echo " --help (-h) shows help message and exit"
    echo
}


while [[ $# -gt 0 ]]; do
    case $1 in
        --dice|-d)
            dice_number=$2
            if ! [[ $dice_number =~ ^[123456]{1,6}$ ]]; then
                echo "Invalid dice input!"
                exit 1
            fi
            shift
        ;;
        --min|-n)
            min_word_length=$2
            shift
        ;;
        --max|-m)
            max_word_length=$2
            if [[ $max_word_length -lt $min_word_length ]]; then
                echo
                echo "max should be greater than min"
                exit 1
            fi
            shift
        ;;
        --count|-c)
            password_word_count=$2
            shift
        ;;
        --help|-h)
            show_help
            exit 0
        ;;
    esac
    shift
done


elegible_words=$(
    grep -E "^[A-Za-z]{${min_word_length},${max_word_length}}$" /usr/share/dict/words | tr '\n' ' ')
word_count=$(wc -w <<< "$elegible_words")


if [[ -z $dice_number ]]; then
    for ((i = 0; i < "$password_word_count"; i++)); do
        echo -n "$(cut -d ' ' -f $(("$RANDOM" % "$word_count" + 1)) <<< "$elegible_words" | tr '[:upper:]' '[:lower:]') "
    done

    echo
    exit 0
fi

if [ "$(dice2int "$dice_number")" -gt "$word_count" ]; then

    echo
    echo -n "$dice_number represents the $(dice2int "$dice_number")th word, but"
    echo " we just have $word_count words."
    echo

    exit 1
fi

cut -d ' ' -f "$(dice2int "$dice_number")" <<< "$elegible_words" | tr '[:upper:]' '[:lower:]'

#!/bin/bash

card_name=$1
profile_name=$2

card_id=$(pactl list cards | awk -v name="$card_name" '/Card #/{sub(/#/,"",$2); id=$2} $0~name{print id; exit}')

if [[ -n $card_id ]]; then
    pactl set-card-profile "$card_id" ${profile_name}
else
    echo "Card not found!"
fi

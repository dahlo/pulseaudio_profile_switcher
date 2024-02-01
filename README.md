```bash
# see all cards and profiles
pactl list cards

# set by
pactl set-card-profile <index> <profile-name>

# ex.
pactl set-card-profile 2 output:analog-stereo+input:analog-stereo

pactl set-card-profile 2 output:iec958-stereo
```

Since the #id of the card apparently can change, `set_output.sh` takes the name of the card and fetches the #id based of that instead. Use `pactl list cards` to get name of card and available profiles for it.

```bash
# example

set_output.sh "alsa_card.pci-0000_0b_00.4" "output:analog-stereo+input:analog-stereo"
```

# PulseAudio profile switcher

My computer is connected with a optical cable from the sound card on the motherboard to a speaker. I also have a headset for video meetings and i want to switch back and forth between the speaker and the headset. Using the panel plugin in xfce4 requires you to go into the audio mixer, then to `Profiles`, and then change the profile from a drop-down list for the sound card in question. Too much work.

This small bash script will take the name of the card you want to modify and the name of a profile and set the card to that profile. See the name of the card and its profiles by running `pactl list cards`

It uses the name of the card instead of the #id of the card since the #id kept changing on my computer. The name seems to be unchanged though.

## Installation

Just clone this repo.

```bash
git clone https://github.com/dahlo/pulseaudio_profile_switcher.git
```

## Usage

First get the name of the card and the profile(s) you want to switch to.

```bash
# see all cards and profiles
pactl list cards

# trunkated output:
Card #76
	Name: alsa_card.pci-0000_09_00.1
	Driver: alsa
	Owner Module: n/a
	Properties:
		api.acp.auto-port = "false"
		api.acp.auto-profile = "false"
.
.
.
	Profiles:
		off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
		output:analog-stereo+input:analog-stereo: Analog Stereo Duplex (sinks: 1, sources: 1, priority: 6565, available: yes)
		output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0, priority: 6500, available: yes)
		output:iec958-stereo+input:analog-stereo: Digital Stereo (IEC958) Output + Analog Stereo Input (sinks: 1, sources: 1, priority: 5565, available: yes)
		output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, sources: 0, priority: 5500, available: yes)
.
.
.

```

So the important parts in the output are `Name: alsa_card.pci-0000_09_00.1` and `output:analog-stereo+input:analog-stereo` or `output:iec958-stereo` in my case. The card name and profile name will be passed to the script as arguments, like this:

```bash
# switch to headset
set_output.sh "alsa_card.pci-0000_0b_00.4" "output:analog-stereo+input:analog-stereo"

# switch to speaker
set_output.sh "alsa_card.pci-0000_0b_00.4" "output:iec958-stereo"
```

I then created launchers in the xfce4 panel, one for each command (either add the repo dir to your `$PATH` or specify full path to the script), and gave them nice icons representing a headset and speaker respectively. Then you just press one of the icons and the sound comes out from a different place.

## Under the hood

```bash
# example of how the script uses pulseaudio to set the profile
pactl set-card-profile <index> <profile-name>

# ex.
pactl set-card-profile 2 output:analog-stereo+input:analog-stereo

pactl set-card-profile 2 output:iec958-stereo
```

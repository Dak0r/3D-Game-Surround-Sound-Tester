# 3D Surround Sound Tester

This tool allows you to test how your Surround Sound Setup sounds in games and
verify all speakers are set up correctly.
It plays looping sounds at a steady volume while moving them around the listeners
position.
The audio source can also be controlled via keyboard or a game pad.

![Screenshot of the surround sound tester app](/screenshot.png?raw=true)

Created with Godot 4

## Adjusting settings
1. Open Sound Settings (in Windows 11 choose "More Sound Settings").
2. Choose your audio device in the Playback Tab
3. Click Properties, Open the "Levels" Tab and click on `Balance`
4. Run this tool and adjust the Levels for the individual channels until the
volume is identical from any direction.

##  Why?
I created this after noticing that the rear channels were noticeably too loud
in Windows, even though they were fine if used with a FireTV or the devices
Test tone.
I had to adjust the "Levels" for the rear channels in the Windows settings to
get an identical volume from all speakers. Testing with real game sounds can
be tedious, I created this tool that lets me play the same sound from any direction
over and over again.

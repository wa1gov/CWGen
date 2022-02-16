# CWGen

Shell script to generate XML animated images for use with Windows Movie Maker
*Now updated with wav file creation using github.com/cardre/morsewav.py

*Note: Windows Movie Maker is a discontinued video editing software program
 by Microsoft. It was a part of Windows Essentials software suite and offered
 the ability to create and edit videos.

Usage: cwgen < Morse code characters > | < Text characters >

Examples:
Use / for word space
cwgen "-.-. --.- / -.. . / .-- .- .---- --. --- ...-" > cq.wlmp
Output XML, redirect to .wlmp file for input to the WMM app.
Output will also be decoded in the file cwgen.decoded
No wav file will be generated for Morse code input.
Or:
cwgen "CQ DE WA1GOV" > cq.wlmp
Output will be Morse code in the file cwgen.code
A wav file will be generated for text input if morsewav.py is installed.

Examples of the final product can be found on YouTube
https://www.youtube.com/watch?v=OcyDW8ZoexY

KeyUp, KeyDown images and wav file locations must be defined
in the MediaItems section:

    <MediaItem id=\"1\" filePath=\"C:\\cygwin64\\home\\Art\\key up.jpg\"
    <MediaItem id=\"2\" filePath=\"C:\\cygwin64\\home\\Art\\key down.jpg\"
    <MediaItem id=\"3\" filePath=\"C:\\cygwin64\\home\\Art\\cwgen.wav\"

Audio files are automatically created for text input using morsewav.py if
 it is installed. (see github.com/cardre/morsewav.py)

The morsewav.py program should reside in the working directory under
 morsewav.py. (e.g. ./morsewav.py/morsewav.py)

If using externally generated wav files, Morse code should be at a speed
 of 12wpm with the following timing and various pauses:
Dit: 1 unit
Dah: 3 units
Intra-character space (the gap between dits and dahs within a character): 1 unit
Inter-character space (the gap between the characters of a word): 3 units
Word space (the gap between two words): 7 units.

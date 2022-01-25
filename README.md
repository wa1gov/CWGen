# CWGen
Create animated images for use with Windows Movie Maker
Shell script to generate XML animated code key for use with Windows Movie Maker

*Note: Windows Movie Maker is a discontinued video editing software program
 by Microsoft. It was a part of Windows Essentials software suite and offered
 the ability to create and edit videos.

Usage: cwgen < Morse code characters > | < Text characters >

Examples:
Use / for word space
cwgen "-.-. --.- / -.. . / .-- .- .---- --. --- ...-" > cq.wlmp
Output XML, redirect to .wlmp file for input to the WMM app.
Output will also be decoded in the file cwgen.decoded
Or:
cwgen "CQ DE WA1GOV" > cq.wlmp
Output will be Morse code in the file cwgen.code

Examples of the final product can be found on YouTube
https://www.youtube.com/watch?v=OcyDW8ZoexY

KeyUp and KeyDown images must be defined in the MediaItems section

    <MediaItem id=\"1\" filePath=\"C:\\Users\\Art\\Downloads\\key up.jpg\"
    <MediaItem id=\"2\" filePath=\"C:\\Users\\Art\\Downloads\\key down.jpg\"

Audio files can be created using various apps that translate text into Morse.
These files for Morse code should be at a speed of 12wpm with the following timing and various pauses:
Dit: 1 unit
Dah: 3 units
Intra-character space (the gap between dits and dahs within a character): 1 unit
Inter-character space (the gap between the characters of a word): 3 units
Word space (the gap between two words): 7 units.

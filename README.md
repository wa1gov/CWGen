# CWGen
Create animated images for use with Windows Live Movie Maker

Shell script to generate XML animated code key for use with Windows Movie Maker

Usage: cwgen < Morse code characters >

Examples:
Use / for word space in both cases
cwgen "-.-. --.- / -.. . / .-- .- .---- --. --- ...-" > cq.wlmp
Output XML, redirect to .wlmp file for input to the WMM app.
Output will also be decoded in the file cwgen.decode
Or:
cwgen "C Q / D E / W A 1 G O V" > cq.wlmp
Output will be Morse code in the file cwgen.code

Examples of the final product can be found on YouTube
https://www.youtube.com/watch?v=OcyDW8ZoexY

KeyUp and KeyDown images must be defined in the MediaItems section

    <MediaItem id=\"1\" filePath=\"C:\\Users\\Art\\Downloads\\key up.jpg\"
    <MediaItem id=\"2\" filePath=\"C:\\Users\\Art\\Downloads\\key down.jpg\"

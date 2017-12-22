# Saves multiple sound files as WAV in a directory chosen in the script.
# This has been checked on a Mac and saves the files with the name given in the
# object window. 
# Written by: Richard Hatcher email: rjhatche@buffalo.edu

dir$ = chooseDirectory$: "Choose a directory"

n = numberOfSelected("Sound")
for i from 1 to n
s'i' = selected("Sound",'i')
s'i'$ = selected$("Sound",'i')
endfor

for i from 1 to n
n$ = s'i'$
select s'i'
Save as WAV file... 'dir$'/'n$'.wav
endfor

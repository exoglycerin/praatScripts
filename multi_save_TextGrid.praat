# Saves multiple TextGrid files in a directory chosen within the script.
# This has been checked on a Mac and saves the files with the name given in the
# object window. 
# Written by: Richard Hatcher email: rjhatche@buffalo.edu

dir$ = chooseDirectory$: "Choose a directory"

n = numberOfSelected("TextGrid")
for i from 1 to n
s'i' = selected("TextGrid",'i')
s'i'$ = selected$("TextGrid",'i')
endfor

for i from 1 to n
n$ = s'i'$
select s'i'
Save as text file... 'dir$'/'n$'.TextGrid
endfor
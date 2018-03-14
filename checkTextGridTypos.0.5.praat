# Checks TextGrid files within a directory chosen by user.
# It determines whether there are any typos in the TextGrid.
# It checks whether the trial tier is the same name as the 
# filename. It checks that each word is spelled the same.
# It checks that each syllable of disyllabic words are typed
# identically. And each rime of a disyllabic word is identical.
# Errors are output to a file output.txt in the same directory
# as the TextGrid files.
#
# Written by: Richard Hatcher email: rjhatche@buffalo.edu

dir$ = chooseDirectory$: "Choose a directory"

# Check Trial Tier

list = Create Strings as file list: "Filelist", dir$ + "/*.TextGrid"

numOfFiles = Get number of strings
writeFileLine: dir$ + "/output.txt", dir$
for i to numOfFiles - 1
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: dir$+ "/" + filename$
	tier1$ = Get label of interval: 1,1
	nameLen = length(filename$)
	fileNoExt$ = left$(filename$, nameLen - 9)
	if fileNoExt$<>tier1$
		appendFileLine: dir$ + "/output.txt", filename$ + " tier 1 error"
	endif
	removeObject: fileID
endfor
removeObject: list

# Check Word Tier

list = Create Strings as file list: "Filelist", dir$ + "/*.TextGrid"

numOfFiles = Get number of strings
# The minus one disregards the unsegmented TextGrid
for i to numOfFiles - 1 
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: dir$+ "/" + filename$
	@labelsToStrings: 2

	numOfReps = Get number of strings
	prevRep$ = ""
	for j to numOfReps
		repID$ = Get string: j
		if prevRep$ = ""
			prevRep$ = repID$
		elsif prevRep$<>repID$
			appendFileLine: dir$ + "/output.txt", filename$ + " tier 2 error"
		endif
	endfor
	removeObject: fileID
endfor
removeObject: list

# Check Syllable Tier

list = Create Strings as file list: "Filelist", dir$ + "/*.TextGrid"

numOfFiles = Get number of strings
# The minus one disregards the unsegmented TextGrid
for i to numOfFiles - 1 
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: dir$+ "/" + filename$
	disyllabic$ = Get label of interval: 3,3
	if disyllabic$ <> ""
		@labelsToStrings: 3

		numOfReps = Get number of strings
		initial$ = ""
		final$ = ""
		for j to numOfReps
			repID$ = Get string: j
			if j mod 2 <> 0
				if initial$ = ""
					initial$ = repID$
				elsif initial$<>repID$
					appendFileLine: dir$ + "/output.txt", filename$ + " tier 3 error"
				endif
			else
				if final$ = ""
					final$ = repID$
				elsif final$<>repID$
					appendFileLine: dir$ + "/output.txt", filename$ + " tier 3 error"
				endif
			endif
		endfor
	else
		@labelsToStrings: 3

		numOfReps = Get number of strings
		prevRep$ = ""
		for j to numOfReps
			repID$ = Get string: j
			if prevRep$ = ""
				prevRep$ = repID$
			elsif prevRep$<>repID$
				appendFileLine: dir$ + "/output.txt", filename$ + " tier 2 error"
			endif
		endfor
	endif
	removeObject: fileID
endfor
removeObject: list

# Check Rime Tier

list = Create Strings as file list: "Filelist", dir$ + "/*.TextGrid"

numOfFiles = Get number of strings
# The minus one disregards the unsegmented TextGrid
for i to numOfFiles - 1 
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: dir$+ "/" + filename$
	disyllabic$ = Get label of interval: 3,3
	if disyllabic$ <> ""
		@labelsToStrings: 4

		numOfReps = Get number of strings
		initial$ = ""
		final$ = ""
		for j to numOfReps
			repID$ = Get string: j
			if j mod 2 <> 0
				if initial$ = ""
					initial$ = repID$
				elsif initial$<>repID$
					appendFileLine: dir$ + "/output.txt", filename$ + " tier 4 error"
				endif
			else
				if final$ = ""
					final$ = repID$
				elsif final$<>repID$
					appendFileLine: dir$ + "/output.txt", filename$ + " tier 4 error"
				endif
			endif
		endfor
	else
		@labelsToStrings: 4

		numOfReps = Get number of strings
		prevRep$ = ""
		for j to numOfReps
			repID$ = Get string: j
			if prevRep$ = ""
				prevRep$ = repID$
			elsif prevRep$<>repID$
				appendFileLine: dir$ + "/output.txt", filename$ + " tier 4 error"
			endif
		endfor
	endif
	removeObject: fileID
endfor
removeObject: list

list = Create Strings as file list: "Filelist", dir$ + "/*.TextGrid"

numOfFiles = Get number of strings
# The minus one disregards the unsegmented TextGrid
for i to numOfFiles - 1 
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: dir$+ "/" + filename$
	disyllabic$ = Get label of interval: 3,3
	numOfTiers = Get number of tiers
	if numOfTiers = 5
	if disyllabic$ <> ""
		@labelsToStrings: 5

		numOfReps = Get number of strings
		initial$ = ""
		final$ = ""
		for j to numOfReps
			repID$ = Get string: j
			if j mod 2 <> 0
				if initial$ = ""
					initial$ = repID$
				elsif initial$<>repID$
					appendFileLine: dir$ + "/output.txt", filename$ + " tier 5 error"
				endif
			else
				if final$ = ""
					final$ = repID$
				elsif final$<>repID$
					appendFileLine: dir$ + "/output.txt", filename$ + " tier 5 error"
				endif
			endif
		endfor
	else
		@labelsToStrings: 5

		numOfReps = Get number of strings
		prevRep$ = ""
		for j to numOfReps
			repID$ = Get string: j
			if prevRep$ = ""
				prevRep$ = repID$
			elsif prevRep$<>repID$
				appendFileLine: dir$ + "/output.txt", filename$ + " tier 5 error"
			endif
		endfor
	endif
	endif
	removeObject: fileID
endfor
removeObject: list










procedure labelsToStrings: .tier
  .textgrid = selected("TextGrid")

  # Make sure this works with interval and point tiers
  .item$ = if do("Is interval tier...", .tier) then
    ... "interval" else "point" fi

  # Make the empty Strings
  .strings = Create Strings as tokens: ""
  Rename: filename$

  # Fetch each label, and insert it to the Strings object
  selectObject: .textgrid
  .n = do("Get number of " + .item$ + "s...", .tier)
  for .i to .n
    selectObject: .textgrid
    .label$ = do$("Get label of " + .item$ + "...", .tier, .i)

    # I assume you don't care about empty labels?
    if .label$ != ""
      selectObject: .strings
      Insert string: 0, .label$
    endif
  endfor

  # Make sure the new object is selected
  selectObject: .strings
endproc
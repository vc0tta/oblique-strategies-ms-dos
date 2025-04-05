'Oblique Strategies (Over One Hundred Worthwhile Dilemmas) for DOS
'2025 Valentin Cotta
'Written in FreeBasic

'displays help
if Command(1) = "/?" then
	Print("Oblique Strategies (Over One Hundred Worthwhile Dilemmas) for DOS")
	Print("Version 2.5.4.5 ""America Is Waiting""")
	Print("1975 Brian Eno and Peter Schmidt")
	Print("2025 Valentin Cotta")
	Print("")
	Print("OSDOS [/T]")
	Print("")
	Print("  /T      Displays a random card in text mode")
	end
End If

''oblique strategies list
'taken from sansumbrella/Processing-ObliqueStrategies: Processing tool for generating useful dilemmas. (2025). GitHub. https://github.com/sansumbrella/Processing-ObliqueStrategies/tree/master
Dim As String strategies(0 To 110) = { "Turn it over", "Switch the axes", "Think about color", "Make it black and white", "Use the tangents", "Move across the room", "Restart", "Make it ridiculous", "Stop making sense", "Emphasize the side effects", "Turn it into a game", "More semicolons", "A => AB, B => B", "Apply the Sieve of Eratosthenes", "0,1,1 => 0,0,0", "1,0,1 => 0,1,0", "Maybe you should use %", "Block, Beehive, Loaf, Boat", "Blinker, Toad, Beacon, Pulsar", "Glider, LWSS", "The R pentomino", "Make the model the view", "Change your controller", "Try faking it", "State the problem in words as clearly as possible", "Only one element of each kind", "What would your closest friend do?", "What to increase? What to reduce?", "Are there sections? Consider transitions", "Don't think. Do", "But, does it float?", "Remove half", "0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597...", "3.14159265358 9793238462643 3832795028...", "Double the main element", "Abandon normal instruments", "Accept advice", "Accretion", "A line has two sides", "Balance the consistency principle with the inconsistency principle", "Be dirty", "Breathe more deeply", "Bridges -build -burn", "Cascades", "Cluster analysis", "Consider different fading systems", "Courage!", "Cut a vital connection", "Decorate, decorate", "Define an area as 'safe' and use it as an anchor", "Destroy the most important thing", "Discard an axiom", "Disconnect from desire", "Discover the recipes you are using and abandon them", "Distorting time", "Don't be afraid of things because they're easy to do", "Don't be frightened of cliches", "Don't be frightened to display your talents", "Don't stress one thing more than another", "Do something boring", "Do the washing up", "Do the words need changing?", "Do we need holes?", "Emphasize differences", "Emphasize repetitions", "Emphasize the flaws", "Get your neck massaged", "Give way to your worst impulse", "Go slowly all the way round the outside", "Honor thy error as a hidden intention", "How would you have done it?", "Humanize something free of error", "Infinitesimal gradations", "Into the impossible", "Is it finished?", "Is there something missing?", "Just carry on", "Left channel, right channel, centre channel", "Look at a very small object, look at its centre", "Look at the order in which you do things", "Look closely at the most embarrassing details and amplify them", "Make a blank valuable by putting it in an exquisite frame", "Make an exhaustive list of everything you might do and do the last thing on the list", "Make a sudden, destructive unpredictable action; incorporate", "Only one element of each kind", "Remember those quiet evenings", "Remove ambiguities and convert to specifics", "Remove specifics and convert to ambiguities", "Repetition is a form of change", "Reverse", "Simple subtraction", "Spectrum analysis", "Take a break", "Take away the elements in order of apparent non-importance", "Tidy up", "Turn it upside down", "Twist the spine", "Use an old idea", "Use an unacceptable color", "Water", "What are you really thinking about just now? Incorporate", "What is the reality of the situation?", "What mistakes did you make last time?", "What wouldn't you do?", "Work at a different speed", "Take a walk", "Take a shower", "Look to Nature", "Talk it through with a friend", "Who's my audience", "Forget the money, make it cool" }

Dim cardscount as Integer = UBound(strategies)
Dim index As Integer
Dim strategy As String

'text mode
if LCase(Command(1)) = "/t" then
	'pick random index
	Randomize
	index = Rnd * cardscount
	strategy = strategies(index)
	
	Print(strategy)
	end
End If
		
'clear screen
cls

'320x200 graphics mode
screen 13

'screen dimensions
Const w = 320, h = 200
Dim x As Integer, y As Integer

'open a graphics window
ScreenRes w, h

'hide mouse cursor
SetMouse -1, -1, 0
	
'corners radius	
Dim radius As Integer = 20

Dim key As String, part as String, char as String
While True
	'check for key press
    key = Inkey()  
	
	'if enter or space or init
    If key = Chr(13) Or key = Chr(32) Or x = 0 Then
		'pick random index
		Randomize
		index = Rnd * cardscount
		strategy = strategies(index)

		''draw an Oblique Strategy in the centre of the screen:
		'x = (w - Len(strategy) * 8) \ 2
		y = (h - 1 * 8) \ 2

		''card drawing
		'corners radius
		'upper left corner
		Circle (radius, radius), radius, 15, , , 1, F
		'upper right corner
		Circle (w-radius-1, radius), radius, 15, , , 1, F
		'bottom right corner
		Circle (w-radius-1, h-radius-1), radius, 15, , , 1, F
		'bottom left corner
		Circle (radius, h-radius-1), radius, 15, , , 1, F
		'white rectangle fill on width
		Line (0, radius)-(w-1, h-radius-1), 15, bf
		'white rectangle fill on height
		Line (radius, 0)-(w-radius-1, h-1), 15, bf

		'split and word wrap
		Dim lastpos as Integer = 1
		For i As Integer = 1 To Len(strategy)
			char = mid(strategy,i,1)
			
			'if space and fit screen do a line break
			if (char = " ") And (i-lastpos >= 20) Then
				part = mid(strategy,lastpos,i-lastpos)
				
				'draw strategy text part
				x = (w - Len(part) * 8) \ 2
				Draw String (x, y), part, 0
				
				y += 12
				lastpos = i+1
			End If
			
			'append remaining part of the string
			If i = Len(strategy) Then
				part = mid(strategy,lastpos,i-lastpos+1)
				'draw strategy text part
				x = (w - Len(part) * 8) \ 2
				Draw String (x, y), part, 0
			End if
		Next i
    End If

    'if the Escape key is pressed, exit the loop
    If key = Chr(27) Then
        Exit While
    End If

    Sleep
Wend
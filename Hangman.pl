#!/usr/local/bin/perl

#To lay down instructions.
sub intro {
    print "\n\tWelcome to Hangman.\n";
    hangmanLose();
    print"\nYou have to guess letters one at a time to solve the given word puzzle.
If you enter the correct letter(A-Z or a-z), all the corresponding places
in the word will be filled with the entered letter.
Otherwise, you will lose one body part of the hangman.
You will be given 7 chances to guess the word correctly.
To get a clue of the word, enter 'hint'.\n\n";
    $win=0;
    $lose=0;
}


#random game word generator.
sub wordDecide {
    my @words = ('computer','radio','calculator','teacher','bureau','police',
    'geometry','president','subject','country','enviroment','classroom',
    'animals','province','month','politics','puzzle','instrument','kitchen',
    'language','vampire','ghost','solution','service','software','virus',
    'security','phonenumber','expert','website','agreement','support',
    'compatibility','advanced','search','triathlon','immediately','encyclopedia',
    'endurance','distance','nature','history','organization','international',
    'championship','government','popularity','thousand','feature','wetsuit',
    'fitness','legendary','variation','equal','approximately','segment','priority',
    'physics','branche','science','mathematics','lightning','dispersion','accelerator',
    'detector','terminology','design','operation','foundation','application',
    'prediction','reference','measurement','concept','perspective','overview',
    'position','airplane','symmetry','dimension','toxic','algebra','illustration',
    'classic','verification','citation','unusual','resource','analysis','license',
    'comedy','screenplay','production','release','emphasis','director',
    'trademark','vehicle','aircraft','experiment');

    #print $words[rand @words], "\n";

    $gameWord = $words[rand@words];
    #print $gameWord,"\t", length($gameWord), "\n" ;
    gamePlay();
} 


#the game loop.
sub gamePlay {

    print "\n\tHere is your word: ";
    # for ($i=0; $i<length($gameWord); $i++){
    #     print "_ ";
    # }

    #initialising array to hold progress of the word.
    @currentWord = (_) x length($gameWord);
    print "@currentWord" , "\n";

    while(checkWin(@currentWord)== 1 && checkLose()==1){
        @currentWord = letterPosition(@currentWord);
    }

    #dereferencing the arrays.
    @incorrectInput = ();
    @inputArray = ();
    print "Games won: $win\t\tGames lost: $lose\n";
    playAgain();
}


#to take a valid letter input
sub letterInput {

    print "\nMake a guess: ";
    my $letter=<STDIN>;
    chomp $letter;
    #print length($letter);

    #to ensure single character input.
    while(length($letter)!= 1 && (lc $letter ne 'hint')){
        print "Invalid input! Please enter only one letter.\n";
        print "Make a guess: ";
        $letter = <STDIN>;
        chomp $letter;
    }

    #in case user asks for hint.
    if(lc $letter eq 'hint'){
        $letter = hint();
        while(validMove($letter)==1){
            $letter = hint();  
        }
        pop(@inputArray);
        print "Hint: ", uc "$letter";
    }

    return $letter;
}

#determines the position of entered letter in the word.
sub letterPosition {

    (@wordDisplay) = @_;
    # print "$word\n";

    my $input = lc letterInput();

    while(validMove($input)==1){
        print "Invalid Input!! You have already entered this. Please try again!" ;
        $input = letterInput();
    }

    my $offset = 0;
    my $position = index($gameWord, $input, $offset);
    #print "$position\n";
    #splice(@display, $position, 1, $letter);
    #print uc "@display" , "\n" ;
    #print "$letter at $position\n";

    #in case of incorrect input
    @incorrectInput;
    if($position == -1){
        push(@incorrectInput, $input);
    }
    else{
        #to check all the occurences of the correct input in the word
        while($position != -1){
            splice(@wordDisplay, $position, 1, $input);
            #print "$letter at $position\n";

            $offset = $position +1;
            $position = index($gameWord, $input, $offset);
        }
    }

    print "\n\nWord Progress: \t";
    print uc "@wordDisplay" , "\n" ;
    print "Incorrect guesses so far: ";
    print uc "@incorrectInput", "\n";

    return @wordDisplay;
}


#to check whether the letter has been entered before or not.
sub validMove {
    ($input) = @_;

    @inputArray;
 
    # print "valid move: ", scalar @inputArray, "\n";
    # print @inputArray, "\n";

    foreach $ele (@inputArray){
        if($input eq $ele){
            return 1;   
        }
    }
    push(@inputArray, $input);
    return 0;
}


#if user calls for hint
sub hint {

    $index = rand(length($gameWord));
    $char = substr($gameWord,$index,1);
    #print "hint = $char\n";
    return $char;
}

#to check winning condition.
sub checkWin {
    (@wordDisplay) = @_;
    my $check = join('',@wordDisplay);
    #print "$check \n";
    
    if($check eq $gameWord){
        hangmanWin();
        $win++;
        return 0;
    }
    else{
        return 1;
    }
}

#to check the losing condition and updating hangman after every input.
sub checkLose {

    if(scalar @incorrectInput == 7 ){
        hangmanLose();
        print "\tYou lost. Better luck next time!!\n\n";
        print "Correct Word: \t" ;
        print uc "$gameWord" , "\n";
        $lose++;
        return 0;
    }
    elsif(scalar @incorrectInput == 0){
        hangmanStart();
        return 1;
    }
    elsif(scalar @incorrectInput == 1){
        incorrect1() ;
        return 1;
    }
    elsif(scalar @incorrectInput == 2){
        incorrect2() ;
        return 1;
    }
    elsif(scalar @incorrectInput == 3){
        incorrect3() ;
        return 1;
    }
    elsif(scalar @incorrectInput == 4){
        incorrect4() ;
        return 1;
    }
    elsif(scalar @incorrectInput == 5){
        incorrect5() ;
        return 1;
    }
    elsif(scalar @incorrectInput == 6){
        incorrect6() ;
        return 1;
    }
}


#when the game is lost. (seventh incorrect try)
sub hangmanLose {

   print "  
             _____
            |     |
            |     O
            |    /|\\
            |    / \\
           _|_\n";
}

#initial condition, no incorrect entry.
sub hangmanStart {

   print "  
             _____
            |     
            |     
            |    
            |    
           _|_\t\tYou have 7 chances left.\n";
}

#first incorrect try
sub incorrect1 {

   print "  
             _____
            |     |
            |     
            |    
            |    
           _|_\t\tYou have 6 chances left.\n";
}

#second incorrect try
sub incorrect2 {

   print "  
             _____
            |     |
            |     O
            |    
            |   
           _|_\t\tYou have 5 chances left.\n";
}

#third incorrect try
sub incorrect3 {

   print "  
             _____
            |     |
            |     O
            |     |
            |   
           _|_\t\tYou have 4 chances left.\n";
}

#fourth incorrect try
sub incorrect4 {

   print "  
             _____
            |     |
            |     O
            |    /|
            |    
           _|_\t\tYou have 3 chances left.\n";
}


#fifth incorrect try
sub incorrect5 {

   print "  
             _____
            |     |
            |     O
            |    /|\\
            |    
           _|_\t\tYou have 2 chances left.\n";
}

#sixth incorrect try
sub incorrect6 {

   print "  
             _____
            |     |
            |     O
            |    /|\\
            |    / 
           _|_\t\tYou have 1 chance left.\n";
}

#when the game is won
sub hangmanWin {
    print "  
             _____
            |     
            |
            |     O
            |    \\|/
           _|_  _/ \\_     
    ";
    print "\n\tYou have guessed the word correctly. Yayyy!!\n\n";
}


#to continue the game play
sub playAgain {
    print"Do you want to play again? (Y/N) ";
    my $answer = <STDIN>;
    chomp $answer;

    if(uc $answer eq 'Y'){
        wordDecide();
    }
    elsif(uc $answer eq 'N'){
        print "The program is terminated.\n";
    }
    else{
        print "Invalid Input!!\n";
        playAgain();
    }
}


intro();
wordDecide();
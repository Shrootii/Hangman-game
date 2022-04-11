>To run the program:
    -Enter 'perl Hangman.pl' in the terminal in order to compile and run the program.

>Game Settings:
    -Only single character (a-z or A-Z) will be accepted as an input.
    -Along with incorrect character inputs, numbers and special characters will also be considered as incorrect.
    -All the input have to be unique, otherwise the program will consider it as invalid and ask user again.
    -Entering 'hint'/'HINT' will provide the user with an autofilled letter in the word progress display.
    -User can ask for a hint as many times as he wants.
    -After every game, a counter will display total number of wins and losses of the user. 
     These values will reset once the program is terminated.
    -After every game, the user will be asked whether he wants to play again or not. 
     The only acceptable inputs will be 'Y'/'y' for yes, and 'N'/'n' for no.
    -User can get the same word again also for another game.


-------------------------------------------------------------
>Initial Game appearance (when the user is given the word):

        Here is your word: _ _ _ _ _ _ _                    (given word puzzle)

             _____
            |     
            |     
            |    
            |    
           _|_        You have 7 chances left.              (initial hangman visual)

    Make a guess:                                           (user input)

-------------------------------------------------------------
>Game appearance at any point of game:

    Word progress: _ E _ _ _ E R                            (User's progress)
    Incorrect Guesses So Far: S Y K U                       (Incorrect guesses by user)

             _____
            |     |
            |     O
            |    /|
            |    
           _|_        You have 3 chances left.              (Current hangman visual)

    Make a guess:                                           (user input)

-------------------------------------------------------------

>SUB-ROUTINES ORDER IN THE CODE
    1. intro - to lay down the instructions of the game.
    2. wordDecide - to randomly generate a word from the list of words for the game.
    3. gamePlay - this function contains the game loop that is to ask user
                for his guess until the won is won or lost.
                Also initializes the array containing word progress for user.
    4. letterInput - to take the input of user.
                    this function will only take single character input or the string 'hint'.
    5. letterPosition - this function determines the position of input letter in the game word,
                        and updates the array displaying user's progress.
    6. validMove - to check whether an input has been entered before or not.
    7. hint - generates a random letter of the game word as hint for the user.
    8. checkWin - checks the winning condition of the game by comparing the word progress with game word.
    9. checkLose - to check the losing condition, and update the hangman after every move.
    10. hangmanStart - initial visuals of hangman. (0 incorrect try)
    11. incorrect(1-6) - visuals of hangman at corresponding incorrect attempts.
    12. hangmanLose - visuals of hangman when the user loses. (7th incorrect try)
    13. hangmanWin - visuals of hangman when the user wins.
    14. playAgain - asks user whether to he wants to play again or not. 

#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT player_id FROM players WHERE player_name = '$USERNAME'")
if [[ -z $USER_ID ]]
then
echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
INSERT_NEW_PLAYER=$($PSQL "INSERT INTO players(player_name) VALUES('$USERNAME')")
USER_ID=$($PSQL "SELECT player_id FROM players WHERE player_name = '$USERNAME'")
else
USER_INFO=$($PSQL "SELECT games_played,best_game FROM players WHERE player_id = $USER_ID")
IFS="|" read GAMES_PLAYED BEST_GAME <<< $USER_INFO
echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$(( RANDOM % 1000 +1 ))
GUESSES=0
echo -e "\nGuess the secret number between 1 and 1000:"
while read GUESS
do
if [[ ! $GUESS =~ ^[0-9]+$ ]]
then
echo -e "\nThat is not an integer, guess again:"
continue
fi
((GUESSES++))
if [[ $GUESS < $SECRET_NUMBER ]]
then
echo -e "\nIt's higher than that, guess again:"
elif [[ $GUESS > $SECRET_NUMBER ]]
then
echo -e "\nIt's lower than that, guess again:"
else
echo -e "\nYou guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
break
fi
done

UPDATE_GAMES_PLAYED=$($PSQL "UPDATE players SET games_played = games_played + 1 WHERE player_id = $USER_ID")
BEST_GAME=$($PSQL "SELECT best_game FROM players WHERE player_id = $USER_ID")
if [[ -z $BEST_GAME || $GUESSES -lt $BEST_GAME ]]
then
UPDATE_BEST_GAME=$($PSQL "UPDATE players SET best_game = $GUESSES WHERE player_id = $USER_ID")
fi
INSERT_GAME_STATS=$($PSQL "INSERT INTO games(player_id,guesses) VALUES($USER_ID,$GUESSES)")
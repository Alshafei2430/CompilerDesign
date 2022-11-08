/* Definations */
UPPER [A-Z]
LOWER [a-z]
INT [0-9]+
EXP ([eE][+-]?[INT])
SPECIAL_CHARACTER [$&+,:;=?@#|'<>.^*()%!-]
NEW_LINE [\n]
WORD [\t ' ']

%{
  int lines = 1,
  words = 0,
  lowercase_letters = 0,
  uppercase_letters = 0,
  numbers = 0,
  special_characters = 0,
  totals = 0,
  size = 0;
%}

/* Delimiters: These separate the definitions from the Rules and actions section */
%%
{NEW_LINE} { lines++; words++;} /* Adds to the lines and words variables a value of 1 when one goes to a new line */
{WORD} words++; /* Adds a value to the words variable when one moves from one word to another (words are separated by a space) */
{UPPER} uppercase_letters++;
{LOWER} lowercase_letters++;
{INT} numbers++;
{INT}\.{INT}?{EXP}? numbers++;
{SPECIAL_CHARACTER} special_characters++;
%%

int yywrap() {
    return 1;
}

int main() {
  yyin = fopen("text.txt", "r"); /* Open the 'test.txt' file in a read only fomart */
  yylex();
  totals = special_characters + numbers + uppercase_letters + lowercase_letters;
  size = (totals * 1); /* The total size in bytes is equal to the total number of characters multiplied by one byte since each is one byte */

  /* Prints the output */
  printf("This file contains the following:");
  printf("\n\t%d lines", lines);
  printf("\n\t%d words", words);
  printf("\n\t%d Lowercase letters", lowercase_letters);
  printf("\n\t%d Uppercase letters", uppercase_letters);
  printf("\n\t%d digits", numbers);
  printf("\n\t%d special characters", special_characters);
  printf("\n\t The total size of the file characters in bytes is: %d bytes.\n", size);
}
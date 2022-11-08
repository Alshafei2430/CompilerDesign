%option noyywrap
digit [0-9]
letter [a-zA-Z]
%%
{letter}({letter}|{digit})* printf("found id: %s\n", yytext);
\n printf("new line\n");
%%
int main() {
    yylex();
}
%option noyywrap
INT [0-9]+
EXP ([eE][+-]?[INT])
%{
    int i;
    float f;
%}
%%
{INT} {
    sscanf(yytext, "%d", &i);
    printf("Int: %d\n", i);
}
{INT}\.{INT}?{EXP}? { 
    sscanf(yytext, "%f", &f);
    printf("Float: %.3f\n", f);
}
. ;
%%
int main() {
    yylex();
}
// int yywrap();
%{
#include <stdio.h>
%}

%option noyywrap

%%
"idiot"         printf("intellectually challenged person");
[[:alnum:]]+    printf( yytext );
[[:^alnum]]+    printf( yytext );
\n              printf( "\n" );

%%
void main() {
  yylex();
}

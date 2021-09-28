%{
#include <stdio.h>

int length = 80;
%}

%option noyywrap

%%
\n                    { length = 80; printf("\n");}
[ \t]+                {}
.                     {
  if ( length == 0 ) {
    printf("\n");
    length = 80;
  }
  printf( yytext );
  length--;
}

<<EOF>>               printf("%s\n", line); return 0;

%%
void main() {
  yylex();
}

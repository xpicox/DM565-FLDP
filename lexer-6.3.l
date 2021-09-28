%{
#include <stdio.h>

int length = 80;
%}

%option noyywrap

%%
\n                { length = 80; printf( "\n"); }
[ \t]+            { length--; printf(" "); }
[^ \t\n]+         {
  if( yyleng > length ) {
    printf( "\n" );
    length = 80;
  }
  printf( "%s", yytext );
  length -= yyleng;
  if( yyleng > 80) {
    printf( "\n" );
    length = 80;
  }
}


%%
void main() {
  yylex();
}

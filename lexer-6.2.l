%{
#include <stdio.h>

int length = 80;
char line[80];
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
[^ \t\n]+             {
  int min;
  do {
    min = length <  yyleng ? length : yyleng;
    for( int i = 0; i < min; i++ ) {
      line[80 - length + i] = yytext[i];
    }
    length -= min;
    yyleng -= min;
    yytext += min;
    if( length == 0 ) {
      printf( "%s\n", line );
      memset(line, '\0', sizeof(line));
      length = 80;
    }
  } while( yyleng > 0 );
}

<<EOF>>               printf("%s\n", line); return 0;

%%
void main() {
  yylex();
}

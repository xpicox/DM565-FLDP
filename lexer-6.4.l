%{
#include <stdio.h>
%}

%option noyywrap

%%
\<\/?[^>]+\>        {};
[^<]+               printf( yytext );

%%
void main() {
  yylex();
}

/* C Declarations */


s_char [a-z]
c_char [A-Z]
digit [0-9]
sp [" "]
operator [!+|*|/|=|;|:|-]


inc "include"
nazib "nazib.j"
nishupto "nishupto.j"


nint "int"
nstring "string"
nfloat "float"
ndouble "double"
nchar "char"
print "output"

/**** operator ***/


assign "eq"


sbs "sbs"
sbc "sbc"


main "mainfunc"
fbs "fbs"
fbc "fbc"


add "add"
sub "sub"
mul "mul"
div "div"

for "for"
le "le"
pp "pp"


if "if"
grt ">"
lst "<"

elif "elif"
else "else"

switch "switch"
sack "sack"
default "defau"


%{
	#include<stdio.h>
	#include<string.h>
	#include "prac.tab.h"
	#include<stdlib.h>
	extern int yylval;
	char str[100];
	char multichar[100][100];
	int i,cnt=0;
%}


%%

{nint}		{ return INT; }
{nfloat}	{ return FLOAT; }
{ndouble}   { return DOUBLE; } 
{nchar}		{ return CHAR; }

{digit}+	{ 
				yylval = atoi(yytext);
				return NUM;
			}

{fbs}		{ return FBS; }
{fbc}		{ return FBC; }
{sbs}		{ return SBS; }
{sbc}		{ return SBC; }




","			{ return COM; }
";"			{ return SCOM; }

{add}		{ return PLUS; }
{sub}		{ return MINUS; }
"**"		{ return MULT; }
"///"		{ return DIV; }
{assign}	{ return ASSIGN;  }
{print}		{ return PRINT; }

{for} 		{ return FOR; }
{le} 		{ return LE; }
{pp} 		{ return PP; }

{if}		{ return IF; }
{grt}		{ return GRT; }
{lst}		{ return LST; }

{elif}		{ return ELIF; }
{else}		{ return ELSE; }

{switch}  	{ return SWITCH; }
{sack}  	{ return SACK; }
{default}  	{ return DEFAULT; }




"\""[a-zA-Z]([ a-z]+|[A-Z]+|[!]+)+"\"" { 
				for(i=0;i<yyleng-2;i++) str[i] = yytext[i+1]; 
				return STR; 
			}
			
			
[a-z]		{
				yylval = *yytext - 'a';
				return	VAR;
			}

[a-z][a-z]+ {
				strcpy(multichar[cnt],yytext);
				cnt++;
				return VAR1;
			}			



{inc}{sp}{nazib}    { return FIRST; }
{inc}{sp}{nishupto}    { return SECOND; }


{nint}{sp}{main}	{ return MAIN; }

[ \t\n]*	;

"//"(.)*"\n" { printf("This is a comment\n");}

.	{
		yyerror("Unknown Character.\n");
	}
%%

/* user subroutines */

int main()
{
	yyin = freopen("a.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();
}


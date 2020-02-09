%{
	#include<stdio.h>
	int sym[26],store[26];
	int di,dj;;
	int ll=0,l=0,flag=1,val,i,j,count=0;
	
	extern char str[100];
	extern char multichar[100][100];
	int m=0,flagformulti=0,t=1,single=0,multi=0;
	extern int cnt;
	
	int loopcount=0,nn,z=0,y=0;
	int condelse=0,condif=0;
	int casecount=0;
	int switchdone=0,swflag=0;
	
	void strclean(){
		for(i=0;str[i]!='\0';i++)
			str[i]='\0';
	}
	
	void clearmultichar(int cnt)
	{
		for(di=0; multichar[cnt-1][di]!='\0'; di++)
			multichar[cnt-1][di] = '\0';
	}
	
	int undeclaredcheck()
	{	
		flagformulti=0;
		for(i=0; i<cnt-1; i++)
		{	
			if(!strcmp(multichar[cnt-1],multichar[i]))
			{
				flagformulti = 1;
			}
		}
		
		if(!flagformulti)
		{
			printf("'%s' ==> multiple variable is Undeclared !!!\n",multichar[cnt-1]);
			clearmultichar(cnt);
			cnt=cnt-1;
			return 1;
		}
		
		return 0;
	}
	
	int checkindex(int cnt){
		for(i=0; i<cnt-1; i++)
		{	
			if(!strcmp(multichar[cnt-1],multichar[i]))
			{
				return i;
			}
		}
	}
	
%}


%token NUM VAR VAR1 FIRST SECOND MAIN INT STR FLOAT DOUBLE CHAR FBS FBC SBS SBC COM SCOM ASSIGN PLUS MINUS MULT DIV FOR LE PP IF GRT LST PRINT ELSE ELIF DEFAULT SWITCH SACK



%%

program		: FIRST SECOND MAIN FBS FBC SBS cstatement SBC { printf("\nsuccessful compilation\n"); }
			;

cstatement	: /* empty */
            | cstatement statement
			| cstatement cdeclaration
			| cstatement structure
		    | cstatement switch
			;


cdeclaration: TYPE varlist SCOM			{ printf("valid declaration\n\n"); }
			;
			
TYPE 		: INT | FLOAT | DOUBLE | CHAR ;
				
varlist 	: vassign COM varlist | vassign ;
			
vassign		: VAR					{
										if(store[$1] == 1) printf("'%c' ==> single variable is Redeclared !!!\n",$1+'a');
										else
										{
											store[$1]=1;
											printf("%c ==> single variable declared !!!\n",$1+'a');
										}	
									}
									
			| VAR1					{	
										int v = 1;
										for(i=0; i<cnt-1; i++)
										{	
											if(!strcmp(multichar[cnt-1],multichar[i]))
											{
												printf("'%s'==>  multiple variable is Redeclared !!!\n",multichar[i]);
												cnt--;
												v=0;
											}
										}
										
										if(v)
											{
												printf("%s ==> multiple variable is declared !!!\n",multichar[cnt-1]);
											}
									}
			

			| VAR ASSIGN NUM 		{
										if(store[$1] == 1)
										{
											printf("'%c' ==> single variable Redeclared !!!\n",$1+'a');
										}
										else{
											store[$1]=1;
											sym[$1] = $3;
											printf("%c = %d ==> single variable declared && assigned !!!\n",$1+'a',$3);
											}
									}
									
									
			| VAR1 ASSIGN NUM 		{
										t=1;
										
										if((t&&cnt>1)||cnt==1)
										{
											char c = (char) $3;
											multichar[cnt-1][99]=c;
											int i = (int) c;
										
										}
										
										for(i=0; i<cnt-1; i++)  //when cnt > 1
										{	
											if(!strcmp(multichar[cnt-1],multichar[i])&& t==1)
											{
												printf("'%s' ==> multiple variable is Redeclared !!!\n",multichar[i]);
												t=0;
												clearmultichar(cnt);
												cnt--;
											}
										}
										
										if(t)
										{
											printf("%s = %d ==> multiple variable declared && assigned !!!\n",multichar[cnt-1],multichar[cnt-1][99]);
										}
									}						
									
									
			
			;
			

statement	: SCOM
			| expr SCOM 			{ printf("\nvalue of expression: %d\n", $1); }
			| VAR ASSIGN expr SCOM 	{
										sym[$1] = $3;
										
										if(store[$1]!=1)
										{
											printf("'%c' ==> single variable is Undeclared !!!\n",$1+'a');
										}
										else{
											printf("%c = %d ==> single variable assigned !!!\n",$1+'a',$3);}
										}
			| VAR1 ASSIGN expr SCOM 	{
										flagformulti = 0;
										
										undeclaredcheck();
										
										for(i=0;i<cnt-1;i++)
										{
											if(!strcmp(multichar[cnt-1],multichar[i]))
											{
												multichar[i][99] =(char)$3;
												printf("%s = %d ==> multiple variable is assined !!!\n",multichar[i],multichar[i][99]);
												
											}
										}
										
									}
			;		

expr 		: VAR					{ $$ = sym[$1]; } 
			| VAR1 					{ $$ = multichar[checkindex(cnt)][99];clearmultichar(cnt);cnt--; }
			| expr MULT term		{ $$ = $1 * $3; }
			| expr DIV term			{ 
										if($3) 
										{
												$$ = $1 / $3;
										}
										else
										{
											$$ = 0;
											printf("\ndivision by zero\t");
										}
									}
			| term
			 ;
			 
term 		: term PLUS factor		{ $$ = $1 + $3; }
			| term MINUS factor		{ $$ = $1 - $3; }
			| factor 
			;
			
factor 		: NUM	    			{ $$ = $1; } 
			;


			

structure   : FOR FBS variable ASSIGN NUM COM variable LE NUM COM VAR PP FBC SBS structure SBC 	        {printf("\nLoop!!\n");
																							
																										for($3= $5;$3< $9;$3++)	
																										{
																											loopcount++;
																											printf("%s\n",str);
																										}
																										strclean();
																										}

			| IF FBS variable operator NUM FBC SBS structure SBC										{printf("\nIf Section\n");
																										if(z==1)
																										{
																											if($3>$5){
																											printf("If condition true\n");
																											printf("%s\n",str);
																											strclean();
																											condif=1;
																											z=0;
																											}
																											else{
																											printf("If condition false\n");
																											z=0;
																											}
																										}
																										if(y==1)
																										{
																											if($3<$5){
																											printf("If condition true\n");
																											printf("%s\n",str);
																											strclean();
																											condif=1;
																											y=0;
																											}
																											else{
																											printf("If condition false\n");
																											y=0;
																											}
																										}
																										}
			
			| ELIF FBS variable operator NUM FBC SBS structure SBC										{printf("\nElseIf section\n");
																										if(z==1)
																										{
																											if($3>$5){
																											printf("Else-If condition true\n");
																											printf("%s\n",str);
																											strclean();
																											condelse=1;
																											z=0;
																											}
																											else{
																											printf("Else-If condition false\n");
																											z=0;
																											}
																										}
																										if(y==1)
																										{
																											if($3<$5){
																											printf("Else-If condition true\n");
																											printf("%s\n",str);
																											strclean();
																											condelse=1;
																											y=0;
																											}
																											else{
																											printf("Else-If condition false\n");
																											y=0;
																											}
																										}
																										}
			
			| ELSE SBS structure SBC																	{printf("\nElse section\n");
																										if(condif==0&&condelse==0){
																										printf("Else condition true\n");
																										printf("%s\n",str);
																										strclean();
																										}
																										else
																										printf("Else condition false\n");
			
																										}
            
																						
			
			| print
			;
			


switch	    : SWITCH FBS variable FBC SBS {printf("\nSwitch Section\n");}switchin SBC 					{
																										
																										}
			;																							
switchin	: /* empty */
			| switchin SACK variance SBS print SBC													{printf("\nIn case : ");
																									casecount++;
																									printf("%d\n",casecount);
																									if($3 == swflag)
																									{
																									
																								        printf("is working!!!!!\n");
																										printf("%s\n",str);
																										strclean();
																										switchdone = 1;
																										swflag=0;
																									}
																									else
																										printf("is not working!!!!!\n");
																									
																									}																						
																									

			| switchin DEFAULT SBS print SBC														{printf("\ndefault case \n");
																									if(switchdone==0)
																									{
																										printf("is working!!!!!\n");
																										printf("%s\n",str);
																										strclean();
																										switchdone = 1;
																									}
																									else
																									printf("is not working!!!!!\n");
																									
																									}

						
variance    : VAR					{ $$ = sym[$1]; } 
			| VAR1 					{ $$ = multichar[checkindex(cnt)][99];clearmultichar(cnt);cnt--; }
			| NUM	    			{ $$ = $1; }


variable    : VAR					{ $$ = sym[$1]; swflag=sym[$1]; } 
			| VAR1 					{ $$ = multichar[checkindex(cnt)][99]; swflag=multichar[checkindex(cnt)][99];clearmultichar(cnt);cnt--; }
			;

operator    : GRT               	{ z=1; }
			| LST					{ y=1; }
			;
			
print       : PRINT STR SCOM       
			;
	
			


%%

int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}


package Parse;
import ErrorMsg.ErrorMsg;

%% 

%implements Lexer
%function nextToken
%type java_cup.runtime.Symbol
%char

%{
int comments = 0;
StringBuffer string;
int in_string=0;

private void newline() {
  errorMsg.newline(yychar);
}

private void err(int pos, String s) {
  errorMsg.error(pos,s);
}

private void err(String s) {
  err(yychar,s);
}

private java_cup.runtime.Symbol tok(int kind) {
    return tok(kind, null);
}

private java_cup.runtime.Symbol tok(int kind, Object value) {
    return new java_cup.runtime.Symbol(kind, yychar, yychar+yylength(), value);
}

private ErrorMsg errorMsg;

Yylex(java.io.InputStream s, ErrorMsg e) {
  this(s);
  errorMsg=e;
}

%}

%eofval{
	{
	 return tok(sym.EOF, null);
        }
%eofval} 

comment_text=([^/*\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])*
3digits=[0-9][0-9][0-9]
%state COMMENT STRING


%%
" "				{}
\n				{newline();}
<YYINITIAL>"/*"		{comments++; yybegin(COMMENT);}

<COMMENT>"/*"			{comments++;}
<COMMENT>{comment_text}	{ }
<COMMENT>"*/"			{if (--comments == 0) { yybegin(YYINITIAL); }}



\t				{     }
\\{3digits}[0-9]+	{Integer ascin= new Integer(yytext().substring(1, yytext().length()));
				return tok(sym.STRING, ascin.shortValue());}


"while" 			{return tok(sym.WHILE, null);}
"for"				{return tok(sym.FOR, null);}
"to"				{return tok(sym.TO, null);}
"break"			{return tok(sym.BREAK, null);}
"let"				{return tok(sym.LET, null);}
"in"				{return tok(sym.IN, null);}
"end"				{return tok(sym.END, null);}
"function"			{return tok(sym.FUNCTION, null);}
"var"				{return tok(sym.VAR, null);}
"type"				{return tok(sym.TYPE, null);}
"array"			{return tok(sym.ARRAY, null);}
"if"				{return tok(sym.IF, null);}
"then"				{return tok(sym.THEN, null);}
"else"				{return tok(sym.ELSE, null);}
"do"				{return tok(sym.DO, null);}
"of"				{return tok(sym.OF, null);}
"nil"				{return tok(sym.NIL, null);}


","				{return tok(sym.COMMA, null);}
"("				{return tok(sym.LPAREN, null);}
")"				{return tok(sym.RPAREN, null);}
"="				{return tok(sym.EQ, null);}
"&"				{return tok(sym.AND, null);}   
"+"				{return tok(sym.PLUS, null);} 
"["				{return tok(sym.LBRACK, null);} 
"]"				{return tok(sym.RBRACK, null);} 
"-"				{return tok(sym.MINUS, null);} 
"."				{return tok(sym.DOT, null);} 
"/"				{return tok(sym.DIVIDE, null);} 
":"				{return tok(sym.COLON, null);} 
","				{return tok(sym.COMMA, null);} 
":="				{return tok(sym.ASSIGN, null);} 
";"				{return tok(sym.SEMICOLON, null);} 
"<"				{return tok(sym.LT, null);} 
"<="				{return tok(sym.LE, null);} 
"<>"				{return tok(sym.NEQ, null);} 
">"				{return tok(sym.GT, null);} 
">="				{return tok(sym.GE, null);} 
"{"				{return tok(sym.LBRACE, null);} 
"}"				{return tok(sym.RBRACE, null);} 
"|"				{return tok(sym.OR, null);} 
"*"				{return tok(sym.TIMES, null);}



[a-zA-Z][a-zA-Z0-9_]+	{return tok(sym.ID,yytext()); }
[0-9]|[1-9][0-9]+		{return tok(sym.INT, new Integer(yytext())); }
. 				{ err("Illegal character: " + yytext()); }



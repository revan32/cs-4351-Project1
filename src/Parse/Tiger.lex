package Parse;
import ErrorMsg.ErrorMsg;

%% 

%implements Lexer
%function nextToken
%type java_cup.runtime.Symbol
%char

%{
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


%%
" "		{}
[a-zA-Z]+	{return tok(sym.ID); }
\n		{newline();}
"while " 	{return tok(sym.WHILE, null);}
"for "		{return tok(sym.FOR, null);}
"to "		{return tok(sym.TO, null);}
"break "	{return tok(sym.BREAK, null);}
"let "		{return tok(sym.LET, null);}
"in "		{return tok(sym.IN, null);}
"end "		{return tok(sym.END, null);}
"function "	{return tok(sym.FUNCTION, null);}
"var "		{return tok(sym.VAR, null);}
"type "	{return tok(sym.TYPE, null);}
"array "	{return tok(sym.ARRAY, null);}
"if "		{return tok(sym.IF, null);}
"then "	{return tok(sym.THEN, null);}
"else "	{return tok(sym.ELSE, null);}
"do "		{return tok(sym.DO, null);}
"of "		{return tok(sym.OF, null);}
"nil "		{return tok(sym.NIL, null);}
","	{return tok(sym.COMMA, null);}
"("	{return tok(sym.LPAREN);}
. { err("Illgal character: " + yytext()); }



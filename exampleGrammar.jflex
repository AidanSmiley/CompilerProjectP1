import java_cup.runtime.*;

// used to delimit sections of our code 
%%

// Lexical Functions:

%cup
%line
%column
%unicode
%class ExampleLexer

%{
    Symbol newSym(int tokenId) {
        return new Symbol(tokenId, yyline, yycolumn);
    }

    Symbol newSym(int tokenId, Object value) {
        return new Symbol(tokenId, yyline, yycolumn, value);
    }
%}

// Pattern Definitions
tab = \\t
newline = \\n
slash = \\
letter = [A-Za-z]
decimal = [.]
digit = [0-9]
id = {letter}[{letter}{digit}]*
whitespace = [ \n\t\r]
intlit = {digit}+
floatlit = {digit}+{decimal}{digit}+
charlit = [\'{letter}\']
strlit = [\"][{letter}{whitespace}]+[\"]
inlinecomment = {slash}{slash}.*\n
multilinecomment = [{slash}\*.*{slash}\*]

%%

// Lexical Rules:
//order does matter

read {return newSym(sym.READ, "read"); }
print {return newSym(sym.PRINT, "print"); }
printline {return newSym(sym.PRINTLINE, "printline"); }
class {return newSym(sym.CLASS, "class"); }
if {return newSym(sym.IF, "if"); }
else {return newSym(sym.ELSE, "else"); }
while {return newSym(sym.WHILE, "while"); }
return {return newSym(sym.RETURN, "return"); }
void {return newSym(sym.VOID, "void"); }
int {return newSym(sym.INT, "int"); }
float {return newSym(sym.FLOAT, "float"); }
bool {return newSym(sym.BOOL, "bool"); }
char {return newSym(sym.CHAR, "char"); }
true {return newSym(sym.TRUE, "true"); }
false {return newSym(sym.FALSE, "false"); }


"*" {return newSym(sym.TIMES, "*"); }
"+" {return newSym(sym.PLUS, "+"); }
"-" {return newSym(sym.MINUS, "-"); }
"/" {return newSym(sym.DIVIDE, "/"); }
"=" {return newSym(sym.ASSMNT, "="); }
";" {return newSym(sym.SEMI, ";"); }
"&&" {return newSym(sym.AND, "&&"); }
"||" {return newSym(sym.OR, "||"); }
"(" {return newSym(sym.LEFTPARAN, "("); }
")" {return newSym(sym.RIGHTPARAN, ")"); }
"[" {return newSym(sym.LEFTSQUARE, "["); }
"]" {return newSym(sym.RIGHTSQUARE, "]"); }
"{" {return newSym(sym.LEFTCURLY, "{"); }
"}" {return newSym(sym.RIGHTCURLY, "}"); }
"++" {return newSym(sym.INCREMENT, "++"); }
"<" {return newSym(sym.LESS, "<"); }
">" {return newSym(sym.GREATER, ">"); }
"<=" {return newSym(sym.LESSEQUAL, "<="); }
">=" {return newSym(sym.GREATEREQUAL, ">="); }
"==" {return newSym(sym.EQUALS, "=="); }
"<>" {return newSym(sym.CARATS, "<>"); }
"~" {return newSym(sym.SQUIG, "~"); }
"?" {return newSym(sym.QUESTION, "?"); }
":" {return newSym(sym.COLON, ":"); }
"," {return newSym(sym.COMMA, ","); }

var {return newSym(sym.VAR, "var"); }
{id} {return newSym(sym.ID, yytext() ); }       //yytext is the text found in the id regex
{intlit} {return newSym(sym.INTLIT, new Integer(yytext())); }
{charlit} {return newSym(sym.CHARLIT, new Character(yytext().charAt(1))); }
{strlit} {return newSym(sym.STRLIT, new String(yytext())); }
{floatlit} {return newSym(sym.FLOATLIT, new Float(yytext())); } 
{inlinecomment} {/*empty*/}                     //do nothing because its a comment
{whitespace} {/*ignore*/}
{multilinecomment} {/*ignore*/}
. {System.out.println("illegal char, " + yytext() + "line: " + yyline + "col: " + yychar); }

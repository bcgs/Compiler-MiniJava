package lexicalAnalyzer;

%%

%class Lexer
%standalone
%unicode
%line
%column

%{
	StringBuffer sb = new StringBuffer();
	int qtdID = 0;
%}

%eof{
	System.out.println(qtdID + " ID found.");
%eof}

WhiteSpace 					= [ \n\t\r]
Comment 					= "/*" [^*] ~"*/" | "/*" "*"+ "/"

LineTerminator 				= \r|\n|\r\n
InputCharacter 				= [^\r\n]
EndOfLineComment 			= "//" {InputCharacter}* {LineTerminator}?

IntegerLiteral 				= 0 | [1-9][0-9]*
FloatLiteral 				= {IntegerLiteral}\.[0-9]+(E[\+-]?[1-9]+)?

LetterOrUnderline 			= [a-zA-Z] | "_"
LetterOrUnderlineOrDigit 	= {LetterOrUnderline} | [0-9]
Identifier 					= {LetterOrUnderline}{LetterOrUnderlineOrDigit}*

%state STRING

%%

/* TRANSLATION RULES */

/* Keywords */
<YYINITIAL> "class" 		{System.out.println("Token CLASS");}
<YYINITIAL> "public" 		{System.out.println("Token PUBLIC");}
<YYINITIAL> "extends" 		{System.out.println("Token EXTENDS");}
<YYINITIAL> "static" 		{System.out.println("Token STATIC");}
<YYINITIAL> "void" 			{System.out.println("Token VOID");}
<YYINITIAL> "int" 			{System.out.println("Token INT");}
<YYINITIAL> "boolean" 		{System.out.println("Token BOOLEAN");}
<YYINITIAL> "new" 			{System.out.println("Token NEW");}
<YYINITIAL> "this" 			{System.out.println("Token THIS");}
<YYINITIAL> "true" 			{System.out.println("Token TRUE");}
<YYINITIAL> "false" 		{System.out.println("Token FALSE");}

<YYINITIAL> {

	/* Operators */
	"||" 					{System.out.println("Token ||");}
	"&&" 					{System.out.println("Token &&");}
	"==" 					{System.out.println("Token ==");}
	"!=" 					{System.out.println("Token !=");}
	"<" 					{System.out.println("Token <");}
	"<=" 					{System.out.println("Token <=");}
	">" 					{System.out.println("Token >");}
	">=" 					{System.out.println("Token >=");}
	"+" 					{System.out.println("Token +");}
	"-" 					{System.out.println("Token -");}
	"*" 					{System.out.println("Token *");}
	"/" 					{System.out.println("Token /");}
	"%" 					{System.out.println("Token %");}
	"!" 					{System.out.println("Token !");}

	/* Delimiters */
	";" 					{System.out.println("Token ;");}
	"." 					{System.out.println("Token .");}
	"," 					{System.out.println("Token ,");}
	"=" 					{System.out.println("Token =");}
	"(" 					{System.out.println("Token (");}
	")" 					{System.out.println("Token )");}
	"{" 					{System.out.println("Token {");}
	"}" 					{System.out.println("Token }");}
	"[" 					{System.out.println("Token [");}
	"]" 					{System.out.println("Token ]");}

	/* Literals */
	{IntegerLiteral} 		{System.out.println("Token INTEGER ("+ yytext() +")");}
	{FloatLiteral} 			{System.out.println("Token FLOAT ("+ yytext() +")");}

	/* Identifiers */
	{Identifier} 			{qtdID++; System.out.println("Token ID ("+ yytext() +")");}
	\" 						{sb.setLength(0); yybegin(STRING);}

	{Comment} 				{/* ignore */}
	{EndOfLineComment} 		{System.out.println("Illegal char // line: "+ yyline +", column: "+ yycolumn);}
	{WhiteSpace} 			{/* ignore */}

}
<STRING> {
	\" 						{yybegin(YYINITIAL);System.out.println("STRING_LITERAL:"+ sb.toString());}
	[^\n\r\"\\]+ 			{sb.append(yytext());}
	\\t 					{sb.append('\t');}
	\\r 					{sb.append('\r');}
	\\n 					{sb.append('\n');}
}

. 							{System.out.println("Illegal char "+ yytext() +" line: "+ yyline +", column: "+ yycolumn);}
grammar cal;

// Nonterminals
prog:                   decl_list function_list main;

decl_list:              decl Semicolon decl_list
                        | /*empty*/
                        ;

decl:                   var_decl
                        | const_decl
                        ;

var_decl:               Variable ID Colon type;

const_decl:             Constant ID Colon type Assign expr;

function_list:          function function_list
                        | /*empty*/
                        ;

function:               type ID LBR parameter_list RBR Is decl_list Begin statement_block Return LBR (expr |/*empty*/) RBR Semicolon End;

type:                   Int
                        | BV
                        | Void
                        ;

parameter_list:         nemp_parameter_list
                        | /*empty*/;

nemp_parameter_list:    ID Colon type
                        | ID Colon type Comma nemp_parameter_list
                        ;

main:                   Main Begin decl_list statement_block End;

statement_block:        statement statement_block
                        |/*empty*/
                        ;

statement:              ID Assign expr Semicolon
                        | ID LBR arg_list RBR Semicolon
                        | Begin statement_block End
                        | If condition Begin statement_block End
                        | Else Begin statement_block End
                        | While condition Begin statement_block End
                        | Skippy Semicolon
                        ;

expr:                   frag binary_arith_op frag
                        | LBR expr RBR
                        | ID LBR arg_list RBR
                        | frag
                        ;

binary_arith_op:        Plus
                        | Minus
                        ;

frag:                   ID
                        | Minus ID
                        | Number
                        | True
                        | False
                        | LBR expr RBR
                        ;

condition:              Neg condition
                        | LBR condition RBR
                        | expr comp_op expr
                        | condition (Or | And) condition
                        ;

comp_op:                Equals
                        | NotEquals
                        | Less
                        | LessOrEquals
                        | Greater
                        | GreaterOrEquals
                        ;

arg_list:               nemp_arg_list
                        |/*empty*/
                        ;

nemp_arg_list:          ID
                        | ID Comma nemp_arg_list
                        ;

// Alphabet Fragments
fragment A:		        'a' | 'A';
fragment B:		        'b' | 'B';
fragment C:		        'c' | 'C';
fragment D:		        'd' | 'D';
fragment E:		        'e' | 'E';
fragment F:		        'f' | 'F';
fragment G:		        'g' | 'G';
fragment H:		        'h' | 'H';
fragment I:		        'i' | 'I';
fragment J:		        'j' | 'J';
fragment K:		        'k' | 'K';
fragment L:		        'l' | 'L';
fragment M:		        'm' | 'M';
fragment N:		        'n' | 'N';
fragment O:		        'o' | 'O';
fragment P:		        'p' | 'P';
fragment Q:		        'q' | 'Q';
fragment R:		        'r' | 'R';
fragment S:		        's' | 'S';
fragment T:		        't' | 'T';
fragment U:		        'u' | 'U';
fragment V:		        'v' | 'V';
fragment W:		        'w' | 'W';
fragment X:		        'x' | 'X';
fragment Y:		        'y' | 'Y';
fragment Z:		        'z' | 'Z';

fragment Letter:		[a-zA-Z];
fragment Digit:			[0-9];
fragment Underscore:	'_';

// Terminals
Assign:				    ':=';
Plus:				    '+';
Minus:				    '-';
Neg:				    '~';
Or:					    '|';
And:				    '&';
Equals:				    '=';
NotEquals:			    '!=';
Less:				    '<';
LessOrEquals:		    '<=';
Greater:			    '>';
GreaterOrEquals:	    '>=';
Comma:				    ',';
Colon: 				    ':';
Semicolon:			    ';';
LBR:		            '(';
RBR:		            ')';

Variable:               V A R I A B L E;
Constant:               C O N S T A N T;
Return:                 R E T U R N;
Int:                    I N T E G E R;
BV:				        B O O L E A N;
Void:                   V O I D;
Main:                   M A I N;
If:                     I F;
Else:                   E L S E;
True:                   T R U E;
False:                  F A L S E;
While:                  W H I L E;
Begin:					B E G I N;
End:					E N D;
Is:                     I S;
Skippy:                 S K I P;

Number:		            (('-')? [1-9][0-9]*) | '0';
ID:						Letter (Letter | Underscore | Number)*;

Comment:		        '/*' (. | Comment)* '*/' -> skip;
CommentLine:		    '//'.*? ('\n' | EOF) -> skip;
WS:			            [ \t\n\r]+ -> skip;

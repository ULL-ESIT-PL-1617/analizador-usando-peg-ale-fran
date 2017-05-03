## Practica 07
  Analizador PDR usando PEG.

#### Gramática `pegjs-strip parser.pegjs`

~~~
start 'Statements'
  = statement+

statement
  = declaration
  / conditional
  / function
  / loop

declaration
  = DECLARE ID (ASSIGN expression)? SEMICOLON
  / ID ASSIGN expression

conditional
  = 'if'i condition block

loop
  = 'while'i condition block

function
  = 'function'i ID? LEFTPAR parameters? RIGHTPAR block

block
  = LEFTBRACE statement+ RIGHTBRACE

parameters
  = primary (COMMA primary)*

condition
  = LEFTPAR primary COMP primary RIGHTPAR

expression
  = term (ADDOP expression)*  //TODO

term
  = factor (MULOP term)*

factor
  = LEFTPAR expression RIGHTPAR
  / primary

primary 'String or integer'
  = ID
  / NUM

//////////////
// Literals //
//////////////
_          = [ \t\n\r]*
COMP       = _ $([!=<>]'=') _
           / _ [<>] _
ADDOP      = PLUS / MINUS
MULOP      = MUL / DIV
PLUS       = _'+'_
MINUS      = _'-'_
MUL        = _'*'_
DIV        = _'/'_
ASSIGN     = _'='_
SEMICOLON  = _';'_
COMMA      = _','_
LEFTPAR    = _'('_
RIGHTPAR   = _')'_
LEFTBRACE  = _'{'_
RIGHTBRACE = _'}'_
ID         = _ $[a-z]i+_
NUM        = _ $[0-9]+ _
DECLARE    = _ 'var'i _
           / _ 'const'i _
~~~

## Ejemplos
~~~


~~~

## Colaboradores
  + [Francisco Palacios](http://franjpr.github.io)
  + [Alejandro Hernández](http://alehdezp.github.io)

## Enlaces
  + Heroku
  + Tests

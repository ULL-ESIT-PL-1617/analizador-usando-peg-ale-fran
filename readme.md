## Practica 07
  Analizador PDR usando PEG.
  [Descripcion de la tarea](https://casianorodriguezleon.gitbooks.io/ull-esit-1617/content/practicas/practicapegparser.html)

#### Gramática `pegjs-strip parser.pegjs`

~~~
start 'Statements'
  = statement+

statement
  = declaration
  / conditional
  / function
  / loop
  / call

declaration
  = DECLARE? ID (ASSIGN expression)? SEMICOLON
  / DECLARE? ID ASSIGN function

conditional
  = 'if'i condition block

loop
  = 'while'i condition block

function
  = 'function'i ID? LEFTPAR parameters? RIGHTPAR block

call
  = ID LEFTPAR parameters? RIGHTPAR SEMICOLON

block
  = LEFTBRACE statement+ RIGHTBRACE

parameters
  = primary (COMMA primary)*

condition
  = LEFTPAR primary COMP primary RIGHTPAR

expression
  = term (ADDOP expression)*


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

## Ejemplo
~~~
const MAX = 5;
var i;
While ( i < MAX) {
  i = i + 1;
}

function (i){
  if(i == 5) {
      i = 0;
  }
}
~~~

## Colaboradores
  + [Francisco Palacios](http://franjpr.github.io)
  + [Alejandro Hernández](http://alehdezp.github.io)

## Enlaces
  + Heroku
  + Tests

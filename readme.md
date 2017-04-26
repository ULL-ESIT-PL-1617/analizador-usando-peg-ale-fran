## Practica 07
  Analizador PDR usando PEG.

#### Alfabeto

  Σ = {'var', 'function', 'if', 'while', 'do', '=', ';', '(', ')', '{', '}', NUM, ADDOP, MULOP, COMPARSION}  
  V = {sentencias, sentencia, declaración, condición, bucle, llamada, expresión, terminal, factor, función, comparación}

#### Reglas
  * sentencias  --> sentencia*
  * sentencia   --> declaración | condición | función | bucle | expresión
  * declaración --> 'VAR' asignación ';'
  * condición   --> 'IF' comparación {' sentencia '}'
  * bucle       --> 'WHILE (' comparación ') DO {' sentencia '}'
  * expresión   --> terminal (ADDOP expresión)*
  * terminal    --> factor (MULTOP terminal)*
  * factor      --> '(' expresión ')' | NUM | ID
  * función     --> 'FUNCTION (' ID ') {' declaración '}'
  * asignación  --> ID '=' expresión ';'
  * comparación --> '(' expresión COMPARSION expresión ')'

## Ejemplos
~~~
if ( a == 5){
  var a = 1 + 5;
}

function mifunc(x){
  while(x != 5){
    x = 3 + 1;
  }
}
~~~

## Colaboradores
  + [Francisco Palacios](http://franjpr.github.io)
  + [Alejandro Hernández](http://alehdezp.github.io)

## Enlaces
  + Heroku
  + Tests

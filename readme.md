## Practica 07
  Analizador PDR usando PEG.

#### Alfabeto

  Σ = {'var', 'function', 'if', 'while', 'do', '=', ';', '(', ')', '{', '}', NUM, ADDOP, MULOP, COMPARSION}  
  V = {sentencias, sentencia, declaración, condición, bucle, llamada, expresión, terminal, factor, función, comparación}

#### Reglas
  * sentencias  --> (sentencia ';')*
  * sentencia   --> declaración | condición | función | bucle | expresión
  * declaración --> 'VAR' asignación
  * condición   --> 'IF' comparación {' sentencias '}'
  * función     --> 'FUNCTION (' parametros ') {' sentencias '}'
  * bucle       --> 'WHILE (' comparación ') DO {' sentencias '}'
  * expresión   --> terminal (ADDOP expresión)*
  * terminal    --> factor (MULTOP terminal)*
  * factor      --> '(' expresión ')' | NUM | ID
  * parametros  --> parametro (','parametros)*
  * parametro   --> NUM | ID | VACIO
  * asignación  --> ID '=' expresión
  * comparación --> '(' expresión COMPARSION expresión ')'

## Ejemplos
~~~

if( 5 == 5){
  function(k){
    var h = 2 + 2;
  };
};


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

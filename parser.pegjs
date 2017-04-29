{
  var tree = [];
}

start "Statements"
  = s:statements {return s;}

statements "Statement"
  = a:statement SEMICOLON s:(statement SEMICOLON)* {
                                if(s.length == 0){
                                  return a;
                                } else {
                                  tree.push(a);
                                  s.forEach(function(item){
                                    tree.push(item[0]);
                                  });
                                  return tree;
                                }
                              }

statement "Declaration, condition, loop, function or expression"
  = d:declaration {return d;}

declaration "var/const"
  = VAR   a:assign { return {"group" : 'Declaration', "type" : 'VAR',   "value" : a }; }
  / CONST a:assign { return {"group" : 'Declaration', "type" : 'CONST',   "value" : a }; }

assign "Asignacion"
  = id:ID EQ n:NUM { return {"type" : '=', "left" : id, "right" : n }; }


  //Syntax

  _ = $[ \t\r\n]*                                             //Blancos
  ID = _ id:$[a-zA-Z]+ _   { return id;}                      //Identificadores
  EQ = _"="_               { return '=';}
  NUM = _ digits:$[0-9]+ _ { return parseInt(digits, 10); }
  SEMICOLON = _";"_        { return ';'}
  VAR = _'var'_            { return 'VAR';}
  CONST = _'const'_        { return 'CONST';}

/* Reglas
  * sentencias  --> (sentencia ';')*
  * sentencia   --> declaración | condición | función | bucle | expresión
  * declaración --> ('VAR'|'CONST') asignación
  * condición   --> 'IF' comparación {' sentencias '}'
  * función     --> 'FUNCTION (' parametros ') {' sentencias '}'
  * bucle       --> 'WHILE (' comparación ') DO {' sentencias '}'
  * expresión   --> terminal (ADDOP expresión)*
  * terminal    --> factor (MULTOP terminal)*
  * factor      --> '(' expresión ')' | NUM | ID
  * parametros  --> parametro (','parametros)*
  * parametro   --> NUM | ID | VACIO
  * asignación  --> ID '=' expresión
  * comparación --> '(' expresión COMPARSION expresión ')'*/

{
  const util = require('util');
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

statement "Declaration, condition, function, loop or expression"
  = d:declaration { return d;}
  / 'if'i c:condition LEFTBRACE s:statements RIGHTBRACE { return {"type":'IF', "left":c, "right":s}; }
  / 'function'i id:ID? LEFTPAR a:arguments? RIGHTPAR LEFTBRACE s:statements RIGHTBRACE { return {"type":"FUNCTION", "id" : id, "args" : a, "value":s}}
  / 'while'i c:condition LEFTBRACE s:statements RIGHTBRACE { return { "type":"WHILE", "left" : c, "right" : s};}
  / expression

declaration "Declaration"
  = d:DECLARE a:assign { return {"type" : d, "value": a}; }

condition "Comparsion"
  = LEFTPAR l:factor c:COMP r:factor RIGHTPAR { var result = { "type" : c.join(",").replace(/,/g,"").trim(), "value" : {"left":l, "right" : r}};
                                                return util.inspect(result, {showHidden:true, depth : null});
                                              }

expression "Expression"
  = t:term e:(ADDOP expression)* { if(e.length == 0){
                                    return t;
                                   } else {
                                    //TODO
                                   }
                                 }

term "Terminal"
  = f:factor t:(MULOP term)* {
                              if(t.length == 0) return f;
                              else {
                                //TODO
                              }
                             }

arguments
  = a:[a-z]i+ ar:(COMMA [a-z]i+)* { if(ar.length == 0) return a;
                                    else{
                                      let res = [];
                                      res.push(a);
                                      ar.forEach(function(p){
                                        res.push(p[1]);
                                      })
                                      return res;
                                    }
                                  }

factor  "Factor"
 = n:NUM { return { "type" : 'NUM', "value" : n}; }
 / id:ID { return { "type" : 'ID', "value" : id}; }
 / LEFTBRACE e: expression RIGHTBRACE {return e;}


assign "Assignments"
  = id:ID EQ n:NUM { var left  = { "type" : 'ID', "value"  : id };
                     var right = { "type" : "NUM", "value" : n };
                     var result = { "left" : left, "right" : right };
                     return util.inspect(result, {showHidden:true, depth : null});
                   }

  //Syntax

  _ = $[ \t\r\n]*                                             //Blancos
  ID = _ id:$[a-zA-Z]i+ _   { return id;}                      //Identificadores
  EQ = _"="_               { return '=';}
  NUM = _ digits:$[0-9]+ _ { return parseInt(digits, 10); }
  SEMICOLON = _";"_        { return ';'}
  COMMA = _","_
  DECLARE = _"var"_        { return 'VAR';}
          / _"const"_      { return 'CONST';}
  LEFTPAR = _"("_
  RIGHTPAR = _")"_
  LEFTBRACE = _"{"_
  RIGHTBRACE = _"}"_
  COMP = _ $([!=<>]"=") _
       / _ c:[<>] _



/* Reglas
  * sentencias  --> (sentencia ';')*
  * sentencia   --> declaración | condición | función | bucle | expresión
  * bucle       --> 'WHILE (' comparación ') DO {' sentencias '}'
  * expresión   --> terminal (ADDOP expresión)*
  * terminal    --> factor (MULTOP terminal)*
  * factor      --> '(' expresión ')' | NUM | ID
  * asignación  --> ID '=' expresión
  * comparación --> '(' expresión COMPARSION expresión ')'*/

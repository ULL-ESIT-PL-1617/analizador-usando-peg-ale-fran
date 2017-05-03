{
  const util = require('util');
  var tree = [];
  var table = {}; //Table to store variables
}
//Rules
start 'Statements'
  = s:statement+ {
                    if(s.length == 1){
                      tree.push(s[0]);
                    } else {
                      s.forEach(function(item){
                        tree.push(item);
                      });
                    }
                    return tree;
                  }

statement
  = d:declaration {return d;}
  / c:conditional {return c;}
  / f:function    {return f;}
  / l:loop        {return l;}

declaration
  = d:DECLARE id:ID e:(ASSIGN expression)? SEMICOLON {
                                                        return {
                                                          'type' : d,
                                                          'left' : id,
                                                          'right': (e == null) ? null : e[1]
                                                        }
                                                      }
  / id:ID a:ASSIGN e:expression {
                        return {
                          'type' : a,
                          'left' : id,
                          'right': e
                        }
                      }

conditional
  = 'if'i c:condition b:block {
                            return {
                              'type' : 'Conditional',
                              'left' : c,
                              'right': b
                            };
                          }

loop
  = 'while'i c:condition b:block { 
                                return {
                                  'type': 'LOOP',
                                  'left': c,
                                  'right': b
                                };
                             }

function
  = 'function'i id:ID? LEFTPAR p:parameters? RIGHTPAR b:block {
                                                                return { 'type' : 'Function',
                                                                         'parameters' : p,
                                                                         'left' : id,
                                                                         'right' : b
                                                                        };
                                                               }

block
  = LEFTBRACE s:statement+ RIGHTBRACE { return {'type' : 'block', 'value' : s};}

parameters
  = p:primary pa:(COMMA primary)* {
                                    if(pa.length == 0)
                                      return p;
                                    else {
                                      let params = [];
                                      params.push(p);
                                      pa.forEach(function(item){
                                        params.push(item[1]);
                                      });
                                     return params;
                                    }
                                  }

condition
  = LEFTPAR a:primary c:COMP b:primary RIGHTPAR {
                                                  return {
                                                    'type' : c,
                                                    'left' : a,
                                                    'right': b
                                                   }
                                                 }

expression
  = t:term e:(ADDOP expression)* {
                                  if(e.length == 0){
                                    return t;
                                  } else {
                                    let arr = e; //Array de arrays
                                    return false;
                                  }
                                } //TODO

term
  = f:factor fa:(MULOP term)* {
                                if(fa.length == 0){
                                  return f;
                                } else {
                                  let arr = fa;
                                  return false; //TODO
                                }
                              }

factor
  = LEFTPAR e:expression RIGHTPAR {return e;}
  / p:primary {return p;}

primary 'String or integer'
  = id:ID   { return id; }
  / n:NUM   { return n; }

//////////////
// Literals //
//////////////
_          = [ \t\n\r]*
COMP       = _ c:$([!=<>]'=') _  { return c;}
           / _ c:[<>] _  { return c;}
ADDOP      = PLUS / MINUS
MULOP      = MUL / DIV
PLUS       = _'+'_ { return '+'; }
MINUS      = _'-'_ { return '-'; }
MUL        = _'*'_ { return '*'; }
DIV        = _'/'_ { return '/'; }
ASSIGN     = _'='_ { return '=';}
SEMICOLON  = _';'_
COMMA      = _','_
LEFTPAR    = _'('_
RIGHTPAR   = _')'_
LEFTBRACE  = _'{'_
RIGHTBRACE = _'}'_
ID         = _ id:$[a-z]i+_     { return {'type' : 'ID', 'value' : id}; }
NUM        = _ digits:$[0-9]+ _ { return {'type' : 'NUM', 'value' : parseInt(digits, 10)}; }
DECLARE    = _ v:'var'i _       { return v; }
           / _ c:'const'i _     { return c; }

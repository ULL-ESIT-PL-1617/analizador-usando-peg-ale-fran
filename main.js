var PEG = require("./parser.js");
//var input = "myfunc(a,b,c);"                    //Declarations
//var input = "const k = 42;  k = 422;"                    //Declarations
//var input = "function () { var k = 33; }"                      //Function no param no id OK
//var input = "function myfunc(f){ var k = 33;}"               //Function w1 param OK
//var input = "function myfunc(f,g,h){ var k = 33;}"           //Function w+ param OK
//var input = "function myfunc(f, 55){ var k = 33; const FK;}"           //Function w+ param OK
//var input = 'var myf = function(){ i = 0;}'
//var input = 'myfunc(5,h);'
//var input = "if ( a == 5 ) { var b = 0; }";               //Condition OK
//var input = "IF ( a > 5 ) { if (b<4) {const k = 33;} }";    //nested Condition OK
//var input = "while ( a != 5 ) { var a = a + 1; }";    //nested Condition OK
//var input = 'i = 5 + 5';
//var input = 'if (5 < a ) { a=a+3; a = 0;} const k = 33;'
var input = `
            const MAX = 5;
            var i;
            While (i < MAX) {
              i = i + 1;
            }

            function (i){
              if(i == 5) {
                  i = 0;
              }
            }
            `;
console.log(`Processing <${input}>`);
var r = PEG.parse(input);
console.log(JSON.stringify(r, null, 2));

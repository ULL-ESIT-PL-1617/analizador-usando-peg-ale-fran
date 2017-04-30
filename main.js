var PEG = require("./parser.js");
//var input = process.argv[2] || "statements";
//var input = "function (){ var k = 33;};"                      //Function no param no id OK
//var input = "function myfunc(f){ var k = 33;};"               //Function w1 param OK
//var input = "function myfunc(f,g,h){ var k = 33;};"           //Function w+ param OK
//var input = "if ( a == 5 ) { const k = 33; };";               //Condition OK
//var input = "IF ( a == 5 ) { if (b<4) {const k = 33;};};";    //nested Condition OK
var input = "while ( a == 5 ) { var k = 33; };";    //nested Condition OK
console.log(`Processing <${input}>`);
var r = PEG.parse(input);
console.log(r);

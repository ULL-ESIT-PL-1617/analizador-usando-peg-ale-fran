var chai = require('chai');
var PEG = require('./parser.js');
var expect = chai.expect;

function removeSpaces(str){
  return str.replace(/\s/g,'');;
}

describe("Aritmethics expressions", function () {
  it("# a = 5 + 5", function(){
    var tree = `[{"type": "=", "left": {"type": "ID", "value": "a"}, "right": [{"type": "+", "left":
                  {"type": "NUM", "value": 5}, "right": {"type": "NUM", "value": 5} }] }]
                `;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('a = 5 + 5;'), null, 2))
    expect(res).to.equal(tree);
  });
  it("# a = 5 * 5 - 10", function(){
    var tree = `[{"type": "=", "left": {"type": "ID","value": "a" },"right": [{"type": "-","left": [{
                "type": "*","left": { "type": "NUM", "value": 5},"right": {"type": "NUM", "value": 5}
                }],"right": {"type": "NUM", "value": 10} } ]}]
                `;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('a = 5 * 5 - 10;'), null, 2))
    expect(res).to.equal(tree);
  });
});

describe("Declaring & defining variables", function () {
  it("# var myvar = 33;", function(){
    var tree = `[{"type": "var","left": {  "type": "ID", "value": "myvar"}, "right": { "type": "NUM",  "value": 33 }}]  `;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('var myvar = 33;'), null, 2))
    expect(res).to.equal(tree);
  });
  it("# const MAX;", function(){
    var tree = `[{"type": "const","left": {  "type": "ID", "value": "MAX"}, "right": null}] `;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('const MAX;'), null, 2))
    expect(res).to.equal(tree);
  });
});

describe("Declaring, defining & calling functions", function () {
  it("# var myfunc = function () { var k = 33; }", function(){
    var tree = `[{"type": "var","left": {"type": "ID","value": "myfunc"},"right": {"type": "Function", "parameters": null,
                "left": null, "right": { "type": "block", "value": [{"type": "var", "left": {"type": "ID","value": "k"},
                "right": { "type": "NUM",  "value": 33  }  }  ]  } } }]                `;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('var myfunc = function () { var k = 33; }'), null, 2))
    expect(res).to.equal(tree);
  });
  it("# function myFunction(p,c) { var k = 33; }", function(){
    var tree = `[{ "type": "Function","parameters": [ { "type": "ID", "value": "p"}, {"type": "ID","value": "c" }],
              "left": {"type": "ID", "value": "myFunction" },"right": { "type": "block", "value": [ { "type": "var",
              "left": { "type": "ID","value": "k" }, "right": {   "type": "NUM",     "value": 33        }}]}}]`;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('function myFunction(p,c) { var k = 33; }'), null, 2))
    expect(res).to.equal(tree);
  });
  it("# myFunction(a,b,c);", function(){
    var tree = `[{"type": "CALL","parameters": [ { "type": "ID", "value": "a" }, { "type": "ID",  "value": "b"
  }, { "type": "ID", "value": "c"  }  ],  "id": {    "type": "ID",   "value": "myFunction"   }}]`;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('myFunction(a,b,c);'), null, 2))
    expect(res).to.equal(tree);
  });
});

describe("Conditonals and loops", function () {
  it("# if ( a == 5 ) { var b = 0; }", function(){
    var tree = `[{ "type": "Conditional", "left": {  "type": "==",  "left": {     "type": "ID",    "value": "a"      },
                "right": {    "type": "NUM",   "value": 5  }},"right": { "type": "block", "value": [   {   "type": "var",
                "left": {"type": "ID",    "value": "b"       },     "right": {     "type": "NUM", "value": 0}}]}}]`;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('if ( a == 5 ) { var b = 0; }'), null, 2))
    expect(res).to.equal(tree);
  });
  it("# while ( a != 5 ) { var a = a + 1; }", function(){
    var tree = `[{"type": "LOOP","left": {"type": "!=", "left": { "type": "ID","value": "a" },"right": {"type": "NUM", "value": 5
                } },"right": {"type": "block","value": [ { "type": "var", "left": { "type": "ID", "value": "a"},"right": [
                  { "type": "+",     "left": {  "type": "ID",  "value": "a" }, "right": {"type": "NUM", "value": 1}}]}]}}]`;
    tree = removeSpaces(tree);
    var res = removeSpaces(JSON.stringify(PEG.parse('while ( a != 5 ) { var a = a + 1; }'), null, 2))
    expect(res).to.equal(tree);
  });
});

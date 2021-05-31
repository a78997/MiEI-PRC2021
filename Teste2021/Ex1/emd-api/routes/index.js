var express = require('express');
var router = express.Router();
var gdb = require('../utils/graphdb')
var axios = require('axios')

/* GET home page. */
router.get('/', function(req, res){
  res.jsonp("Servidor dos EMDs a responder!")
})

router.get('/api/emd', async function(req, res, next) {
  var myquery = `select ?id ?nome ?data ?res where{
    ?id rdf:type :EMD .
    ?id :éExameDe ?a .
    ?a :temNome ?nome .
    ?id :Data ?data .
    ?id :Resultado ?res .
}`
  var result = await gdb.execQuery(myquery);
  return result 
});

router.get('/api/emd/:id', async function(req, res, next) {
  var myquery = `select ?nome ?idade ?data ?res where{
    :${req.params.id} rdf:type :EMD .
    :${req.params.id} :éExameDe ?a .
    ?a :temNome ?nome .
    :${req.params.id} :Data ?data .
    :${req.params.id} :Resultado ?res .
    ?a :temIdade ?idade .
  }
  `
  var result = await gdb.execQuery(myquery);
  return result 
});

router.get('/api/emd/modalidades', async function(req, res, next) {
  var myquery = `select distinct ?modalidade where{
    ?modalidade a :Modalidade .
}  `
  var result = await gdb.execQuery(myquery);
  return result 
});

router.get('/api/emd?res=OK', async function(req, res, next) {
  var myquery = `select ?s where {
    ?s a :EMD .
   	?s :Resultado "True"^^xsd:boolean .
}  `
  var result = await gdb.execQuery(myquery);
  return result 
});

router.get('/api/atletas?gen=F', async function(req, res, next) {
  var myquery = `select ?n where {
    ?a a :Atleta .
   	?a :temNome ?n .
    ?a :temGénero "F".
} 
Order by ?n`
  var result = await gdb.execQuery(myquery);
  return result 
});

router.get('/api/atletas?clube=X', async function(req, res, next) {
  var myquery = `select ?n where {
    ?a a :Atleta .
   	?a :temNome ?n .
    ?a :pertenceAoClube :${req.query.clube} .
} 
Order by ?n`
  var result = await gdb.execQuery(myquery);
  return result 
});


module.exports = router;

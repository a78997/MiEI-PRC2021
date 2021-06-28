var express = require('express');
var router = express.Router();
var axios = require('axios');
var gdb = require('../utils/graphdb');

/* GET /api/filmes - Devolve a lista de Filmes apenas com os campos "id", "titulo", "ano" e "numAtores" */
router.get('/api/filmes',async function(req,res) {

var query = `  
  select ?id ?t ?ano (COUNT(?a) as ?numAtores) where { 
    ?id a :Filme .
    ?id :título ?t . 
    ?id :ano ?ano .
    ?id :éRealizadoPor ?a
  } 
  group by ?id ?t ?ano
  `
  var result = await gdb.execQuery(query);
  result = result.results.bindings.map(f => {
    return{
      id : f.id.value.split('#')[1],
      titulo : f.t.value,
      ano : f.ano.value,
      atores : f.numAtores.value
    }
  });
res.jsonp(result);

});

router.get('/api/generos',async function(req,res) {
  var query = `  
  select distinct ?g where {
    ?g a :Género .
  }
  order by ?g
  `
  var result = await gdb.execQuery(query);
  result = result.results.bindings.map(g => {
    return{
      Género : g.g.value.split('#')[1]
    }
  });
  res.jsonp(result);
  
  });

module.exports = router;
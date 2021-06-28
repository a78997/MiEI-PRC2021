import json 



with open ('./cinema.json') as f:
    jsonfile = json.load(f)

    r = open('./cinema_data.ttl',"a",encoding='utf-8')
    for e in jsonfile:

        r.write('###  http://www.di.uminho.pt/prc2021/cinema-americano#filme'+e.index()+'\n')
        r.write(':filme'+e.index()+' rdf:type owl:NamedIndividual ,\n')
        r.write('             :Filme ;\n')
        for g in e.genres :
            r.write(':temGénero :'+g+' ;\n')
        
        for a in e.cast :
            r.write(':éRealizadoPor :'+a+' ;\n')
        r.write(':ano '+ e.year +' ;\n')
        r.write('    :título "'+ e.title + '" .\n')
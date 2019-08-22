
--Setar esquema
SET search_path to omop5; 

--Exames observacionais que contem pesos#
SELECT * from measurement join concept on concept_id= measurement_concept_id and concept_name like 'Body%'

--Quantidades de exames realizados de todos os tipos
SELECT concept_name, COUNT(concept_name) from measurement join concept on concept_id= measurement_concept_id GROUP BY concept_name

--Observações dos resultados de determinados exames
SELECT * from measurement join concept on concept_id= measurement_concept_id and concept_name like 'COLESTEROL%'

--Tipo de exames, measurement que uma determinada pessoa já realizou#
SELECT * from measurement join concept on concept_id= measurement_concept_id   where person_id = 8833732778727498

-- Total de pessoas
SELECT COUNT(person_id) AS num_persons_count
FROM   person


-- Quantidade de acordo com o genero 
-- unknown gender (8551)
-- other (8521) 
-- ambiguous (8570)
-- 8532 women 
-- 8707 man
SELECT  COUNT(person_ID) AS num_persons_count 
FROM Person
WHERE GENDER_CONCEPT_ID = 8532


--  Caracterização do genero 
SELECT  concept_name, concept_id
FROM concept INNER JOIN person
ON GENDER_CONCEPT_ID = concept_id GROUP BY concept_id


--  Caracterização do Raca 
SELECT  concept_name, concept_id
FROM concept INNER JOIN person
ON RACE_CONCEPT_ID = concept_id GROUP BY concept_id


-- Quantidade de acordo com a Raça 
-- No matching concept(0)
-- Asian (8515) 
-- Black or African American (8516)
-- White (8527)
-- American Indian or Alaska Native (8657)
SELECT  COUNT(person_ID) AS num_persons_count 
FROM Person
WHERE RACE_CONCEPT_ID = 8532


-- Numero de pacientes, agrupados por ano de nasciento 
SELECT year_of_birth,
       COUNT(person_id) AS Num_Persons_count
FROM   person
GROUP BY year_of_birth
ORDER BY year_of_birth

--- count of concept with order e group by 
SELECT domain_id, COUNT(*) 
FROM concept 
GROUP BY  (domain_id)  ORDER BY 2


-- observção por data 
SELECT observation_period_start_date FROM OBSERVATION_PERIOD  ORDER BY  (observation_period_start_date) 


--COUNT when concept was invalid
-- D deleted
-- U replace with an update
SELECT COUNT(concept_id) as quant 
FROM CONCEPT 
WHERE invalid_reason in ('D')

-- Busca do nome do do conceito  Vocabulário - Conceito
SELECT concept_id, concept_name
FROM vocabulary 
INNER JOIN concept
ON vocabulary.vocabulary_concept_id = concept.concept_id


SELECT observation_period_id, observation_period_start_date, observation_period_end_date, year_of_birth
FROM observation_period
INNER JOIN person
ON observation_period.person_id = person.person_id

-- conceito nome em visit occurence----
SELECT DISTINCT concept_name FROM concept  
INNER JOIN visit_occurrence
ON visit_concept_id = concept_id

------
SELECT visit_start_date from visit_occurrence
WHERE visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' 
order by visit_start_date



SELECT observation_period_id, observation_period_start_date, observation_period_end_date, year_of_birth, concept_name
FROM observation_period
INNER JOIN person
ON observation_period.person_id = person.person_id
INNER JOIN concept
ON person.gender_concept_id = concept.concept_id


--"Emergency Room Visit"
--"Inpatient Visit"
--"Outpatient Visit"

-- Buscar de tipo de observação " Count dos anos 
select date_trunc('year',visit_start_date), count(*) as "Emergency Room Visit" from visit_occurrence 
INNER JOIN concept
ON concept_id = visit_concept_id
where visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' and concept.concept_name like 'Emergency Room Visit'
group by date_trunc('year',visit_start_date) order by
date_trunc('year',visit_start_date);


WHERE concept_name not in ('No matching concept')



-- Data
WHERE visit_occurrence.visit_start_date > '1999/02/02' and visit_occurrence.visit_start_date < '2018/01/01'


--Pegando COunt dos anos acima de 1999 e abaixo de 2018 

select date_trunc('year',visit_start_date), count(*) from visit_occurrence
where visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' 
is true group by date_trunc('year',visit_start_date) order by
date_trunc('year',visit_start_date);




select date_trunc('year',visit_start_date), count(*) from visit_occurrence
INNER JOIN concept
ON visit_occurrence_id = concept_id
where visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' and concept.concept_name like 'Outpatient Visit'
is true group by date_trunc('year',visit_start_date) order by
date_trunc('year',visit_start_date);





-- Todas as visitas De acordo com o genero 
select date_trunc('year',visit_start_date), count(*) as "Female" from visit_occurrence 
INNER JOIN person
ON visit_occurrence.person_id = person.person_id
where visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' and person.gender_concept_id in (8532)
group by date_trunc('year',visit_start_date) order by
date_trunc('year',visit_start_date);


-- Visitas + generro + tipo de visita 

( select date_trunc('year',visit_start_date), count(*) as "No Match" from visit_occurrence
INNER JOIN person
ON visit_occurrence.person_id = person.person_id
INNER JOIN concept
ON concept_id = visit_concept_id
where visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' and concept.concept_name like 'Emergency Room Visit' and  person.gender_concept_id in (0)
group by date_trunc('year',visit_start_date) order by
date_trunc('year',visit_start_date))


--- Doenças -------
SELECT DISTINCT concept_name from condition_occurrence
INNER JOIN concept
on condition_occurrence.condition_concept_id = concept.concept_id



SELECT DISTINCT concept_name , concept_class_id from condition_occurrence
INNER JOIN concept
on condition_occurrence.condition_concept_id = concept.concept_id
INNER JOIN concept_claas
on concept. concept_class_id = concept_class_id

where concept_id = 



2000024922
2000020671


Anemia por deficiencia de ferro
Anemia por deficiencia de ferro nao especificada
Anemia por deficiencia de ferro secundaria a perda de sangue (cronica)
Anemia por deficiencia de folato
Anemia por deficiencia de folato induzida por drogas


-- Contagem de diagnosticos anualmente entre 2000 à 2017
( select date_trunc('year',visit_start_date), count(*) as "No Match" from visit_occurrence
INNER JOIN person
ON visit_occurrence.person_id = person.person_id
INNER JOIN concept
ON concept_id = visit_concept_id
INNER JOIN condition_occurrence
ON condition_occurrence.visit_occurrence_id = visit_occurrence.visit_occurrence_id

where visit_occurrence.visit_start_date >= '2000/01/01' and visit_occurrence.visit_start_date < '2018/01/01' and concept.concept_name like 'Emergency Room Visit' and  person.gender_concept_id in (0) 
group by date_trunc('year',visit_start_date) order by
date_trunc('year',visit_start_date))

--- Detalhe dos diagnósticos que são diferentes do DIAG/C, ou seja, do CID 10
SELECT DISTINCT * from condition_occurrence
INNER JOIN concept
on condition_occurrence.condition_concept_id = concept.concept_id

WHERE condition_source_value not like 'DIAG/C/%'

	
-- Testando a buscar recursiva, para Neoplasia e Pulmao e seus derivados,
-- com palavra seguintes as conjunções"

SELECT COUNT (*), CONCEPT_NAME from condition_occurrence 
INNER JOIN concept
on condition_occurrence.condition_concept_id = concept.concept_id
WHERE upper(CONCEPT_NAME) LIKE upper('%NEOPLASIA%')and  upper(CONCEPT_NAME)  NOT LIKE upper('%HISTORIA%') and (upper(concept_name) Like upper ('%PULMao%') 
OR upper(concept_name) Like upper ('%lobo%') OR upper(concept_name) Like upper ('%bronquio%') OR upper(concept_name) Like upper ('%bronquios%') OR upper(concept_name) Like upper ('%pulmoes%') 
OR upper(concept_name) Like upper ('%traqueia%') OR upper(concept_name) Like upper ('%traqueias%') 
)
AND upper(concept_name) NOT Like upper ('%exceto%') 

group by(concept_name)
order by count

--- Mostrando os 10 primeiros diagnósticos com JOIN com o conceito
SELECT * from condition_occurrence 
INNER JOIN concept
on condition_occurrence.condition_concept_id = concept.concept_id
LIMIT 10;



-- Mostrando as medidas de "Body" ou seja as vezes que foram retiradas as medidas de kg, altura 
SELECT * from measurement join concept on concept_id= measurement_concept_id and concept_name like 'Body%'

-- Quantidade dos resultados de exames disponiveis de todos os exames
SELECT concept_name, COUNT(concept_name) from measurement join concept on concept_id= measurement_concept_id GROUP BY concept_name

-- Informações de pessoas que realizaram exames e os resultados de colesterol
SELECT * from measurement join concept on concept_id= measurement_concept_id and concept_name like 'COLESTEROL%'


--Numero de pessoas diagnosticadas
select count(*) as n_pessoa_diagnostico
from (
    select person_id, concept_id, count(*)
    from omop5.condition_occurrence d
    join omop5.concept c on concept_id = condition_concept_id
    group by person_id, concept_id
    order by count(*) desc
    ) as x;


    --Numero de pessoas diagnosticadas utilizando CID 10 
	select count(*) as n_pessoa_diagnostico_cid
from (
    select person_id, concept_id, count(*)
    from omop5.condition_occurrence d
    join omop5.concept c on concept_id = condition_concept_id
    where concept_code  like 'DIAG/C/%'
    group by person_id, concept_id
    order by count(*) desc
    ) as x;

    --Numero de Pessoas que não utilizam CID10
    - só mudar o like para not like = 7259
    
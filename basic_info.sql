-- Detalhamento banco 
--Tamanho de todos BD
(SELECT
	datname                                   AS banco,
	pg_database_size(datname)                 AS tamanho,
	pg_size_pretty(pg_database_size(datname)) AS tamanho_pretty
FROM pg_database
WHERE datname NOT IN ('template0', 'template1', 'postgres')
ORDER BY tamanho DESC, banco ASC)

UNION ALL

(SELECT
	'TOTAL'                                        AS banco,
	sum(pg_database_size(datname))                 AS tamanho,
	pg_size_pretty(sum(pg_database_size(datname))) AS tamanho_pretty
FROM pg_database
WHERE datname NOT IN ('template0', 'template1', 'postgres'));



-- Todas tabelas e quantidade de tuplas 

SELECT
   relname,
   n_live_tup
FROM
   pg_stat_user_tables
ORDER BY
   n_live_tup DESC;

   
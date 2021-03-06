-- 200	Number of persons with at least one visit occurrence, by visit_concept_id

--HINT DISTRIBUTE_ON_KEY(stratum_1)
select 200 as analysis_id, 
	CAST(vo1.visit_concept_id AS VARCHAR(255)) as stratum_1,
	cast(null as varchar(255)) as stratum_2, cast(null as varchar(255)) as stratum_3, cast(null as varchar(255)) as stratum_4, cast(null as varchar(255)) as stratum_5,
	COUNT_BIG(distinct vo1.PERSON_ID) as count_value
into @scratchDatabaseSchema@schemaDelim@tempAchillesPrefix_200
from
	@cdmDatabaseSchema.visit_occurrence vo1
group by vo1.visit_concept_id
;

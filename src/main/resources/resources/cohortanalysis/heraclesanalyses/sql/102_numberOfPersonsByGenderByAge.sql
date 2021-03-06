-- 102   Number of persons by gender by age, with age at first observation period
--insert into @results_schema.heracles_results (cohort_definition_id, analysis_id, stratum_1, stratum_2, count_value)
select c1.cohort_definition_id, 102 as analysis_id,  p1.gender_concept_id as stratum_1, year(op1.index_date) - p1.YEAR_OF_BIRTH as stratum_2,
                                cast( '' as varchar(1) ) as stratum_3, cast( '' as varchar(1) ) as stratum_4,
                                COUNT_BIG(p1.person_id) as count_value
into #results_102
from @CDM_schema.person p1
inner join #HERACLES_cohort_subject c1
on p1.person_id = c1.subject_id
inner join (select person_id, MIN(observation_period_start_date) as index_date from @CDM_schema.observation_period group by PERSON_ID) op1
on p1.PERSON_ID = op1.PERSON_ID
group by c1.cohort_definition_id, p1.gender_concept_id, year(op1.index_date) - p1.YEAR_OF_BIRTH
;

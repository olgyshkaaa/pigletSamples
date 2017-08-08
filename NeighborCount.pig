edge= LOAD 'C://Spark//Students.txt' USING PigStorage(',')
   as (start:int, end:int);
edge_group_end = GROUP edge BY end;
result_end = FOREACH edge_group_end GENERATE edge.end, COUNT(edge.start);
edge_group_end = GROUP edge BY start;
result_start = FOREACH edge_group_start GENERATE edge.start, COUNT(edge.end);
result = UNION result_start, result_end; 
result_group = GROUP result BY $0;
result_all = FOREACH result_group GENERATE result.$0, SUM (result.$1);
DUMP result_all;

edge = LOAD 'C://Spark//edge.txt' USING PigStorage(',')
   as (start:int, end:int);
edge_reverse = FOREACH edge GENERATE $1, $0; 
edge_direct = FOREACH edge GENERATE $0, $1;
edge_all = UNION edge_reverse, edge_direct;
edge_all_copy = FOREACH edge_all GENERATE $0, $1;
first_edge_join = JOIN edge_all BY $1, edge_all_copy BY $0;
second_edge_join = FOREACH first_edge_join GENERATE $0, $1, $3;
third_edge_join = FILTER second_edge_join BY $0 != $2;
fourth_edge_join = JOIN third_edge BY $2, edge_all BY $0;
fifth_edge_join = FOREACH fourth_edge GENERATE $0, $1, $2, $4;
result = FILTER fifth_edge_join BY $0 == $3;
edge_join5=FOREACH edge_join4 GENERATE $0, $1, $2, $4;
result = FILTER edge_join5  BY $0 == $3;
result_all = Group result All;
triangle = FOREACH result_all GENERATE COUNT ($1)/6;
DUMP triangle;





#!/usr/bin/env bash

qrels_18=qrels_abs_task2_training
qrels_17=qrel_abs_train

bulk_eval ${qrels_18} rm_grid_search_2018 1 trec cutoff_gs/*_2018_*.run
bulk_eval ${qrels_18} rm_grid_search_2018 0 entrez cutoff_gs/*_2018_*.run
bulk_eval ${qrels_18} rm_grid_search_2018 _ tar18 cutoff_gs/*_2018_*.run

bulk_eval ${qrels_17} rm_grid_search_2017 1 trec cutoff_gs/*_2017_*.run
bulk_eval ${qrels_17} rm_grid_search_2017 0 entrez cutoff_gs/*_2017_*.run
bulk_eval ${qrels_17} rm_grid_search_2017 _ tar17 cutoff_gs/*_2017_*.run

mkdir -p rm_grid_search_2017comb
for FILE in $(ls cutoff_gs/ | grep 2017) ; do
    comb_trec+json rm_grid_search_2017/${FILE}.trec.eval rm_grid_search_2017/${FILE}.entrez.eval.json > rm_grid_search_2017comb/${FILE}.tmp.json
    comb_trec+json rm_grid_search_2017/${FILE}.tar17.eval rm_grid_search_2017comb/${FILE}.tmp.json > rm_grid_search_2017comb/${FILE}.eval.json
    rm rm_grid_search_2017comb/${FILE}.tmp.json
done

mkdir -p rm_grid_search_2018comb
for FILE in $(ls cutoff_gs/ | grep 2018) ; do
    comb_trec+json rm_grid_search_2018/${FILE}.trec.eval rm_grid_search_2018/${FILE}.entrez.eval.json > rm_grid_search_2018comb/${FILE}.tmp.json
    comb_trec+json rm_grid_search_2018/${FILE}.tar18.eval rm_grid_search_2018comb/${FILE}.tmp.json > rm_grid_search_2018comb/${FILE}.eval.json
    rm rm_grid_search_2018comb/${FILE}.tmp.json
done
#!/usr/bin/env bash

bulk_eval qrel_abs_task2 2018 1 trec ranking_runs/*_2018.run
bulk_eval qrel_abs_test.txt 2017 1 trec ranking_runs/*_2017.run
bulk_eval qrel_abs_task2 2018 0 entrez ranking_runs/*_2018.run
bulk_eval qrel_abs_test.txt 2017 0 entrez ranking_runs/*_2017.run
bulk_eval qrel_abs_task2 2018 _ tar18 ranking_runs/*_2018.run
bulk_eval qrel_abs_test.txt 2017 _ tar17 ranking_runs/*_2017.run

mkdir -p 2017comb
for FILE in $(ls ranking_runs/ | grep _2017.run) ; do
    comb_trec+json 2017/${FILE}.trec.eval 2017/${FILE}.entrez.eval.json > 2017comb/${FILE}.tmp.json
    comb_trec+json 2017/${FILE}.tar17.eval 2017comb/${FILE}.tmp.json > 2017comb/${FILE}.eval.json
    rm 2017comb/${FILE}.tmp.json
done

mkdir -p 2018comb
for FILE in $(ls ranking_runs/ | grep _2018.run) ; do
    comb_trec+json 2018/${FILE}.trec.eval 2018/${FILE}.entrez.eval.json > 2018comb/${FILE}.tmp.json
    comb_trec+json 2018/${FILE}.tar18.eval 2018comb/${FILE}.tmp.json > 2018comb/${FILE}.eval.json
    rm 2018comb/${FILE}.tmp.json
done

stat_sig -r 2017comb/*.json -m map ndcg recip_rank Rprec last_rel -x 2017comb/pubmed-2017.run.eval.json > ../tables/2017results.tmp.tex
stat_sig -r 2018comb/*.json -m map ndcg recip_rank Rprec last_rel -x 2018comb/pubmed-2018.run.eval.json > ../tables/2018results.tmp.tex

bulk_eval qrel_abs_task2 rm2018 1 trec cutoff_runs/*_2018.run
bulk_eval qrel_abs_test.txt rm2017 1 trec cutoff_runs/*_2017.run
bulk_eval qrel_abs_task2 rm2018 0 entrez cutoff_runs/*_2018.run
bulk_eval qrel_abs_test.txt rm2017 0 entrez cutoff_runs/*_2017.run
bulk_eval qrel_abs_task2 rm2018 _ tar18 cutoff_runs/*_2018.run
bulk_eval qrel_abs_test.txt rm2017 _ tar17 cutoff_runs/*_2017.run

mkdir -p rm2017comb
for FILE in $(ls cutoff_runs/ | grep _2017.run) ; do
    comb_trec+json rm2017/${FILE}.trec.eval rm2017/${FILE}.entrez.eval.json > rm2017comb/${FILE}.tmp.json
    comb_trec+json rm2017/${FILE}.tar17.eval rm2017comb/${FILE}.tmp.json > rm2017comb/${FILE}.eval.json
    rm rm2017comb/${FILE}.tmp.json
done

mkdir -p rm2018comb
for FILE in $(ls cutoff_runs/ | grep _2018.run) ; do
    comb_trec+json rm2018/${FILE}.trec.eval rm2018/${FILE}.entrez.eval.json > rm2018comb/${FILE}.tmp.json
    comb_trec+json rm2018/${FILE}.tar18.eval rm2018comb/${FILE}.tmp.json > rm2018comb/${FILE}.eval.json
    rm rm2018comb/${FILE}.tmp.json
done

stat_sig -r rm2017comb/*.json -m set_P set_recall F1Measure F0.5Measure F3Measure total_cost loss_er -x rm2017comb/clf+weighting-2017.run.eval.json > ../tables/2017_rm_results.tmp.tex
stat_sig -r rm2018comb/*.json -m set_P set_recall F1Measure F0.5Measure F3Measure total_cost loss_er -x rm2018comb/clf+weighting-2018.run.eval.json > ../tables/2018_rm_results.tmp.tex

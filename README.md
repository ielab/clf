# Coordination Level Fusion

This repository contains the experimental pipeline scripts to produce the results in the paper "You _Can_ Teach an Old Dog New Tricks: Rank Fusion applied to Coordination Level Matching for Ranking in Systematic Reviews", presented at ECIR 2020. You may cite this research as:

```text
@inproceedings{scells2020clf,
	Author = {Scells, Harrisen and Zuccon, Guido and Koopman, Bevan},
	Booktitle = {Proceedings of the 42nd European Conference on Information Retrieval},
	Title = {You \textit{can} Teach an Old Dog New Tricks: Rank Fusion applied to Coordination Level Matching for Ranking in Systematic Reviews},
	Year = {2020}
}
```

There are a couple of tools that need to be installed that will allow one to replicate the experiments. These tools are as follows:
 
 - python3
 - go1.12 (or higher) 
 - prettyres (https://github.com/hscells/prettyres)
 - boogie (https://github.com/hscells/boogie @ 07c3c66222)
 - groove (https://github.com/hscells/groove @ 26ff32ea28)
 
This repository is split into two parts: *ranking* and *evaluation*.

## Ranking

The scripts to run the ranking experiments can be found in the [`ranking`](ranking) folder. The `clf.sh` file must be edited to point to the boogie main file.

### CLF Experiments:

The following two scripts produce rankings for the TAR'17 and TAR'18 queries. The files and folders that are referenced in the scripts are available in the `ranking` folder.
 
#### TAR'17 
 
```bash
./clf.sh false true true true false false false tar17_testing_pmids tar17_testing_titles 1 tar17_testing_topics tar17_clf_testing.run
```

#### TAR'18

```bash
./clf.sh false true true true false false false tar2_testing_pmids tar2_testing_titles 1 tar2_testing_topics tar18_clf_testing.run
```

Note that in order to change the weighting schemes, the source code must be directly modified. The place to do so is located [here](https://github.com/hscells/groove/blob/26ff32ea28ef26b9e119b324fb8b981438c17a98/rank/clf.go#L100). The arguments to the script are available at the top of the file. There are also three arguments that must be replaced in the `clf.json` file. These can be obtained by signing up for an API key with ncbi (https://www.ncbi.nlm.nih.gov/).

### Cut-Off Experiments:

The following two scripts produce cut-off rankings for the TAR'17 and TAR'18 queries. The scripts are pre-configured to sweep the parameters listed in the paper. The files and folders that are referenced in the scripts are available in the `ranking` folder.

#### TAR'17

```bash
./clf_rm.sh tar17_training_pmids tar17_training_titles clf_rm_gain_2017_ tar17_training_topics 
```

#### TAR'18

```bash
./clf_rm.sh tar2_training_pmids tar2_training_titles clf_rm_gain_2018_ tar2_training_topics
```

## Evaluation

The following two scripts evaluate the main ranking task of TAR and the cut-off tasks. Both scripts evaluate the TAR'17 & '18 scripts at the same time. Note that all of the final evaluation and run files used in the paper are already provided, including the cut-off runs. The run files (from these experiments, and the same run files used from the TAR collections) can be found in [evaluation/ranking_runs](evaluation/ranking_runs) and [evaluation/cutoff_runs](evaluation/cutoff_runs) respectively. The runs for the grid search can be found in [evaluation/cutoff_gs](evaluation/cutoff_gs). The results from running the below scripts can be found in the [results](results) folder. Each subdirectory of results is categorised into evaluation results for ranking, cut-offs and the grid search for the cut-off parameter. Within each of these subdirectories, the results are further split into the respective TAR collection. Finally, the results are available in one of two folders: the `split` folder contains the evaluation results from the three different tools needed to cover all the evaluation measures, and the `combined` folder contains json files with these measures combined into a single JSON object. For example, the [results/ranking/TAR17/combined/clf+weighting+pubmed+qe_2017.run.eval.json](results/ranking/TAR17/combined/clf+weighting+pubmed+qe_2017.run.eval.json) folder contains the combined evaluation output of the best performing CLF weighting scheme on the TAR'17 collection.


The scripts provided below are only for the purposes of reproducibility and awareness.

### Ranking Evaluation:

```bash
./evaluate_ranking.sh
```

### Cut-Off Evaluation:

```bash
./evaluate_cutoff.sh
```

### Additional Scripts

There are some additional python notebook scripts that are used to produce figures and some cost evaluations. These scripts should be fairly self-explanatory.
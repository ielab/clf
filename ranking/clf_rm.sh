#!/usr/bin/env bash

RANK_CLM=false
RANK_CLF=true
QUERY_EXPANSION=true
SCORE_PUBMED=true
ONLY_SCORE_PUBMED=false
RETRIEVAL_MODEL=true
CLF_VARIATIONS=false
PMIDS=$1
TITLES=$2
RUN=$3
QUERY_PATH=$4

CUTOFFS=(0.05 0.075 0.1 0.2 0.3 0.4 0.5 0.75 0.9 0.95)

for cut in ${CUTOFFS[@]}; do
    echo "running ${RUN} with cutoff ${cut}"
    ./clf.sh ${RANK_CLM} ${RANK_CLF} ${QUERY_EXPANSION} ${SCORE_PUBMED} ${ONLY_SCORE_PUBMED} ${RETRIEVAL_MODEL} ${CLF_VARIATIONS} ${PMIDS} ${TITLES} ${cut} ${QUERY_PATH} ${RUN}${cut}.run
done

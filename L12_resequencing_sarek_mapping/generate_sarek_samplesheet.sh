#!/bin/bash

#create the input samplesheet for sarek

echo "patient,sample,lane,fastq_1,fastq_2" >> germline-input.csv

#cd datasets_labos-2023/germline_calling/reads


for sample in `ls datasets_bsa-2022/*.fastq.gz`
do
current=`pwd`
fwd=`ls "${current}/${dir}"*_1.fastq.gz`
rev=`ls "${current}/${dir}"*_2.fastq.gz`
echo "${sample},${sample},L1,${fwd},${rev}" >> datasets_labos-2023/germline_calling/germline-input.csv
done


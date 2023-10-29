# Re-sequencing data analysis: Annotating variant

In this class we will use the VCF file obtained from the joint variant calling in the last class. 

We will mine the ClinVar and gnomAD databases to check for the availability of clinical interpretation and allele frequency data for a _prioritised_ subset of variants.


## Finding the causal variant(s)

### Inspecting the VCF file

We can start searching for the variants with **HIGH** impact. We can investigate only variants found in the case sample (patient_01_sample_01) and not present in the related control (patient_02_sample_02)

```
zcat joint_germline_recalibrated_snpEff.ann.vcf.gz | grep HIGH | perl -nae 'if($F[10]=~/0\/0/){print $_;}' 
```

We can count how many:

```
zcat joint_germline_recalibrated_snpEff.ann.vcf.gz | grep HIGH | perl -nae 'if($F[10]=~/0\/0/){print $_;}' | wc -l 
```

Finally, we can save those variants in a file:

```
zcat joint_germline_recalibrated_snpEff.ann.vcf.gz | grep HIGH | perl -nae 'if($F[10]=~/0\/0/){print $_;}' > joint_germline_recalibrated_snpEff_HIGH_in_case.ann.vcf.gz
```

We can now focus on the **LOF**, Loss of Function variants:

```
grep joint_germline_recalibrated_snpEff_HIGH_in_case.ann.vcf.gz | wc -l
```

We get 9 variants which need additional data for clinical interpretation.


## Mining other databases

Now we can are able to search for the position(s) we found, or their variant identifier if available (rs number) in the following databases:

- [gnomAD](https://gnomad.broadinstitute.org/)  
- [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/)



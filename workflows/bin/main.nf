nextflow.enable.dsl=2
//define input files
params.reads='../../raw_data/*.fastq'
//define output directory
params.outdir='../../results'

//FASTQC
process FastQC {

  input:
  path fastq

  output:
  path "*_fastqc.html"
  
  publishDir params.outdir, mode: 'copy', overwrite: true
  
  script:
  """
  fastqc $fastq -o .
  """
}

workflow {
    fastq_ch=Channel.fromPath(params.reads)
    qc_results=FastQC(fastq_ch)
}


# DNA CODEC: Compressed Obfuscated DNA Encoding in Cells for Secure In Vivo Data Storage

## Abstract

DNA represents a promising medium for data storage due to its exceptional density, long-term durability, and compatibility with biological systems. While in vivo storage offers exciting potential for distributed, self-replicating data embedded in living cells, current DNA data storage strategies are restricted to single-population systems, limiting storage capacity and increasing the risk of data corruption or unauthorized access. A next-generation platform must address not only density and stability but also replication fidelity, long-term maintainability, and—critically—security and access control. 

Herein, we introduce **DNA CODEC**, a multi-population in vivo DNA data storage platform that combines high-density encoding with cryptographic obfuscation, enabling secure and durable information storage across human cells. We developed a high-efficiency, information-dense DNA storage framework by adapting a 10-ary Huffman coding algorithm with degenerate bases to optimize sequence compressibility while maintaining decoding accuracy despite biological and technical noise. The data payloads are stably integrated into the human genome using CRISPR-based targeted insertion. 

To introduce security and obfuscate the true data, we engineer a heterogeneous population of cells comprising decoy clones containing structurally similar, non-informative masking sequences. This cellular-level obfuscation strategy mitigates the risk of unauthorized access by concealing the true payload within the genomic sequence landscape. Furthermore, we demonstrate that CODEC stably maintains genomic payloads across extended cell culture and propagation, with robustness against replication errors and population drift. By distributing information across distinct cell subpopulations and embedding cryptographic obfuscation at the genomic level, CODEC ensures both data fidelity and access control, establishing a scalable, robust, and secure framework for long-term DNA data storage within living biological systems.

---

## Repository Structure
### Python folder

* `DNA_Encode_Obfuscate_V1.ipynb`: Core pipeline for converting text data into degenerate DNA sequences using 10-ary Huffman encoding, splitting the payload into 2 single letter DNA sequences (P1/P2), generating obfuscating mask sequences based on P1/P2 (M1/M2), and performing QC steps for homopolymer and GC content evaluation.

* `DNA_Encode_Obfuscate_V2.ipynb`: Includes identical steps as V1, with per-position shuffling algorithm that generates S1–S4 from P1/P2/M1/M2 before the final QC step.

* `DNA_sequencing_analyze_Illumina.ipynb`: Pipeline for processing Illumina next-generation sequencing (NGS) data (paired-end), extracting payload sequences, classifying F1/F2/F3 fragments (for extended payload only), calculating per-position base frequencies for each complete fragment, and generating a consensus sequence. 

* `DNA_sequencing_analyze_Nanopore.ipynb`: Pipeline for processing Nanopore data, performing sequence alignment for partial reads, calculating per-position base frequencies, and generating consensus sequence.

* `Subsampling_From_Sequencing_Results.ipynb`: Script used to subsample from the analyzed sequencing results for Figure 5D and Figure S23.

### MATLAB folder
* `Fig5B_passagesratio`: Script for Figure 5B plot and related data.
* `Fig5C_passageserror`: Script for Figure 5C plot and related data.
* `Fig5D_subsampling`: Script for Figure 5D plot and related data.
* `Fig6D_passagesratio_extended`: Script for Figure 6D plot and related data.
* `Fig6E_passageserror_extended`: Script for Figure 6E plot and related data.
* `FigS23_subsampling_extended`: Script for Figure S23 plot and related data.

---

## Requirements

Python 3.11 (developed on 3.11.4) plus Jupyter. Install the third-party packages with:

```bash
pip install numpy pandas matplotlib edlib openpyxl jupyter
```

Everything else used by the notebooks (`heapq`, `collections`, `itertools`, `random`,
`csv`, `re`, `os`, `glob`, `gzip`, `pathlib`, `dataclasses`, `typing`) is part of the
Python standard library and needs no installation.

System requirements (DNA_sequencing_analyze_Illumina.ipynb): that pipeline shells out to
`awk`, `rev`, `tr`, `paste`, `grep`, and `mkdir` via `os.system`, so run it on Linux,
macOS, or WSL — not stock Windows. The Nanopore, encoding, and subsampling notebooks
are pure Python and run anywhere.

---

## Instruction
## 1. `DNA_Encode_Obfuscate_V1.ipynb`

- **Input:** the text to encode, set as `example_text` in the first cell.
- **Output:** printed DNA strands — `encode_1`, `encode_2` (P1/P2) and
  `obfu_1`, `obfu_2` (M1/M2), plus a *Good/Poor quality* verdict for each.
- **How to run:** set `example_text`, then run all cells top to bottom. Regenerate
  if any strand is not "Good quality" (GC 40–60%, homopolymer ≤ 6).

## 2. `DNA_Encode_Obfuscate_V2.ipynb`

- **Input:** the text to encode, set as `example_text_long_2` in the first cell.
- **Output:** printed DNA strands `en_long_1/2` and `ob_long_1/2`(P1/P2/M1/M2), then the
  column-shuffled strands `swapped_seq_1`–`swapped_seq_4`(S1/S2/S3/S4), plus a quality verdict.
- **How to run:** set the input text, then run all cells top to bottom. Set a `seed`
  in `random_swap_columns` if you need the shuffle to be reproducible.

## 3. `DNA_sequencing_analyze_Illumina.ipynb`

Two independent pipelines; run the one matching your payload design.

**Short version**
- **Input:**  paired `*_R1_*.fastq` / `*_R2_*.fastq` files placed in `./Step1/` (created by the notebook).
- **Output:** per-position frequency CSVs in `./base_frequnceies/` and an IUPAC
  consensus checked against `ref` (prints `True` on an exact match).
- **How to run:** Run the cells below *Functions used for analysis* and  *Processing Illumina Fastq files, extracting payload sequence*. 
  once the folders (Step1 to Step8) are created, put FASTQ pairs in `./Step1/`, then run the following short-version cells in order 
  (Step 2 → Step 8 → consensus). Payload length is fixed at **376**; change it in the Step 8 and frequency cells if yours differs.

**Extended version**
- **Input:** paired `*_R1_*.fastq` / `*_R2_*.fastq` files placed beside the notebook.
- **Output:** `./pipeline_output/` containing per-index FASTAs and frequency tables,
  `pipeline_counts.csv`, `index_summary.csv`, `combined_consensus.csv` (checked
  against `ref_seq`), and `signature_classification.csv`.
- **How to run:** put the FASTQ pairs next to the notebook, then run the
  extended-version cells (`run_pipeline` → `build_combined_consensus` →
  `classify_payloads_by_signature`). Adjust `indices_to_concat`, `PATTERN`, and
  `SIGNATURES` to match your design.

## 4. `DNA_sequencing_analyze_Nanopore.ipynb`

- **Input:** `.fastq` / `.fastq.gz` reads in `<PROJECT_DIR>/data/`, plus the four
  reference amplicons `S1_Amplicon.fasta`…`S4_Amplicon.fasta` in the same folder.
- **Output:** written to `<PROJECT_DIR>/output/stacked_coverage_exclusive/` —
  per-reference coverage CSVs, merged per-sample stacked-coverage CSVs, stacked
  coverage plots (`.svg`), and `exclusive_assignment_summary_STRICT.csv`.
- **How to run:** set `PROJECT_DIR` in the first cell, place the FASTQ files and the
  four reference FASTAs in `data/`, then run all cells top to bottom. Each read is
  aligned to S1–S4 with `edlib` and exclusively assigned to its best match under the
  strict thresholds (`MIN_IDENTITY_STRICT`, `MAX_LEN_DIFF_STRICT`, and the ambiguity
  margins) — adjust those parameters at the top to tune assignment strictness.
- **Note:** The reference amplicons used in the manuscript could be found in the folder Reference_amplicons

## 5. `Subsampling_From_Sequencing_Results.ipynb`

**Short version**
- **Input:** a processed reads file (your Step 8 output), path set in `file`.
- **Output:** subsampled read files in `./short_subsampled_reads/` and per-position
  frequency CSVs in `./base_frequnceies/`.
- **How to run:** set `file` and the `number_of_reads` depths, then run the short-version cells.

**Extended version**
- **Input:** the per-index FASTAs (e.g. `S-mix-P1_AAAA_reads.fasta`, …) listed in
  `fasta_files`.
- **Output:** a combined payload file, 100 subsampled replicates in
  `./subsampled_reads/`, and per-index count tables (Excel) in `./frequency_table/`.
- **How to run:** list your FASTAs in `fasta_files`, set `number_of_reads`, then run
  the extended-version cells in order.
---

## Sequencing Data
All sequencing data in this manuscript were uploaded to the National Center for Biotechnology Information (NCBI). Please find detailed information in the Excel file `Raw_seq_data.xlxs`


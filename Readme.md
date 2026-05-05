# DNA CODEC: Compressed Obfuscated DNA Encoding in Cells for Secure In Vivo Data Storage

## Abstract

DNA represents a promising medium for data storage due to its exceptional density, long-term durability, and compatibility with biological systems. While in vivo storage offers exciting potential for distributed, self-replicating data embedded in living cells, current DNA data storage strategies are restricted to single-population systems, limiting storage capacity and increasing the risk of data corruption or unauthorized access. A next-generation platform must address not only density and stability but also replication fidelity, long-term maintainability, and—critically—security and access control. 

Herein, we introduce **DNA CODEC**, a multi-population in vivo DNA data storage platform that combines high-density encoding with cryptographic obfuscation, enabling secure and durable information storage across human cells. We developed a high-efficiency, information-dense DNA storage framework by adapting a 10-ary Huffman coding algorithm with degenerate bases to optimize sequence compressibility while maintaining decoding accuracy despite biological and technical noise. The data payloads are stably integrated into the human genome using CRISPR-based targeted insertion. 

To introduce security and obfuscate the true data, we engineer a heterogeneous population of cells comprising decoy clones containing structurally similar, non-informative masking sequences. This cellular-level obfuscation strategy mitigates the risk of unauthorized access by concealing the true payload within the genomic sequence landscape. Furthermore, we demonstrate that CODEC stably maintains genomic payloads across extended cell culture and propagation, with robustness against replication errors and population drift. By distributing information across distinct cell subpopulations and embedding cryptographic obfuscation at the genomic level, CODEC ensures both data fidelity and access control, establishing a scalable, robust, and secure framework for long-term DNA data storage within living biological systems.

---

## Repository Structure
### Python folder

* `DNA_Encode_Obfuscate_V1.ipynb`: Core pipeline for converting text data into degenerate DNA sequences using 10-ary Huffman encoding, splitting the payload to 2 single letter DNA sequence (P1/P2), generating obfuscating mask sequences based on P1/P2 (M1/M2), and performing QC steps for homopolymer and GC content evaluation.

* `DNA_Encode_Obfuscate_V2.ipynb`: Includes identical steps as V1, with per-position shuffling algorithm that generates S1–S4 from P1/P2/M1/M2 before the final QC step.

* `DNA_sequencing_analyze_Illumina.ipynb`: Pipeline for processing Illumina next-generation sequencing (NGS) data (paired-end), extracting payload sequences, classification of F1/F2/F3 fragment (for extended payload only), calculating per-position base frequencies for each complete fragment, and generating consensus sequence. 

* `DNA_sequencing_analyze_Nanopore.ipynb`: Pipeline for processing Nanopore data, performing sequence aligntment for partial reads, calculating per-position base frequencies, and generating consensus sequence.


### MATLAB folder
* `Fig5B_passagesratio`: Script for Figure 5B plot and related data.
* `Fig5C_passageserror`: Script for Figure 5C plot and related data.
* `Fig5D_subsampling`: Script for Figure 5D plot and related data.
* `Fig6D_passagesratio_extended`: Script for Figure 6D plot and related data.
* `Fig6E_passageserror_extended`: Script for Figure 6E plot and related data.
* `FigS23_subsampling_extended`: Script for Figure S23 plot and related data.

---

## Installation
This project requires a Python 3 environment (developed using Python 3.11.4) and MATLAB.

### Prerequisites
The core data encoding, obfuscation, and sequencing pipelines rely primarily on Python standard libraries (`csv`, `collections`, `itertools`, `re`, `pathlib`). You will also need the following external packages installed:

```bash
pip install numpy jupyterlab
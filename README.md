# GenoPredProtocols
Inhouse protocols and scripts for running GenoPred on TSD projects or other offline environments.

## GenoPred

GenoPred is a research programme based at King’s College London that focuses on key issues relating to the clinical utility of polygenic scores, investigating polygenic scoring research questions, and developing tools that implement current best practises.

For details on GenoPred, see its excellent [documantation](https://opain.github.io/GenoPred/index.html)

## Dependencies

In offline environments, the entirety of GenoPred, its reference data required by its Snakemake based workflows, and container (.sif) file must be downloaded and installed locally.
As of now copies exist in the following TSD project directories:

- `/ess/p697/data/durable/users/espehage/GenoPred`
- `/ess/p33/data/durable/users/espehage/GenoPred`

## MoBa

The directory "MoBa" contains scripts and protocols for running GenoPred on the Norwegian Mother, Father and Child Cohort Study (MoBa) data.
See README.md in the MoBa directory for details.

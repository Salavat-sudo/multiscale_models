# SPE10 Overview

This folder contains the data and configurations for running the SPE10 benchmark on various problem sizes and physics models organized into different directories. It includes XML configuration files for various problem levels and size categories, along with logs and common data files for fluid properties and grid parameters.

## Directory Structure

- **common/**: Contains the input files needed across simulations, including:
  - `.geos` files for porosity and permeability distributions
  - `.txt` files for fluid properties

- **multiphaseFlow/**: Contains XML configuration files for running the compositional flow model version for SPE10 at different fidelity levels (lvl0 to lvl5).
  - **logs**: Contains simulation logs for different machines.

    | **Level** | **XML Input**         | **Mesh Size** | **Number of cells** |
    |:----------|:----------------------|--------------:|--------------------:|
    |        0a | SPE10_fim_lvl0a.xml   |      30x55x21 |              34,650 |
    |        0b | SPE10_fim_lvl0b.xml   |      60x55x21 |              69,300 |
    |        0c | SPE10_fim_lvl0c.xml   |     60x110x21 |             138,600 |
    |        1a | SPE10_fim_lvl1a.xml   |     60x110x42 |             277,200 |
    |        1b | SPE10_fim_lvl1b.xml   |    120x110x42 |             544,400 |
    |        1c | SPE10_fim_lvl1c.xml   |    120x220x42 |           1,108,800 |
    |        2a | SPE10_fim_lvl2a.xml   |    120x220x85 |           2,244,000 |
    |        2b | SPE10_fim_lvl2b.xml   |    240x220x85 |           4,488,000 |
    |        2c | SPE10_fim_lvl2c.xml   |    240x440x85 |           8,976,000 |
    |        3a | SPE10_fim_lvl3a.xml   |   240x440x170 |          17,952,000 |
    |        3b | SPE10_fim_lvl3b.xml   |   480x440x170 |          35,904,000 |
    |        3c | SPE10_fim_lvl3c.xml   |   480x880x170 |          71,808,000 |
    |        4a | SPE10_fim_lvl4a.xml   |   480x880x340 |         143,616,000 |
    |        4b | SPE10_fim_lvl4b.xml   |   960x880x340 |         287,232,000 |
    |        4c | SPE10_fim_lvl4c.xml   |  960x1760x340 |         574,464,000 |
    |        5a | SPE10_fim_lvl5a.xml   |  960x1760x680 |       1,148,928,000 |

- **multiphasePoromechanics/**: - Contains XML configuration files for running the multiphase poromechanics model version for SPE10 at different fidelity levels (lvl0 to lvl4). Rock properties are heterogeneous, except for the XML filenames containing `homog`, which indicate homogeneous rock properties.
  - **logs**: Contains simulation logs for different machines.

    | **Level** | **XML Input**                     | **Mesh Size** | **Number of cells** | **Number of nodes** |
    |:----------|:----------------------------------|--------------:|--------------------:|--------------------:|
    |        0a | SPE10_with_burdens_fim_lvl0a.xml  |      30x55x63 |             103,950 |             111,104 |
    |        0b | SPE10_with_burdens_fim_lvl0b.xml  |      60x55x63 |             207,900 |             218,624 |
    |        0c | SPE10_with_burdens_fim_lvl0c.xml  |     60x110x63 |             415,800 |             433,344 |
    |        1a | SPE10_with_burdens_fim_lvl1a.xml  |    60x110x126 |             831,600 |             859,917 |
    |        1b | SPE10_with_burdens_fim_lvl1b.xml  |   120x110x126 |           1,663,200 |           1,705,737 |
    |        1c | SPE10_with_burdens_fim_lvl1c.xml  |   120x220x126 |           3,326,400 |           3,396,107 |
    |        2a | SPE10_with_burdens_fim_lvl2a.xml  |   120x220x255 |           6,732,000 |           6,845,696 |
    |        2b | SPE10_with_burdens_fim_lvl2b.xml  |   240x220x255 |          13,464,000 |          13,634,816 |
    |        2c | SPE10_with_burdens_fim_lvl2c.xml  |   240x440x255 |          26,928,000 |          27,207,936 |
    |        3a | SPE10_with_burdens_fim_lvl3a.xml  |   240x440x510 |          53,856,000 |          54,309,591 |
    |        3b | SPE10_with_burdens_fim_lvl3b.xml  |   480x440x510 |         107,712,000 |         108,393,831 |
    |        3c | SPE10_with_burdens_fim_lvl3c.xml  |   480x880x510 |         215,424,000 |         216,541,871 |
    |        4a | SPE10_with_burdens_fim_lvl4a.xml  |  480x880x1020 |         430,848,000 |         432,659,981 |
    |        4b | SPE10_with_burdens_fim_lvl4b.xml  |  960x880x1020 |         861,696,000 |         864,420,461 |
    |        4c | SPE10_with_burdens_fim_lvl4c.xml  | 960x1760x1020 |       1,723,392,000 |       1,727,859,741 |

## Notes

- Logs contain output information and are organized by machine and node counts for reproducibility and performance benchmarking.
- For additional information about the configurations and usage, refer to specific `.yml` files.

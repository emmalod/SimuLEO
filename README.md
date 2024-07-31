<!---<img align="right" title="SimuLEO_logo" width="260" src="SimuLOGO_noback.png">--->
<img align="center" title="SimuLEO_cover" src="SimuLEO_cover.png">

**SimuLEO - Low Earth Orbit Satellites Simulator** is a tool for designing Low Earth Orbit satellite constellations and analyzing their behavior in the real world.

# Our tool

**SimuLEO** is an innovative tool designed to simulate Low Earth Orbit (LEO) satellite orbits, offering a robust foundation for future positioning studies. This tool introduces a new approach, focusing on Low Earth Orbit satellites to create fresh research opportunities in LEO-based positioning.

SimuLEO is composed of a user-friendly dashboard developed in Python (Jupyter Lab), which allows users to design satellite constellations by specifying the number of satellite orbits, the number of satellites per orbit, and the inclination of orbital planes. The tool graphically represents the ground tracks of the desired constellations.

The core computational work is handled by a group of functions written in Octave, responsible for accurately calculating satellite positions in the International Terrestrial Reference Frame (ITRF).
Additionally, SimuLEO includes functionality for satellite visibility analysis. This feature transforms satellite coordinates into local coordinates, enabling users to determine the visibility periods of specific satellites from any given location on Earth's surface throughout the day.

By combining these features, SimuLEO offers a complete platform for simulating and analyzing LEO satellite constellations and orbits, supporting and advancing research in satellite-based positioning systems. This tool could play a crucial role in developing new methods and applications within the field of satellite navigation and positioning.

# Getting started

To run SimuLEO locally, Python, version 3.11.5, and GNU Octave, version 9.1.0 are needed. We suggest to use Anaconda and open a new environment.
The application requires the following libraries:

     ipython==8.20.0
     ipywidgets==8.1.2
     matplotlib==3.8.4
     numpy==1.26.4
     oct2py==5.6.1
     pandas==2.2.1
     plotly==5.19.0
     tk==8.6.12

'requirement.txt' file can be used to install those libraries:

```bash
conda install --yes --file requirements.txt
```

The tool consists of a Jupyter dashboard, that can be run in an Anaconda environment.

# How it works

The SimuLEO dashboard is split into several sections, each offering different functions for analyzing various aspects of the designed constellation.
- **Constellation creation:** the user designs its constellation of satellites, by entering the number of orbital planes of the constellation, the number of satellites per orbital plane, and the inclination of the orbital planes with respect to the reference equatorial plane.
- **Ground tracks plot:** the user can plot the constellation groundntracks both in 2D and 3D plots.
- **PDOP computation:** the user can compute the PDOP index with respect to a chosen position and time of the day.
- **Satellites Visibility Chart:** the user can analyze the designed constellation's coverage through the visibility table's usage.

These different tasks can be accomplished in sequence, or independently. Indeed, in each step, the user will be prompted to select a constellation from the saved designs to perform the chosen task.

# Our repository

In the repository can be found the following files:
- **SimuLEO.ipynb:** The Jupyter Dashboard of the project.
- **OCTAVE:** the folder that contains all the Octave code needed to perform the computations
- **requirements.txt:** txt file to install the libraries
- **Almanacs030480, SatellitePositions030480, InViewMask030480:** an example of constellation produced by the tool

# The project

SimuLEO is a project developed by Emma Lodetti and Angelica Iseni, two final-year students from the Geoinformatics Engineering at Politecnico di Milano. This project was supervised by Professor Ludovico G. A. Biagi in the field of Positioning and Location Based Services.

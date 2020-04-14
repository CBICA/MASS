
  Section of Biomedical Image Analysis
  Department of Radiology
  University of Pennsylvania
  3600 Market Street, Suite 380
  Philadelphia, PA 19104

  Web:   http://www.cbica.upenn.edu/sbia/
  Email: sbia-software at uphs.upenn.edu

  Copyright (c) 2011-2014 University of Pennsylvania. All rights reserved.
  See http://www.cbica.upenn.edu/sbia/software/license.html or COPYING file.



INTRODUCTION
============

  The Multi Atlas Skull-Stripping (MASS) is brain extraction algorithm based
  on a multiple-atlas registration framework which provides a robust and 
  accurate brain extraction tool applicable for both small and 
  large population studies.


PACKAGE OVERVIEW
================

  Source Package
  --------------

  - CTestConfig.cmake		Dashboard configuration file.
  - CMakeLists.txt       	Root CMake configuration file.

  - config/              	Package configuration files.
  - data/                	Contains the template images.
  - doc/                 	Software documentation such as the software manual.
  - src/                 	Source code files.
  - test/			Software build testing files.

  - MASS_Software_Manual.pdf	Software manual in pdf format.
  - AUTHORS.txt			List of authors, advisors, contributors and testers.
  - COPYING.txt          	The copyright and license notices.
  - README.txt           	This readme file.
  - INSTALL.txt		 	The installation instructions for the software package.
  - ChangeLog.txt		Software change log history.


  Binary Package
  --------------

  Please refer to the INSTALL file for details on where the built executables
  and libraries, the auxiliary data, and the documentation files are installed.



LICENSING
=========

  See http://www.cbica.upenn.edu/sbia/software/license.html or COPYING file.



INSTALLATION
============

  See build and installation instructions given in the INSTALL file.



DOCUMENTATION
=============

  See the software manual for details on the software including a demonstration
  of how to apply the software tools provided by this package.



REFERENCES
==========

  [1] Jimit Doshi, Guray Erus, Yangming Ou, Bilwaj Gaonkar, Christos Davatzikos.
      Multi-Atlas Skull-Stripping, MASS.
      Academic radiology 20 (12), 1566-1576

  [2] Yangming Ou, Aristeidis Sotiras, Nikos Paragios, Christos Davatzikos.
      DRAMMS: Deformable registration via attribute matching and mutual-saliency weighting.
      Medical Image Analysis 15(4): 622-639 (2011).

  [3] Yangming Ou, Christos Davatzikos.
      DRAMMS: Deformable Registration via Attribute Matching and Mutual-Saliency Weighting.
      IPMI 2009: 50-62.

  [4] Yangming Ou, Dong Hye Ye, Kilian M. Pohl, Christos Davatzikos.
      Validation of DRAMMS among 12 Popular Methods in Cross-Subject Cardiac MRI Registration.
      WBIR 2012: 209-219.

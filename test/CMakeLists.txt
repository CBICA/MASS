##############################################################################
# @file  CMakeLists.txt
# @brief Build configuration of software testing.
#
# Unit tests test only single functions, classes, and modules of the software.
# System tests, on the other side, execute the programs of this package with
# given test input data and compare the output of the programs to the expected
# results. For the definition of system tests which perform image regression
# tests, i.e., compare the images written by the test to given baseline images,
# the basis.testdriver executable target imported from BASIS can be used to
# execute the executable to test and perform the regression tests.
#
# Example:
# @code
# add_test (
#  COMMAND basis.testdriver -v
#    --intensity-tolerance 2
#    --compare "t1_bc.nii.gz"
#              "${PROJECT_TESTING_DIR}/baseline/t1_bc.nii.gz"
#    --
#    $<TARGET_FILE:biascorrect>
#      "${PROJECT_TESTING_DIR}/input/t1.nii.gz"
#      t1_bc.nii.gz
# )
# @endcode
#
# If the tests are implemented in C/C++ as supported by CMake's
# create_test_sourcelist() function, a custom test driver can be generated
# using the add_test_driver() function and this test driver then be used
# to execute the tests and perform the regression tests.
#
# Example:
# @code
# basis_add_test_driver (testdriver test1.cxx test2.cxx test3.cxx)
#
# basis_add_test (
#   COMMAND testdriver -v
#     --intensity-tolerance 2
#     --compare "t1_bc.nii.gz"
#               "${PROJECT_TESTING_DIR}/baseline/t1_bc.nii.gz"
#     --
#     biascorrect # test1.cxx defines int biascorrect(int argc, char* argv[])
#      "${PROJECT_TESTING_DIR}/input/t1.nii.gz"
#      t1_bc.nii.gz
# )
#
# # ...
# @endcode
#
# @sa http://www.cmake.org/cmake/help/cmake-2-8-docs.html#command:create_test_sourcelist
#
# The built test executables can be found in @c TESTING_RUNTIME_DIR.
# The test output shall be written to @c TESTING_OUTPUT_DIR. In most cases,
# a subdirectory for each test should be created under this output directory.
# Therefore, the basis_add_test() function creates such subdirectory and sets
# the working directory of the test to this output directory.
#
# Copyright (c) 2011-2014 University of Pennsylvania. All rights reserved.<br />
# See http://www.cbica.upenn.edu/sbia/software/license.html or COPYING file.
#
# Contact: SBIA Group <sbia-software at uphs.upenn.edu>
##############################################################################

# ============================================================================
# internal tests
# ============================================================================

# Define directories
if (IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/internal")
  add_subdirectory ("internal")
endif ()

#set (INPUT_DIR    "${CMAKE_CURRENT_SOURCE_DIR}/input")
set (BASELINE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/baseline")

# Get the number of processors
if(NOT DEFINED PROCESSOR_COUNT)
	# Unknown:
	set(PROCESSOR_COUNT 0)

	# Linux:
	set(cpuinfo_file "/proc/cpuinfo")
	if(EXISTS "${cpuinfo_file}")
		file(STRINGS "${cpuinfo_file}" procs REGEX "^processor.: [0-9]+$")
		list(LENGTH procs PROCESSOR_COUNT)
	endif()
endif()
# message (STATUS "Number of CPU(s) detected: ${PROCESSOR_COUNT}")

# Configure some input text files for the test
configure_file(${BASELINE_DIR}/FileList.txt.in ${TESTING_OUTPUT_DIR}/mass_chooseTemplates_test/FileList.txt @ONLY)
configure_file(${BASELINE_DIR}/ChosenTemplates.txt.in ${TESTING_OUTPUT_DIR}/mass_chooseTemplates_test/ChosenTemplates_baseline.txt @ONLY)

# ============================================================================
# public tests
# ============================================================================

# mass_fillholes_test
basis_add_test(
  mass_fillholes_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_fillholes_test/TestCase1_444_byte_brainmask_holes_filled.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brainmask_holes_filled.nii.gz"
      --
      $<TARGET_FILE:mass-fillHoles> 
      	-in ${BASELINE_DIR}/TestCase1_444_byte_brainmask_holes.nii.gz 
      	-dest ${TESTING_OUTPUT_DIR}/mass_fillholes_test/
      	-v
)

basis_set_tests_properties(
  mass_fillholes_test
  PROPERTIES
    LABELS mass
)

# mass_morphodilate_test
basis_add_test(
  mass_morpho-dilate_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_morpho-dilate_test/TestCase1_444_byte_brainmask_dil2mm.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brainmask_dil2mm.nii.gz"
      --
      $<TARGET_FILE:mass-morpho> 
      	-in ${BASELINE_DIR}/TestCase1_444_byte_brainmask.nii.gz 
      	-dilate 
      	-dest ${TESTING_OUTPUT_DIR}/mass_morpho-dilate_test/
      	-kernel 2 
      	-v
)

basis_set_tests_properties(
  mass_morpho-dilate_test
  PROPERTIES
    LABELS mass
)

# mass_morphoerode_test
basis_add_test(
  mass_morpho-erode_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_morpho-erode_test/TestCase1_444_byte_brainmask_ero2mm.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brainmask_ero2mm.nii.gz"
      --
      $<TARGET_FILE:mass-morpho> 
      	-in ${BASELINE_DIR}/TestCase1_444_byte_brainmask.nii.gz 
      	-erode 
      	-dest ${TESTING_OUTPUT_DIR}/mass_morpho-erode_test/
      	-kernel 2 
      	-v
)

basis_set_tests_properties(
  mass_morpho-erode_test
  PROPERTIES
    LABELS mass
)

# mass_chooseTemplates_test
basis_add_test(
  mass_chooseTemplates_test
  COMMAND
    basis.testdriver
      --diff "${TESTING_OUTPUT_DIR}/mass_chooseTemplates_test/ChosenTemplates.txt"
                "${TESTING_OUTPUT_DIR}/mass_chooseTemplates_test/ChosenTemplates_baseline.txt"
      --
      $<TARGET_FILE:mass-chooseTemplates> 
        -list ${TESTING_OUTPUT_DIR}/mass_chooseTemplates_test/FileList.txt 
        -clust 1 
        -dest ${TESTING_OUTPUT_DIR}/mass_chooseTemplates_test/
        -pref ChosenTemplates.txt 
        -MT ${PROCESSOR_COUNT}
        -v
)

basis_set_tests_properties(
  mass_chooseTemplates_test
  PROPERTIES
    LABELS mass
)

# mass_registrations_test
basis_add_test(
  mass_registrations_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_registrations_test/TestCase1_444_byte-Template1_mask_InSpace.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte-Template1_mask_InSpace.nii.gz"
      --compare "${TESTING_OUTPUT_DIR}/mass_registrations_test/TestCase1_444_byte-Template1_affine_warp_jacobian.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte-Template1_affine_warp_jacobian.nii.gz"
      --
      $<TARGET_FILE:mass-registrations>
        -in ${BASELINE_DIR}/TestCase1_444_byte.nii.gz 
        -ref ${PROJECT_DATA_DIR}/Templates/WithCerebellum/Template1.nii.gz 
        -str ${PROJECT_DATA_DIR}/Templates/WithCerebellum/Template1_str_cbq.nii.gz 
        -dest ${TESTING_OUTPUT_DIR}/mass_registrations_test/
        -v 1
)

basis_set_tests_properties(
  mass_registrations_test
  PROPERTIES
    LABELS mass
)

# mass_skullstripping_test
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template1_affine_warp_jacobian.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template1_mask.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template1_mask_InSpace.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template2_affine_warp_jacobian.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template2_mask.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template2_mask_InSpace.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template3_affine_warp_jacobian.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template3_mask.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)
file (COPY ${BASELINE_DIR}/TestCase1_444_byte-Template3_mask_InSpace.nii.gz DESTINATION ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/)

basis_add_test(
  mass_skullstripping_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_skullstripping_test/TestCase1_444_byte_brain.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brain.nii.gz"
      --compare "${TESTING_OUTPUT_DIR}/mass_skullstripping_test/TestCase1_444_byte_brainmask.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brainmask.nii.gz"
      --compare "${TESTING_OUTPUT_DIR}/mass_skullstripping_test/TestCase1_444_byte_brain_JacRank.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brain_JacRank.nii.gz"
      --
      $<TARGET_FILE:mass-skullstripping> 
        -in ${BASELINE_DIR}/TestCase1_444_byte.nii.gz 
        -dest ${TESTING_OUTPUT_DIR}/mass_skullstripping_test/ 
        -mask TestCase1_444_byte_brainmask
        -cbq TestCase1_444_byte_brain
        -regs 3 
        -int 1 
        -jacRank 1 
        -v 1
)

basis_set_tests_properties(
  mass_skullstripping_test
  PROPERTIES
    LABELS mass
)

# mass_thresholdJacobian_test
basis_add_test(
  mass_thresholdJacobian_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_thresholdJacobian_test/TestCase1_444_byte_mask.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_mask.nii.gz"
      --
      $<TARGET_FILE:mass-thresholdJacobian> 
        -in ${BASELINE_DIR}/TestCase1_444_byte.nii.gz 
        -jacRank ${BASELINE_DIR}/TestCase1_444_byte_brain_JacRank.nii.gz 
        -dest ${TESTING_OUTPUT_DIR}/mass_thresholdJacobian_test/
        -perThresh 70 
        -v
)

basis_set_tests_properties(
  mass_thresholdJacobian_test
  PROPERTIES
    LABELS mass
)

# mass_system_test
basis_add_test(
  mass_system_test
  COMMAND
    basis.testdriver
      --intensity-tolerance 0.01
      --compare "${TESTING_OUTPUT_DIR}/mass_system_test/TestCase1_444_byte_brain.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brain.nii.gz"
      --compare "${TESTING_OUTPUT_DIR}/mass_system_test/TestCase1_444_byte_brainmask.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brainmask.nii.gz"
      --compare "${TESTING_OUTPUT_DIR}/mass_system_test/TestCase1_444_byte_brain_JacRank.nii.gz"
                "${BASELINE_DIR}/TestCase1_444_byte_brain_JacRank.nii.gz"
      --
      $<TARGET_FILE:mass> 
        -in ${BASELINE_DIR}/TestCase1_444_byte.nii.gz 
        -dest ${TESTING_OUTPUT_DIR}/mass_system_test/
        -regs 3
        -NOQ
        -MT ${PROCESSOR_COUNT}
        -log ${TESTING_OUTPUT_DIR}/mass_system_test/
        -delay 1
        -int 1
        -v
)

basis_set_tests_properties(
  mass_system_test
  PROPERTIES
    LABELS mass
)

# mass_scheduler_test
if (DEFINED SCHEDULER_SETTING_FILE)
	basis_add_test(
	  mass_scheduler_test
	  COMMAND
	      $<TARGET_FILE:mass> 
		-in ${BASELINE_DIR}/TestCase1_444_byte.nii.gz 
		-dest ${TESTING_OUTPUT_DIR}/mass_scheduler_test/
		-regs 3
		-log ${TESTING_OUTPUT_DIR}/mass_scheduler_test/
		-delay 1
		-v
	)

	basis_set_tests_properties(
	  mass_scheduler_test
	  PROPERTIES
	    LABELS mass
	)
endif()

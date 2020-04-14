##############################################################################
# @file  CMakeLists.txt
# @brief Build configuration of software.
#
# Copyright (c) 2011-2014 University of Pennsylvania. All rights reserved.<br />
# See http://www.cbica.upenn.edu/sbia/software/license.html or COPYING file.
#
# Contact: SBIA Group <sbia-software at uphs.upenn.edu>
##############################################################################

# ============================================================================
# library target(s)
# ============================================================================

# Add library target for each library using basis_add_library().
#
# This command can not only be used to build libraries from C/C++, but also source
# code written in other programming languages such as Java, Python, Perl,
# MATLAB, and Bash. Note that here we consider modules written in a scripting
# language which are no executables but to be included by other scripts written
# in the particular language as libraries.
#
# Note: Public modules written in a scripting language such as Python, Perl,
#       MATLAB, or Bash which are intended for use by other packages should
#       be placed in the lib/[<lang>/]MASS/ directory,
#       where <lang> is the language name in lowercase and is optional.
#       BASIS will automatically add a library build target for these modules.



# ============================================================================
# executable target(s)
# ============================================================================

# Add executable target for each executable program using basis_add_executable().
#
# This command can not only be used to build executables from C/C++, but also
# source code written in other programming languages such as Java, Python, Perl,
# MATLAB, and Bash.


#basis_add_executable (mass.sh NO_BASIS_UTILITIES)
configure_file( mass.sh.in ${CMAKE_BINARY_DIR}/src/mass.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION bin 
	RENAME mass )

#basis_add_executable (mass-chooseTemplates.sh NO_BASIS_UTILITIES)
configure_file( mass-chooseTemplates.sh.in ${CMAKE_BINARY_DIR}/src/mass-chooseTemplates.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-chooseTemplates.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION bin 
	RENAME mass-chooseTemplates )

#basis_add_executable (mass-thresholdJacobian.sh NO_BASIS_UTILITIES)
configure_file( mass-thresholdJacobian.sh.in ${CMAKE_BINARY_DIR}/src/mass-thresholdJacobian.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-thresholdJacobian.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION bin 
	RENAME mass-thresholdJacobian )

#basis_add_executable (mass-fillHoles.sh LIBEXEC NO_BASIS_UTILITIES)
configure_file( mass-fillHoles.sh.in ${CMAKE_BINARY_DIR}/src/mass-fillHoles.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-fillHoles.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION lib 
	RENAME mass-fillHoles )
#basis_add_executable (mass-morpho.sh LIBEXEC NO_BASIS_UTILITIES)
configure_file( mass-morpho.sh.in ${CMAKE_BINARY_DIR}/src/mass-morpho.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-morpho.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION lib 
	RENAME mass-morpho )
#basis_add_executable (mass-registrations.sh LIBEXEC NO_BASIS_UTILITIES)
configure_file( mass-registrations.sh.in ${CMAKE_BINARY_DIR}/src/mass-registrations.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-registrations.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION lib 
	RENAME mass-registrations )
#basis_add_executable (mass-skullstripping.sh LIBEXEC NO_BASIS_UTILITIES)
configure_file( mass-skullstripping.sh.in ${CMAKE_BINARY_DIR}/src/mass-skullstripping.sh.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-skullstripping.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION lib 
	RENAME mass-skullstripping )
#basis_add_executable (mass-choosetemplate.py LIBEXEC NO_BASIS_UTILITIES)
configure_file( mass-choosetemplate.py.in ${CMAKE_BINARY_DIR}/src/mass-choosetemplate.py.in @ONLY )
install( FILES ${CMAKE_BINARY_DIR}/src/mass-choosetemplate.py.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION lib 
	RENAME mass-choosetemplate )

#basis_add_library (massUtilities mass-functions.sh)
#add_library( massUtilities mass-functions.sh )

#install( TARGETS massUtilities
#    	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
#    	DESTINATION lib )
install( FILES mass-functions.sh.in 
	PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ 
	DESTINATION ${BASH_LIBRARY_DIR} 
	RENAME mass-functions.sh )


if(SCHEDULER)
	add_subdirectory(schedulerSettings)
endif()


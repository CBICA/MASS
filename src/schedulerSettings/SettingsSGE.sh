#!/bin/bash

setSubmitCMD()
{
	# Getting the arguments 
	_memory=$1
	shift
	_holdids="$*"
	
	# Getting the options for SGE scheduler into variables
	# This is done so that the user can adapt these options to match them with his own scheduler
	_OptExec="qsub"							# Executable name for job scheduler
	_OptPriority="-p"						# Option for setting priority
	_OptMemory="-l h_vmem=${_memory}G"				# String for requesting memory
	_OptTerse="-terse"						# Option for requesting output of a job id only
	_OptJoin="-j y"							# String for joining the output files
	_OptOutput="-o ${log}\$JOB_NAME-\$JOB_ID.log"			# String for specifying output filename
	_OptHoldID="-hold_jid"						# String for requesting a job dependency
	
	
	# Setting up the basic command and then the other options will be added onto it
	submitCMD="${_OptExec} ${_OptTerse} ${_OptJoin} ${_OptOutput} ${_OptMemory}"
	
	
	# check if priority variable
	if [ -n "${priority}" ]
	then 
		submitCMD="${submitCMD} ${_OptPriority} ${priority}";
	fi

	# check if the user provided a hold jobid
	# Modify this part of the code depending on how the job ids need to be appended
	if [ -n "${_holdids}" ]
	then 
		for _id in ${_holdids}
		do
			submitCMD="${submitCMD} ${_OptHoldID} ${_id}"
		done
	fi

	echo $submitCMD
}

setDeleteJob()
{
	# Getting the job IDs
	_jobid="$*"
	
	# Getting the options for SGE scheduler into variables
	# This is done so that the user can adapt these options to match them with his own scheduler
	_OptJobDeleteExec="qdel"					# Executable name for deleting jobs
	
	echo ${_OptJobDeleteExec}
}

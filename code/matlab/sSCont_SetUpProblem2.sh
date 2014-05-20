#!/bin/sh
# Start many worker threads, each of which will save output to a separate file
# in a directory specified within sSCont_SetUpProblem2.m
for n in {1001..10000}
do
	# Add a job, which is to run sSCont_SetUpProblem2.nbs, to the long NBS queue.
	# The flags at the end tell it to only send email if there is a failure.
	jsub "sSCont_SetUpProblem2.nbs $n" -mail nostart end -mfail
done

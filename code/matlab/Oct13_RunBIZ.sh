#!/bin/sh
# Run Oct13_RunBIZ.nbs, which runs BIZ at the specified number of alternatives
# and starting seed, for all starting seeds in a specified range, and a fixed
# value of k.
for n in {101..300}
do
	# Add a job, which is to run Oct13_RunBIZ.nbs, to the long NBS queue.
	# The flags at the end tell it to only send email if there is a failure.
	# The first argument is the problem, e.g., sSCont or SC
	# The second argument is k.  The third argument is the seed.
	#jsub "Oct13_RunBIZ.nbs sSCont 2 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 5 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 10 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 25 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 50 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 100 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 250 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 500 $n" -mail nostart end -mfail
	#jsub "Oct13_RunBIZ.nbs sSCont 1000 $n" -mail nostart end -mfail
	jsub "Oct13_RunBIZ.nbs sSCont 2500 $n" -mail nostart end -mfail
	jsub "Oct13_RunBIZ.nbs sSCont 5000 $n" -mail nostart end -mfail
	jsub "Oct13_RunBIZ.nbs sSCont 10000 $n" -mail nostart end -mfail
done

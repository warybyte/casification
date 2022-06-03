#!/bin/bash
# Script auto-generates data for CAS JSON service profiles.
# UUID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx format
# ServiceID: aaaabbbbaaaabbbb
# EvalOrder: abab
#
# Auto-check existing profiles for duplication. If a match is identified, the generator for
# that value reruns until it pulls a unique value.
#
# Instructions:
# ./uuid_gen.sh <profilename>
#
# generate a random UUID value for CAS service profiles
casroot="etc/cas/"
# UUID variables, split into five groups then combined
val0=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 8 | head -1 | tr [:upper:] [:lower:]);
val1=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 4 | head -1 | tr [:upper:] [:lower:]);
val2=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1);
val3=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1);
val4=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 12 | head -1 | tr [:upper:] [:lower:]);
uuid="$val0-$val1-$val2-$val3-$val4";

serviceid=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 16 | head -1);
evalorder=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1);

# set and check UUID
grep -r "$uuid" $casroot 2>/dev/null;
valuecheck=$?;
while [ $valuecheck -eq 0 ]
do
	echo "Recaculating UUID";
	val4=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 12 | head -1 | tr [:upper:] [:lower:]);
	uuid="$val0-$val1-$val2-$val3-$val4";
	grep -r "$uuid" $casroot 2>/dev/null;
        valuecheck=$?;
done

# set and check ServiceID
grep -r "$serviceid" $casroot 2>/dev/null;
valuecheck=$?;
while [ $valuecheck -eq 0 ]
do
        echo "Recaculating ServiceID";
        serviceid=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 16 | head -1)
        grep -r "$serviceid" $casroot 2>/dev/null;
        valuecheck=$?;
done

#set and check EvaluationOrder
grep -r "\"evaluationOrder\": $evalorder" $casroot 2>/dev/null;
valuecheck=$?;
while [ $valuecheck -eq 0 ]
do
        echo "Recaculating EvaluationOrder";
        evalorder=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1)
        grep -r "\"evaluationOrder\": $evalorder" $casroot 2>/dev/null;
        valuecheck=$?;
done

# Print results
echo "UUID: $uuid";
echo "EvaluationOrder: $evalorder";
echo "ServiceID: $serviceid";
echo "FileName: $1_$evalorder-$serviceid.json";

#!/bin/bash
# I wrote this script because I hate guessing random values...and CAS service profiles want SEVERAL!
# Key features:
# xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx format UUID...this is standard in my environment, so YMMV
# 16 char ServiceID...because we wouldn't want any confused services!
# 4 char eval order...you probably want less in your env...I hope...
# Auto-check existing profiles for duplication...no more grepping! Only errors on matches.

# build UUID
uval0=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 8 | head -1 | tr [:upper:] [:lower:])
uval1=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 4 | head -1 | tr [:upper:] [:lower:])
uval2=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1)
uval3=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1)
uval4=$(cat /dev/urandom | tr -dc [:alnum:] | fold -w 12 | head -1 | tr [:upper:] [:lower:])
uuid="$uval0-$uval1-$uval2-$uval3-$uval4"

# set the other vars
serviceid=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 16 | head -1)
evalorder=$(cat /dev/urandom | tr -dc [:digit:] | fold -w 4 | head -1)

# output
echo "UUID: $uuid";
echo "ServiceID: $serviceid";
# check for dups
grep -r "$uuid\|$serviceid" /etc/cas/ 2>/dev/null;

echo "EvaluationOrder: $evalorder";
# check for dups
grep -r "\"evaluationOrder\": $evalorder" 2>/dev/null;

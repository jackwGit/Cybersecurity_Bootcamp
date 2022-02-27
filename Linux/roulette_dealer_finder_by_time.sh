#!/bin/bash

FNAME="$1_Dealer_schedule"

grep "$2" $FNAME | awk -F"\t" '{print $1, $3}'

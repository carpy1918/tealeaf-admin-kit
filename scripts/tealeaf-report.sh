#!/bin/bash

#
#tealeaf config report
#

log="/tmp/tealeaf.log"
report="/tmp/tealeaf-report-$(date +%m%d%Y)-`hostname`.report"
reportperm="/tmp/tealeaf-report-perm-$(date +%m%d%Y)-`hostname`.report"
date=$(date +%m%d%Y)

echo "" > $report

for i in `cat $log | grep $date | awk '{print $3}' | sort | uniq | grep ":"`;do
  echo "$i" >> $report
  `grep $i $log | grep $date | sort | uniq > /tmp/results.txt`
  while read line;do
    echo "$line" >> $report
  done < /tmp/results.txt
  echo "" >> $report
done

echo "DISK WARNINGS and ALERTS: " >> $report
for i in `egrep "DISK WARNING|DISK ALERT" /tmp/tealeaf-disk.log`;do
  echo "$i" >> $report
done

echo ""
echo "SWAP WARNINGS and ALERTS: " >> $report
for i in `egrep "SWAP WARNING|DISK ALERT" /tmp/tealeaf-disk.log`;do
  echo "$i" >> $report
done

echo 'Tealeaf Ownership Permissions Scan' > $reportperm
echo '' > $reportperm
grep 'OWNERSHIP-PERM-SCAN:' $log | grep $(date +%m%d%Y) | sort | uniq  >> $reportperm


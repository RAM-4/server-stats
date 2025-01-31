#!/bin/bash

cpu_usage=$(top -l 1 -s 0 | grep "CPU usage")
cpu_processes=$(ps aux | sort -nrk 3,3 | head -n 6 | awk '{print $2, $11, $3"%"}')
memory_usage=$(top -l 1 -s 0 -o MEM | tail -n 5 | awk '{printf "%s %s %8.1fMB\n", $1, $2, $8/1024}')
total_disk_usage=$(df -h | grep "/" -w | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}')

format_columns() {
    while read -r line; do
        echo "- $line"
    done | column -t
}

echo -e "$(tput sgr 0 1)\n💡 \033[1m$cpu_usage\033[0m"
echo "$cpu_processes" | format_columns
echo -e "$(tput sgr 0 1)\n🛠️  \033[1m$(top -l 1 | grep "PhysMem")\033[0m"
echo "$memory_usage" | format_columns
echo -e "$(tput sgr 0 1)\n💽 \033[1mTotal Disk Usage\033[0m"
echo "$total_disk_usage"

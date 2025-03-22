# vm_health_check.sh
Explanation:
Threshold Definition:

The script sets a threshold value of 60% for CPU, memory, and disk usage. If any of these resources exceed this threshold, the VM health is considered "NOT OK".
CPU Usage Check:

The script uses the top command to get the CPU usage. It filters the idle CPU percentage, converts it to used CPU percentage, and compares it with the threshold.
Memory Usage Check:

The script uses the free command to get the memory usage. It calculates the percentage of used memory and compares it with the threshold.
Disk Usage Check:

The script uses the df command to get the disk usage of the root filesystem. It extracts the percentage of used disk space and compares it with the threshold.
Health Status Determination:

The script checks the status of each resource (CPU, memory, and disk). If all resources are below the threshold, the VM health is "OK". If any resource exceeds the threshold, the VM health is "NOT OK".

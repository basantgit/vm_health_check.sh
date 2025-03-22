#!/bin/bash

# Threshold for determining the health of the VM
THRESHOLD=60

# Function to check CPU usage
check_cpu_usage() {
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  echo "CPU Usage: $CPU_USAGE%"
  if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    echo "CPU usage is above $THRESHOLD%. VM health is NOT OK."
    return 1
  fi
  return 0
}

# Function to check memory usage
check_memory_usage() {
  MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  echo "Memory Usage: $MEMORY_USAGE%"
  if (( $(echo "$MEMORY_USAGE > $THRESHOLD" | bc -l) )); then
    echo "Memory usage is above $THRESHOLD%. VM health is NOT OK."
    return 1
  fi
  return 0
}

# Function to check disk usage
check_disk_usage() {
  DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
  echo "Disk Usage: $DISK_USAGE%"
  if (( DISK_USAGE > THRESHOLD )); then
    echo "Disk usage is above $THRESHOLD%. VM health is NOT OK."
    return 1
  fi
  return 0
}

# Check CPU, memory, and disk usage
check_cpu_usage
CPU_STATUS=$?
check_memory_usage
MEMORY_STATUS=$?
check_disk_usage
DISK_STATUS=$?

# Determine overall VM health
if [ $CPU_STATUS -eq 0 ] && [ $MEMORY_STATUS -eq 0 ] && [ $DISK_STATUS -eq 0 ]; then
  echo "VM health is OK."
else
  echo "VM health is NOT OK."
fi

#!/bin/bash

# System Cleaner Script with Aesthetic Colors & ASCII Progress

set -e  # Exit if a command fails

echo -e "\n\e[1;35m🚀 Starting System Cleanup...\e[0m\n"
start_time=$(date +%s)

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\n\e[1;91m[❌ ERROR] This script must be run as root! Use sudo.\e[0m\n"
    exit 1
fi

# Capture memory & disk status before cleanup
before_cleanup_mem=$(free -h | awk 'NR==2{print $2, $3, $4, $5, $6, $7}')
before_cleanup_disk=$(df -B1 / | awk 'NR==2 {print $4}')

default_response="Y"

# Function to show progress with an ASCII animation
show_progress() {
    echo -ne "\e[1;36m➤ $1... \e[0m"
    for i in {1..5}; do 
        echo -ne "\e[1;94m█\e[0m"; sleep 0.3;
    done
    echo -e " \e[1;92m✅ Done.\e[0m"
}

# Function to perform cleanup
perform_cleanup() {
    show_progress "🧹 Cleaning package cache"
    apt autoremove -y && apt autoclean -y && apt clean -y

    show_progress "🗑️ Removing old kernels"
    dpkg --list | awk '/^rc/ { print $2 }' | xargs -r dpkg --purge

    show_progress "📂 Clearing thumbnail cache"
    rm -rf ~/.cache/thumbnails/*

    show_progress "📜 Clearing system logs"
    journalctl --vacuum-size=100M
}

# Check for silent mode
if [[ "$1" == "-s" ]]; then
    perform_cleanup
else
    # Ask user for confirmation
    echo -ne "\n\e[1;33m➤ Do you want to proceed with system cleanup? (Y/n): \e[0m"
    read -r response
    response=${response:-$default_response}
    if [[ "$response" =~ ^[Yy]$ ]]; then
        perform_cleanup
    else
        echo -e "\e[1;91m❌ Cleanup aborted.\e[0m"
        exit 1
    fi
fi

# Capture memory & disk status after cleanup
after_cleanup_mem=$(free -h | awk 'NR==2{print $2, $3, $4, $5, $6, $7}')
after_cleanup_disk=$(df -B1 / | awk 'NR==2 {print $4}')

# Calculate disk space freed
disk_space_freed=$((before_cleanup_disk - after_cleanup_disk))

# Display results in a stylish format
echo -e "\n\e[1;34m📊 Resource Usage Comparison:\e[0m"
printf "\e[1;36m%-20s %-20s %-20s\e[0m\n" "📝 Before" "🔽 Freed" "📝 After"
printf "\e[1;92m%-20s %-20s %-20s\e[0m\n" "$(numfmt --to=iec $before_cleanup_disk) free" "$(numfmt --to=iec $disk_space_freed)" "$(numfmt --to=iec $after_cleanup_disk) free"

# Calculate total runtime
end_time=$(date +%s)
total_time=$((end_time - start_time))
echo -e "\n\e[1;33m⏳ Total script execution time: $total_time seconds\e[0m"

echo -e "\n\e[1;92m🎉 System Cleanup Completed Successfully!\e[0m\n"

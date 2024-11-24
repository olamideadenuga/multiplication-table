#!/bin/bash

# Function to generate multiplication table using List Form
generate_table_list_form() {
  echo "Using List Form Loop:"
  for i in {1..10}; do
    echo "$1 x $i = $(( $1 * i ))"
  done
}

# Function to generate multiplication table using C-style Loop
generate_table_c_style() {
  echo "Using C-Style Loop:"
  for (( i = $2; i <= $3; i++ )); do
    echo "$1 x $i = $(( $1 * i ))"
  done
}

# Function to generate multiplication table in descending order
generate_table_descending() {
  echo "Descending Order:"
  for (( i = $2; i >= $3; i-- )); do
    echo "$1 x $i = $(( $1 * i ))"
  done
}

# Prompt user for the number
echo -n "Enter a number to generate the multiplication table: "
read number

# Input validation: Check if the input is a valid number
if ! [[ "$number" =~ ^[0-9]+$ ]]; then
  echo "Invalid input! Please enter a valid positive number."
  exit 1
fi

# Ask the user if they want a full or partial table
echo "Do you want a full multiplication table (1-10) or a partial table?"
echo "Enter 'full' for full table or 'partial' for partial table."
read table_choice

if [[ "$table_choice" == "full" ]]; then
  generate_table_list_form "$number"

elif [[ "$table_choice" == "partial" ]]; then
  # Ask for the range of the table
  echo -n "Enter the start of the range: "
  read start_range
  echo -n "Enter the end of the range: "
  read end_range

  # Input validation for the range
  if ! [[ "$start_range" =~ ^[0-9]+$ ]] || ! [[ "$end_range" =~ ^[0-9]+$ ]] || (( start_range > end_range )); then
    echo "Invalid range! Defaulting to full table."
    generate_table_list_form "$number"
  else
    # Ask if the table should be ascending or descending
    echo "Do you want the table in ascending or descending order? (Enter 'asc' or 'desc')"
    read order_choice

    if [[ "$order_choice" == "asc" ]]; then
      generate_table_c_style "$number" "$start_range" "$end_range"
    elif [[ "$order_choice" == "desc" ]]; then
      generate_table_descending "$number" "$end_range" "$start_range"
    else
      echo "Invalid order choice! Defaulting to ascending order."
      generate_table_c_style "$number" "$start_range" "$end_range"
    fi
  fi
else
  echo "Invalid choice! Defaulting to full table."
  generate_table_list_form "$number"
fi
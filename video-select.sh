#!/bin/bash
# This script wrapps prime-select command and adds an extra operation to fix acpi power management bug in nVidia driver
# that drains Laptop's battery. It has been observed that nVidia card stays powered even if intel card is selected.
# The script depends on https://wiki.ubuntu.com/Bumblebee library.
# I recommend using Bumblebee library for power saving purpose only. To do so install it using the following command:
# sudo apt-get install --no-install-recommends bumblebee

if [[ "$1" == "nvidia" ]]
then
  echo "Powering on nvidia card"
  tee /proc/acpi/bbswitch <<<ON
  prime-select nvidia
elif [[ "$1" == "intel" ]]
then
  prime-select intel
  echo "Powering off nvidia card"
  tee /proc/acpi/bbswitch <<<OFF
elif [[ "$1" == "query" ]]
then
  prime-select query
  cat /proc/acpi/bbswitch
else
  echo "Not supported operaiton"
fi

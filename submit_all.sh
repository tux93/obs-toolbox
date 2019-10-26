#! /usr/bin/env bash

# Sometimes submitting multiple packages in one SR fails, this script opens a
# separate request for each package in a project.

echo "Enter a target project"
read -r target
echo "Enter a submit message"
read -r msg

for d in *
do
  (
  if [ -d "${d}" ]
  then
    cd "${d}" || exit
    osc sr -m "${msg}" "${target}"
  fi
  )
done

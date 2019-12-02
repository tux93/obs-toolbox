#! /usr/bin/env bash

# This script branches an entire OBS project, to do so it first temporarily
# checks out the source project locally, branches the packages to
# home:$USER:branches:$PROJECT and removes the temporary checkout.

echo "Enter the name of the project you want to branch"
read -r project

osc co "${project}"

(
  cd "${project}" || exit
  for d in *
  do
    if [ -d "${d}" ]
    then
      osc branch "${project}" "${d}"
    fi
  done
)

rm -r "${project}"

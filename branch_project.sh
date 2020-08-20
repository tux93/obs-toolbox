#! /usr/bin/env bash

# This script branches an entire OBS project, to do so it first temporarily
# checks out the source project locally, branches the packages to
# home:$USER:branches:$PROJECT and removes the temporary checkout.

echo "Enter the name of the project you want to branch"
read -r project

echo "Enter the name of the target Project"
echo "If left empty will default to home:\$user:branches:\$project"
read -r target

osc co "${project}"

(
  cd "${project}" || exit
  for d in *
  do
    if [ -d "${d}" ]
    then
      osc branch "${project}" "${d}" "${target}"
    fi
  done
)

rm -r "${project}"

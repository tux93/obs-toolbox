#! /usr/bin/env bash

# Prerequisites:
# - Maintainer access to the project
# - The whole project is checked out localy
#
# Usage:
# Start the script in the projects base directory, it will enter the
# contained packages folders and run the services one by one.
# Once all packages services have been run it will check in the changes in
# one step.

osc up
for d in *
do
  (
  if [ -d "${d}" ]
  then
    cd "${d}" || exit
    oldsource=$(find . -maxdepth 1 -name '*.tar.xz')
    osc service run
    count=$(find . -maxdepth 1 -name '*.tar.xz' | wc -l)
    if [ "${count}" -gt 1 ]
    then
      osc rm -f "${oldsource}"
    fi
    find . -name '*.obscpio' -delete
  fi
  )
done
osc addremove -r
osc ci --noservice -m "Service Run"

#!/usr/bin/env bash

#
# Run steps
#

source /steps/activate.sh
if [ -z "$EXPORT_PACKAGE_NAME" ]; then 
  #
  # User has not provided EXPORT_* parameters therefore 
  # expected action is to build the solution.
  #

  source /steps/build.sh
else
  #
  # User has provided EXPORT_* parameters therefore 
  # expected action is to export a unity package.
  #

  source /steps/export.sh
fi
source /steps/return_license.sh

#
# Instructions for debugging
#

if [[ $BUILD_EXIT_CODE -gt 0 ]]; then
echo ""
echo "###########################"
echo "#         Failure         #"
echo "###########################"
echo ""
echo "Please note that the exit code is not very descriptive."
echo "Most likely it will not help you solve the issue."
echo ""
echo "To find the reason for failure: please search for errors in the log above."
echo ""
fi;

#
# Exit with code from the build step.
#

exit $BUILD_EXIT_CODE

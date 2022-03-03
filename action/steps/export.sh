#!/usr/bin/env bash

#
# Set project path
#

UNITY_PROJECT_PATH="$GITHUB_WORKSPACE/$PROJECT_PATH"
echo "Using project path \"$UNITY_PROJECT_PATH\"."

#
# Display the name for the unitypackage
#

echo "Using package name \"$EXPORT_PACKAGE_NAME\"."

#
# Display the contents of the unitypackage
#

echo "Using package contents \"$EXPORT_PACKAGE_CONTENTS\"."

#
# Display build path and file
#

PACKAGE_PATH="$GITHUB_WORKSPACE/build"
PACKAGE_FILE="$PACKAGE_PATH/$EXPORT_PACKAGE_NAME"
echo "Saving \"$EXPORT_PACKAGE_NAME\" to \"$PACKAGE_PATH\"."

#
# Display custom parameters
#
echo "Using custom parameters $CUSTOM_PARAMETERS."

# The build specification below may require Unity 2019.2.11f1 or later (not tested below).
# Reference: https://docs.unity3d.com/2019.3/Documentation/Manual/CommandLineArguments.html

#
# Build info
#

echo ""
echo "###########################"
echo "#    Current build dir    #"
echo "###########################"
echo ""

echo "Creating \"$PACKAGE_PATH\" if it does not exist."
mkdir -p "$PACKAGE_PATH"
ls -alh "$PACKAGE_PATH"

echo ""
echo "###########################"
echo "#    Project directory    #"
echo "###########################"
echo ""

ls -alh $UNITY_PROJECT_PATH

echo ""
echo "###########################"
echo "#    Exporting package    #"
echo "###########################"
echo ""

unity-editor \
  -nographics \
  -logfile /dev/stdout \
  -quit \
  -customBuildName "$BUILD_NAME" \
  -projectPath "$UNITY_PROJECT_PATH" \
  -exportPackage $EXPORT_PACKAGE_CONTENTS "$PACKAGE_FILE" \
  -buildVersion "$VERSION" \
  $CUSTOM_PARAMETERS

# Catch exit code
EXPORT_EXIT_CODE=$?

# Display results
if [ $EXPORT_EXIT_CODE -eq 0 ]; then
  echo "Export succeeded";
else
  echo "Export failed, with exit code $EXPORT_EXIT_CODE";
fi

#
# Results
#

echo ""
echo "###########################"
echo "#     Build directory     #"
echo "###########################"
echo ""

ls -alh "$PACKAGE_PATH"

#!/bin/zsh
#
# By default this script will look for the xibLocalizationPostprocessor tool
# in the build product folder, as set by Xcode in the $BUILT_PRODUCTS_DIR
# environment variable.
#
# This script takes an optional argument that lets you override this default.
#
# Any remaining arguments are treated as input folders for genstrings; if none
# are given this defaults to $SRCROOT.

# See if the user provided a path to the XIB localization post processor script
# otherwise fall back on the build directory
if (( ${+1} )); then
  XIB_PROCESSOR_PATH=$1
  shift
else
  XIB_PROCESSOR_PATH=${BUILT_PRODUCTS_DIR}/xibLocalizationPostprocessor
fi

# Any remaining arguments are treated as folders in which to run genstrings
# (default is $SRCROOT)
if ! (( ${+1} )); then
    1=${SRCROOT}
fi

# Internationalize source code -- piped through xargs to support a large number
# of input files
OUTPUT_FOLDER="${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${DEVELOPMENT_LANGUAGE}.lproj"
# -q silences duplicate comments with same key warning
find "$@" -name "*.[hm]" -print0 | xargs -0 genstrings -q -o "${OUTPUT_FOLDER}" 

# Internationalize XIBs
foreach nibFile (${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/**/*.nib)
 stringsFilePath=${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${DEVELOPMENT_LANGUAGE}.lproj/`basename ${nibFile} .nib`.strings
 xibFile=`basename ${nibFile} .nib`.xib
 xibFilePath=`find "${SOURCE_ROOT}" -name "${xibFile}" | head -n 1`
 if [[ -e ${xibFilePath} ]] {
  ibtool --generate-stringsfile ${stringsFilePath}~ ${xibFilePath}
  "${XIB_PROCESSOR_PATH}" ${stringsFilePath}~ ${stringsFilePath}
  rm ${stringsFilePath}~
 }
end

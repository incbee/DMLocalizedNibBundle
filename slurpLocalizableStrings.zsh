#!/bin/zsh
#
# By default this script will look for the xibLocalizationPostprocessor tool
# in the build product folder, as set by Xcode in the $BUILT_PRODUCTS_DIR
# environment variable.
#
# This script takes an optional argument that lets you override this default.

# See if the user provided a path to the XIB localization post processor script
# otherwise fall back on the build directory
if (( ${+1} )); then
  XIB_PROCESSOR_PATH=$1
else
  XIB_PROCESSOR_PATH=${BUILT_PRODUCTS_DIR}/xibLocalizationPostprocessor
fi

# Internationalize source code
# -q silences duplicate comments with same key warning
genstrings -q -o ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${DEVELOPMENT_LANGUAGE}.lproj ${SRCROOT}/**/*.[hm]

# Internationalize XIBs
foreach nibFile (${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/**/*.nib)
 stringsFilePath=${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${DEVELOPMENT_LANGUAGE}.lproj/`basename ${nibFile} .nib`.strings
 xibFile=`basename ${nibFile} .nib`.xib
 xibFilePath=`print -l ${SOURCE_ROOT}/**/${xibFile} | head -n 1`
 if [[ -e ${xibFilePath} ]] {
  ibtool --generate-stringsfile ${stringsFilePath}~ ${xibFilePath}
  "${XIB_PROCESSOR_PATH}" ${stringsFilePath}~ ${stringsFilePath}
  rm ${stringsFilePath}~
 }
end

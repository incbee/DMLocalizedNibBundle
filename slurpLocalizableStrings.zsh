#!/bin/zsh

# Internationalize source code
# -q silences duplicate comments with same key warning
genstrings -q -o ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${DEVELOPMENT_LANGUAGE}.lproj ${SRCROOT}/**/*.[hm]

# Internationalize XIBs
foreach nibFile (${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/**/*.nib)
 stringsFilePath=${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${DEVELOPMENT_LANGUAGE}.lproj/`basename ${nibFile} .nib`.strings
 xibFile=`basename ${nibFile} .nib`.xib
 xibFilePath=`echo ${SOURCE_ROOT}/**/${xibFile}`
 if [[ -e ${xibFilePath} ]] {
  ibtool --generate-stringsfile ${stringsFilePath}~ ${xibFilePath}
  ${BUILT_PRODUCTS_DIR}/xibLocalizationPostprocessor ${stringsFilePath}~ ${stringsFilePath}
  rm ${stringsFilePath}~
 }
end

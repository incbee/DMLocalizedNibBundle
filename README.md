# DMLocalizedNibBundle

`DMLocalizedNibBundle` is [Wil Shipley's localization
system](http://blog.wilshipley.com/2009/10/pimp-my-code-part-17-lost-in.html)
with improvements to support localization of:

- all `NSTabView` items and their labels
- columns in `NSTableView` and `NSOutlineView`
- display patterns (`%{value1}`, `%{value2}`, ...) in `NSTextField` strings

## How to use

### Xcode 4

Note that these are instructions for Xcode 4.3.

#### Create target for localizable strings extractor

First create a target for the command-line tool that will slurp out the localizable strings from source files and XIB files:

1. In Xcode choose File > New > Target
2. On the left select "Application" under the Mac OS X heading
3. On the right select "Command Line Tool" and click Next
    1. For the Target Name enter "xibLocalizationPostprocessor"
    2. For the type select "Foundation"
    3. Deselect "Use Automatic Reference Counting"
    4. Click Finish
4. In the Project Navigator find the newly added "xibLocalizationPostProcessor" group
    1. Ctrl-click on the group and choose Delete
    2. Choose "Move to Trash"
5. Drag "xibLocalizationPostprocessor.m" into your project
6. Under Add To Targets list select only xibLocalizationPostprocessor and deselect all others

#### Target build settings

1. In the Project Navigator select your project
2. From the Targets select "xibLocalizationPostprocessor"
3. Click Build Settings
4. Clear the "Precompile Prefix Header" and "Prefix Header" build settings

The "xibLocalizationPostprocessor" target should now compile.

#### Set target dependency

Next set the above command-line tool to be compiled with the application:

1. In the Project Navigator select your project
2. From the Targets select your application target
3. Click Build Phases
4. Under Target Dependencies click "+"
3. Select xibLocalizationPostprocessor and click Add Target

#### Add build script phase to extract localizable strings

Then add a build script that will call the above command-line tool:

1. In the Project Navigator select your project
2. From the Targets select your application target
3. Click Build Phases
4. Click "Add Build Phase" and choose "Add Run Script"
5. In the Script text view enter

	`/path/to/slurpLocalizableStrings.zsh`
	
	For example if you have the localization project as a subfolder in the Xcode project folder:

	`${SRCROOT}/DMLocalizedNibBundle/slurpLocalizableStrings.zsh`
6. Rename the build script phase "Generate Localizable Strings" or something to your liking

#### Load localizations dynamically in application

And finally add the dynamic localization loader into your application target:

1. Drag `DMLocalizedNibBundle.m` into your project
2. Under Add To Targets list select only your application target and deselect all others


### Xcode 3

#### Create target for localizable strings extractor

First create a target for the command-line tool that will slurp out the localizable strings from source files and XIB files:

1. In Xcode choose Project > New Target
2. On the left select "Cocoa" under the Mac OS X heading
3. On the right select Shell Tool and click Next
4. For the Target Name enter "xibLocalizationPostprocessor" and click Finish
5. Choose Project > Add to Project
6. In the file browser choose the xibLocalizationPostprocessor.m file and click Add
7. Under Add To Targets list select only xibLocalizationPostprocessor and deselect all others


#### Set target dependency

Next set the above command-line tool to be compiled with the application:

1. In the Groups & Files pane double-click your application target
2. Under the Direct Dependencies list click +
3. Select xibLocalizationPostprocessor and click Add Target


#### Add build script phase to extract localizable strings

Then add a build script that will call the above command-line tool:

1. In the Groups & Files pane select your application target
2. Choose Project > New Build Phase > New Run Script Build Phase
3. In the Script text view enter

	`/path/to/slurpLocalizableStrings.zsh`
	
	For example if you have the localization project as a subfolder in the Xcode project folder:

	`${SRCROOT}/DMLocalizedNibBundle/slurpLocalizableStrings.zsh`
4. Close the script info window
5. Ctrl-Click on the newly create build script phase (it should be called "Run Script") and choose Rename
6. Type "Generate Localizable Strings" and hit enter


#### Load localizations dynamically in application

And finally add the dynamic localization loader into your application target:

1. In the Groups & Files pane select your application target
2. Choose Project > Add to Project
3. In the file browser choose `DMLocalizedNibBundle.m` and click Add
4. Under Add To Targets list select only your application target and deselect all others

## License

Created by William Jon Shipley on 2/13/05. Copyright © 2005-2009 Golden % Braeburn, LLC. All rights reserved except as below:

This code is provided as-is, with no warranties or anything. You may use it in your projects as you wish, but you must leave this comment block (credits and copyright) intact. That's the only restriction -- Golden % Braeburn otherwise grants you a fully-paid, worldwide, transferrable license to use this code as you see fit, including but not limited to making derivative works.

Changes made by [Incredible Bee Ltd.](http://incrediblebee.com) are also under the above license.

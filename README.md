# DMLocalizedNibBundle

`DMLocalizedNibBundle` is [Wil Shipley's localization
system](http://blog.wilshipley.com/2009/10/pimp-my-code-part-17-lost-in.html)
with improvements to support localization of:

- all `NSTabView` items and their labels
- columns in `NSTableView` and `NSOutlineView`
- display patterns (`%{value1}`, `%{value2}`, ...) in `NSTextField` strings


## System requirements

I've tested the code on the Mac OS X 10.10 SDK.

It should run fine on the 10.8 SDK too, though I haven't tested this.

If you need 10.7 compatibility checkout the tag `10.7-compatibility`.


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


## License

Created by William Jon Shipley on 2/13/05. Copyright © 2005-2009 Golden % Braeburn, LLC. All rights reserved except as below:

This code is provided as-is, with no warranties or anything. You may use it in your projects as you wish, but you must leave this comment block (credits and copyright) intact. That's the only restriction -- Golden % Braeburn otherwise grants you a fully-paid, worldwide, transferrable license to use this code as you see fit, including but not limited to making derivative works.

Changes made by [Incredible Bee Ltd.](http://incrediblebee.com) are also under the above license.

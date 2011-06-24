# DMLocalizedNibBundle

`DMLocalizedNibBundle` is [Wil Shipley's localization system](http://wilshipley.com/blog/2009/10/pimp-my-code-part-17-lost-in.html) with improvements to support localization of:

- columns in `NSTableView` and `NSOutlineView`
- display patterns (`%{value1}`, `%{value2}`, ...) in `NSTextField` strings

## How to use

First create a target for the command-line tool that will slurp out the localizable strings from source files and XIB files:

1. In Xcode choose Project > New Target
2. On the left select "Cocoa" under the Mac OS X heading
3. On the right select Shell Tool and click Next
4. For the Target Name enter "xibLocalizationPostprocessor" and click Finish
5. Choose Project > Add to Project
6. In the file browser choose the xibLocalizationPostprocessor.m file and click Add
7. Under Add To Targets list select only xibLocalizationPostprocessor and deselect all others


## License

Created by William Jon Shipley on 2/13/05. Copyright © 2005-2009 Golden % Braeburn, LLC. All rights reserved except as below:

This code is provided as-is, with no warranties or anything. You may use it in your projects as you wish, but you must leave this comment block (credits and copyright) intact. That's the only restriction -- Golden % Braeburn otherwise grants you a fully-paid, worldwide, transferrable license to use this code as you see fit, including but not limited to making derivative works.

Changes made by [Incredible Bee Ltd.](http://incrediblebee.com) are also under the above license.
# NBJMergeLayout-ObjC [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
**Remove unnecessary views from Nib view hierarchies**

NBJMergeLayout is a view that, when added to a view, adds all of its subviews to that view and removes itself.

## Purpose

The power of the `NBJMergeLayout` view comes when it's used as the root view in a Nib and that Nib is loaded as the root view of a custom view or control (see [NJBNibBasedView](https://github.com/BrentleyJones/NBJNibBasedView-ObjC) for an easy way to do that). In this case it removes an unnecessary view from the resulting view hierarchy.

## How it works

When the `NBJMergeLayout` view is added to a view (`didMoveToSuperview` for UIKit and `viewDidMoveToSuperview` for AppKit) it does three things:

1. It reassigns all of its own Autolayout constraints to the superview, changing any references for itself to the superview.
2. It reassigns all of its subviews to the superview.
3. It removes itself from the superview.

The end result is all of the `NBJMergeLayout` view's subviews are subviews of the view it was attached to, with the same constraints they had before (but now referencing their new superview), and the `NBJMergeLayout` view is no longer part of the view hierarchy.

## Known issues

`NBJMergeLayout` will update any IBOutlets in its superview that reference any of its constraints. This is needed because new constraints are created during the reassignment step described above. This covers almost any case in which you would normally use `NBJMergeLayout`. **Any other IBOutlets that reference these constraints will not be updated.**

//
//  NBJMergeLayout.h
//  NBJMergeLayout-Objc
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#include "TargetConditionals.h"

#if TARGET_OS_IPHONE

@import UIKit;
#define View UIView

#else

@import AppKit;
#define View NSView

#endif

/**
 *  `NBJMergeLayout` is a view that, when added to a view, adds all of its
 *  subviews to that view and removes itself. The power of the `NBJMergeLayout`
 *  view comes when it's used as the root view in a Nib and that Nib is loaded
 *  as the root view of a custom view or control. In this case it removes an
 *  unnecessary view from the resulting view hierarchy.
 */
@interface NBJMergeLayout : View

@end

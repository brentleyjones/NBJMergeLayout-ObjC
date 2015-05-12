//
//  CustomView.m
//  NBJMergeLayout-Objc-Example
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

#pragma mark - Initialization Methods

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self initShared];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initShared];
    }
    return self;
}

- (void)initLoadNibSubviews
{
    // Load our root subview, which is a NBJMergeLayout
    UIView *rootSubview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    [self addSubview:rootSubview];
}

- (void)initPreNib
{
    // Set values before the nib for this view is loaded
}

- (void)initPostNib
{
    // Set values after the nib for this view is loaded
}

- (void)initShared
{
    [self initPreNib];
    [self initLoadNibSubviews];
    [self initPostNib];
}

@end

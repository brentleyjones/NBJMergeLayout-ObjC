//
//  NBJMergeLayout.m
//  NBJMergeLayout-Objc
//
//  Created by Brentley Jones on 6/22/14.
//  Copyright (c) 2014 Brentley Jones. All rights reserved.
//

#import "NBJMergeLayout.h"

#import <objc/runtime.h>

@implementation NBJMergeLayout

#if TARGET_OS_IPHONE

- (void)didMoveToSuperview
{
    if (self.superview) {
        [self moveSubviewsToNewSuperview:self.superview];
        
        // Remove ourselves from our superview
        [self removeFromSuperview];
    }
}

#else

- (void)viewDidMoveToSuperview
{
    if (self.superview) {
        [self moveSubviewsToNewSuperview:self.superview];
        
        // Remove ourselves from our superview
        [self removeFromSuperview];
    }
}

#endif

#pragma mark - Private Methods

- (void)moveSubviewsToNewSuperview:(id)newSuperview
{
    // Add all children to superview
    
    // First start by moving the constraints,
    // because if we move the views first we lose the constraints
    for (NSLayoutConstraint *constraint in self.constraints) {
        NSLayoutConstraint *newConstraint = [self constraintForSuperviewConstraint:constraint withNewSuperview:newSuperview];
        
        [newSuperview addConstraint:newConstraint];
        
        // Update IBOutlets from old constraint to new constraint in superview
        // (the most likely place, especially in conjunction with
        // NBJNibBasedView)
        [self replacePropertyReferencesInObject:self.superview forReferencedObject:constraint toNewObject:newConstraint];
    }
    
    // Secondly we move the views over to our new superview
    // Copy needed or OS X complains about mutating the array
    // (since we are technically removing the views by adding them to the superview)
    NSArray *subviews = [self.subviews copy];
    for (id subview in subviews) {
        [newSuperview addSubview:subview];
    }
}

- (NSLayoutConstraint *)constraintForSuperviewConstraint:(NSLayoutConstraint *)constraint withNewSuperview:(id)newSuperview
{
    id firstItem = constraint.firstItem;
    id secondItem = constraint.secondItem;
    
    // Replace self in constraints with new superview
    if (firstItem == self) {
        firstItem = newSuperview;
    }
    if (secondItem == self) {
        secondItem = newSuperview;
    }
    
    // Construct new constraint
    NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:secondItem attribute:constraint.secondAttribute multiplier:constraint.multiplier constant:constraint.constant];
    
    // Copy over other properties
    newConstraint.identifier = constraint.identifier;
    newConstraint.shouldBeArchived = newConstraint.shouldBeArchived;
    newConstraint.priority = constraint.priority;
    
    if ([newConstraint respondsToSelector:@selector(setActive:)]) { // iOS 8
        newConstraint.active = constraint.active;
    }
    
    return newConstraint;
}

- (void)replacePropertyReferencesInObject:(id)object forReferencedObject:(id)referencedObject toNewObject:(id)newReference
{
    id superview = self.superview;
    Class clazz = [superview class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    for (u_int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = [superview valueForKey:propertyName];
        
        if (propertyValue == referencedObject) {
            // Found a reference to the old property, let's reassign it to the new property
            [superview setValue:newReference forKey:propertyName];
        }
    }
    free(properties);
}

@end

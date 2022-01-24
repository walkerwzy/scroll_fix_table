//
//  UIView+Extension.m
//  TableDemo
//
//  Created by yangpei on 2022/1/23.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)fillInView:(UIView *)superView {
    [superView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.topAnchor constraintEqualToAnchor:superView.topAnchor],
        [self.leadingAnchor constraintEqualToAnchor:superView.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:superView.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:superView.bottomAnchor],
    ]];
}

@end

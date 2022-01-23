//
//  UIViewController+Extension.m
//  TableDemo
//
//  Created by 杨沛 on 2022/1/22.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)fillView:(UIView *)view inView:(UIView *)superView {
    [superView addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [view.topAnchor constraintEqualToAnchor:superView.topAnchor],
        [view.leadingAnchor constraintEqualToAnchor:superView.leadingAnchor],
        [view.trailingAnchor constraintEqualToAnchor:superView.trailingAnchor],
        [view.bottomAnchor constraintEqualToAnchor:superView.bottomAnchor],
    ]];
}

@end

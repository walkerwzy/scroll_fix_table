//
//  ProjTableViewCell.h
//  TableDemo
//
//  Created by walker on 2022/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjTableViewCell : UITableViewCell
//@property(nonatomic, strong) UIView *topview;
//@property(nonatomic, strong) UIView *bottomview;
@property(nonatomic, strong) UIStackView *stackview;
@property (nonatomic, readonly) UIView *dockView;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSLayoutAnchor *dockViewAlignAnchor;

@end

NS_ASSUME_NONNULL_END

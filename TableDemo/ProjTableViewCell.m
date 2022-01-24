//
//  ProjTableViewCell.m
//  TableDemo
//
//  Created by walker on 2022/1/23.
//

#import "ProjTableViewCell.h"
#import "UIView+Extension.h"

@interface ProjTableViewCell ()

@property (nonatomic, strong, readwrite) UIView *dockView;
@property (nonatomic, strong) UILabel *projLabel;
@property (nonatomic, strong) UILabel *projIdLabel;
@property (nonatomic, strong) UILabel *workerLabel;
@property (nonatomic, strong) UILabel *posLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *beginLabel;
@property (nonatomic, strong) UILabel *endLabel;
@property (nonatomic, strong) UILabel *useLabel;
@property (nonatomic, strong) UIView *metaView;

@property (nonatomic, assign) CGFloat dockViewWidth;

@end

@implementation ProjTableViewCell

- (void)setData:(NSDictionary *)item {
    self.projLabel.text = item[@"proj"];
    self.projIdLabel.text = item[@"proj_id"];
    self.workerLabel.text = item[@"worker"];
    self.posLabel.text = item[@"pos"];
    self.stateLabel.text = item[@"state"];
    self.beginLabel.text = item[@"begin"];
    self.endLabel.text = item[@"end"];
    self.useLabel.text = item[@"use"];
    self.metaView.hidden = ![item[@"open"] isEqual:@YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.dockViewWidth = 100;
        [[self rowView] fillInView:self.contentView];
    }
    return self;
}

- (void)updateConstraints {
    if (self.dockViewAlignAnchor) {
        [self.dockView.trailingAnchor constraintEqualToAnchor:self.dockViewAlignAnchor].active = YES;
    }
    [super updateConstraints];
}

- (UIView *)rowView {
    UIView *top_view = [[UIView alloc] init];
    // 静态内容禁用事件响应，透传到cell
    top_view.userInteractionEnabled = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView fillInView:top_view];
    scrollView.backgroundColor = UIColor.grayColor;
    
    // 滑动内容
    UIStackView *contentView = [[UIStackView alloc] init];
    [contentView fillInView:scrollView];
    [contentView.heightAnchor constraintEqualToAnchor:scrollView.heightAnchor].active = YES;
    contentView.spacing = 1.0f;
    
    // 列1
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.blackColor;
        label.font = [UIFont systemFontOfSize:16];
        label.translatesAutoresizingMaskIntoConstraints = NO;
//        [view addSubview:label];
        self.projLabel = label;
        
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.textColor = UIColor.lightGrayColor;
        subLabel.font = [UIFont systemFontOfSize:14];
        subLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        [view addSubview:subLabel];
        self.projIdLabel = subLabel;
        
//        [NSLayoutConstraint activateConstraints:@[
//            [label.topAnchor constraintEqualToAnchor:view.topAnchor constant:10],
//            [label.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:15],
//            // 关键点：stack容器高度通过 v:|label-5-subLabel| 这里确定的
//            // scrollView的高度是通过stack确定的
//            // cell的高度是通过scroll的高度确定的（竖向滚动的则是宽度由scroll决定）
//            [label.bottomAnchor constraintEqualToAnchor:subLabel.topAnchor constant:-5.0],
////            [subLabel.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-10],
//            [subLabel.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:15],
//        ]];
        
        [label.heightAnchor constraintEqualToConstant:24.0f].active = YES;
        [subLabel.heightAnchor constraintEqualToConstant:24.0f].active = YES;
        UIStackView *stackCell = [[UIStackView alloc] initWithArrangedSubviews:@[label, subLabel]];
        stackCell.backgroundColor = UIColor.whiteColor;
        stackCell.axis = UILayoutConstraintAxisVertical;
        stackCell.distribution = UIStackViewDistributionFill;
        stackCell.alignment = UIStackViewAlignmentCenter;
        [stackCell.widthAnchor constraintEqualToConstant:150].active = YES;
        return stackCell;
//        [view.widthAnchor constraintEqualToConstant:150].active = YES;
//        return view;
    }()];
    
    // 列2
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        self.workerLabel = label;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:80].active = YES;
        return view;
    }()];
    
    // 列3
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        self.posLabel = label;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:80].active = YES;
        return view;
    }()];
    
    // 列4
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        self.stateLabel = label;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:80].active = YES;
        return view;
    }()];
    
    // 列5
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        self.beginLabel = label;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:150].active = YES;
        return view;
    }()];
    
    // 列6
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        self.endLabel = label;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:150].active = YES;
        return view;
    }()];
    
    // 列7
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        self.useLabel = label;
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:80].active = YES;
        return view;
    }()];
    
    // 固定内容
    UIView *dockView = [[UIView alloc] init];
//        dockView.layer.shadowColor = [UIColor grayColor].CGColor;
//        dockView.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
//        dockView.layer.shadowRadius = 10.0f;
//        dockView.layer.masksToBounds = NO;
//        dockView.clipsToBounds = NO;
//        top_view.clipsToBounds = NO;
//        top_view.layer.masksToBounds = NO;
    [top_view addSubview:dockView];
    dockView.backgroundColor = [UIColor redColor];// colorWithAlphaComponent:1.0f];
    dockView.translatesAutoresizingMaskIntoConstraints = NO;
    [dockView.widthAnchor constraintEqualToConstant:self.dockViewWidth].active = YES;
    [dockView.heightAnchor constraintEqualToAnchor:top_view.heightAnchor].active = YES;
    [dockView.topAnchor constraintEqualToAnchor:top_view.topAnchor].active = YES;
    self.dockView = dockView;
    
    // 再做上下的stack，用来放置详情
    UIStackView *wrapperView = [UIStackView new];
    wrapperView.axis = UILayoutConstraintAxisVertical;
    wrapperView.spacing = 1.0f;
    [wrapperView addArrangedSubview:top_view];
    
    UIView *metaView = [UIView new];
    metaView.backgroundColor = UIColor.lightGrayColor;
    metaView.translatesAutoresizingMaskIntoConstraints = NO;
    [metaView.heightAnchor constraintEqualToConstant:60.0f].active = YES;
    [wrapperView addArrangedSubview:metaView];
    
    [metaView.bottomAnchor constraintEqualToAnchor:wrapperView.bottomAnchor].active = YES;
    self.metaView = metaView;
    
    // 将子视图的top和bottom对齐容器，容器会自动撑高
//    [wrapperView.subviews.firstObject.topAnchor constraintEqualToAnchor:wrapperView.topAnchor].active = YES;
//    [wrapperView.subviews.lastObject.bottomAnchor constraintEqualToAnchor:wrapperView.bottomAnchor].active = YES;
    return wrapperView;
    
    /**
     |scrollview|view|
     |view|
     */
}
@end

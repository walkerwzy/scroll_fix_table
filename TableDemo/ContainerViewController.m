//
//  ContainerViewController.m
//  TableDemo
//
//  Created by 杨沛 on 2022/1/22.
//

#import "ContainerViewController.h"
#import "UIViewController+Extension.h"
#import "ViewController.h"

@interface ContainerViewController ()

// 最外层容器
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) ViewController *tableViewController;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] init];
    [self fillView:self.scrollView inView:self.view];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 15;
    [self fillView:self.stackView inView:self.scrollView];
    [self.stackView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = UIColor.greenColor;
    [self.stackView addArrangedSubview:view1];
    [view1.heightAnchor constraintEqualToConstant:100].active = YES;
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = UIColor.blackColor;
    [self.stackView addArrangedSubview:view2];
    [view2.heightAnchor constraintEqualToConstant:100].active = YES;
    
    UIScrollView *view3 = [[UIScrollView alloc] init];
    view3.backgroundColor = UIColor.blueColor;
    [self.stackView addArrangedSubview:view3];
    // 此处要固定高度，不然外层scrollview的contentSize无法明确，会产生警告
//    [view3.heightAnchor constraintEqualToConstant:600].active = YES;
    [view3.heightAnchor constraintGreaterThanOrEqualToConstant:400.0f].active = YES;
    
    ViewController *vc = [[ViewController alloc] init];
    [vc setDockViewAlign:self.view.trailingAnchor];
    [self addChildViewController:vc];
    [self fillView:vc.view inView:view3];
    [vc.view.widthAnchor constraintEqualToConstant:1200].active = YES;
    [vc.view.heightAnchor constraintEqualToAnchor:view3.heightAnchor].active = YES;
    self.tableViewController = vc;
}

@end

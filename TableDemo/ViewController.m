//
//  ViewController.m
//  TableDemo
//
//  Created by 杨沛 on 2022/1/22.
//

#import "ViewController.h"
#import "UIViewController+Extension.h"
#import "ProjTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *rowViews;

@property (nonatomic, strong) NSMutableArray *dockViewLeadings;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) CGFloat dockViewWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[
        [@{ @"id": @"1",
           @"proj": @"车轮更换",
           @"proj_id": @"N031-38H 1830",
           @"worker": @"张三",
           @"hour": @"2.3",
           @"pos": @"工位4号",
           @"state": @"待开工",
           @"begin": @"2022-01-10 08:00:00",
           @"end": @"2022-01-10 15:00:00",
           @"use": @"8h",
           @"open": @YES} mutableCopy],
        [@{ @"id": @"2",
           @"proj": @"车轮更换",
           @"proj_id": @"N031-38H 1830",
           @"worker": @"张三",
           @"hour": @"2.3",
           @"pos": @"工位5号",
           @"state": @"待开工",
           @"begin": @"2022-01-10 08:00:00",
           @"end": @"2022-01-10 15:00:00",
           @"use": @"8h"} mutableCopy],
        [@{ @"id": @"3",
           @"proj": @"车轮更换",
           @"proj_id": @"N031-38H 1830",
           @"worker": @"张三",
           @"hour": @"2.3",
           @"pos": @"工位6号",
           @"state": @"待开工",
           @"begin": @"2022-01-10 08:00:00",
           @"end": @"2022-01-10 15:00:00",
           @"use": @"8h"} mutableCopy],
    ];
    
    self.dockViewWidth = 100;
    [self setupRowStacks];
    [self setupTableView];
}

// 父视图滚动时固定dockView位置
- (void)containerDidScroll:(UIScrollView *)scrollView {
    // 固定的格子是相对表格起始位置的约束，所以scrollview带着表格滚动的时候，
    // 要把滚动距离抵消掉才能永远相对屏幕左侧不动。
    for (NSLayoutConstraint *leading in self.dockViewLeadings) {
        CGFloat baseLine = UIScreen.mainScreen.bounds.size.width - self.dockViewWidth;
        leading.constant = baseLine + scrollView.contentOffset.x;
    }
}

- (void)setupRowStacks {
    self.rowViews = [NSMutableArray new];
    self.dockViewLeadings = [NSMutableArray new];
    for (NSDictionary *item in self.data) {
        [self.rowViews addObject:[self buildRowStack:item]];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}

- (UIView *)buildRowStack:(NSDictionary *)item {
    UIView *top_view = [[UIView alloc] init];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [top_view addSubview:scrollView];
    [self fillView:scrollView inView:top_view];
    scrollView.backgroundColor = UIColor.grayColor;
    
    // 滑动内容
    UIStackView *contentView = [[UIStackView alloc] init];
    [scrollView addSubview:contentView];
    [self fillView:contentView inView:scrollView];
    [contentView.heightAnchor constraintEqualToAnchor:scrollView.heightAnchor].active = YES;
    contentView.spacing = 1.0f;
    
    // 列1
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = item[@"proj"];
        label.textColor = UIColor.blackColor;
        label.font = [UIFont systemFontOfSize:16];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
        UILabel *subLabel = [[UILabel alloc] init];
        subLabel.text = item[@"proj_id"];
        subLabel.textColor = UIColor.lightGrayColor;
        subLabel.font = [UIFont systemFontOfSize:14];
        subLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:subLabel];
        
        [NSLayoutConstraint activateConstraints:@[
            [label.topAnchor constraintEqualToAnchor:view.topAnchor constant:10],
            [label.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:15],
            [subLabel.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-10],
            [subLabel.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:15],
        ]];
        
        [view.widthAnchor constraintEqualToConstant:150].active = YES;
        return view;
    }()];
    
    // 列2
    [contentView addArrangedSubview:^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = item[@"worker"];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
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
        label.text = item[@"pos"];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
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
        label.text = item[@"state"];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
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
        label.text = item[@"begin"];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
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
        label.text = item[@"end"];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
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
        label.text = item[@"use"];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:label];
        
        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
        
        [view.widthAnchor constraintEqualToConstant:80].active = YES;
        return view;
    }()];
    
    // 固定内容=
    UIView *dockView = [[UIView alloc] init];
//    dockView.layer.shadowColor = [UIColor grayColor].CGColor;
//    dockView.layer.shadowOffset = CGSizeMake(-5.0f, 5.0f);
//    dockView.layer.shadowRadius = 10.0f;
//    dockView.layer.masksToBounds = NO;
//    dockView.clipsToBounds = NO;
//    view.clipsToBounds = NO;
//    view.layer.masksToBounds = NO;
    [top_view addSubview:dockView];
    dockView.backgroundColor = [UIColor redColor];// colorWithAlphaComponent:1.0f];
    dockView.translatesAutoresizingMaskIntoConstraints = NO;
    [dockView.widthAnchor constraintEqualToConstant:self.dockViewWidth].active = YES;
    [dockView.heightAnchor constraintEqualToAnchor:top_view.heightAnchor].active = YES;
    [dockView.topAnchor constraintEqualToAnchor:top_view.topAnchor].active = YES;
    NSLayoutConstraint *dockViewLeading = [dockView.leadingAnchor constraintEqualToAnchor:top_view.leadingAnchor constant:UIScreen.mainScreen.bounds.size.width - self.dockViewWidth];
    dockViewLeading.active = YES;
    // 持有固定内容的横向位置约束
    [self.dockViewLeadings addObject:dockViewLeading];
    
    // 再做上下的stack，用来放置详情
    UIStackView *wrapperView = [UIStackView new];
    wrapperView.axis = UILayoutConstraintAxisVertical;
    wrapperView.spacing = 1.0f;
    [top_view.heightAnchor constraintEqualToConstant:60.0f].active = YES;
    [wrapperView addArrangedSubview:top_view];
    
    UIView *metaView = [UIView new];
    metaView.backgroundColor = UIColor.lightGrayColor;
    metaView.translatesAutoresizingMaskIntoConstraints = NO;
    [metaView.heightAnchor constraintEqualToConstant:60.0f].active = YES;
    [wrapperView addArrangedSubview:metaView];
    
    metaView.hidden = ![item[@"open"] isEqual:@YES];
    
//    [wrapperView layoutIfNeeded];

    return wrapperView;
    
    /**
        |scrollview|view|
        |view|
     */
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[ProjTableViewCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.rowHeight = 60;
    [self fillView:self.tableView inView:self.view];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProjTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self fillView:self.rowViews[indexPath.row] inView:cell.contentView];
    cell.stackview = self.rowViews[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.data[indexPath.row][@"open"] isEqual: @YES] ? 120.0f : 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isOpen = [self.data[indexPath.row][@"open"]  isEqual: @YES];
//    self.data[indexPath.row][@"open"] = @(!isOpen);
    ProjTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] forIndexPath:indexPath];
//    NSLog(@"%@", cell.contentView.subviews);
//    UIStackView *stack = [cell.contentView.subviews lastObject];
//    stack.arrangedSubviews[1].hidden = !isOpen;
//        [self setupRowStacks];
//    [self.view setNeedsLayout];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [tableView reloadData];
}

@end

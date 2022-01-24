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

@property (nonatomic, strong) NSLayoutAnchor *dockAlignAnchor;

@property (nonatomic, strong) NSArray *data;

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
        [@{ @"id": @"4",
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
    
    [self setupTableView];
}

- (void)setDockViewAlign:(NSLayoutAnchor *)anchor {
    self.dockAlignAnchor = anchor;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[ProjTableViewCell class] forCellReuseIdentifier:@"cell"];
    // Self sizing (Autolayout) cell，需设置 estimatedRowHeight 优化性能
//    self.tableView.estimatedRowHeight = 60;
    [self fillView:self.tableView inView:self.view];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProjTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // model <-> view binding
    [cell setData:self.data[indexPath.row]];
    // constraint binding
    cell.dockViewAlignAnchor = self.dockAlignAnchor;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

// Autolayout 自动计算高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self.data[indexPath.row][@"open"] isEqual: @YES] ? 120.0f : 60.0f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // MVC思想 action -> model -> view
    BOOL isOpen = [self.data[indexPath.row][@"open"] isEqual: @YES];
    self.data[indexPath.row][@"open"] = @(!isOpen);
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end

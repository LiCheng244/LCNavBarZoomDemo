//
//  LCHeaderController.m
//  滚动导航栏缩放
//
//  Created by LiCheng on 2017/2/27.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCHeaderController.h"

NSString *const cellID = @"cellID";

#define headerHeight 200

@interface LCHeaderController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LCHeaderController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    [self setupTableView];
    [self setupHeaderView];
}

/** 设置 headerView */
- (void)setupHeaderView {

    UIView *headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, headerHeight))];
    headerView.backgroundColor = [UIColor redColor];

    [self.view addSubview:headerView];
}

/** 设置 tableView */
- (void)setupTableView {

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];

    tableView.dataSource = self;
    tableView.delegate = self;

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: cellID];

    // 设置视图边距
    tableView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0);
    // 设置滚动指示器边距
    tableView.scrollIndicatorInsets = tableView.contentInset;
    // 取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    return cell;
}
@end

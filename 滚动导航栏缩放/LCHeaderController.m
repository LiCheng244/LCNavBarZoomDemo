//
//  LCHeaderController.m
//  滚动导航栏缩放
//
//  Created by LiCheng on 2017/2/27.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCHeaderController.h"

NSString *const cellID = @"cellID";

@interface LCHeaderController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LCHeaderController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    [self setupTableView];
}


- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];

    tableView.dataSource = self;
    tableView.delegate = self;

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: cellID];

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

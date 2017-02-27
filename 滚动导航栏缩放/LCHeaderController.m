//
//  LCHeaderController.m
//  滚动导航栏缩放
//
//  Created by LiCheng on 2017/2/27.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCHeaderController.h"
#import "UIView+BSFrame.h"

NSString *const cellID = @"cellID";

#define headerHeight 200

@interface LCHeaderController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LCHeaderController {

    UIView *_headerView;
    UIImageView *_headerImgView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    [self setupTableView];
    [self setupHeaderView];
}

/** 设置状态栏 样式 */
-(UIStatusBarStyle)preferredStatusBarStyle {

    // 亮色
    return UIStatusBarStyleLightContent;
}

/** 设置 headerView */
- (void)setupHeaderView {

    _headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, headerHeight))];
    _headerView.backgroundColor = [UIColor redColor];

    [self.view addSubview:_headerView];

    // 头像视图
    _headerImgView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    _headerImgView.image = [UIImage imageNamed:@"111.jpg"];
    _headerImgView.backgroundColor = [UIColor grayColor];

    // 设置图像缩放方式 - 等比例填充
    _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    // 设置图片剪裁
//    _headerImgView.clipsToBounds = YES;

    [_headerView addSubview:_headerImgView];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 滚动上下偏移量 向上: 正数  向下: 负数
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    NSLog(@"%lf", offset);

    if (offset <= 0) { // 向下，放大

        // 调整 headerView 和 headerImgView的高度
        _headerView.bs_y = 0;
        _headerView.bs_height = headerHeight - offset;
        _headerImgView.bs_height = _headerView.bs_height;

    }else { // 向上

        _headerView.bs_height = headerHeight;
        _headerImgView.bs_height = _headerView.bs_height;
        _headerView.bs_y = -offset;
    }
}

#pragma mark - <代理方法>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    return cell;
}
@end

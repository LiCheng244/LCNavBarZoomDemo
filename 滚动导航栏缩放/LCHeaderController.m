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

    UIView              *_headerView;
    UIImageView         *_headerImgView;
    UIView              *_lineView;

}

- (void)viewWillAppear:(BOOL)animated {

    // 取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;

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

    // 1. headerView
    _headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, headerHeight))];
    _headerView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    [self.view addSubview:_headerView];

    // 2. 头像视图
    _headerImgView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    _headerImgView.image = [UIImage imageNamed:@"111.jpg"];
    _headerImgView.backgroundColor = [UIColor grayColor];
    //    - 设置图像缩放方式 - 等比例填充
    _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    //    - 设置图片剪裁
    _headerImgView.clipsToBounds = YES;
    [_headerView addSubview:_headerImgView];

    // 3. 分割线
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc] initWithFrame:(CGRectMake(0, headerHeight - lineHeight, self.view.bounds.size.width, lineHeight))];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:_lineView];

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

    [self.view addSubview:tableView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 1. 滚动上下偏移量
    //    - 向上: 正数  向下: 负数
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;

    // 2. 顶部视图 Y 最小值
    CGFloat minHeaderViewY = headerHeight - 64;

    // 3. 顶部视图透明度
    CGFloat progress = 1 - (offset / minHeaderViewY);

    // 4. 根据透明度显示导航栏
    BOOL isHideen = progress > 0 ? true : false;
    [self.navigationController setNavigationBarHidden:isHideen animated:NO];

    // 5. 判断滚动方向
    if (offset <= 0) { // 向下，放大

        // 调整 headerView 布局
        _headerView.bs_y = 0;
        _headerView.bs_height = headerHeight - offset;

    }else { // 向上, 整体移动

        // 整体移动
        _headerView.bs_y = -MIN(minHeaderViewY, offset); // 返回两个数中的最小值
        _headerView.bs_height = headerHeight;

        // 设置 图像的透明度
        _headerImgView.alpha = progress;
    }

    // 6. 调整 图像视图 高度
    _headerImgView.bs_height = _headerView.bs_height;

    // 7. 设置分割线的位置
    _lineView.bs_y = _headerView.bs_height - _lineView.bs_height;
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

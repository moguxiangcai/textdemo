//
//  UITableView+Common.h
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/27.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITapImageView.h"
/** 进入刷新状态的回调 */
typedef void (^RefreshBlock)();
@interface UITableView (Common)
@property (nonatomic, copy) RefreshBlock refreshBlock;
@property (nonatomic, copy) RefreshBlock loadMoreBlock;


- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 给UITableViewCell添加下划线
- (void)addLineForPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
- (void)addLineForPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr andBlock:(void(^)(id obj))tapAction;
- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr color:(UIColor *)color andBlock:(void(^)(id obj))tapAction;


/*! 添加下拉刷新控件 */
- (void)addRefreshHeader:(RefreshBlock)block;

/*! 添加上拉加载控件 */
- (void)addRefreshFooter:(RefreshBlock)block;

#pragma mark - 下拉刷新
/*! 显示下拉刷新 */
- (void)showRefreshHeader;

/*! 隐藏下拉刷新 */
- (void)hideRefreshHeader;

#pragma mark - 上拉加载
/*! 显示上拉加载更多 */
- (void)showRefreshFooter;

/*! 隐藏上拉加载更多 */
- (void)hideRefreshFooter;

#pragma mark - 全部加载完毕
/*! 结束下拉刷新和上提加载 */
- (void)endRefresh;

/*! 已经全部加载完毕 */
- (void)noMoreData;

@end

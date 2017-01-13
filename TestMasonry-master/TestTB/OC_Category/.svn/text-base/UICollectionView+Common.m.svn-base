//
//  UICollectionView+Common.m
//  RRArt-iOS
//
//  Created by wtj on 15/12/22.
//  Copyright © 2015年 YiBei. All rights reserved.
//

#import "UICollectionView+Common.h"
#import <objc/runtime.h>
static const void *RefreshBlockKey = &RefreshBlockKey;
static const void *LoadMoreBlockKey = &LoadMoreBlockKey;
@implementation UICollectionView (Common)
#pragma mark -
#pragma mark - 增加属性
@dynamic refreshBlock;
@dynamic loadMoreBlock;

- (RefreshBlock)refreshBlock {
    return objc_getAssociatedObject(self, RefreshBlockKey);
}

- (RefreshBlock)loadMoreBlock {
    return objc_getAssociatedObject(self, LoadMoreBlockKey);
}

- (void)setRefreshBlock:(RefreshBlock)refreshBlock {
    objc_setAssociatedObject(self, RefreshBlockKey, refreshBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLoadMoreBlock:(RefreshBlock)loadMoreBlock {
    objc_setAssociatedObject(self, LoadMoreBlockKey, loadMoreBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark - 刷新控件
/*! 添加下拉刷新控件 */
- (void)addRefreshHeader:(RefreshBlock)block {
    self.refreshBlock = block;
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    headerView.automaticallyChangeAlpha = YES;
//    headerView.lastUpdatedTimeLabel.hidden = YES;
    headerView.stateLabel.font = [UIFont systemFontOfSize:15];
    self.mj_header = headerView;
}

/*! 添加上拉加载控件 */
- (void)addRefreshFooter:(RefreshBlock)block {
    self.loadMoreBlock = block;
    MJRefreshAutoNormalFooter *footerView = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    footerView.automaticallyChangeAlpha = YES;
    //footerView.refreshingTitleHidden = YES;
    [footerView setTitle:@"" forState:MJRefreshStateIdle];
    [footerView setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    footerView.stateLabel.font = [UIFont systemFontOfSize:15];
    
    self.mj_footer = footerView;
//    self.mj_footer.hidden = YES;
}

/*! 显示下拉刷新 */
- (void)showRefreshHeader {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.mj_header.hidden = NO;
    }];
}

/*! 显示上拉加载更多 */
- (void)showRefreshFooter {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.mj_footer.hidden = NO;
    }];
}

/*! 隐藏下拉刷新 */
- (void)hideRefreshHeader {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.mj_header.hidden = YES;
        
    }];
}

/*! 隐藏上拉加载更多 */
- (void)hideRefreshFooter {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.mj_footer.hidden = YES;
        [self.mj_footer endRefreshingWithNoMoreData];
    }];
}

/*! 结束下拉刷新和上提加载 */
- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

/*! 已经全部加载完毕 */
- (void)noMoreData {
    [self hideRefreshFooter];
}

#pragma mark -
#pragma mark - 刷新事件处理
- (void)headerRefresh {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

- (void)footerRefresh {
    if (self.loadMoreBlock) {
        self.loadMoreBlock();
    }
}


@end

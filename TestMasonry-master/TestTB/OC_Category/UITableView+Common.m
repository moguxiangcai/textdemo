//
//  UITableView+Common.m
//  ZhangcaiLicaishi
//
//  Created by Wujg on 15/4/27.
//  Copyright (c) 2015年 hetang. All rights reserved.
//

#import "UITableView+Common.h"
#import <objc/runtime.h>
static const void *RefreshBlockKey = &RefreshBlockKey;
static const void *LoadMoreBlockKey = &LoadMoreBlockKey;

@implementation UITableView (Common)
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


- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 5.f;
        
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        
        layer.path = pathRef;
        CFRelease(pathRef);
        
        // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        if (cell.backgroundColor) {
            layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
        } else if (cell.backgroundView && cell.backgroundView.backgroundColor){
            layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
        } else {
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        }
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+2, bounds.size.height-lineHeight, bounds.size.width-2, lineHeight);
            lineLayer.backgroundColor = self.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
    }
}


#pragma mark - 给UITableViewCell添加下划线
- (void)addLineForPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace {
    [self addLineForPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:leftSpace hasSectionLine:YES];
}

- (void)addLineForPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    CGPathAddRect(pathRef, nil, bounds);
    layer.path = pathRef;
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    } else if (cell.backgroundView && cell.backgroundView.backgroundColor) {
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    } else {
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = [UIColor colorWithHexString:@"0xdcdcdc"].CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace {
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
    }else{
        left = leftSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}

- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr andBlock:(void(^)(id obj))tapAction{
    return [self getHeaderViewWithStr:headerStr color:[UIColor colorWithHexString:@"0xeeeeee"] andBlock:tapAction];
}

- (UITapImageView *)getHeaderViewWithStr:(NSString *)headerStr color:(UIColor *)color andBlock:(void(^)(id obj))tapAction{
    UITapImageView *headerView = [[UITapImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScaleFrom_iPhone5_Desgin(24))];
    [headerView setImage:[UIImage imageWithColor:color]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreen_Width-20, CGRectGetHeight(headerView.frame))];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
    if (kDevice_Is_iPhone6Plus) {
        headerLabel.font = [UIFont systemFontOfSize:14];
    }else{
        headerLabel.font = [UIFont systemFontOfSize:kScaleFrom_iPhone5_Desgin(12)];
    }
    headerLabel.text = headerStr;
    [headerView addSubview:headerLabel];
    [headerView addTapBlock:tapAction];
    return headerView;
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
    
//    NSMutableArray *refreshImages =[[NSMutableArray alloc]init];
//    
//    for (int i=1; i<7; i++) {
//        UIImage *F=[UIImage imageNamed:[NSString stringWithFormat:@"F%d.png",i]];
//        
//        [refreshImages addObject:F];
//        
//    }
//    
//    MJRefreshGifHeader *headerView = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//    headerView.stateLabel.hidden = YES;
//    headerView.lastUpdatedTimeLabel.hidden = YES;
////     headerView.automaticallyChangeAlpha = YES;
//    [headerView setImages:refreshImages forState:MJRefreshStateIdle];
//    [headerView setImages:refreshImages forState:MJRefreshStatePulling];
//    [headerView setImages:refreshImages forState:MJRefreshStateRefreshing];
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

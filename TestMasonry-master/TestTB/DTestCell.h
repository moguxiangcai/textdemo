//
//  DTestCell.h
//  TestTB
//
//  Created by Damon on 16/8/18.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTestCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton * roomState;
@property (nonatomic, strong) UILabel * sourceTitle;
@property (nonatomic, strong) UIButton * sourceDetail;
@property (nonatomic, strong) UILabel * teacherAndType;
@property (nonatomic, strong) UILabel * number;
@property (nonatomic, strong) UIImageView * profileMap;
@property (nonatomic, strong) UIButton * liveTVDate;

- (CGFloat) getCellHeight;

@end

//
//  DTestCell.m
//  TestTB
//
//  Created by Damon on 16/8/18.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "DTestCell.h"
#import "Masonry.h"

#define DColorRGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DColor_gray_light       DColorRGBA(152, 153, 154, 1)
#define DColor_gray_mid         DColorRGBA(102, 102, 103, 1)
#define DColor_black            DColorRGBA(49, 50, 51, 1)

#define DFont(f)            [UIFont systemFontOfSize:14]
#define DFont_title         DFont(14)
#define DFont_detail        DFont(10)
#define DFont_small         DFont(10)


@implementation DTestCell

#define ICON_SIZE 60

NSString * titleString =nil;
NSString * sourceDetailString =nil;
NSString * teacherString =nil;
NSString * numberString =nil;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        titleString = [NSString stringWithFormat:@"标准题目 : 这就是个题目"];
        sourceDetailString = [NSString stringWithFormat:@"人人没事"];
        teacherString = [NSString stringWithFormat:@"宋老师的发色彩"];
        numberString = [NSString stringWithFormat:@"史蒂夫"];
        [self layoutSelfViews];
    }
    return self;
}

- (void)layoutSelfViews{
    int padding = 10;

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(padding);
        make.left.equalTo(self).with.offset(padding);
        make.width.mas_equalTo(@ICON_SIZE);
        make.height.mas_equalTo(@ICON_SIZE);
    }];
    int heightToLine1 = 30;
    [self.roomState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(padding);
        make.left.equalTo(self.mas_right).with.offset(-85);
        make.size.mas_equalTo(CGSizeMake(80, heightToLine1));
    }];
//    CGFloat sWidthTitle = [self getStringWidth:titleString];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(padding);
        make.left.equalTo(_icon.mas_right).with.offset(padding);
        make.right.equalTo(self.roomState.mas_left).with.offset(-padding);
        make.height.mas_equalTo(heightToLine1);
        
    }];
    int heightToLine2 = 25;
    int line2TopPadding = 10;
    [self.sourceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(line2TopPadding);
        make.left.equalTo(_icon.mas_right).with.offset(padding);
        make.size.mas_equalTo(CGSizeMake(40, heightToLine2));
        
    }];
    CGFloat sWidthSourceDetail = [self getStringWidth:sourceDetailString];
    [self.sourceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(line2TopPadding);
        make.left.equalTo(_sourceTitle.mas_right);
        make.size.mas_equalTo(CGSizeMake(sWidthSourceDetail, heightToLine2));
    }];
    CGFloat sWidthNumber = [self getStringWidth:numberString];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(line2TopPadding);
        make.left.mas_equalTo(self.mas_right).with.offset(-(sWidthNumber+5));
        make.size.mas_equalTo(CGSizeMake(sWidthNumber, heightToLine2));
    }];

    CGFloat sWidthTeacherAndType = [self getStringWidth:teacherString];
    [self.teacherAndType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).with.offset(line2TopPadding);
        make.left.equalTo(_sourceDetail.mas_right).with.offset(padding-5);
        make.right.equalTo(self.number.mas_left);
        make.size.mas_equalTo(CGSizeMake(sWidthTeacherAndType, heightToLine2));
    }];
    
    [self.profileMap mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.sourceTitle.mas_bottom).with.offset(padding);
        make.left.equalTo(self.icon.mas_right).with.offset(padding);
        make.right.equalTo(self).with.offset(-padding);
        make.bottom.equalTo(self).with.offset(-padding);
    }];
    [self.liveTVDate mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.profileMap.mas_bottom).with.offset(-50);
        make.left.equalTo(self.profileMap.mas_right).with.offset(-200);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
}
- (CGFloat) getCellHeight{
    CGFloat height = CGRectGetMaxY(self.profileMap.frame)+CGRectGetMaxY(self.icon.frame);
    NSLog(@"1:%zd,img:%zd,icon:%zd",height,CGRectGetMaxY(self.profileMap.frame),CGRectGetMaxY(self.icon.frame));
    return height+20;
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = (UIImageView*)[self createImageView];
        _icon.image = [UIImage imageNamed:@"3"];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = ICON_SIZE/2;
    }
    return _icon;
}
- (UILabel *)title{
    if (!_title) {
        _title = (UILabel *)[self createLabelView];
        _title.textColor = DColor_black;
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = DFont_title;
        _title.text = titleString;
//        _title.backgroundColor = DColorRGBA(137, 137, 137, 1);
    }
    return _title;
}
- (UILabel *)sourceTitle{
    if (!_sourceTitle) {
        _sourceTitle = (UILabel *)[self createLabelView];
        _sourceTitle.textColor = DColor_gray_mid;
        _sourceTitle.textAlignment = NSTextAlignmentLeft;
        _sourceTitle.font = DFont_detail;
        _sourceTitle.text = @"来源:";
//        _sourceTitle.backgroundColor = DColorRGBA(0, 170, 170, 1);
    }
    return _sourceTitle;
}
- (UIButton *)sourceDetail{
    if (!_sourceDetail) {
        _sourceDetail = [self createButton];
        [_sourceDetail setTitleColor:DColor_gray_mid forState:UIControlStateNormal];
        [_sourceDetail setTitle:sourceDetailString forState:UIControlStateNormal];
        _sourceDetail.titleLabel.font = DFont_detail;
//        _sourceDetail.backgroundColor = DColorRGBA(200, 70, 70, 1);
    }
    return  _sourceDetail;
}

- (UIButton *)roomState{
    if (!_roomState) {
        _roomState = [self createButton];
        [_roomState setTitleColor:DColorRGBA(255, 102, 35, 1) forState:UIControlStateNormal];
        _roomState.titleLabel.font = DFont_title;
        [_roomState setTitle:@"直播中" forState:UIControlStateNormal];
//        [_roomState setBackgroundColor:DColorRGBA(100, 80, 100, 1)];
    }
    return _roomState;
}
- (UILabel *)teacherAndType{
    if (!_teacherAndType) {
        _teacherAndType = (UILabel *)[self createLabelView];
        _teacherAndType.textColor = DColor_gray_mid;
        _teacherAndType.textAlignment = NSTextAlignmentLeft;
        _teacherAndType.text = teacherString;
        _teacherAndType.font = DFont_detail;
//        _teacherAndType.backgroundColor = DColorRGBA(50, 70, 170, 1);
    }
    return _teacherAndType;
}
- (UILabel *)number{
    if(!_number){
        _number = (UILabel *)[self createLabelView];
        _number.textColor = DColor_gray_light;
        _number.textAlignment = NSTextAlignmentLeft;
        _number.text = numberString;
        _number.font = DFont_small;
//        _number.backgroundColor = DColorRGBA(192, 130, 65, 1);
    }
    return _number;
}
- (UIImageView *)profileMap{
    if (!_profileMap) {
        _profileMap = (UIImageView *)[self createImageView];
        _profileMap.image = [UIImage imageNamed:@"223"];
    }
    return _profileMap;
}
- (UIButton *)liveTVDate{
    if (!_liveTVDate) {
        _liveTVDate = [self createButton];
        [self.profileMap addSubview:_liveTVDate];;
        [_liveTVDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _liveTVDate.titleLabel.font = DFont_title;
        [_liveTVDate setTitle:@"🎬 直播时间 : 8.17 10:12 " forState:UIControlStateNormal];
    }
    return _liveTVDate;
}
- (CGFloat)getStringWidth:(NSString*)aString{
    CGSize size;
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary* dic = @{NSFontAttributeName:DFont_title};
//            NSParagraphStyleAttributeName : style};
    size = [aString boundingRectWithSize:CGSizeMake(400, 25) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  size.width;
}
- (UIImageView *)createImageView{
    UIImageView * imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    return imageView;
}
-(UILabel *)createLabelView{
    UILabel *view = [[UILabel alloc] init];
    [self addSubview:view];
    return view;
}
- (UIButton *)createButton{
    UIButton * button = [UIButton buttonWithType: UIButtonTypeCustom];
    [self addSubview:button];
    return button;
}
@end

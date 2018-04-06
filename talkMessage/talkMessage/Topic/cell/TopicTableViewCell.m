//
//  TopicTableViewCell.m
//  USMessage
//
//  Created by Hoang Thuan on 12/4/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "TopicTableViewCell.h"

@implementation TopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imgProfilePhoto.layer.cornerRadius=_imgProfilePhoto.frame.size.width/2;
    _imgProfilePhoto.layer.masksToBounds=YES;
    _viewNewMessage.layer.cornerRadius = _viewNewMessage.frame.size.width/2;
    _viewNewMessage.layer.masksToBounds=YES;
    CGRect frame = CGRectMake(50,self.frame.size.height-1, [[UIScreen mainScreen] bounds].size.width-50,1);
    UIView *viewhr = [[UIView alloc] initWithFrame:frame];
     viewhr.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:viewhr];
//
//    //self.contentView.layer.borderColor =  [UIColor lightGrayColor].CGColor;
//    //self.contentView.layer.borderWidth= 0.3;
//    [self addBottomBorderViewWithColor:[UIColor lightGrayColor] andWidth:0.3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addBottomBorderViewWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.contentView.layer addSublayer:border];
}

@end

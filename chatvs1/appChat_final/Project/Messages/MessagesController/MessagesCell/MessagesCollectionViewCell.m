//
//  MessagesCollectionViewCell.m
//  DemoChat
//
//  Created by CPU11197-local on 10/20/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "MessagesCollectionViewCell.h"
#define GrayColor  [[UIColor alloc] initWithRed:243/255.0  green:243/255.0 blue:243/255.0 alpha:1]
#define GreenColorMesages  [[UIColor alloc] initWithRed:0/255.0  green:217/255.0 blue:147/255.0 alpha:1]

@interface MessagesCollectionViewCell ()
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageBubbleTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet UIView *messageBubbleContainerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCellTopLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBubbleTopLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthBubbleContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBubbleContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCellBottomLabel;


@end

@implementation MessagesCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.heightCellBottomLabel.constant = 0.0f;
    self.heightBubbleTopLabel.constant = 0.0f;
    self.heightCellTopLabel.constant = 0.0f;
    
    self.textView.textAlignment = NSTextAlignmentJustified;
    self.textView.backgroundColor =  GreenColorMesages;
    self.textView.textColor = [UIColor whiteColor];
    self.textView.layer.borderWidth = 0;
    self.textView.layer.borderColor=[[UIColor groupTableViewBackgroundColor] CGColor];
    self.textView.layer.cornerRadius = 12;
    self.textView.editable = NO;
    self.textView.selectable = NO;
     self.textView.scrollEnabled = NO;
    self.textView.text = nil;
    [self.textView setFont:[UIFont systemFontOfSize:14]];
    self.cellTopLabel.backgroundColor = GrayColor;
    self.cellBottomLabel.backgroundColor = GrayColor;
    self.cellBottomLabel.textAlignment =  NSTextAlignmentLeft;
    self.messageBubbleTopLabel.backgroundColor = GrayColor;
    self.messageBubbleTopLabel.textAlignment =  NSTextAlignmentLeft;
    self.avatarContainerView.backgroundColor = [UIColor clearColor];
    self.avatarImageView.backgroundColor = [UIColor whiteColor];
    self.avatarImageView.layer.cornerRadius= self.avatarImageView.frame.size.height/2;
    self.avatarImageView.layer.borderWidth= 0.0;
    self.avatarImageView.layer.masksToBounds = YES;
    
    
}
-(void)bindConstantWithtWidth_MAX_textView:(CGFloat)width_MAX_textView heightCellTop:(CGFloat)heightCellTop heightBubbleTop:(CGFloat)heightBubbleTop heightCellBottom:(CGFloat)heightCellBottom{
    CGRect textViewFrame = CGRectMake(0,0,width_MAX_textView,21);
    UITextView *textViewDemo = [[UITextView alloc] initWithFrame:textViewFrame];
    textViewDemo.text = nil;
    CGSize sizeThatShouldFitTheContent = [self.textView sizeThatFits:textViewDemo.frame.size];
    self.widthBubbleContainer.constant = sizeThatShouldFitTheContent.width + 10;
    self.heightCellTopLabel.constant = heightCellTop;
    self.heightBubbleTopLabel.constant = heightBubbleTop;
    self.heightCellBottomLabel.constant = heightCellBottom;
}
-(void)bindData:(MessageDetail *)messages ContentTextMessages:(NSMutableAttributedString*)ContentText{
    
    
    self.messageBubbleTopLabel.text = @"liem";
    self.cellBottomLabel.text = @"Đã xem";
    self.cellTopLabel.text = [NSDate mysqlDatetimeFormattedAsTimeAgo:messages.timeMesages];
            UIImage *image;// = [UIImage imageWithData:data];
            if ([messages type] == 3){
                if ([[messages senderID] isEqualToString:@"system"]){
                    image = [UIImage imageNamed:@"Talk.png"];
                } else {
                image = [UIImage imageNamed:@"avatar2.jpg"];
                }
            }
            else
                {
                     image = [UIImage imageNamed:@"avatar3.jpg"];
                }
            [self.avatarImageView setImage:image];
    //NSMutableAttributedString *arr = [DrawEmoji_textview AttributedStringFormString:messages.text DicEmoji:DicEmoji];
    [DrawEmoji_textview insertContentTextTo:self.textView formAttributedString:ContentText];
 
}
@end

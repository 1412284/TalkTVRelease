//
//  MessageCollectionViewCell.m
//  USMessage
//
//  Created by Hoang Thuan on 11/29/17.
//  Copyright © 2017 Hoang Thuan. All rights reserved.
//

#import "MessageCollectionViewCell.h"
#import "NSDate+NVTimeAgo.h"

@implementation MessageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.lbContentSystemMessage setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    self.lbTimeMessage.text = nil;
    self.lbTitleSystemMessage.text = nil;
    self.lbTimeSystemMessage.text = nil;
    self.lbContentSystemMessage.text = nil;
    _imgProfilePhoto.layer.cornerRadius =_imgProfilePhoto.frame.size.width/2;
    _imgProfilePhoto.layer.masksToBounds = YES;
    _viewBackgroundContentMessage.layer.cornerRadius = 5.0f;
    _viewBackgroundContentMessage.layer.masksToBounds = YES;

}

-(void)bindData:(Message *)message{
    self.lbTimeMessage.text = [NSDate DatetimeFormattedAsTimeAgoContentMessage:message.lbTimeMessage];
    if(message.type == TYPE_SYSTEM_MESSAGE || message.type == TYPE_EVENT_MESSAGE)
    {
        // System Message and Event Message
        self.lbContentSystemMessage.text = message.lbContentSystemMessage;
        self.lbTitleSystemMessage.text = message.lbTitleSystemMessage;
        self.lbTimeSystemMessage.text = message.lbTimeSystemMessage;
        [self.lbContentSystemMessage setNumberOfLines:0];
        [self.lbContentSystemMessage setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        //[self.lbContentSystemMessage sizeToFit];
        if(message.type == TYPE_SYSTEM_MESSAGE)
        {
             self.imgPhotoEvent.image = [UIImage imageNamed:message.imgPhotoEvent];
        }
    } else {
        // User Message
    }
}
+(CGSize)getSizeContentMessage:(Message *)message{
    CGRect frame;
    
    if(message.type == TYPE_SYSTEM_MESSAGE || message.type == TYPE_EVENT_MESSAGE)
    {
        frame = [self getRectFrameForString:message.lbContentSystemMessage fontSize:FONT_SIZE maxWidth:[[UIScreen mainScreen] bounds].size.width - CELL_CONTENT_WITHOUT_SYSTEM_MESSAGE_WIDTH];
    } else {
        // User Message
        
       

    }
    return frame.size;
}
+ (CGRect)getRectFrameForAttributedString:(NSAttributedString *)text maxWidth:(CGFloat)maxWidth {
    if ([text isKindOfClass:[NSString class]] && !text.length) {
        // no text means no height
        return CGRectNull;
    }
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect frame = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options context:nil];
    return frame;
}

+ (CGRect)getRectFrameForString:(NSString *)text fontSize:(CGFloat)size maxWidth:(CGFloat)maxWidth {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        // no text means no height
        return CGRectNull;
    }
         CGRect frame = [text boundingRectWithSize:CGSizeMake(maxWidth, FLT_MAX)
                                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}
                                                      context:nil];
    return frame;
    
}
@end

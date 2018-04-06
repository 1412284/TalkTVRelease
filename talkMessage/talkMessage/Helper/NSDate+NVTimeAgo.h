//
//  NSDate+NVTimeAgo.h
 
   /* Date Format
    ----------
     < 1 hour         	= "x phút"
     Today            	= "x giờ"
     < Last 7 days    	= "x ngày"
     < 1 year         	= "MM/dd"
     Anything else    	= "MM/dd/yy"
 
 
*/

#import <Foundation/Foundation.h>

@interface NSDate (TimeAgo)
+ (NSString *)DatetimeFormattedAsTimeAgoTopic:(NSString *)Datetime;
+ (NSString *)DatetimeFormattedAsTimeAgoContentMessage:(NSString *)Datetime;
+ (NSString *) stringFormDateNow;
+ (NSDate *) dateFormStringFormat:(NSString*)strDate;
@end

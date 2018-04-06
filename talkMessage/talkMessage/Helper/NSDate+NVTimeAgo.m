//
//  NSDate+NVTimeAgo.m
//  Adventures
//
//  Created by liem on 11/12/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "NSDate+NVTimeAgo.h"

@implementation NSDate (TimeAgo)


#define SECOND  1
#define MINUTE  (SECOND * 60)
#define HOUR    (MINUTE * 60)
#define DAY     (HOUR   * 24)
#define WEEK    (DAY    * 7)
#define MONTH   (DAY    * 31)
#define YEAR    (DAY    * 365.24)
+(NSString*) stringFormDateNow
{
     NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateDisplay = [dateFormatter stringFromDate:now];
    return dateDisplay;
}
+(NSDate*) dateFormStringFormat:(NSString*)strDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:strDate];
    return date;
}
+ (NSString *)DatetimeFormattedAsTimeAgoContentMessage:(NSString *)Datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:Datetime];
    
    return [date formattedAsTimeAgoContentMessage];
}
+ (NSString *)DatetimeFormattedAsTimeAgoTopic:(NSString *)Datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:Datetime];
    
    return [date formattedAsTimeAgoListTopic];
}
- (NSString *)formattedAsTimeAgoContentMessage
{
    NSDate *now = [NSDate date];
    NSTimeInterval secondsSince = -(NSInteger)[self timeIntervalSinceDate:now];
   // Should never hit this but handle the future case
        if(secondsSince < DAY){
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //Format
            [dateFormatter setDateFormat:@"h:mm a"];
            return [dateFormatter stringFromDate:self];
        }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Format
    [dateFormatter setDateFormat:@"dd/MM/yy h:mm a"];
    return [dateFormatter stringFromDate:self];
    
}


-(NSString *)formattedAsTimeAgoListTopic
{
    //Now
       NSDate *now = [NSDate date];
    NSTimeInterval secondsSince = -(NSInteger)[self timeIntervalSinceDate:now];
    
    // < 1 hour = "x phút"
    if(secondsSince < HOUR)
        return [self formatMinutesAgo:secondsSince];
    
    // Today = "x giờ"
    if([self isSameDayAs:now])
        return [self formatAsToday:secondsSince];
    
    // < Last 7 days = "x ngày"
    if([self isLastWeek:secondsSince])
        return [self formatAsLastWeek:secondsSince];
    
    // < 1 year = "MM/dd"
    if([self isLastYear:secondsSince])
        return [self formatAsLastYear];
    
    // Anything else = "MM/dd/yyyy"
    return [self formatAsOther];
    
}



/*
 ========================== Date Comparison Methods ==========================
 */
/*
 Is Same Day As
 Checks to see if the dates are the same calendar day
 */
- (BOOL)isSameDayAs:(NSDate *)comparisonDate
{
    //Check by matching the date strings
    NSDateFormatter *dateComparisonFormatter = [[NSDateFormatter alloc] init];
    [dateComparisonFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //Return true if they are the same
    return [[dateComparisonFormatter stringFromDate:self] isEqualToString:[dateComparisonFormatter stringFromDate:comparisonDate]];
}


 /*
  Is Last Week
 */
- (BOOL)isLastWeek:(NSTimeInterval)secondsSince
{
    return secondsSince < WEEK;
}


/*
 Is Last Year
 TODO: Make last day precise
 */

- (BOOL)isLastYear:(NSTimeInterval)secondsSince
{
    return secondsSince < YEAR;
}

/*
 =============================================================================
 */


/*
 ========================== Formatting Methods ==========================
 */


// < 1 hour = "x phút"
- (NSString *)formatMinutesAgo:(NSTimeInterval)secondsSince
{
    //Convert to minutes
    int minutesSince = (int)secondsSince / MINUTE;
    
    //Handle Plural
    if(minutesSince <= 1)
        return @"1 phút";
    else
        return [NSString stringWithFormat:@"%d phút", minutesSince];
}


// Today = "x giờ"
- (NSString *)formatAsToday:(NSTimeInterval)secondsSince
{
    //Convert to hours
    int hoursSince = (int)secondsSince / HOUR;
    
    //Handle Plural
    if(hoursSince == 1)
        return @"1 giờ";
    else
        return [NSString stringWithFormat:@"%d giờ", hoursSince];
}


// < Last 7 days = "x ngày"
- (NSString *)formatAsLastWeek:(NSTimeInterval)secondsSince
{
    //Convert to minutes
    int DaysSince = (int)secondsSince / DAY;
    
    //Handle Plural
    if( DaysSince <= 1)
        return @"1 ngày";
    else
        return [NSString stringWithFormat:@"%d ngày",  DaysSince];
}


// < 1 year = "dd/MM"
- (NSString *)formatAsLastYear
{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //Format
    [dateFormatter setDateFormat:@"dd/MM"];
    return [dateFormatter stringFromDate:self];
}


// Anything else = "MM/dd/yy"
- (NSString *)formatAsOther
{
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //Format
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    return [dateFormatter stringFromDate:self];
}

@end

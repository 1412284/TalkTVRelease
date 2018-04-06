//
//  Date.m
//  Project
//
//  Created by liem on 11/12/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "Date.h"

@implementation Date
@synthesize year;
@synthesize month;
@synthesize day;
@synthesize hour;
@synthesize minute;
+(NSString*) stringFormDate:(NSDate*)Date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateDisplay = [dateFormatter stringFromDate:Date];
    return dateDisplay;
}
+(NSDate*) dateFormString:(NSString*)strDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:strDate];
    return date;
}
+(Date*) getYear:(NSDate*)date
{   Date *dateTime = [[Date alloc] init];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    dateTime.day = day;
    dateTime.month = month;
    dateTime.year = year;
    dateTime.hour = hour;
    dateTime.minute = minute;
    return  dateTime;
}

+(BOOL) isLaterThan:(NSDate*)date1 date2:(NSDate*)date2{
    
    if ([date1 compare:date2] == NSOrderedDescending) {
        return YES;
    } else if ([date1 compare:date2] == NSOrderedAscending){
        return  NO;
    }
    return NO;
}
@end


//
//  Date.h
//  Project
//
//  Created by liem on 11/12/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject
@property NSInteger year;
@property NSInteger month;
@property NSInteger day;
@property NSInteger hour;
@property NSInteger minute;
+(NSString*) stringFormDate:(NSDate*)Date;
+(NSDate*) dateFormString:(NSString*)strDate;
+(Date*) getYear:(NSDate*)date;
+(BOOL) isLaterThan:(NSDate*)date1  date2:(NSDate*)date2;
@end


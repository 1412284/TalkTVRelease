//
//  RegexStr.m
//  Project
//
//  Created by CPU11197-local on 11/27/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "RegexStr.h"

@implementation RegexStr
+(NSMutableArray*)splitCommas:(NSString*)str
{
    NSMutableArray *res;
    res = [[NSMutableArray alloc] init];
    NSString* const pattern = @"(\\:/[^ )]*\\)|([^:]+))";
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                      options:0
                                                                        error:nil];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSArray *matches = [regex matchesInString:str
                                      options:0
                                        range:searchRange];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSLog(@"%ld", matchRange.location);
        NSLog(@"%ld", matchRange.length);
        [res addObject:[str substringWithRange:matchRange]];
        NSLog(@"%@", [str substringWithRange:matchRange]);
    }
    
    return res;
}
@end

//
//  GlobalData.m
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//
#import "GlobalData.h"

@implementation GlobalData
@synthesize message; // nhớ là phải @synthesize

static GlobalData *sharedGlobalData = nil;

+ (GlobalData*)sharedGlobalData {
    if (sharedGlobalData == nil) {
        sharedGlobalData = [[super allocWithZone:NULL] init];
        
        // Khởi tạo giá trị mặc định cho biến toàn cục
        sharedGlobalData.message = @"0";
    }
    return sharedGlobalData;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    {
        if (sharedGlobalData == nil)
        {
            sharedGlobalData = [super allocWithZone:zone];
            return sharedGlobalData;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
// hàm toàn cục được code tại đây
- (void)myFunc {
    self.message = @"Bien toan cuc";
}
@end

//
//  GlobalData.h
//  Project
//
//  Created by CPU11197-local on 9/11/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject {
    NSString *message; // là một biến toàn cục tên message
}

@property (nonatomic, retain) NSString *message;

+ (GlobalData*)sharedGlobalData;

// là một hàm toàn cục tên myFunc
- (void) myFunc;

@end

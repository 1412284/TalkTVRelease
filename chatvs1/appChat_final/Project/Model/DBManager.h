//
//  DBManager.h
//  Project
//
//  Created by CPU11197-local on 10/27/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

@interface DBManager : NSObject // class quản lý vào ra truy vấn CSDL
// đường dẫn đến thư mục documents
@property (nonatomic, strong) NSString *documentsDirectory;
// tên file + đuôi file
@property (nonatomic, strong) NSString *databaseFilename;
-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;// hàm khởi tạo có tham số.
@end

//
//  DBManager.m
//  Project
//
//  Created by CPU11197-local on 10/27/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>


@interface DBManager()

-(void)copyDatabaseIntoDocumentsDirectory;

@end

@implementation DBManager
@synthesize documentsDirectory = _documentsDirectory;
@synthesize databaseFilename = _databaseFilename;
// đánh dấu đoạn code!!!
#pragma mark - Initialization
// hàm khởi tạo có tham số, Tham số truyền vào là "tên file.đuôi file"
-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if (self) {
        // Lấy đường dẫn đến thư mục documents, Kết quả trả về mảng có một phần tử!
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // đường dẫn gán vào property documentsDirectory
        self.documentsDirectory = [paths objectAtIndex:0];
        
        // Tên file được gán vào property databaseFilename
        self.databaseFilename = dbFilename;
        
        // sao chép file ở source code vào trong Thư mục documents
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}

#pragma mark - Private method implementation

-(void)copyDatabaseIntoDocumentsDirectory{
    // Lấy đường dẫn cụ thể đến file đích bao gồm đường dẫn documents+ tên file + đuôi file
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
     NSLog(@"%@", destinationPath);
    // Kiểm tra nếu file chưa tồn tại thì cho phép sao chép
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSLog(@"file chưa tồn tại! Thực hiện sao chép");
        // Đường dẫn file ở trong source code
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;// tạo một đối tượng error kiểm tra khi đang sao chép có sinh ra lỗi không
        // sao chép file từ sourcePath -> documents
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Nếu có lỗi sao chép đưa ra thông báo!
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }else{// ngược lại file đã tồn tại và không cần sao chép gì cả!
        NSLog(@"destinationPath:  %@", destinationPath);
        NSLog(@"file đã tồn tại");
    }
}
@end


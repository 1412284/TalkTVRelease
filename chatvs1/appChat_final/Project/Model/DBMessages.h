//
//  DBMessages.h
//  Project
//
//  Created by CPU11197-local on 11/3/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "MessageDetail.h"
@interface DBMessages : DBManager
@property (nonatomic, strong) NSMutableArray *arrColumnNames;// lưu lại tổng số cột trong một bảng

@property (nonatomic) int affectedRows;// trả về số lượng hàng bị ảnh hưởng.

@property (nonatomic) long long lastInsertedRowID;// trả vê ID

-(NSArray *)loadDataMesagesFromDB:(NSString *)query;// Truy vấn có đọc dữ liệu ra
-(void)executeQuery:(NSString *)query;// chỉ truy vấn không đọc dữ liệu
+(NSMutableArray*) loadDataMessages:(NSString*)senderID toSenderID:(NSString*)toSenderID dbMessages:(DBMessages*)dbMessages;
+(void) executeQueryInsert:(MessageDetail*)messages  dbMessages:(DBMessages*)dbMessages;
+(void) executeQueryDelete:(MessageDetail*)messages  dbMessages:(DBMessages*)dbMessages;
+(void) executeQueryUpdate:(MessageDetail*)messages  dbMessages:(DBMessages*)dbMessages;
//+(Topic*) loadDataTopicMessagesForID:(NSMutableArray*)ListID dbMessages:(DBMessages*)dbMessages;
@end

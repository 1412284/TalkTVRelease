//
//  DBTopic.h
//  Project
//
//  Created by CPU11197-local on 11/3/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "DBMessages.h"
#import <sqlite3.h>
@interface DBTopic : DBManager

@property (nonatomic, strong) NSMutableArray *arrColumnNames;// lưu lại tổng số cột trong một bảng

@property (nonatomic) int affectedRows;// trả về số lượng hàng bị ảnh hưởng.

@property (nonatomic) long long lastInsertedRowID;// trả vê ID
-(void)createData_column_text:(Topic*)topic compiledStatement:(sqlite3_stmt*)compiledStatement;
-(NSArray *)loadDataTopicFromDB:(NSString *)query;// Truy vấn có đọc dữ liệu ra
-(NSArray *)loadDataTopicUnfollowFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;// chỉ truy vấn không đọc dữ liệu
+(NSMutableArray*) loadDataTopic:(DBTopic*)dbTopic;
+(NSMutableArray*) loadDataTopicUnfollow:(DBTopic*)dbTopic;
+(void) executeQueryInsertTopic:(Topic*)topic dbTopic:(DBTopic*)dbTopic;
+(void) executeQueryDeleteTopic:(Topic*)topic dbTopic:(DBTopic*)dbTopic;
+(void) executeQueryUpdateTopic:(Topic*)topic dbTopic:(DBTopic*)dbTopic;
+(Topic*) loadDataTopicForID:(DBTopic*)dbTopic TopicID:(NSString*) topicID;
+(void) UpdateTopic:(NSMutableArray*)dataMessages dbMessages:(DBMessages *)dbMessages dbTopic:(DBTopic*)dbtopic senderID:(NSString*)senderID toSenderID:(NSString*)toSenderID;
+(void) UpdateContentTopicUnfollow:(DBTopic*)dbtopic senderID:(NSString*)senderID;
 @end

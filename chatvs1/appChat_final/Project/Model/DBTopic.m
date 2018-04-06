//
//  DBTopic.m
//  Project
//
//  Created by CPU11197-local on 11/3/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//


#import "DBTopic.h"


@interface DBTopic()
@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic, strong) NSMutableArray *arrResultsUnfollow;
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end

@implementation DBTopic
-(int) convertInt:(char*)s
{
    if (!s)
    {
        NSLog(@"Error===========");
        return -1; // error
    }
    return atoi(s);
}
// Chuẩn mở file sqlite và truy vấn sqlite
// truyền vào 2 tham số : câu truy vấn và đối tượng bool để kiểm tra: update,delete, insert, create không lấy dữ liệu ra,chỉ truy vấn: Trích lọc lấy dữ liệu truy vấn và lấy ra bảng dữ liệu.
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    // Khởi tạo một đối tượng của class sqlite.
    sqlite3 *sqlite3Database;
    // Lấy đường dẫn đích đến file.sqlite
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    // Khởi tạo mảng kết quả
    if (self.arrResults != nil) {// nếu mảng tồn tại(lưu) đối tượng
        [self.arrResults removeAllObjects];//xoá tất cả đối tượng
        self.arrResults = nil;// set về nil
    }
    if (self.arrResultsUnfollow != nil) {// nếu mảng tồn tại(lưu) đối tượng
        [self.arrResultsUnfollow removeAllObjects];//xoá tất cả đối tượng
        self.arrResultsUnfollow = nil;// set về nil
    }
    self.arrResults = [[NSMutableArray alloc] init];// khởi tạo lại vùng nhớ cho mảng
    self.arrResultsUnfollow = [[NSMutableArray alloc] init];// khởi tạo lại vùng nhớ cho mảng
    
    // Mở cơ sở dữ liệu
    // truyền vào 2 tham số đường dẫn đích đến file định dạng UTF8, Đối tượng sqlite
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if(openDatabaseResult == SQLITE_OK) {// nếu mở csdl thành công
        // Đối tượng lưu trữ các truy vấn prepare statement
        sqlite3_stmt *compiledStatement;
        // Chuyển đổi câu truy vấn ở định dạng chuỗi sang câu truy vấn mà sqlite3 có thể nhận dạng được!
        // các tham số truyền vào đối tượng sqlite3, câu truy vấn,Lấy độ dài câu truy vấn, ở đây -1 độ dài tuỳ ý, đối tượng sqlite3_stmt lưu trữ truy vấn, Con trỏ trỏ tới phần chưa sử dụng của câu truy vấn Sql.
        // sau khi chuyển đổi câu truy vấn được lưu lại trong compiledStatement
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        // Nếu câu truy vấn được chuyển đổi thành công sang dạng sqlite nhận dạng đc.
        if(prepareStatementResult == SQLITE_OK) {
            // Kiểm tra nếu truyền vào QueryExecutable NO thì ta cần trích lọc dữ liệu , đọc dữ liệu ra.
            if (!queryExecutable){
                // Tạo một mảng lưu lại thông tin truy vấn!
                NSMutableArray *arrDataRow;
                Topic *tempTopic;
                
                // Thực thi truy vấn cho phép đọc thành công!
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Khởi tạo mảng.
                    int totalColumns = sqlite3_column_count(compiledStatement);
                   arrDataRow = [[NSMutableArray alloc] init];
                    tempTopic = [[Topic alloc] init];
                    // trả về tổng số cột
                    [self createData_column_text:tempTopic compiledStatement:compiledStatement];
                    //lặp hết các cột
                    for (int i=0; i<totalColumns; i++){
                        // Trả về nội dung một cột kiểu char
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        
                        // If there are contents in the currenct column (field) then add them to the current row array.
                        if (dbDataAsChars != NULL) {
                            // chuyển đổi định sang kiểu string
                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                    
                    // Store each fetched data row in the results array, but first check if there is actually data.
                    if (arrDataRow.count > 0) {// môt đối tượng trong arrResults là một mảng!.
                        if(tempTopic.unfollow == 0)
                        {
                            [_arrResults addObject:tempTopic];
                        }
                        else
                        {
                            if([tempTopic.senderID  isEqual: @"1000"])
                            {
                                [_arrResults addObject:tempTopic];
                            }else {
                                [_arrResultsUnfollow addObject:tempTopic];
                            }
                        }
                        
                    }
                }
            }
            else {
                // Nếu chỉ truy vấn Update , Delete, insert không cần đưa ra dữ liệu
                
                // Execute the query.
                int executeQueryResults = sqlite3_step(compiledStatement);
                if (executeQueryResults == SQLITE_DONE) {// Nếu truy vấn thành công "chỉ truy vấn không đọc dữ liệu".
                    //                    // Trả về  số lượng hàng bị ảnh hưởng.
                    //                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    //
                    //                    // trả về số đối tượng được chèn vào ở dòng cuối cùng.
                    //                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                }
                else {
                    // Lỗi mô tả sqlite.
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        }
        else {
            // In the database cannot be opened then show the error message on the debugger.
            // Nếu xảy ra lỗi mô tả sqlite.
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        // Giải phóng một truy vấn được chuẩn bị
        sqlite3_finalize(compiledStatement);
        
    }
    
    // Đóng lại CSDL
    sqlite3_close(sqlite3Database);
}
#pragma mark - Public method implementation
-(void)createData_column_text:(Topic*)topic compiledStatement:(sqlite3_stmt*)compiledStatement{
    int _topicID = 0;
    int _type = 1;
    int _senderID = 2;
    int _avatarURL =3;
    int _title = 4;
    int _subTitle = 5;
    int _time = 6;
    int _unfollow = 7;
    int _isSeen = 8;
    char *dbDataTopicID = (char *)sqlite3_column_text(compiledStatement, _topicID);
    char *dbDataType = (char *)sqlite3_column_text(compiledStatement, _type);
    char *dbDataSenderID = (char *)sqlite3_column_text(compiledStatement, _senderID);
    char *dbDataAvatarURL = (char *)sqlite3_column_text(compiledStatement, _avatarURL);
    char *dbDataTitle = (char *)sqlite3_column_text(compiledStatement, _title);
    char *dbDataSubTitle = (char *)sqlite3_column_text(compiledStatement, _subTitle);
    char *dbDataDate = (char *)sqlite3_column_text(compiledStatement, _time);
    char *dbDataUnfollow = (char *)sqlite3_column_text(compiledStatement, _unfollow);
    char *dbDataIsSeen = (char *)sqlite3_column_text(compiledStatement, _isSeen);
    topic.topicID = [NSString  stringWithUTF8String:dbDataTopicID];
    topic.type = (NSInteger)[self convertInt:dbDataType];
    topic.senderID = [NSString  stringWithUTF8String:dbDataSenderID];
    topic.avatarURL = [NSString  stringWithUTF8String:dbDataAvatarURL];
    topic.title = [NSString  stringWithUTF8String:dbDataTitle];
    topic.subTitle = [NSString  stringWithUTF8String:dbDataSubTitle];
    topic.date = [NSString  stringWithUTF8String:dbDataDate];
    topic.unfollow = (NSInteger)[self convertInt:dbDataUnfollow];
    topic.isSeen = (NSInteger)[self convertInt:dbDataIsSeen];
}
-(NSArray *)loadDataTopicFromDB:(NSString *)query{
    // Run the query and indicate that is not executable.
    // The query string is converted to a char* object.
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    // Returned the loaded results.
    return (NSArray *)self.arrResults;
}
-(NSArray *)loadDataTopicUnfollowFromDB:(NSString *)query{
    // Run the query and indicate that is not executable.
    // The query string is converted to a char* object.
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    // Returned the loaded results.
    return (NSArray *)self.arrResultsUnfollow;
}
+(NSMutableArray*) loadDataTopic:(DBTopic*)dbTopic{
    Topic *new = [[Topic alloc] init];
    new.topicID = @"10001000liem6396";
    new.type = 1;
    new.senderID = @"1000";
    new.title = @"Người lạ";
    new.unfollow = 1;
    NSMutableArray* listUnfollow = [[NSMutableArray alloc] init];
    Topic *topic = [DBTopic loadDataTopicForID:dbTopic TopicID:@"10001000liem6396"];
    listUnfollow = [DBTopic loadDataTopicUnfollow:dbTopic];
        if ([listUnfollow count] != 0 && topic.topicID == nil)
        {
            NSLog(@"Chua ton tai unflow, %ld %@",[listUnfollow count] , topic.topicID);
                    Topic *temp = [listUnfollow objectAtIndex:0];
                    NSString *str = [temp.title stringByAppendingString:@":"];
                    str = [str stringByAppendingString:temp.subTitle];
                    NSLog(@"list count = %ld  %@", (long)[listUnfollow count], temp.subTitle);
                    new.subTitle = str;
                    new.date = temp.date;
                    new.isSeen = temp.isSeen;
                    [DBTopic executeQueryInsertTopic:new dbTopic:dbTopic];
        }
    // Form the query.
    NSString *query = @"SELECT * FROM Topic ORDER BY Type,Date DESC";
    NSMutableArray *dataTopic =[[NSMutableArray alloc]init];
    dataTopic = [[NSMutableArray alloc] initWithArray:[dbTopic loadDataTopicFromDB:query]];
    // Reload the table view.
    return dataTopic;
    
}
+(Topic*) loadDataTopicForID:(DBTopic*)dbTopic TopicID:(NSString*) topicID{
     //Form the query.
    NSString *query = [NSString
                       stringWithFormat:@"SELECT * FROM Topic WHERE TopicID = \"%@\" ORDER BY Type,Date DESC",topicID];
    NSMutableArray *dataTopic =[[NSMutableArray alloc]init];
    dataTopic = [[NSMutableArray alloc] initWithArray:[dbTopic loadDataTopicFromDB:query]];
    // Reload the table view.
    if ([dataTopic count] == 0){
        NSMutableArray *data =[[NSMutableArray alloc]init];
        data = [[NSMutableArray alloc] initWithArray:[dbTopic loadDataTopicUnfollowFromDB:query]];
        if ([data count] == 0){
            return nil;
        } else {
           return data[0];
        }
    }
    return dataTopic[0];
    
}
+(NSMutableArray*) loadDataTopicUnfollow:(DBTopic*)dbTopic{
    // Form the query.
    NSString *query = @"SELECT * FROM Topic ORDER BY Type,Date DESC";
   NSMutableArray *dataTopicUnfollow =[[NSMutableArray alloc]init];
   dataTopicUnfollow = [[NSMutableArray alloc] initWithArray:[dbTopic loadDataTopicUnfollowFromDB:query]];
    NSLog(@"ok ok ok %ld", (long)[dataTopicUnfollow count]);
    // Reload the table view.
    return dataTopicUnfollow;
}
-(void)executeQuery:(NSString *)query{
    // Run the query and indicate that is executable.
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}
+(void) executeQueryInsertTopic:(Topic*)topic dbTopic:(DBTopic*)dbTopic{
    NSString * query  = [NSString
                         stringWithFormat:@"INSERT INTO Topic (TopicID,Type,SenderID, AvatarURL, Title, SubTitle,Date,Unfollow, IsSeen) VALUES (\"%@\",%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%ld,%ld);",topic.topicID,(long)topic.type,topic.senderID,topic.avatarURL,topic.title,topic.subTitle,topic.date,(long)topic.unfollow,topic.isSeen];
    [dbTopic executeQuery:query];
    
}
+(void) executeQueryUpdateTopic:(Topic*)topic dbTopic:(DBTopic*)dbTopic{
    NSString *query= [NSString
                      stringWithFormat:@"UPDATE Topic SET Type = %ld,Title = \"%@\",SubTitle = \"%@\",Date = \"%@\",Unfollow=%ld,IsSeen=%ld WHERE TopicID = \"%@\";",topic.type,topic.title,topic.subTitle,topic.date,topic.unfollow,topic.isSeen, topic.topicID];
    [dbTopic executeQuery:query];
    
}
+(void) executeQueryDeleteTopic:(Topic*)topic dbTopic:(DBTopic*)dbTopic{
    NSString *query= [NSString
                      stringWithFormat:@"DELETE FROM Topic WHERE TopicID = \"%@\";" ,topic.topicID];
    [dbTopic executeQuery:query];
}

+(void) UpdateTopic:(NSMutableArray*)dataMessages dbMessages:(DBMessages *)dbMessages dbTopic:(DBTopic*)dbtopic senderID:(NSString*)senderID toSenderID:(NSString*)toSenderID{
    dataMessages = [DBMessages loadDataMessages:senderID toSenderID:toSenderID dbMessages:dbMessages];
    NSString *topicID = [toSenderID stringByAppendingString:senderID];
    NSLog(@"Topic ID update messsage last %@", topicID);
    Topic *topic = [DBTopic loadDataTopicForID:dbtopic TopicID:topicID];
    Topic *new = [[Topic alloc] init];
    NSLog(@"Topic ID update messsage last %@", topic.topicID);
    
    if([dataMessages count] == 0){
        
        NSLog(@"emtyemty  %@", topicID);
        new.topicID = topicID;
        [DBTopic executeQueryDeleteTopic:new dbTopic:dbtopic];
        
    } else {
        if (topic.topicID == nil){
            NSLog(@"Message khong ton tai topic");
            NSString *subTitle = [dataMessages[[dataMessages count] - 1] text];
            NSString *date = [dataMessages[[dataMessages count] - 1] timeMesages];
            Topic *new = [Topic init:topicID type:1 senderID:toSenderID avatarURL:@"N/A" title:@"Idol" subtitle:subTitle date:date unfollow:1 isSeen:1];
            [DBTopic executeQueryInsertTopic:new dbTopic:dbtopic];
            topic = [DBTopic loadDataTopicForID:dbtopic TopicID:topicID];
        }
        
        NSString *str1 = [dataMessages[[dataMessages count] - 1] senderID];
        if ([str1 isEqualToString:senderID]){
            NSString *str = [@"Bạn: " stringByAppendingString:[dataMessages[[dataMessages count] - 1] text]];
            topic.subTitle = str;
            topic.isSeen = [dataMessages[[dataMessages count] - 1] stateSeen];
        } else {
            topic.subTitle = [dataMessages[[dataMessages count] - 1] text];
            topic.isSeen = [dataMessages[[dataMessages count] - 1] stateSeen];
        }
        topic.date = [dataMessages[[dataMessages count] - 1] timeMesages];
        [DBTopic executeQueryUpdateTopic:topic dbTopic:dbtopic];
    }
}

+(void) UpdateContentTopicUnfollow:(DBTopic*)dbtopic senderID:(NSString*)senderID{
    NSMutableArray* listUnfollow = [[NSMutableArray alloc] init];
    NSString *topicID = [@"1000" stringByAppendingString:senderID];
    Topic *topic = [DBTopic loadDataTopicForID:dbtopic TopicID:topicID];
    listUnfollow = [DBTopic loadDataTopicUnfollow:dbtopic];
    if ([listUnfollow count] != 0){
        Topic *temp = [listUnfollow objectAtIndex:0];
        NSString *str = [temp.title stringByAppendingString:@":"];
        str = [str stringByAppendingString:temp.subTitle];
        topic.subTitle = str;
        topic.date = temp.date;
        topic.isSeen = temp.isSeen;
        [DBTopic executeQueryUpdateTopic:topic dbTopic:dbtopic];
    }
    else {
        [DBTopic executeQueryDeleteTopic:topic dbTopic:dbtopic];
    }
}

@end

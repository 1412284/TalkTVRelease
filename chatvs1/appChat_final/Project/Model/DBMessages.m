//
//  DBMessages.m
//  Project
//
//  Created by CPU11197-local on 11/3/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "DBMessages.h"
#import "MessageDetail.h"
#import <sqlite3.h>

@interface DBMessages()
@property (nonatomic, strong) NSMutableArray *arrResults;
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end

@implementation DBMessages

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
    
    self.arrResults = [[NSMutableArray alloc] init];// khởi tạo lại vùng nhớ cho mảng
    
    //    // Tương tự đối với mảng chứa các trường tên cột
    //    if (self.arrColumnNames != nil) {
    //        [self.arrColumnNames removeAllObjects];
    //        self.arrColumnNames = nil;
    //    }
    //    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    
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
                MessageDetail *messages;
                
                // Thực thi truy vấn cho phép đọc thành công!
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // trả về tổng số cột
                   int totalColumns = sqlite3_column_count(compiledStatement);
                    // Khởi tạo mảng.
                    arrDataRow = [[NSMutableArray alloc] init];
                    messages = [[MessageDetail alloc] init];
                    [self createData_column_text:messages compiledStatement:compiledStatement];
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
                      
                            [self.arrResults addObject:messages];
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
-(void)createData_column_text:(MessageDetail*)messages compiledStatement:(sqlite3_stmt*)compiledStatement{
    int _messagesID = 0;
    int _topicID = 1;
    int _type = 2;
    int _senderID = 3;
    int _toSenderID = 4;
    int _name = 5;
    int _avatarURL = 6;
    int _text = 7;
    int _time = 8;
    int _acttion = 9;
    int _title = 10;
    int _stateSeen = 11;
    char *dbDataMessagesID = (char *)sqlite3_column_text(compiledStatement, _messagesID);
    char *dbDataType = (char *)sqlite3_column_text(compiledStatement, _type);
    char *dbDataSenderID = (char *)sqlite3_column_text(compiledStatement, _senderID);
    char *dbDataToSenderID = (char *)sqlite3_column_text(compiledStatement, _toSenderID);
    char *dbDataTime = (char *)sqlite3_column_text(compiledStatement, _time);
    char *dbDataTitle = (char *)sqlite3_column_text(compiledStatement, _title);
    char *dbDataAvatarURL = (char *)sqlite3_column_text(compiledStatement, _avatarURL);
    char *dbDatanameSenderID = (char *)sqlite3_column_text(compiledStatement, _name);
    char *dbDataText = (char *)sqlite3_column_text(compiledStatement, _text);
    char *dbDataTopicID = (char *)sqlite3_column_text(compiledStatement, _topicID);
    char *dbDataActtion = (char *)sqlite3_column_text(compiledStatement, _acttion);
    char *dbDataStateSeen = (char *)sqlite3_column_text(compiledStatement, _stateSeen);
    messages.messagesID = [NSString  stringWithUTF8String:dbDataMessagesID];
    messages.topicID = [NSString  stringWithUTF8String:dbDataTopicID];
    messages.type = (NSInteger)[self convertInt:dbDataType];
    messages.senderID = [NSString stringWithUTF8String:dbDataSenderID];
    messages.toSenderID = [NSString stringWithUTF8String:dbDataToSenderID];
    messages.avatarURLSenderID = [NSString  stringWithUTF8String:dbDataAvatarURL];
    messages.nameSenderID = [NSString  stringWithUTF8String:dbDatanameSenderID];
    messages.title = [NSString  stringWithUTF8String:dbDataTitle];
    messages.text = [NSString  stringWithUTF8String:dbDataText];
    messages.timeMesages = [NSString  stringWithUTF8String:dbDataTime];
    messages.acttion = [NSString  stringWithUTF8String:dbDataActtion];
    messages.stateSeen = (NSInteger)[self convertInt:dbDataStateSeen];
}

-(NSArray *)loadDataMesagesFromDB:(NSString *)query{
    // Run the query and indicate that is not executable.
    // The query string is converted to a char* object.
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    // Returned the loaded results.
    return (NSArray *)self.arrResults;
}
-(void)executeQuery:(NSString *)query{
    // Run the query and indicate that is executable.
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
    NSLog(@"executeQuery");
}
//+(Topic*) loadDataTopicMessagesForID:(Topic*)ListID dbMessages:(DBMessages*)dbMessages{
//    Topic *topic = [[Topic alloc] init];
//    NSMutableArray *dataMessages =[[NSMutableArray alloc]init];
//    for (Topic *data in ListID) {
//    NSString *str1 = [[data senderID] stringByAppendingString:@"1000liem6396"];
//    NSString *str2 = [@"1000liem6396" stringByAppendingString:[data senderID]];
//    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Messages WHERE TopicID == \"%@\" OR TopicID == \"%@\" ORDER BY Time ASC",str1,str2];
//    NSLog(@"*query. =. %@",query);
//    //NSString *query = @"select * from peopleInfo";
//    NSMutableArray *Messages =[[NSMutableArray alloc]init];
//        Messages = [[NSMutableArray  alloc] initWithArray:[dbMessages loadDataMesagesFromDB:query]];
//        [dataMessages addObjectsFromArray:Messages];
//    }
//    if ([dataMessages count] == 0 ) {
//        return nil;
//    }
//    MessageDetail * messagesDetail = [dataMessages objectAtIndex:[dataMessages count]-1];
//    topic.subTitle = messagesDetail.text;
//    topic.date = messagesDetail.timeMesages;
//    return topic;
//}
+(NSMutableArray*) loadDataMessages:(NSString*)senderID toSenderID:(NSString*)toSenderID dbMessages:(DBMessages*)dbMessages{
    // Form the query.
    NSString *str1 = [senderID stringByAppendingString:toSenderID];
    NSString *str2 = [toSenderID stringByAppendingString:senderID];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Messages WHERE TopicID == \"%@\" OR TopicID == \"%@\" ORDER BY Time ASC",str1,str2];
    NSLog(@"*query. =. %@",query);
    //NSString *query = @"select * from peopleInfo";
    NSMutableArray *dataMessages =[[NSMutableArray alloc]init];
     dataMessages = [[NSMutableArray  alloc] initWithArray:[dbMessages loadDataMesagesFromDB:query]];
    NSLog(@"mesages %ld",(unsigned long)[dataMessages count]);
    //for(int i = dataMessages)
    return  dataMessages;
}
+(void) executeQueryInsert:(MessageDetail*)messages  dbMessages:(DBMessages*)dbMessages{
    NSString * query  = [NSString
                         stringWithFormat:@"INSERT INTO Messages (MessagesID,TopicID,Type,SenderID,ToSenderID,NameSenderID,AvatarSenderID,Text,Time,Action,Title,StateSeen) VALUES (\"%@\",\"%@\",%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%ld);",messages.messagesID,messages.topicID,(long)messages.type,messages.senderID,messages.toSenderID,messages.nameSenderID,messages.avatarURLSenderID,messages.text,messages.timeMesages,messages.acttion,messages.title,(long)messages.stateSeen];
    [dbMessages executeQuery:query];
    
}
+(void) executeQueryUpdate:(MessageDetail*)messages  dbMessages:(DBMessages*)dbMessages{
    NSString *query= [NSString
                      stringWithFormat:@"UPDATE Messages SET StateSeen=%ld WHERE MessagesID = \"%@\";",messages.stateSeen,messages.messagesID];
    [dbMessages executeQuery:query];
    
}
+(void) executeQueryDelete:(MessageDetail*)messages  dbMessages:(DBMessages*)dbMessages{
    NSString *query= [NSString
                      stringWithFormat:@"DELETE FROM Messages WHERE MessagesID = \"%@\";" ,messages.messagesID];
    [dbMessages executeQuery:query];
}



@end


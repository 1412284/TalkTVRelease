//
//  TopicData.m
//  Topic
//
//  Created by Do Nhat Khanh on 9/15/17.
//  Copyright © 2017 Do Nhat Khanh. All rights reserved.
//

#import "TopicData.h"
#import "Topic.h"
@implementation TopicData
+ (NSArray *)getTopicListData{
    Topic *news = [[Topic alloc] init];
    news.uin = 0;
    news.title = @"TalkTV";
    news.subTitle = @"Tin tức mới nhất từ TalkTV";
    
    Topic *group = [[Topic alloc] init];
    group.uin = 1;
    group.child = [TopicData getGroupData];;
    group.title = @"Người lạ";
    group.subTitle = @"Danh sách những người bạn chưa kết bạn";

    Topic *friendA = [[Topic alloc] init];
    friendA.uin = 398875240;
    friendA.title = @"Phi Long";
    friendA.subTitle = @"Đang coi room nào vậy mày?";
    
    Topic *friendB = [[Topic alloc] init];
    friendB.uin = 398875240;
    friendB.title = @"Thanh Trúc";
    friendB.subTitle = @"Nạp cho tui cái card 1tr coi?";
    return @[news,group,friendA,friendB];
}

+ (NSArray *)getGroupData{
    Topic *friendA = [[Topic alloc] init];
    friendA.uin = 398875240;
    friendA.title = @"Thu Thuỷ";
    friendA.subTitle = @"Bạn coi hướng dẫn trên FanPage ấy?";
    return @[friendA,friendA,friendA,friendA,friendA,friendA,friendA,friendA];
}
@end

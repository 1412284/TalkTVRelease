//
//  sort.m
//  Project
//
//  Created by liem on 11/12/17.
//  Copyright © 2017 CPU11197-local. All rights reserved.
//

#import "sort.h"
#import "MessageDetail.h"
#import "DBMessages.h"
#import "Date.h"

@implementation sort
+(NSMutableArray*)quickSortMessagesTime:(NSMutableArray*)unsortedDataArray
{
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *greaterArray =[[NSMutableArray alloc] init];
    if ([unsortedDataArray count] <1)
    {
        return nil;
    }
    int randomPivotPoint = arc4random() % [unsortedDataArray count];
    MessageDetail *pivotValue = [unsortedDataArray objectAtIndex:randomPivotPoint];
    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
//    for (NSNumber *num in unsortedDataArray)
//    {
//        //quickSortCount++; //This is required to see how many iterations does it take to sort the array using quick sort
//        if (num < pivotValue)
//        {
//            [lessArray addObject:num];
//        }
//        else
//        {
//            [greaterArray addObject:num];
//        }
//    }
       for (NSInteger i = 0 ; i< [unsortedDataArray count]; i++){
              MessageDetail* value = [unsortedDataArray objectAtIndex:i];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateStyle:NSDateFormatterMediumStyle];
                [dateFormat setDateFormat:@"dd/MM/yyyy h:mm:ss a"];
                NSDate *date1 = [dateFormat dateFromString:[value timeMesages]];
                NSDate *date2=  [dateFormat dateFromString:[pivotValue timeMesages]];
                if([date1 compare:date2] == NSOrderedDescending){
                    [lessArray addObject:value];
                } else if ([date1 compare:date2] != NSOrderedDescending){
                    [greaterArray addObject:value];
                }
            }
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:greaterArray]];
    return sortedArray;

}
-( NSArray *)mergeSort:( NSArray *)unsortedArray
{
    if ([unsortedArray count] < 2)
    {
        return unsortedArray;
    }
    long middle = ([unsortedArray count]/2);
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
    NSArray *rightArr = [unsortedArray subarrayWithRange:right];
    NSArray *leftArr = [unsortedArray subarrayWithRange:left];
    //Or iterate through the unsortedArray and create your left and right array
    //for left array iteration starts at index =0 and stops at middle, for right array iteration starts at midde and end at the end of the unsorted array
     NSArray *resultArray = [self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
    return resultArray;
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count])
    {
        MessageDetail* leftArrvalue = [leftArr objectAtIndex:left];
        MessageDetail* rightArrvalue = [leftArr objectAtIndex:right];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        [dateFormat setDateFormat:@"dd/MM/yyyy h:mm:ss a"];
        NSDate *date1 = [dateFormat dateFromString:[leftArrvalue timeMesages]];
        NSDate *date2=  [dateFormat dateFromString:[rightArrvalue timeMesages]];
        if([date1 compare:date2] == NSOrderedDescending){
        //if ([[leftArr objectAtIndex:left] intValue] < [[rightArr objectAtIndex:right] intValue]){
            [result addObject:[leftArr objectAtIndex:left++]];
        }
        else
        {
            [result addObject:[rightArr objectAtIndex:right++]];
        }
    }
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}
+(NSMutableArray*)quickSort:(NSMutableArray*)unsortedArray
{
    NSInteger numberOfElements = [unsortedArray count];
    if(numberOfElements <= 1){
        return unsortedArray;
    }

    NSNumber* pivotValue = [unsortedArray objectAtIndex: numberOfElements/2];

    NSMutableArray* lessArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    NSMutableArray* moreArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];

    for (NSNumber* value in unsortedArray) {
        if([value floatValue] < [pivotValue floatValue]){
            [lessArray addObject:value];
        } else if([value floatValue] > [pivotValue floatValue]){
            [moreArray addObject:value];
        }
    }

    NSMutableArray* sortedArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:moreArray]];

    return [sortedArray copy];
}
//NSMutableArray *data = [[NSMutableArray alloc] init];
//    for (NSInteger i = 1 ; i< [self.dataMessages count]; i++){
//        NSLog(@"%@", [self.dataMessages[i] timeMesages]);
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
//        [dateFormat setDateFormat:@"dd/MM/yyyy h:mm:ss a"];
//        NSDate *date1 = [dateFormat dateFromString: [self.dataMessages[i] timeMesages]];
//        NSDate *date2= [Date DateForString:[self.dataMessages[i-1] timeMesages]];
//        if ([Date isLaterThan:date1 date2:date2]== YES) {
//                    NSLog(@"date1 is later than date2");
//                } else if ([Date isLaterThan:date1 date2:date2]== NO ) {
//                    NSLog(@"date1 is earlier than date2");
//                } else {
//                    NSLog(@"dates are the same");
//                }
//    }
//NSArray *array = [NSArray arrayWithArray:self.dataMessages];
//MessageDetail* pivotValue = [self.dataMessages objectAtIndex:4];
//MessageDetail* pivotValue2 = [self.dataMessages objectAtIndex:3];
//NSDate *date1 = [Date DateForString:[pivotValue timeMesages]];
//NSDate *date2 = [Date DateForString:[pivotValue2 timeMesages]];
//    if ([Date isLaterThan:date1 date2:date2]== YES) {
//        NSLog(@"date1 is later than date2");
//    } else if ([Date isLaterThan:date1 date2:date2]== NO ) {
//        NSLog(@"date1 is earlier than date2");
//    } else {
//        NSLog(@"dates are the same");
//    }
//            if([Date isEarlierThan:date1 date2:date2]){
//                NSLog(@"be hon;");
//            } else if(![Date isEarlierThan:date1 date2:date2]){
//                 NSLog(@"lon hon;");
//            }
//     NSMutableArray *myIntegers = [NSMutableArray array];
//     for (NSInteger i = 0; i < 100; i++)
//    {
//        if (i%2 == 0)
//        {
//            [myIntegers addObject:[NSNumber numberWithInteger:i-5]];
//        }
//        else{
//            [myIntegers addObject:[NSNumber numberWithInteger:i+10]];
//        }
//    }
//    for (NSInteger i = 0 ; i< [myIntegers count]; i++){
//        NSLog(@"%@", myIntegers[i]);
//    }
//    NSMutableArray *myInteger2 = [sort quickSort:myIntegers];
//    for (NSInteger i = 0 ; i< [myInteger2 count]; i++){
//        NSLog(@"%@", myInteger2[i]);
//    }
@end

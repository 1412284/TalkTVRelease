//
//  NSDate+NVTimeAgo.h
 
   /* Date Format
    -----------
     < 1 minute       	= "Just now"
     < 1 hour         	= "x minutes ago"
     Today            	= "x hours ago"
     Yesterday        	= "Yesterday at 1:28pm"
     < Last 7 days    	= "Friday at 1:48am"
     < Last 30 days   	= "March 30 at 1:14 pm"
     < 1 year         	= "September 15"
     Anything else    	= "September 9, 2011"
 
 
*/

#import <Foundation/Foundation.h>

@interface NSDate (NVFacebookTimeAgo)

/*
    Mysql Datetime Formatted As Time Ago
    Takes in a mysql datetime string and returns the Time Ago date format
 */
+ (NSString*)mysqlDatetimeFormattedAsTimeAgo:(NSString *)mysqlDatetime;


/*
    Formatted As Time Ago
    Returns the time formatted as Time Ago (in the style of Facebook's mobile date formatting)
 */
- (NSString *)formattedAsTimeAgo;

@end

//
//  NSDate+YYBInternetDateTime.h
//  ImageWaterMakeExample
//
//  Created by yyb on 16/5/23.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import <Foundation/Foundation.h>
// Formatting hints
typedef enum {
    DateFormatHintNone,
    DateFormatHintRFC822,
    DateFormatHintRFC3339
} DateFormatHint;
// A category to parse internet date & time strings
@interface NSDate (YYBInternetDateTime)

+ (NSDate *)dateFromInternetDateTimeString:(NSString *)dateString formatHint:(DateFormatHint)hint;
+ (NSDate *)dateFromRFC3339String:(NSString *)dateString;
+ (NSDate *)dateFromRFC822String:(NSString *)dateString;

/**
 *  获取服务器时间后转换为字符串 2016-05-23 16:29:45 +0000
 *
 *  @param completionHandler 字符串和错误信息
 */
+ (void)getCurrentTimeFromService:(void (^)(NSString * currentTimeStr, NSError *error))completionHandler;
@end

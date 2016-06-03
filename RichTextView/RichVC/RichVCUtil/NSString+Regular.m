//
//  NSString+Regular.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)
//输出正则里面的内容//输出正则里面的内容
-(NSDictionary *)RXImageUrl
{
    NSString *pattern = @"<img src=\"([^\\s]*)\" w=\"([^\\s]*)\" h=\"([^\\s]*)\"\\s*/>";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                options:0
                                                                                  error:NULL];
    NSArray *lines = [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSMutableArray * resultArr=[NSMutableArray array];
    for (NSTextCheckingResult *textCheckingResult in lines) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        
        //0 代表整个正则内容
        NSString* value1 = [self substringWithRange:[textCheckingResult rangeAtIndex:1]];
        NSString* value2 = [self substringWithRange:[textCheckingResult rangeAtIndex:2]];
        NSString* value3 = [self substringWithRange:[textCheckingResult rangeAtIndex:3]];
        
        result[@"src"] = value1;
        result[@"w"] = value2;
        result[@"h"] = value3;
        [resultArr addObject:result];
        
    }
    
    
    return resultArr.firstObject;
}
//输出正则里面的内容
-(NSArray *)RXToArray
{
    NSString *pattern = @"<img src=\"([^\\s]*)\" w=\"([^\\s]*)\" h=\"([^\\s]*)\"\\s*/>";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                options:0
                                                                                  error:NULL];
    NSArray *lines = [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSMutableArray * resultArr=[NSMutableArray array];
    for (NSTextCheckingResult *textCheckingResult in lines) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        
        //0 代表整个正则内容
        NSString* value1 = [self substringWithRange:[textCheckingResult rangeAtIndex:1]];
        NSString* value2 = [self substringWithRange:[textCheckingResult rangeAtIndex:2]];
        NSString* value3 = [self substringWithRange:[textCheckingResult rangeAtIndex:3]];
        
        result[@"src"] = value1;
        result[@"w"] = value2;
        result[@"h"] = value3;
        [resultArr addObject:result];
        
    }
    
    
    return resultArr;
}
//替换正则
-(NSString *)RXToString
{
    
    NSString *pattern = @"<img src=\"([^\\s]*)\" w=\"([^\\s]*)\" h=\"([^\\s]*)\"\\s*/>";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    
    
    NSString *rxString = [regex stringByReplacingMatchesInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])
                                                    withTemplate:RICHTEXT_IMAGE];
    return rxString;
    
}
//分隔成字符串数组
-(NSArray *)RXToStringArray
{
    NSString *pattern = @"<img src=\"([^\\s]*)\" w=\"([^\\s]*)\" h=\"([^\\s]*)\"\\s*/>";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    
    
    NSString *rxString = [regex stringByReplacingMatchesInString:self
                                                         options:0
                                                           range:NSMakeRange(0, [self length])
                                                    withTemplate:RICHTEXT_IMAGE];
    
    
    
    //    //这里是把字符串分割成数组，
    NSArray * strArr=[rxString  componentsSeparatedByString:RICHTEXT_IMAGE];
    return strArr;
    
}
@end

//
//  NSJSON+Extension.m
//  RichTextView
//
//  Created by     songguolin on 16/6/1.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "NSJSON+Extension.h"

// NSArray
@implementation NSArray (_JSON_)

+ (NSArray*)arrayWithJSON:(NSString*)json
{
    NSArray* ret = nil;
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

// NSMutableArray
@implementation NSMutableArray (_JSON_)

+ (NSArray*)arrayWithJSON:(NSString*)json
{
    NSMutableArray* ret = nil;
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

// NSDictionary
@implementation NSDictionary (_JSON_)

+ (NSDictionary*)dictWithJSON:(NSString*)json
{
    NSDictionary* ret = nil;
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

// NSMutableDictionary
@implementation NSMutableDictionary (_JSON_)

+ (NSMutableDictionary*)dictWithJSON:(NSString*)json
{
    NSMutableDictionary* ret = nil;
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData != nil)
    {
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
    }
    return ret;
}

- (NSString*)toJSON
{
    NSString* json = @"";
    NSData* ret = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    if (ret != nil)
    {
        json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
    }
    return json;
}

@end

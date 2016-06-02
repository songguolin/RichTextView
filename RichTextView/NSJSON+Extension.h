//
//  NSJSON+Extension.h
//  RichTextView
//
//  Created by     songguolin on 16/6/1.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (_JSON_)

+ (NSArray*)arrayWithJSON:(NSString*)json;
- (NSString*)toJSON;

@end

@interface NSMutableArray (_JSON_)

+ (NSMutableArray*)arrayWithJSON:(NSString*)json;
- (NSString*)toJSON;

@end

@interface NSDictionary (_JSON_)

+ (NSDictionary*)dictWithJSON:(NSString*)json;
- (NSString*)toJSON;

@end

@interface NSMutableDictionary (_JSON_)

+ (NSMutableDictionary*)dictWithJSON:(NSString*)json;
- (NSString*)toJSON;

@end

//
//  NSString+Regular.h
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

/**
 *  输出正则里面的内容
 *
 *  @return NSDictionary
 */
-(NSDictionary *)RXImageUrl;

/**
 *  输出正则里面的内容
 *
 *  @return NSArray
 */
-(NSArray *)RXToArray;

/**
 *  富文本图片标识 替换正则
 *
 *  @return NSString
 */
-(NSString *)RXToString;

/**
 *  富文本 按照图片标示 分隔成字符串数组
 *
 *  @return NSArray
 */
-(NSArray *)RXToStringArray;
@end

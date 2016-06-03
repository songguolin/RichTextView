//
//  NSString+CaclSize.h
//  果动校园
//
//  Created by AnYanbo on 15/3/17.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CaclSize)
/**
 *  Description
 *
 *  @param size
 *  @param font
 *  NSLineBreakByWordWrapping,以单词为单位换行，以单位为单位截断。
 *  @return return value description
 */
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
/**
 *  calculateSize
 *
 *  @param size
 *  @param font
 *  @param mode 
    //ios7 显示
    NSLineBreakByWordWrapping,以单词为单位换行，以单位为单位截断。
    NSLineBreakByCharWrapping,以字符为单位换行，以单位为单位截断。
    NSLineBreakByClipping,以单词为单位换行。以字符为单位截断。
    NSLineBreakByTruncatingHead,以单词为单位换行。如果是单行，则开始部分有省略号。如果是多行，则中间有省略号，省略号后面有4个字符。:
 *
 *  @return
 */
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font lineBreakMode:(NSLineBreakMode)mode;

@end

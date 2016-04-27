//
//  NSAttributedString+html.h
//  RichTextView
//
//  Created by     songguolin on 16/4/26.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSAttributedString (html)
/**
 *  textview的内容转化为html格式的字符串
 *
 *  @return 普通字符串 html
 */
-(NSString *)toHtmlString;
/**
 *  html转化为属性字符串，可直接显示在textview
 *
 *  @param content 内容，网页
 *
 *  @return 属性字符串
 */
+(NSAttributedString *)toAttributedString:(NSString *)html;
@end

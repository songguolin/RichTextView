//
//  NSAttributedString+RichText.h
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (RichText)
//返回带有图片标示的字符串
- (NSString *)getPlainString;

//返回数组，每个数组是一种属性和对应的内容
-(NSMutableArray *)getArrayWithAttributed;

//获取颜色值
- (NSString *)getHexStringByColor:(UIColor *)originColor;
//获取有 rgb，alpha的字典
- (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor;
@end

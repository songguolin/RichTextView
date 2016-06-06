//
//  NSAttributedString+RichText.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSAttributedString+RichText.h"
#import "ImageTextAttachment.h"



@implementation NSAttributedString (RichText)
- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[ImageTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((ImageTextAttachment *) value).imageTag];
                          base += ((ImageTextAttachment *) value).imageTag.length - 1;
                      }
                  }];
    
    return plainString;
}
-(NSArray *)getImgaeArray
{
    
    
    NSMutableArray * imageArr=[NSMutableArray array];
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[ImageTextAttachment class]]) {
                          ImageTextAttachment* TA=(ImageTextAttachment*)value;
                          [imageArr addObject:TA.image];
                      }
                  }];
    
    return imageArr;
}
-(NSMutableArray *)getArrayWithAttributed
{
    
static NSDictionary *nameToWeight;
    nameToWeight = @{
                                              @"normal": @(UIFontWeightRegular),
                                              @"bold": @(UIFontWeightBold),
                                              @"ultralight": @(UIFontWeightUltraLight),
                                              @"thin": @(UIFontWeightThin),
                                              @"light": @(UIFontWeightLight),
                                              @"regular": @(UIFontWeightRegular),
                                              @"medium": @(UIFontWeightMedium),
                                              @"semibold": @(UIFontWeightSemibold),
                                              @"bold": @(UIFontWeightBold),
                                              @"heavy": @(UIFontWeightHeavy),
                                              @"black": @(UIFontWeightBlack),
                                              };
    NSMutableArray * array=[NSMutableArray array];

    //枚举出所有的附件字符串-这个是顺序来的NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
    [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary *Attributes, NSRange range, BOOL *stop) {
        
       
        NSMutableDictionary * AttributeDict=[NSMutableDictionary dictionary];
        //1.  通过range取出相应的字符串
        NSString * title=[self.string substringWithRange:range];
        //1.把属性字典和相应字符串成为一个大字典
        if (title!=nil) {
            [AttributeDict setObject:title forKey:@"title"];
        }
        //2.把属性存储为一个字典
        //2.取出相应的属性
        //2.字体－大小－加粗:NSOriginalFont,NSFont这里有两个
        UIFont * font= Attributes[@"NSFont"];
        if (font!=nil) {
            //这里这两种都可以
            //             NSLog(@"fontSize1--%@",[font.fontDescriptor objectForKey:@"NSFontSizeAttribute"]);
            //             NSLog(@"fontSize2--%f",font.fontDescriptor.pointSize);
            CGFloat size=font.fontDescriptor.pointSize;
            [AttributeDict setObject:[NSNumber numberWithFloat:size] forKey:@"font"];
        }
        //2.取出字体描述fontDescriptor
        NSDictionary *traits = [font.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
        CGFloat weight=[traits[UIFontWeightTrait] doubleValue];

        
        if (weight>0.0) {
            [AttributeDict setObject:[NSNumber numberWithBool:YES] forKey:@"bold"];
        }
        else
        {
            [AttributeDict setObject:[NSNumber numberWithBool:NO] forKey:@"bold"];
        }
        //可以得到字体加粗的大小
        //         NSLog(@"fontbold--%f",[traits[UIFontWeightTrait] doubleValue]);
        //            if ([traits[UIFontWeightTrait] doubleValue] == 0.0) {
        //                for (NSString *name in nameToWeight) {
        //                    if ([font.fontName.lowercaseString containsString:name]) {
        //                        NSLog(@"normal---%f",[nameToWeight[name] doubleValue]) ;
        //                    }
        //                }
        //            }
        
        
        
        //2.字体－颜色
        UIColor * fontColor= Attributes[@"NSColor"];
        if (fontColor!=nil) {
            
            [AttributeDict setObject:[fontColor HEXString] forKey:@"color"];
        }
        //2.图片
        ImageTextAttachment * ImageAtt = Attributes[@"NSAttachment"];
        if (ImageAtt!=nil) {
            [AttributeDict setObject:ImageAtt.image forKey:@"image"];
            //这里为title加上图片标示
            [AttributeDict setObject:ImageAtt.imageTag forKey:@"title"];
        }
        //2.行间距
        NSParagraphStyle * paragraphStyle= Attributes[@"NSParagraphStyle"];
        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.lineSpacing] forKey:@"lineSpace"];
        
        
        //4.返回一个数组
        [array addObject:AttributeDict];
        
        
    }];
    
    
    return array;
    
    
    
    //    //枚举出所有的附件字符串-这个是反着来的NSAttributedStringEnumerationReverse，
    //    [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary *Attributes, NSRange range, BOOL *stop) {
    //
    //
    //         NSMutableDictionary * AttributeDict=[NSMutableDictionary dictionary];
    //        //1.  通过range取出相应的字符串
    //        NSString * title=[self.string substringWithRange:range];
    //        //1.把属性字典和相应字符串成为一个大字典
    //        if (title!=nil) {
    //            [AttributeDict setObject:title forKey:@"title"];
    //        }
    //        //2.把属性存储为一个字典
    //
    //        //2.取出相应的属性
    //        //2.字体－大小－加粗:NSOriginalFont,NSFont这里有两个
    //        UIFont * font= Attributes[@"NSFont"];
    //        if (font!=nil) {
    //            //这里这两种都可以
    ////             NSLog(@"fontSize1--%@",[font.fontDescriptor objectForKey:@"NSFontSizeAttribute"]);
    ////             NSLog(@"fontSize2--%f",font.fontDescriptor.pointSize);
    //            CGFloat size=font.fontDescriptor.pointSize;
    //            [AttributeDict setObject:[NSNumber numberWithFloat:size] forKey:@"font"];
    //        }
    //       //2.取出字体描述fontDescriptor
    //        NSDictionary *traits = [font.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
    //        CGFloat weight=[traits[UIFontWeightTrait] doubleValue];
    //        if (weight>0.0) {
    //             [AttributeDict setObject:[NSNumber numberWithBool:YES] forKey:@"bold"];
    //        }
    //        else
    //        {
    //             [AttributeDict setObject:[NSNumber numberWithBool:NO] forKey:@"bold"];
    //        }
    //        //可以得到字体加粗的大小
    ////         NSLog(@"fontbold--%f",[traits[UIFontWeightTrait] doubleValue]);
    ////            if ([traits[UIFontWeightTrait] doubleValue] == 0.0) {
    ////                for (NSString *name in nameToWeight) {
    ////                    if ([font.fontName.lowercaseString containsString:name]) {
    ////                        NSLog(@"normal---%f",[nameToWeight[name] doubleValue]) ;
    ////                    }
    ////                }
    ////            }
    //
    //
    //
    //         //2.字体－颜色
    //        UIColor * fontColor= Attributes[@"NSColor"];
    //        if (fontColor!=nil) {
    //
    //            [AttributeDict setObject:[self getRGBDictionaryByColor:fontColor] forKey:@"color"];
    //        }
    //        //2.图片
    //        ImageTextAttachment * ImageAtt = Attributes[@"NSAttachment"];
    //        if (ImageAtt!=nil) {
    //            [AttributeDict setObject:@"image" forKey:@"image"];
    //        }
    //        //2.行间距
    //       NSParagraphStyle * paragraphStyle= Attributes[@"NSParagraphStyle"];
    //        [AttributeDict setObject:[NSNumber numberWithFloat:paragraphStyle.lineSpacing] forKey:@"lineSpace"];
    //        
    //
    //        //4.返回一个数组
    //        [array addObject:AttributeDict];
    //    
    //    }];
    
}


- (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor

{
    
    CGFloat r=0,g=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        
        [originColor getRed:&r green:&g blue:&b alpha:&a];
        
    }
    
    else {
        
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        
        r = components[0];
        
        g = components[1];
        
        b = components[2];
        
        a = components[3];
        
    }
    
    return @{@"R":@(r),
             
             @"G":@(g),
             
             @"B":@(b),
             
             @"A":@(a)};
    
}



@end

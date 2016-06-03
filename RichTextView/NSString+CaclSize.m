//
//  NSString+CaclSize.m
//  果动校园
//
//  Created by AnYanbo on 15/3/17.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSString+CaclSize.h"

@implementation NSString (CaclSize)


- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font
{
    
    return [self calculateSize:size font:font lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font lineBreakMode:(NSLineBreakMode)mode
{
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = mode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    }
//    else
//    {
//        expectedLabelSize = [self sizeWithFont:font
//                             constrainedToSize:size
//                                 lineBreakMode:mode];
//  
//    }
    
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height + 5.0f));
}

@end

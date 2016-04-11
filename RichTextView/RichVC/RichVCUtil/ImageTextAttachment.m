//
//  ImageTextAttachment.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "ImageTextAttachment.h"

@implementation ImageTextAttachment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
        return CGRectMake(0, 0, _imageSize.width, _imageSize.height);
    
//    //调整图片大小
//    return CGRectMake( 0 , 0 , [[UIScreen mainScreen] bounds].size.width , 80);
   
}
- (UIImage *)scaleImage:(UIImage *)image withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end

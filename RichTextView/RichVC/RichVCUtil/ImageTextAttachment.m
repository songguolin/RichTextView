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

- (UIImage*)getMaxImage:(UIImage *)image withSize:(CGSize)size
{
    if (size.width == 0 || size.height == 0)
        return image;
    CGSize imgSize = image.size;
    float scale    = size.height / size.width;
    float imgScale = imgSize.height / imgSize.width;
    float width    = 0.0f;
    float height   = 0.0f;
    
    if (imgScale < scale && imgSize.width > size.width)
    {
        width  = size.width;
        height = width * imgScale;
    }
    else if (imgScale > scale && imgSize.height > size.height)
    {
        height = size.height;
        width  = height / imgScale;
    }
    else
    {
        width  = size.width;
        height = size.height;
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage* imagemax= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imagemax;
}
@end

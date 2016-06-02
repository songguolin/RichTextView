//
//  ImageTextAttachment.h
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextAttachment : NSTextAttachment
@property(strong, nonatomic) NSString *imageTag;
@property(assign, nonatomic) CGSize imageSize;  //For emoji image size

- (UIImage *)scaleImage:(UIImage *)image withSize:(CGSize)size;
- (UIImage*)getMaxImage:(UIImage *)image withSize:(CGSize)size;
@end

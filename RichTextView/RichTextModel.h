//
//  RichTextModel.h
//  RichTextView
//
//  Created by     songguolin on 16/6/1.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RichTextModel : NSObject
@property (nonatomic,assign) BOOL       bold;
@property (nonatomic,copy  ) NSString   * title;
@property (nonatomic,assign) NSUInteger lineSpace;
@property (nonatomic,assign) NSUInteger font;
@property (nonatomic,copy  ) NSString   * image;

@end

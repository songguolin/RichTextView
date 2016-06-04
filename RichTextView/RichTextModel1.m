//
//  RichTextModel1.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "RichTextModel1.h"

@implementation RichTextModel1

-(id)init
{
    self=[super init];
    if (self) {
        
     _picture=nil;
        
        
    }
    return self;
}
//如果使用的是MJExtension
- (void)mj_keyValuesDidFinishConvertingToObject
{
    //下面方法的调用 写在这里
    if (self.image!=nil) {
        NSDictionary * imageDict=[self.image RXImageUrl];
        
        
        NSString * imageStr= imageDict[@"src"];
        
        if (imageStr!=nil) {
           _picture=[[PictureModel alloc]init];
            _picture.imageurl=imageDict[@"src"];
            _picture.width=[imageDict[@"w"] floatValue];
            _picture.height=[imageDict[@"h"] floatValue];
            

        }
    }
   

    
}


@end

//
//  RichTextModel.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "RichTextModel.h"

@implementation RichTextModel

//如果使用的是MJExtension
- (void)mj_keyValuesDidFinishConvertingToObject
{
  //下面方法的调用 写在这里
  
}

-(void)setContent:(NSString *)content
{
    
    _content=content;
    if (self.content!=nil) {
        self.contentStrArr=[NSMutableArray arrayWithArray:[self.content RXToStringArray]];
        self.contentStr=[self.content RXToString];
        
        self.imageArr=[NSMutableArray array];
        NSArray * imageOfWH=[self.content RXToArray];
        
        if (self.imageArr!=nil) {
            [self.imageArr removeAllObjects];
        }
        //获取字符串中的图片
        for (NSDictionary * dict in imageOfWH) {
            if ([dict isKindOfClass:[NSDictionary class]]) {
                
                PictureModel * model=[[PictureModel alloc]init];
                model.imageurl=dict[@"src"];
                model.width=[dict[@"width"] floatValue];;
                model.height=[dict[@"height"] floatValue];
                [self.imageArr addObject:model];
                
                
               

            }
        }
        
        
        self.cellHeightArr=[NSMutableArray array];
        for (int i=0; i<self.contentStrArr.count; i++) {
            
            NSString * str=[self.contentStrArr objectAtIndex:i];
            CGSize textSize=CGSizeZero;
            CGFloat cellHeight=0.f;
            //注意这里的设置，是根据约束条件来的
            textSize=[str calculateSize:CGSizeMake(SCREEN_WIDTH-20, FLT_MAX) font:[UIFont systemFontOfSize:14.f]];
            
            if (i<self.contentStrArr.count-1) {
                PictureModel * model=[self.imageArr objectAtIndex:i];
                CGFloat ImgWidth=SCREEN_WIDTH-40;
                
                if (model.width>0||model.height>0) {
                    
                    CGFloat ImgHeight=model.height*ImgWidth/model.width;
                    NSLog(@"ImgHeight--%f",ImgHeight);
                    cellHeight=ImgHeight+textSize.height;
                    
                    [self.cellHeightArr addObject:[NSNumber numberWithFloat:cellHeight]];
                    
                }
                
            }
            else
            {
                NSString * str=[self.contentStrArr objectAtIndex:i];
                CGSize textSize=CGSizeZero;
              
                //注意这里的设置，是根据约束条件来的
                textSize=[str calculateSize:CGSizeMake(SCREEN_WIDTH-20, FLT_MAX) font:[UIFont systemFontOfSize:14.f]];
                [self.cellHeightArr addObject:[NSNumber numberWithFloat:textSize.height]];
            }
        }
        

        
    }
    
    
    
}
@end

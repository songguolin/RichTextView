//
//  RIchTextCompose.m
//  RichTextView
//
//  Created by     songguolin on 16/6/4.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "RIchTextCompose.h"

@implementation RIchTextCompose
+(NSMutableArray  *)composeDataArr:(NSArray *)dataArr
{

    
    NSMutableArray * viewModelArr=[NSMutableArray array];
    __block RichTextViewModel * viewTextModel=nil;
    __block RichTextViewModel * viewImageModel=nil;
    __block  NSMutableAttributedString * mutableAttributedStr=[[NSMutableAttributedString alloc]init];
    [dataArr enumerateObjectsUsingBlock:^(RichTextModel1 *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        

        if (model.image!=nil) {
            viewImageModel=[[RichTextViewModel alloc]init];
            
            
            //遇到 图片，加入字符串，加载图片，初始化心得字符串
            if (model.picture!=nil) {
                
                if (mutableAttributedStr.length>0) {
                    viewTextModel=[[RichTextViewModel alloc]init];
                    viewTextModel.attributedString=mutableAttributedStr;
                    
                    
                   CGRect rect=[mutableAttributedStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                    
                    viewTextModel.cellHeight=rect.size.height;
                     [viewModelArr addObject:viewTextModel];
                    
                    
                }
                
                viewImageModel.picture=model.picture;
                
                CGFloat ImageWidth=SCREEN_WIDTH-40;
                
                if ( viewImageModel.picture.height>0) {
                    
                    CGFloat ImgHeight= viewImageModel.picture.height*ImageWidth/ viewImageModel.picture.width;
                    viewImageModel.cellHeight=ImgHeight;
                    
                }
                
                [viewModelArr addObject:viewImageModel];
                
                //初始化心得字符串
                mutableAttributedStr=[[NSMutableAttributedString alloc]init];
            }
            
            
        }
        else
        {
            //这个属于自动换行，列表本身就是不同的单元格，无需换行了
            if ([model.title isEqualToString:@"\n"]&&model.lineSpace==0) {
                
            }
            else
            {
                NSString * plainStr=model.title;
                NSMutableAttributedString * attrubuteStr=[[NSMutableAttributedString alloc]initWithString:plainStr];
                //设置初始内容
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.lineSpacing = model.lineSpace;// 字体的行间距
                
                //是否加粗
                if (model.bold) {
                    NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:model.font],NSFontAttributeName,[UIColor colorWithHexString:model.color],NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
                    [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
                }
                else
                {
                    NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:model.font],NSFontAttributeName,[UIColor colorWithHexString:model.color],NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
                    [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
                }
                
                
                [mutableAttributedStr appendAttributedString:attrubuteStr];
                
                //当循环到最后一个
                if (idx==dataArr.count-1) {
                    if (mutableAttributedStr.length>0) {
                        viewTextModel=[[RichTextViewModel alloc]init];
                        viewTextModel.attributedString=mutableAttributedStr;
                        
                        
                        CGRect rect=[mutableAttributedStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                        
                        viewTextModel.cellHeight=rect.size.height;
                        [viewModelArr addObject:viewTextModel];
                        
                        
                    }

                }

            }
            
        }

    }];
    

    
    return viewModelArr;
    
}



@end

//
//  RichTextModel.h
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Regular.h"
#import "NSString+CaclSize.h"
@interface RichTextModel : NSObject


@property (nonatomic,copy   ) NSString       * content;//jsonString 上传到服务器的内容
//自己将富文本内容分解
@property (nonatomic,copy   ) NSString       * contentStr;   //带有图片标签的字符串
@property (nonatomic,strong ) NSMutableArray * contentStrArr;//从content 把文字内容分割成数组
@property (nonatomic,strong ) NSMutableArray * imageArr;    //从content 里面得到图片数组

@property (nonatomic,strong ) NSMutableArray * cellHeightArr;    //直接算出高度，优化tableview加载
@end

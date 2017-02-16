//
//  RIchTextCompose.h
//  RichTextView
//
//  Created by     songguolin on 16/6/4.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RichTextViewModel.h"
#import "RichTextModel1.h"
@interface RIchTextCompose : NSObject
/**
 *  拼接字符串
 *
 *  @param dataArr 服务器得到的数组
 *
 *  @return 用来展示的数组
 */
+(NSMutableArray *)composeDataArr:(NSArray *)dataArr;
@end

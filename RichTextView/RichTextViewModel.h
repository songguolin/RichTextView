//
//  RichTextViewModel.h
//  RichTextView
//
//  Created by     songguolin on 16/6/4.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Regular.h"
#import "UIColor+HEX.h"
#import "NSString+CaclSize.h"
#import "PictureModel.h"

@interface RichTextViewModel : NSObject
@property (nonatomic,strong) PictureModel * picture;
@property (nonatomic,copy) NSMutableAttributedString * attributedString;
@property (nonatomic,assign) CGFloat  cellHeight;//cell 高度


@end

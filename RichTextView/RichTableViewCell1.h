//
//  RichTableViewCell1.h
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichTextViewModel.h"
@interface RichTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgv;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgvHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgvWidth;



- (void)creatTextModel:(RichTextViewModel *)model;
@end

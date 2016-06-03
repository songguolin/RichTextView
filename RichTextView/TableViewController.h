//
//  TableViewController.h
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichTextModel.h"

//用于展示文字 没有加颜色，大小，的
@interface TableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (nonatomic,copy) NSString * jsonString;
@end

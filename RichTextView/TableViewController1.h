//
//  TableViewController1.h
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>


//属性 字符串和图片展示
@interface TableViewController1 : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

//   比如这是服务器返回的数据
@property (nonatomic,copy) NSString * jsonString;

@end

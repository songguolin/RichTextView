//
//  TableViewController1.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "TableViewController1.h"
#import "RichTableViewCell1.h"
#import "RIchTextCompose.h"






static NSString *indentifireCell=@"RichTableViewCell1";
@interface TableViewController1 ()

@property (nonatomic,strong) NSMutableArray * dataArr;
@end

@implementation TableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.jsonString 比如这是服务器返回的数据
    
    NSMutableArray * arr=[NSMutableArray arrayWithJSON:self.jsonString];
    NSArray * richTextArr=[RichTextModel1 mj_objectArrayWithKeyValuesArray:arr];
    self.dataArr=[RIchTextCompose composeDataArr:richTextArr];
    
    self.myTableView.estimatedRowHeight=40;

    //故意显出了线条，实际可以去掉
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.dataArr.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    RichTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:indentifireCell forIndexPath:indexPath];
    RichTextViewModel * model=[self.dataArr objectAtIndex:indexPath.row];
    [cell creatTextModel:model];

    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RichTextViewModel * model=[self.dataArr objectAtIndex:indexPath.row];
    NSLog(@"cellHeight---%f",model.cellHeight);
    return model.cellHeight;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

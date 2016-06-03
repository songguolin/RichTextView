//
//  TableViewController.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "TableViewController.h"
#import "RichTableViewCell.h"

static NSString *indentifireCell=@"RichTableViewCell";

@interface TableViewController ()
@property (nonatomic,strong) RichTextModel * info;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.info=[[RichTextModel alloc]init];
    self.info.content=self.jsonString;
    [self.myTableView reloadData];
    //这种方式 只支持ios8+；
    self.myTableView.estimatedRowHeight = 40;
//    self.myTableView.rowHeight=UITableViewAutomaticDimension;

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"self.info.contentStrArr.count--%lu",(unsigned long)self.info.contentStrArr.count);
        if (self.info.contentStrArr!=nil) {
            
            return self.info.contentStrArr.count;
        }
        return 0;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    
    RichTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifireCell forIndexPath:indexPath];

    PictureModel * model=nil;
    if (indexPath.row<self.info.imageArr.count) {
        model=[self.info.imageArr objectAtIndex:indexPath.row];
        
    }
    
    [cell creatTextContainerString:self.info.contentStrArr[indexPath.row] withPicModel:model];
        return cell;
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.info.cellHeightArr.count) {
        return [[self.info.cellHeightArr objectAtIndex:indexPath.row] floatValue];
    }
    return 0;
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

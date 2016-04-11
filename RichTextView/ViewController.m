//
//  ViewController.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "ViewController.h"
#import "RichTextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)richtext:(id)sender {
    RichTextViewController * ctrl=[RichTextViewController ViewController];
    ctrl.finished=^(id content){
        NSArray * arr=(NSArray *)content;
        NSLog(@"count--%lu",(unsigned long)arr.count);
         NSLog(@"arr--%@",arr);
        if (arr.count>0) {
            
            for (NSDictionary * dict in arr) {
                NSLog(@"title---%@",[dict objectForKey:@"title"]);
                
               //注意这里的lineSpace，有时候取不到
               
            }
        }
    };
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

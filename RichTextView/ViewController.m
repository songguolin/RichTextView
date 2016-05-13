//
//  ViewController.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "ViewController.h"
#import "RichTextViewController.h"
#import "PictureModel.h"
@interface ViewController ()<RichTextViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)richtext:(id)sender {
    RichTextViewController * ctrl=[RichTextViewController ViewController];
    
//    需要返回的是网页
//    ctrl.RTDelegate=self;
//    ctrl.feedbackHtml=YES;
    
    
//    无需返回网页
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



#pragma mark RichTextViewControllerDelegate
-(void)uploadImageArray:(NSArray *)imageArr withCompletion:(NSString * (^)(NSArray * urlArray))completion;
{
    
    //上传图片
    
    
    //把图片地址传入
    NSMutableArray * urlArr=[NSMutableArray array];
    //模拟图片上传，返回每个图片的地址和大小
    for (int i=0; i<imageArr.count; i++) {
        PictureModel * model=[[PictureModel alloc]init];
        model.imageurl=@"http://photocdn.sohu.com/20160426/Img446187083.jpg";
        [urlArr addObject:model];
    }
    
    
    
    //获取到网页
   NSString * htmlStr=completion(urlArr);
    
    NSLog(@"htmlStr--%@",htmlStr);

    
    //这个显示就看大家怎么处理了
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//



//－－－－－－－－－－－demo下载地址:https://github.com/songguolin/RichTextView－－－－－－－－－
//－－－－－－－－－－－－－ TYAttributedLabel 给大家借鉴的，富文本显示－－－－－－－－－－－－－－
//－－－－－－－－－－－相关介绍博客http://doc.okbase.net/qianglong/archive/119421.html





#import "ViewController2.h"
#import "RichTextViewController.h"
#import "TableViewController.h"
#import "TableViewController1.h"

@interface ViewController2 ()<RichTextViewControllerDelegate>
{
    NSString * jsonString;
    BOOL textNeedAttribute;  //文字是否需要属性
    
}
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


//富文本编辑里面的图片都是调整了显示大小的，毕竟不能让图片影响到编辑，但是图片没有压缩过，不用担心失真
//编辑富文本，这种方式图片全部重新上传，网络不佳的情况不建议
//生成 上传富文本,注意初次编辑 和以后的
- (IBAction)richtext:(id)sender {
    RichTextViewController * ctrl=[RichTextViewController ViewController];
    //需要返回的是网页,开启代理
    ctrl.RTDelegate=self;
 
    //控制 文字是否需要 颜色，大小等属性
    ctrl.textType=RichTextType_HtmlString;

    //设置内容
    ctrl.content=jsonString;
    __weak typeof(self) weakSelf=self;
    //    无需返回网页
    ctrl.finished=^(id content,NSArray * imageArr){
        
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ctrl animated:YES];
}




#pragma mark RichTextViewControllerDelegate 生成网页
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
   jsonString=completion(urlArr);
    
    NSLog(@"jsonString--%@",jsonString);
    //然后上传网页
    //这个显示就看大家怎么处理了
    [self.webView loadHTMLString:jsonString baseURL:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

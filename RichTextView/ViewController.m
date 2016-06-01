//
//  ViewController.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "ViewController.h"
#import "RichTextViewController.h"

@interface ViewController ()<RichTextViewControllerDelegate>
{
    NSString * jsonString;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//列表显示富文本
- (IBAction)viewText:(id)sender {
}

//编辑富文本
- (IBAction)edtingText:(id)sender {
    
    //.1 从服务器得到数据，jsonString
    
    
    RichTextViewController * ctrl=[RichTextViewController ViewController];
    //设置内容
    [ctrl setContent:[NSArray arrayWithJSON:jsonString]];
    
    __weak typeof(self) weakSelf=self;
    //    无需返回网页
    ctrl.finished=^(NSArray * content,NSArray * imageArr){

        [weakSelf uploadData:content withImageArray:imageArr];

        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ctrl animated:YES];
}
//生成 上传富文本
- (IBAction)richtext:(id)sender {
    RichTextViewController * ctrl=[RichTextViewController ViewController];
    
   //    需要返回的是网页
   //    ctrl.RTDelegate=self;
   //    ctrl.feedbackHtml=YES;
    

    __weak typeof(self) weakSelf=self;
   //    无需返回网页
    ctrl.finished=^(NSArray * content,NSArray * imageArr){
      
        [weakSelf uploadData:content withImageArray:imageArr];

        
//        if (arr.count>0) {
//            for (NSDictionary * dict in arr) {
//                NSLog(@"title---%@",[dict objectForKey:@"title"]);
//               //注意这里的lineSpace，有时候取不到
//               
//            }
//        }
        
  
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)uploadData:(NSArray *)dataArr withImageArray:(NSArray *)imageArr
{
    //这是选择完图片一次性上传，可能会慢,.另一种就是在用户选择图片的时候就上传，这种方法大家可以考虑
   //1.先上传图片
    
   //2.模拟上传成功
   /*
    arr--(
    {
    bold = 0;
    color = "#00ff00";
    font = 16;
    lineSpace = 5;
    title = "Rerr ";
    },
    {
    bold = 0;
    color = "#ff0000";
    font = 25;
    lineSpace = 5;
    title = "rrrrr ";
    },
    {
    bold = 0;
    font = 12;
    lineSpace = 5;
    title = "\n";
    },
    {
    bold = 0;
    font = 12;
    image = "<UIImage: 0x7f9c0e06c110> size {310, 206} orientation 0 scale 1.000000";
    lineSpace = 0;
    title = "[UIImageView]";
    },
    {
    bold = 0;
    color = "#ff0000";
    font = 25;
    lineSpace = 0;
    title = "\n";
    },
    {
    bold = 0;
    color = "#ff0000";
    font = 25;
    lineSpace = 5;
    title = "Ffff ";
    }
    )

      这个时候重新组装数据，吧image替换成url

    */
    
    for (NSDictionary * dict in dataArr) {
        if (dict[@"image"]!=nil) {
            //这个是为了图片加载的时候有个默认 宽高
            
            [dict setValue:@"<img src=\"http://viewfile.innos-campus.com/Image/500089/20160601/17513249e9fd82.jpeg\" w=\"240\" h=\"321\"/>" forKey:@"image"];
          
        }
    }
    //    //根据上传
    jsonString=[dataArr toJSON];
    NSLog(@"jsonString--%@",jsonString);
    

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"上传成功" message:@"马上进入下载数据页面" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self pushTextViewVC];
//        }]];
//    });
//    
//    
//    

    
}



//    需要返回的是网页,开启代理
//    ctrl.RTDelegate=self;
//    ctrl.feedbackHtml=YES;
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

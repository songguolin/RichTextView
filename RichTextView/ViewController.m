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





#import "ViewController.h"
#import "RichTextViewController.h"
#import "TableViewController.h"
#import "TableViewController1.h"

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


//富文本编辑里面的图片都是调整了显示大小的，毕竟不能让图片影响到编辑，但是图片没有压缩过，不用担心失真
//编辑富文本，这种方式图片全部重新上传，网络不佳的情况不建议
//生成 上传富文本,注意初次编辑 和以后的
- (IBAction)richtext:(id)sender {
    RichTextViewController * ctrl=[RichTextViewController ViewController];
    
    //控制 文字是否需要 颜色，大小等属性
    ctrl.textType=RichTextType_PlainString;
    //设置内容
    ctrl.content=jsonString;


    __weak typeof(self) weakSelf=self;
    ctrl.finished=^(id content,NSArray * imageArr){
        [weakSelf uploadData:content withImageArray:imageArr];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ctrl animated:YES];
}
#pragma mark uploadData 上传服务器
- (void)uploadData:(id )contentData withImageArray:(NSArray *)imageArr
{
    //这是选择完图片一次性上传，可能会慢,.另一种就是在用户选择图片的时候就上传，这种方法大家可以考虑
   //1.先上传图片
    
   //2.模拟上传
   /*
    
    这个时候重新组装数据，吧image替换成url

    来代替的图片地址
    http://pic32.nipic.com/20130829/12906030_124355855000_2.png
    http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg
    http://pic36.nipic.com/20131217/6704106_233034463381_2.jpg
    http://img05.tooopen.com/images/20140604/sy_62331342149.jpg
    http://img05.tooopen.com/images/20150531/tooopen_sy_127457023651.jpg
    http://pic44.nipic.com/20140721/11624852_001107119409_2.jpg

    */
    
    
    //比如这是服务器返回的数据
    NSArray * urlarr=@[@"<img src=\"http://pic32.nipic.com/20130829/12906030_124355855000_2.png\" width=\"240\" height=\"321\"/>",
                       @"<img src=\"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg\" width=\"240\" height=\"321\"/>",
                       @"<img src=\"http://pic36.nipic.com/20131217/6704106_233034463381_2.jpg\" width=\"240\" height=\"321\"/>",
                       @"<img src=\"http://img05.tooopen.com/images/20140604/sy_62331342149.jpg\" width=\"240\" height=\"321\"/>",
                       @"<img src=\"http://img05.tooopen.com/images/20150531/tooopen_sy_127457023651.jpg\" width=\"240\" height=\"321\"/>",
                       @"<img src=\" http://pic44.nipic.com/20140721/11624852_001107119409_2.jpg\" width=\"240\" height=\"321\"/>"
                      ];
   

        //这里是把字符串分割成数组，
        NSArray * strArr=[contentData  componentsSeparatedByString:RICHTEXT_IMAGE];
        
        NSString * newContent=@"";
        for (int i=0; i<strArr.count; i++) {
            
            NSString * imgTag=@"";
            if (i<strArr.count-1) {
                //这是用url 地址替换 图片标示 imgTag=urlarr[i];
                imgTag=urlarr[i%6];
                NSLog(@"图片顺序比对地址－－－%@",urlarr[i%6]);
            }
            
            //因为cutstr 可能是null
            NSString * cutStr=[strArr objectAtIndex:i];
            newContent=[NSString stringWithFormat:@"%@%@%@",newContent,cutStr,imgTag];
            
        }
        
        
        //上传服务器
        jsonString=newContent;
        
        NSLog(@"jsonString--%@",jsonString);
        
        

    
}

#pragma mark prepareForSegue 列表展示
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //1.如果是 changText＝NO
    UIViewController * ctrl=segue.destinationViewController;
    if ([ctrl isKindOfClass:[TableViewController class]]) {
      
            TableViewController * table=(TableViewController *)ctrl;
            table.title=@"无属性文字";
            table.jsonString=jsonString;
      

        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

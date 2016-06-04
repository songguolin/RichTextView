//
//  RichTextViewController.h
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RichTextViewControllerDelegate <NSObject>

@optional
/**
 *  得到网页
 *
 *  @param imageArr   要上传的图片数组
 *  @param completion 传入urlArray 服务器返回的图片地址，返回网页NSString
 */
-(void)uploadImageArray:(NSArray *)imageArr withCompletion:(NSString * (^)(NSArray * urlArray))completion;

@end



typedef void (^inputFinished)(id  content,NSArray * imageArr);
typedef NSArray *(^uploadCompelte)(void);

IB_DESIGNABLE
@interface RichTextViewController : UIViewController

@property (weak,nonatomic) id<RichTextViewControllerDelegate>RTDelegate;

@property (weak, nonatomic) IBOutlet UIButton *fontBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *boldBtn;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;


//提示字
@property (nonatomic,copy) IBInspectable NSString * placeholderText;
//是否返回的是网页，是的话请实现 代理方法
@property (nonatomic,assign) BOOL feedbackHtml;
//需要改变字体 颜色，大小，加粗
@property (nonatomic,assign) BOOL changText;

@property (nonatomic,copy) inputFinished finished;

//初始化页面
+(instancetype)ViewController;

////编辑富文本，设置内容
@property (nonatomic,strong) id content;
@end

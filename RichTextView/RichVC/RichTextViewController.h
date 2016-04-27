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
-(void)uploadImageArray:(NSArray *)imageArr withCompletion:(NSString * (^)(NSArray * urlArray))completion;

@end




typedef NSArray *(^uploadCompelte)(void);
@interface RichTextViewController : UIViewController

@property (weak,nonatomic) id<RichTextViewControllerDelegate>RTDelegate;

@property (weak, nonatomic) IBOutlet UIButton *fontBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *boldBtn;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;


//是否返回的是网页，是的话请实现 代理方法
@property (nonatomic,assign) BOOL feedbackHtml;

//这一种是返回
@property (nonatomic,copy) void (^finished)(id  content);

//初始化页面
+(instancetype)ViewController;

@end

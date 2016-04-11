//
//  RichTextPreviewVC.m
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "RichTextPreviewVC.h"

@implementation RichTextPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.attributedText=self.content;
    self.textView.userInteractionEnabled=NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

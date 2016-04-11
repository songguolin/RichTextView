//
//  RichTextPreviewVC.h
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RichTextPreviewVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) NSAttributedString * content;
@end

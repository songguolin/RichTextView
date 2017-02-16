//
//  RichTableViewCell1.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "RichTableViewCell1.h"


@implementation RichTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTextModel:(RichTextViewModel *)model
{
    
    if (model.picture==nil) {
        self.imgvWidth.constant=0;
        self.imgvHeight.constant=0;
        self.imgv.hidden=YES;
        self.contentLabel.hidden=NO;
        self.contentLabel.text=nil;
        if (model.attributedString.length>0) {


                self.contentLabel.attributedText=model.attributedString;
           
        }

    }
    else
    {
        self.imgv.hidden=NO;
        self.contentLabel.hidden=YES;
        
        
    
        NSString * imageStr= model.picture.imageurl;
        
        if (imageStr!=nil) {
            CGFloat ImgWidth=SCREEN_WIDTH-40;
            
            self.imgvWidth.constant=ImgWidth;
            if (model.picture.height>0) {
                
                CGFloat ImgHeight=model.picture.height*ImgWidth/model.picture.width;
                self.imgvHeight.constant=ImgHeight;
                
            }
            __weak typeof(self) weakSelf=self;
            
            [self.imgv sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"活动默认图片"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (image!=nil) {
                    if (model.picture.height==0) {
                        
                        CGFloat ImgHeight=image.size.height*ImgWidth/image.size.width;
                        weakSelf.imgvHeight.constant=ImgHeight;
                        
                        
                    }
                    
                    
                }
                
            }];
  
            
        }
        
        else
        {
            self.imgvHeight.constant=0;
        }

        
    }
    
    
    
    
    [self layoutIfNeeded];
    [self layoutSubviews];

}

@end

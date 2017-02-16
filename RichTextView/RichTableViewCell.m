//
//  RichTableViewCell.m
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "RichTableViewCell.h"

@implementation RichTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)creatTextContainerString:(NSString *)contentStr withPicModel:(PictureModel *)model
{

    self.contentLabel.text=nil;
    if ([contentStr isKindOfClass:[NSString class]]) {
            self.contentLabel.text=contentStr;
            NSLog(@"contentStr--%@", self.contentLabel.text);

    }

    
    NSString * imageStr=model.imageurl;

    if (imageStr!=nil) {
        CGFloat ImgWidth=SCREEN_WIDTH-40;
   
        self.imgvWidth.constant=ImgWidth;
        if (model.height>0) {
            
            CGFloat ImgHeight=model.height*ImgWidth/model.width;
            self.imgvHeight.constant=ImgHeight;
  
        }
        __weak typeof(self) weakSelf=self;
        
        [self.imgv sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"活动默认图片"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
                    if (image!=nil) {
                        if (model.height==0) {
                            
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
    
    [self layoutIfNeeded];
    [self layoutSubviews];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

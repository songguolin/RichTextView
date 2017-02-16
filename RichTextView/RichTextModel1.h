//
//  RichTextModel1.h
//  RichTextView
//
//  Created by     songguolin on 16/6/3.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+Regular.h"
#import "UIColor+HEX.h"
#import "NSString+CaclSize.h"
#import "PictureModel.h"
@interface RichTextModel1 : NSObject

@property (nonatomic,strong) PictureModel * picture;

//img src=\"http://pic32.nipic.com/20130829/12906030_124355855000_2.png\" w=\"240\" h=\"321\"/>
@property (nonatomic,copy  ) NSString * image;  //图片地址,注意这个格式，这是不能直接用的
@property (nonatomic,copy  ) NSString * title;  //文字内容，也可能是图片标示
@property (nonatomic,assign) BOOL     bold;     //是否加粗
@property (nonatomic,assign) CGFloat  font;     //字体大小
@property (nonatomic,copy  ) NSString * color;  //字体颜色

@property (nonatomic,assign) CGFloat  lineSpace;//行间距，这个一般自己定义就好


//arr--(
//      {
//          bold = 0;
//          color = "#00ff00";
//          font = 16;
//          lineSpace = 5;
//          title = "Rerr ";
//      },
//      {
//          bold = 0;
//          color = "#ff0000";
//          font = 25;
//          lineSpace = 5;
//          title = "rrrrr ";
//      },
//      {
//          bold = 0;
//          font = 12;
//          lineSpace = 5;
//          title = "\n";
//      },
//      {
//          bold = 0;
//          font = 12;
//          image = "<img src=\"http://pic32.nipic.com/20130829/12906030_124355855000_2.png\" w=\"240\" h=\"321\"/>";
//          lineSpace = 0;
//          title = "[UIImageView]";
//      },
//      {
//          bold = 0;
//          color = "#ff0000";
//          font = 25;
//          lineSpace = 0;
//          title = "\n";
//      },
//      {
//          bold = 0;
//          color = "#ff0000";
//          font = 25;
//          lineSpace = 5;
//          title = "Ffff ";
//      }
//      )
@end

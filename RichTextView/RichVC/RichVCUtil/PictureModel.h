//
//  PictureModel.h
//  果动校园
//
//  Created by jang on 8/8/15.
//  Copyright (c) 2015 GDSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject


//图片的大 中 小
@property (nonatomic,strong) NSString * imageurl;

//宽
@property(nonatomic, assign) NSUInteger width;
//高
@property(nonatomic, assign) NSUInteger height;


@end

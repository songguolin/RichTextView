//
//  PictureModel.m
//  果动校园
//
//  Created by jang on 8/8/15.
//  Copyright (c) 2015 GDSchool. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel

-(id)init
{
    self=[super init];
    if (self) {
        self.imageurl=@"";

        self.width=220.f;
        self.height=200.f;
    }
    
    return self;
}

@end

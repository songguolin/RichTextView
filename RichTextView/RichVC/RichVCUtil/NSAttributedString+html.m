//
//  NSAttributedString+html.m
//  RichTextView
//
//  Created by     songguolin on 16/4/26.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import "NSAttributedString+html.h"

@implementation NSAttributedString (html)
-(NSString *)toHtmlString
{
    NSDictionary * exportParams=@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSData * htmlData=[self dataFromRange:NSMakeRange(0, self.length) documentAttributes:exportParams error:nil];
    
    
    NSString * html=[[NSString alloc]initWithData:htmlData encoding:NSUTF8StringEncoding];
    
    return html;
}


@end

@implementation NSString (html)
-(NSAttributedString *)toAttributedString
{
    NSData * htmlData=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * importParams=@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
    NSError * error=nil;
    NSAttributedString * htmlString=[[NSAttributedString alloc]initWithData:htmlData options:importParams documentAttributes:NULL error:&error];
    
    return htmlString;
}


@end

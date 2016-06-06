//
//  ArchiveFile.m
//  果动校园
//
//  Created by     songguolin on 15/11/25.
//  Copyright © 2015年 GDSchool. All rights reserved.
//

#import "ArchiveFile.h"

@implementation ArchiveFile

+ (NSString *)LibraryDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)DocumentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)PreferencePanesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)CachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
+ (NSString *)getFilePathWithDirectoryName:(NSString *)directoryName fileName:(NSString *)fileName
{
    
     NSString *filePath =nil;
   
   
    if (directoryName==nil) {
        
        NSString * path = [NSString stringWithFormat:@"%@",fileName];
        filePath = [[self DocumentDirectory] stringByAppendingPathComponent:path];
    }
    else
    {
        NSString * path = [NSString stringWithFormat:@"%@/%@",directoryName,fileName];
        
         filePath = [[self DocumentDirectory]stringByAppendingPathComponent:path];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        

    }

    return filePath;
}
//文件是否存在
+(BOOL)isHaveFileWithPath:(NSString *)path
{
    NSFileManager * fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    
    
    return NO;
}



//存储数据
-(void)saveDataWithPath:(NSString *)path data:(NSArray *)dataArr
{

//     //    在这里对数据进行编码操作
//    NSMutableData * data = [[NSMutableData alloc] initWithCapacity:0];
//    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    
//    //    真正的开始编码
//    [archiver encodeObject:dataArr forKey:path];
//    [archiver finishEncoding];
//    //    保存到本地
//    
//    [data writeToFile:path atomically:YES];
    
    // 归档
    [NSKeyedArchiver archiveRootObject:dataArr toFile:path];
    
    NSLog(@"归档,path--%@",path);
}

//取出本地存储数据
-(NSArray *)getDataWithPath:(NSString *)path
{
    
    NSArray * dataArr=nil;
    if ([ArchiveFile isHaveFileWithPath:path]) {
        
//        NSData * data=[[NSData alloc] initWithContentsOfFile:path];
//         NSKeyedUnarchiver * unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        //        开始解码
//        dataArr = [unArchiver decodeObjectForKey:path];
//        //        结束解码
//        [unArchiver finishDecoding];
        
       dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        
         NSLog(@"dataArr=--%@",dataArr);
        
    }
    else
    {
        dataArr=[NSArray array];
    }
    
    
    return dataArr;
}


// 按路径清除文件
+ (void)clearCachesWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
    
}


+ (double)sizeWithFilePath:(NSString *)path
{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1000 * 1000.0);
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1000 * 1000.0);
    }
}
@end

//
//  FileTool.h
//  快手
//
//  Created by liulichao on 16/5/10.
//  Copyright © 2016年 刘立超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject
+ (long long)fileSizeAtPath:(NSString*) filePath;
+ (float )folderSizeAtPath:(NSString*) folderPath;
+ (void)removeFileAtPath:(NSString *)filePath;
@end

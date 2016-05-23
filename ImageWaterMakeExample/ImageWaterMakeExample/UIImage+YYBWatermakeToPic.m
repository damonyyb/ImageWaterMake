//
//  UIImage+YYBWatermakeToPic.m
//  ImageWaterMakeExample
//
//  Created by yyb on 16/5/23.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "UIImage+YYBWatermakeToPic.h"

@implementation UIImage (YYBWatermakeToPic)
- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- ( UIImage *)createShareImage:( NSString *)str image:(UIImage *)image andRect:(CGRect )rect andFont:(UIFont *)font andColor:(UIColor *)color;

{
    
    
    CGSize size= CGSizeMake (image. size . width , image. size . height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions (size, NO , 0.0 );
    
    [image drawAtPoint : CGPointMake ( 0 , 0 )];
    
    // 获得一个位图图形上下文
    
    CGContextRef context= UIGraphicsGetCurrentContext ();
    
    CGContextDrawPath (context, kCGPathStroke );
    
    // 画 打败了多少用户
    [str drawInRect :rect withAttributes : @{ NSFontAttributeName :font, NSForegroundColorAttributeName :color } ];
    //画自己想画的内容。。。。。
    
    // 返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}
@end

//
//  UIImage+YYBWatermakeToPic.h
//  ImageWaterMakeExample
//
//  Created by yyb on 16/5/23.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYBWatermakeToPic)
/**
 加半透明水印
 @param useImage 需要加水印的图片
 @param addImage1 水印
 @returns 加好水印的图片
 */
- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;
/**
 *  添加文字水印到图片
 *
 *  @param str   文字
 *  @param image 图片
 *  @param rect 文字位于图片的位置 使用rect 比 point  可以轻易处理自适应高度
 *  @param font  文字字体
 *  @param color 文字颜色
 *
 *  @return 返回添加好水印的图片
 */
- ( UIImage *)createShareImage:( NSString *)str image:(UIImage *)image andRect:(CGRect )rect andFont:(UIFont *)font andColor:(UIColor *)color;


@end

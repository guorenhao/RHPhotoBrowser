//
//  RHPhotoBrowser.h
//  RHKit
//
//  Created by 郭人豪 on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>

// 显示动画样式
typedef NS_ENUM(NSUInteger, RHPhotoBrowserShowStyle) {
    
    RHPhotoBrowserShowStyleDefault     = 0,
    RHPhotoBrowserShowStyleMoveOut     = 1,
    RHPhotoBrowserShowStyleFromTop     = 2,
    RHPhotoBrowserShowStyleFromLeft    = 3,
    RHPhotoBrowserShowStyleFromRight   = 4,
    RHPhotoBrowserShowStyleFromBottom  = RHPhotoBrowserShowStyleDefault,
    RHPhotoBrowserShowStyleFromImage   = 6
};
// 数据类型
typedef NS_ENUM(NSUInteger, RHPhotoSourceType) {
    
    RHPhotoSourceTypeImage     = 0,  // 图片
    RHPhotoSourceTypeUrl       = 1,  // 链接地址
    RHPhotoSourceTypeFilePath  = 2,  // 本地地址
    RHPhotoSourceTypeFileName  = 3   // 本地文件名
};
@interface RHPhotoBrowser : NSObject

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr;

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr selectIndex:(NSInteger)selectIndex;

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage;

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage selectIndex:(NSInteger)selectIndex;

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr;

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage;

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr selectIndex:(NSInteger)selectIndex;

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage selectIndex:(NSInteger)selectIndex;


@end

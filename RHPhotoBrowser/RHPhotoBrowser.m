//
//  RHPhotoBrowser.m
//  RHKit
//
//  Created by 郭人豪 on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "RHPhotoBrowser.h"
#import "RHPhotoBrowserView.h"

@implementation RHPhotoBrowser

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr {
    
    [self browseImageWithStyle:RHPhotoBrowserShowStyleDefault sourceType:sourceType imageArr:imageArr placeholderImage:nil selectIndex:0];
}

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr selectIndex:(NSInteger)selectIndex {
    
    [self browseImageWithStyle:RHPhotoBrowserShowStyleDefault sourceType:sourceType imageArr:imageArr placeholderImage:nil selectIndex:selectIndex];
}

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage {
    
    [self browseImageWithStyle:RHPhotoBrowserShowStyleDefault sourceType:sourceType imageArr:imageArr placeholderImage:placeholderImage selectIndex:0];
}

/**
 快速浏览图片
 
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithSourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage selectIndex:(NSInteger)selectIndex {
    
    [self browseImageWithStyle:RHPhotoBrowserShowStyleDefault sourceType:sourceType imageArr:imageArr placeholderImage:placeholderImage selectIndex:selectIndex];
}

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr {
    
    [self browseImageWithStyle:style sourceType:sourceType imageArr:imageArr placeholderImage:nil selectIndex:0];
}

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage {
    
    [self browseImageWithStyle:style sourceType:sourceType imageArr:imageArr placeholderImage:placeholderImage selectIndex:0];
}

/**
 快速浏览图片
 
 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr selectIndex:(NSInteger)selectIndex {
    
    [self browseImageWithStyle:style sourceType:sourceType imageArr:imageArr placeholderImage:nil selectIndex:selectIndex];
}

/**
 快速浏览图片

 @param style            浏览器弹出动画样式
 @param sourceType       数组数据类型
 @param imageArr         图片数据数组
 @param placeholderImage 占位图
 @param selectIndex      当前选中下标
 */
+ (void)browseImageWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage selectIndex:(NSInteger)selectIndex {
    
    if (selectIndex > imageArr.count - 1) {
        
        selectIndex = 0;
    }
    RHPhotoBrowserView * browser = [[RHPhotoBrowserView alloc] initWithStyle:style sourceType:sourceType imageArr:imageArr placeholderImage:placeholderImage selectIndex:selectIndex];
    [browser show];
}


@end
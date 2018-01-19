//
//  RHPhotoBrowserView.h
//  RHKit
//
//  Created by 郭人豪 on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHPhotoBrowser.h"

@interface RHPhotoBrowserView : UIView

- (instancetype)initWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage selectIndex:(NSInteger)selectIndex;

- (void)show;

@end

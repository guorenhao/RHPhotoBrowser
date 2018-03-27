//
//  RHPhotoBrowserCell.h
//  RHKit
//
//  Created by Abner_G on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RHScreen_Width       [UIScreen mainScreen].bounds.size.width
#define RHScreen_Height      [UIScreen mainScreen].bounds.size.height
#define RHScaleSize          RHScreen_Width / 375
#define RHSS(a)              RHScaleSize * (a)

@interface RHPhotoBrowserCell : UICollectionViewCell

- (void)configCellWithImage:(UIImage *)image;

- (void)configCellWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

- (void)configCellWithFilePath:(NSString *)filePath;

- (void)configCellWithFileName:(NSString *)fileName;

@end

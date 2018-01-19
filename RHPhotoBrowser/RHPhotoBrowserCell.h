//
//  RHPhotoBrowserCell.h
//  RHKit
//
//  Created by 郭人豪 on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHPhotoBrowserCell : UICollectionViewCell

- (void)configCellWithImage:(UIImage *)image;

- (void)configCellWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

- (void)configCellWithFilePath:(NSString *)filePath;

- (void)configCellWithFileName:(NSString *)fileName;

@end

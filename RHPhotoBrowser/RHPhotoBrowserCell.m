//
//  RHPhotoBrowserCell.m
//  RHKit
//
//  Created by Abner_G on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "RHPhotoBrowserCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <RHProgressHUD/RHProgressHUD.h>

@interface RHPhotoBrowserCell ()

@property (nonatomic, strong) UIImageView * img_photo;
@end
@implementation RHPhotoBrowserCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
        [self makeConstraintsForUI];
    }
    return self;
}
- (void)addSubviews {
    
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.img_photo];
}

- (void)makeConstraintsForUI {
    
    _img_photo.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_img_photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_img_photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_img_photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_img_photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:RHScreen_Width]];
}

#pragma mark - config cell

- (void)configCellWithImage:(UIImage *)image {
    
    _img_photo.image = image;
}

- (void)configCellWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage {
    
    [RHProgressHUD showHudOnView:self tip:@""];
    [_img_photo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        [RHProgressHUD removeFromView:self];
    }];
}

- (void)configCellWithFilePath:(NSString *)filePath {
    
    _img_photo.image = [UIImage imageWithContentsOfFile:filePath];
}

- (void)configCellWithFileName:(NSString *)fileName {
    
    _img_photo.image = [UIImage imageNamed:fileName];
}

#pragma mark - setter and getter

- (UIImageView *)img_photo {
    
    if (!_img_photo) {
        
        _img_photo = [[UIImageView alloc] init];
        _img_photo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _img_photo;
}

@end

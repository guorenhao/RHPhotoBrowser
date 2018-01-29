//
//  RHPhotoBrowserView.m
//  RHKit
//
//  Created by 郭人豪 on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "RHPhotoBrowserView.h"
#import "RHPhotoBrowserCell.h"

#define Cell_PhotoBrowser    @"Cell_PhotoBrowser"
#define PhotoSpace           10        // 图片间距
#define ShowAndHideAnimateTime 0.3     // 动画时长
@interface RHPhotoBrowserView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) UIImage * placeholderImage;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, assign) RHPhotoSourceType sourceType;
@property (nonatomic, assign) RHPhotoBrowserShowStyle style;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation RHPhotoBrowserView

- (instancetype)initWithStyle:(RHPhotoBrowserShowStyle)style sourceType:(RHPhotoSourceType)sourceType imageArr:(NSArray *)imageArr placeholderImage:(UIImage *)placeholderImage selectIndex:(NSInteger)selectIndex {
    
    self = [super init];
    if (self) {
        
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:imageArr];
        _placeholderImage = placeholderImage;
        _style = style;
        _sourceType = sourceType;
        _selectIndex = selectIndex;
        [self addSubviews];
        [self makeConstraintsForUI];
    }
    return self;
}

- (void)show {
    
    [self showWithStyle:_style];
}

- (void)showWithStyle:(RHPhotoBrowserShowStyle)style {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowserWillAppear)]) {
        
        [self.delegate photoBrowserWillAppear];
    }
    _style = style;
    if (![[UIApplication sharedApplication].delegate.window.subviews.lastObject isKindOfClass:[RHPhotoBrowserView class]]) {
        
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        CGRect frame = [UIScreen mainScreen].bounds;
        self.frame = frame;
        [self layoutIfNeeded];
        __weak typeof(self)weakSelf = self;
        if (style == RHPhotoBrowserShowStyleMoveOut) {
            
            weakSelf.alpha = 0;
            weakSelf.transform = CGAffineTransformMakeScale(0.3, 0.3);
            [UIView animateWithDuration:ShowAndHideAnimateTime animations:^{
                
                weakSelf.alpha = 1;
                weakSelf.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
                if (finished) {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowserDidAppear)]) {
                        
                        [self.delegate photoBrowserDidAppear];
                    }
                }
            }];
        } else {
            
            switch (style) {
                case RHPhotoBrowserShowStyleDefault:
                {
                    weakSelf.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
                }
                    break;
                case RHPhotoBrowserShowStyleFromLeft:
                {
                    weakSelf.frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
                }
                    break;
                case RHPhotoBrowserShowStyleFromRight:
                {
                    weakSelf.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
                }
                    break;
                case RHPhotoBrowserShowStyleFromTop:
                {
                    weakSelf.frame = CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height);
                }
                    break;
                default:
                    break;
            }
            [UIView animateWithDuration:ShowAndHideAnimateTime animations:^{
                
                weakSelf.frame = frame;
            } completion:^(BOOL finished) {
                
                if (finished) {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowserDidAppear)]) {
                        
                        [self.delegate photoBrowserDidAppear];
                    }
                }
            }];
        }
    }
}

- (void)dismissWithStyle:(RHPhotoBrowserShowStyle)style {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowserWillDisappear)]) {
        
        [self.delegate photoBrowserWillDisappear];
    }
    __weak typeof(self)weakSelf = self;
    CGRect frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:ShowAndHideAnimateTime animations:^{
        
        switch (style) {
            case RHPhotoBrowserShowStyleDefault:
            {
                weakSelf.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
            }
                break;
            case RHPhotoBrowserShowStyleFromLeft:
            {
                weakSelf.frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
            }
                break;
            case RHPhotoBrowserShowStyleFromRight:
            {
                weakSelf.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
            }
                break;
            case RHPhotoBrowserShowStyleFromTop:
            {
                weakSelf.frame = CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height);
            }
                break;
            case RHPhotoBrowserShowStyleMoveOut:
            {
                weakSelf.alpha = 0;
                weakSelf.transform = CGAffineTransformMakeScale(0.4, 0.4);
            }
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [weakSelf removeFromSuperview];
            if (self.delegate && [self.delegate respondsToSelector:@selector(photoBrowserDidDisappear)]) {
                
                [self.delegate photoBrowserDidDisappear];
            }
        }
    }];
}

#pragma mark - add subviews

- (void)addSubviews {
    
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.collection];
    [self addSubview:self.pageControl];
}

- (void)makeConstraintsForUI {
    
    _collection.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_collection attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_collection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_collection attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_collection attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:PhotoSpace]];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-RHSS(50)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:20]];
    
    [self setCollectionContentOffset];
}

- (void)setCollectionContentOffset {
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakSelf.collection setContentOffset:CGPointMake((RHScreen_Width + PhotoSpace) * _selectIndex, 0)];
        weakSelf.pageControl.numberOfPages = weakSelf.dataArr.count;
        weakSelf.pageControl.currentPage = _selectIndex;
    });
}

#pragma mark - collection delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RHPhotoBrowserCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_PhotoBrowser forIndexPath:indexPath];
    if (indexPath.row < self.dataArr.count) {
        
        if (_sourceType == RHPhotoSourceTypeImage) {
            
            UIImage * image = [self.dataArr objectAtIndex:indexPath.row];
            [cell configCellWithImage:image];
        } else if (_sourceType == RHPhotoSourceTypeUrl) {
            
            NSString * url = [self.dataArr objectAtIndex:indexPath.row];
            [cell configCellWithUrl:url placeholderImage:_placeholderImage];
        } else if (_sourceType == RHPhotoSourceTypeFilePath) {
            
            NSString * filePath = [self.dataArr objectAtIndex:indexPath.row];
            [cell configCellWithFilePath:filePath];
        } else if (_sourceType == RHPhotoSourceTypeFileName) {
            
            NSString * fileName = [self.dataArr objectAtIndex:indexPath.row];
            [cell configCellWithFileName:fileName];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArr.count > 1) {
        
        if (indexPath.row == self.dataArr.count - 1) {
            
            return CGSizeMake(RHScreen_Width + PhotoSpace, RHScreen_Height);
        }
    }
    return CGSizeMake(RHScreen_Width, RHScreen_Height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return PhotoSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return PhotoSpace;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissWithStyle:_style];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.collection) {
        
        _selectIndex = (self.collection.contentOffset.x + (RHScreen_Width + PhotoSpace) / 2 ) / (RHScreen_Width + PhotoSpace);
        self.pageControl.currentPage = _selectIndex;
    }
}

#pragma mark - setter and getter

- (UICollectionView *)collection {
    
    if (!_collection) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView * cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        cv.backgroundColor = [UIColor blackColor];
        cv.delegate = self;
        cv.dataSource = self;
        cv.pagingEnabled = YES;
        cv.showsHorizontalScrollIndicator = NO;
        [cv registerClass:[RHPhotoBrowserCell class] forCellWithReuseIdentifier:Cell_PhotoBrowser];
        _collection = cv;
    }
    return _collection;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        UIPageControl * pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.userInteractionEnabled = NO;
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end


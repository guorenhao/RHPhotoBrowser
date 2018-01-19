//
//  RHPhotoBrowserView.m
//  RHKit
//
//  Created by 郭人豪 on 2017/12/19.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "RHPhotoBrowserView.h"
#import "RHPhotoBrowserCell.h"

#define RHScreen_Width       [UIScreen mainScreen].bounds.size.width
#define RHScreen_Height      [UIScreen mainScreen].bounds.size.height
#define RHScaleSize          RHScreen_Width / 375
#define RHSS(a)              RHScaleSize * (a)
#define Cell_PhotoBrowser    @"Cell_PhotoBrowser"
#define PhotoSpace           10        // 图片间距
@interface RHPhotoBrowserView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) UIImage * placeholderImage;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, assign) RHPhotoSourceType sourceType;
@property (nonatomic, assign) RHPhotoBrowserShowStyle style;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, assign) CGFloat panCenterX;
@property (nonatomic, assign) CGFloat startOffsetX;

@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) CGFloat panX;
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
    
    _style = style;
    if (![[UIApplication sharedApplication].delegate.window.subviews.lastObject isKindOfClass:[RHPhotoBrowserView class]]) {
        
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        CGRect frame = [UIScreen mainScreen].bounds;
        self.frame = frame;
        [self layoutIfNeeded];
        __weak typeof(self) weakSelf = self;
        if (style == RHPhotoBrowserShowStyleMoveOut) {
            
            weakSelf.alpha = 0;
            weakSelf.transform = CGAffineTransformMakeScale(0.3, 0.3);
            [UIView animateWithDuration:0.3 animations:^{
                
                weakSelf.alpha = 1;
                weakSelf.transform = CGAffineTransformIdentity;
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
            [UIView animateWithDuration:0.3 animations:^{
                
                weakSelf.frame = frame;
            }];
        }
    }
}

- (void)dismissWithStyle:(RHPhotoBrowserShowStyle)style {
    
    __weak typeof(self) weakSelf = self;
    CGRect frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.3 animations:^{
        
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_collection attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-RHSS(50)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:20]];
    
    [self setCollectionContentOffset];
}

- (void)setCollectionContentOffset {
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{

        [weakSelf.collection setContentOffset:CGPointMake((RHScreen_Width + PhotoSpace) * _selectIndex, 0)];
        weakSelf.pageControl.numberOfPages = weakSelf.dataArr.count;
        weakSelf.pageControl.currentPage = _selectIndex;
    });
    _startOffsetX = _collection.contentOffset.x;
}

#pragma mark - GestureRecognizer event

- (void)panCollection:(UIPanGestureRecognizer *)pan {
    
    _panCenterX = [pan translationInView:self.collection].x;
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        _startOffsetX = _collection.contentOffset.x;
        _offsetX = 0;
        _panX = 0;
    }
    if (_selectIndex == 0) {
        
        if (_panCenterX > 0) {
            
            CGFloat s = (RHScreen_Width - _panCenterX) / RHScreen_Width;
            _offsetX += (_panCenterX - _panX) * s;
            _panX = _panCenterX;
            [self.collection setContentOffset:CGPointMake(-_offsetX, 0) animated:NO];
        } else {
            
            if (self.dataArr.count == 1) {
                
                CGFloat s = (RHScreen_Width + _panCenterX) / RHScreen_Width;
                _offsetX += (_panCenterX - _panX) * s;
                _panX = _panCenterX;
                [self.collection setContentOffset:CGPointMake(-_offsetX, 0) animated:NO];
            } else {
                
                [self.collection setContentOffset:CGPointMake(_startOffsetX - _panCenterX, 0) animated:NO];
            }
        }
    } else if (_selectIndex == self.dataArr.count - 1) {
        
        if (_panCenterX < 0) {
            
            CGFloat s = (RHScreen_Width + _panCenterX) / RHScreen_Width;
            _offsetX += (_panCenterX - _panX) * s;
            _panX = _panCenterX;
            [self.collection setContentOffset:CGPointMake(_startOffsetX - _offsetX, 0) animated:NO];
        } else {
            
            [self.collection setContentOffset:CGPointMake(_startOffsetX - _panCenterX, 0) animated:NO];
        }
    } else {
        
        [self.collection setContentOffset:CGPointMake(_startOffsetX - _panCenterX, 0) animated:NO];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if ([self absoluteValue:_panCenterX] > RHScreen_Width/3) {
            
            if (_panCenterX < 0) {
                
                _selectIndex += 1;
            } else {
                
                _selectIndex -= 1;
            }
            if (_selectIndex == self.dataArr.count) {
                
                _selectIndex = self.dataArr.count - 1;
            } else if (_selectIndex == -1) {
                
                _selectIndex = 0;
            }
            [self.collection setContentOffset:CGPointMake((RHScreen_Width + PhotoSpace) * _selectIndex, 0) animated:YES];
            self.pageControl.currentPage = _selectIndex;
        } else {
            
            [self.collection setContentOffset:CGPointMake(_startOffsetX, 0) animated:YES];
        }
    }
}

- (void)swipeCollection:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        _selectIndex += 1;
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        _selectIndex -= 1;
    }
    if (_selectIndex == self.dataArr.count) {
        
        _selectIndex = self.dataArr.count - 1;
    } else if (_selectIndex == -1) {
        
        _selectIndex = 0;
    }
    self.pageControl.currentPage = _selectIndex;
    [self.collection setContentOffset:CGPointMake((RHScreen_Width + PhotoSpace) * _selectIndex, 0) animated:YES];
}

// 返回value的绝对值
- (CGFloat)absoluteValue:(CGFloat)value {
    
    if (value < 0) {
        
        return -value;
    }
    return value;
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
    
    return CGSizeMake(RHScreen_Width, RHScreen_Height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return PhotoSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissWithStyle:_style];
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
        cv.showsHorizontalScrollIndicator = NO;
        [cv registerClass:[RHPhotoBrowserCell class] forCellWithReuseIdentifier:Cell_PhotoBrowser];
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCollection:)];
        [cv addGestureRecognizer:pan];
        UISwipeGestureRecognizer * swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCollection:)];
        swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
        [cv addGestureRecognizer:swipeL];
        UISwipeGestureRecognizer * swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCollection:)];
        swipeR.direction = UISwipeGestureRecognizerDirectionRight;
        [cv addGestureRecognizer:swipeR];
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

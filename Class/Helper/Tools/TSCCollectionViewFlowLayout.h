//
//  TSCCollectionViewFlowLayout.h
//  Test-inke
//
//  Created by 唐嗣成 on 2017/12/11.
//  Copyright © 2017年 shawnTang. All rights reserved.
//


//特性详解 http://www.jianshu.com/p/9dd5f225cc01

#import <UIKit/UIKit.h>

/**
 这个重写UICollectionViewFlowLayout 主要是为了解决uicollection 在分页排列的时候是上下排列的问题。
 */
@interface TSCCollectionViewFlowLayout : UICollectionViewFlowLayout
/** 列间距 */
@property (nonatomic, assign) CGFloat columnSpacing;

/** 行间距 */
@property (nonatomic, assign) CGFloat rowSpacing;

/** collectionView的内边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/** 多少行 */
@property (nonatomic, assign) NSInteger rowCount;

/** 每行展示多少个item */
@property (nonatomic, assign) NSInteger itemCountPerRow;

/** 所有item的属性数组 */
@property (nonatomic, strong) NSMutableArray *attributesArrayM;

/** 设置行间距及collectionView的内边距 */
-(void)setColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing edgeInsets:(UIEdgeInsets)edgeInsets;

/** 设置多少行及每行展示的item个数 */
-(void)setRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;

#pragma mark - 构造方法
/** 设置多少行及每行展示的item个数 */
+(instancetype)horizontalPageFlowlayoutWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;
/** 设置多少行及每行展示的item个数 */
-(instancetype)initWithRowCount:(NSInteger)rowCount itemCountPerRow:(NSInteger)itemCountPerRow;

@end

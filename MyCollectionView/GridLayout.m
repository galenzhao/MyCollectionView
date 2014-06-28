//
//  GridLayout.m
//  MyCollectionView
//
//  Created by Neil Davis on 24/04/13.
//  Copyright (c) 2013 Neil Davis. All rights reserved.
//

#import "GridLayout.h"

//#define _itemWidth 75
//#define _itemHeight 50

@interface GridLayout()

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) NSInteger numRows;
@property (nonatomic, assign) NSInteger numCols;

@end

@implementation GridLayout

- (id)init
{
    self = [super init];
    if (self) {
        _itemWidth = 75;
        _itemHeight = 50;
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.numRows = [self.collectionView numberOfSections];
    self.numCols = [self.collectionView numberOfItemsInSection:0];  // assume same for all rows for now
    self.contentSize = CGSizeMake(self.numCols * _itemWidth, self.numRows * _itemHeight);
}

-(CGSize)collectionViewContentSize
{
    return self.contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.frame = CGRectMake(path.item * _itemWidth, path.section * _itemHeight, _itemWidth, _itemHeight);
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    
    NSUInteger startRow = floorf(rect.origin.y / _itemHeight);
    NSUInteger endRow = MIN(self.numRows -1, ceilf(CGRectGetMaxY(rect) / _itemHeight));
    NSUInteger startCol = floorf(rect.origin.x / _itemWidth);
    NSUInteger endCol = MIN(self.numCols -1, ceilf(CGRectGetMaxX(rect) / _itemWidth));
    for (NSUInteger r = startRow; r <= endRow; r++)
    {
        for (NSUInteger c = startCol; c <=  endCol; c++)
        {
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:c inSection:r]]];
        }
    }

    return attributes;
}
@end

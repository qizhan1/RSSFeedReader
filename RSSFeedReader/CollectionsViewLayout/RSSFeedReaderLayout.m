//
//  RSSFeedReaderLayout.m
//  RSSFeedReader
//
//  Created by Qi Zhan on 9/18/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

#import "RSSFeedReaderLayout.h"

#pragma mark - RSSParser Interface

@interface RSSFeedReaderLayout ()

#pragma mark - Private Properties

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> *cachedAttributes;
@property (nonatomic, assign) NSInteger numOfCols;

@end

@implementation RSSFeedReaderLayout

#pragma mark - init

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.cachedAttributes = [[NSMutableArray alloc] init];
        self.numOfCols = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 2 : 3;
    }
    
    return self;
}

#pragma mark - Overried Methods

- (CGSize)collectionViewContentSize {
    // Don't scroll horizontally
    CGFloat contentWidth = self.collectionView.bounds.size.width;
    CGFloat height = [self heightForCellinSectionOne];
    CGFloat heightForSection0 = [self heightForSectionZero];
    NSInteger numberOfItemsInSection1 = [self.collectionView numberOfItemsInSection:1];
    CGFloat heightForSection1 = (numberOfItemsInSection1 % self.numOfCols == 0) ?
        (numberOfItemsInSection1 / self.numOfCols) * height : (numberOfItemsInSection1 / self.numOfCols + 1) * height;
    CGFloat contentHeight = heightForSection0 + heightForSection1;
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    
    return contentSize;
}

-(void)prepareLayout {
    [super prepareLayout];
    
    [self.cachedAttributes removeAllObjects];
    [self prepareLayoutForSectionZero];
    [self prepareLayoutForSectionOne];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.cachedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    return self.cachedAttributes[indexPath.item];
}

- (void)invalidateLayout{
    [super invalidateLayout];
    [self.cachedAttributes removeAllObjects];
}

#pragma mark - Private Methods

- (CGFloat)heightForSectionZero {
    return self.collectionView.bounds.size.height / 3;
}

- (CGFloat)heightForCellinSectionOne {
    return self.collectionView.bounds.size.height / 5;
}

- (void)prepareLayoutForSectionZero {
    NSInteger countOfElements = [self.collectionView numberOfItemsInSection:0];
    
    if (countOfElements != 0) {
        CGFloat x = 0.f;
        CGFloat y = 0.f;
        CGFloat width = self.collectionView.bounds.size.width ;
        CGFloat height = [self heightForSectionZero];
        UICollectionViewLayoutAttributes *attributes
        = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        attributes.frame = CGRectMake(x, y, width, height);
        
        [self.cachedAttributes addObject:attributes];
    }
}

- (void)prepareLayoutForSectionOne {
    NSInteger countOfElements1 = [self.collectionView numberOfItemsInSection:1];
    CGFloat x = 0.f;
    CGFloat y = [self heightForSectionZero];
    CGFloat width = self.collectionView.bounds.size.width / self.numOfCols;
    CGFloat height = [self heightForCellinSectionOne];
    for (NSInteger idx = 0; idx < countOfElements1; idx++) {
        x = (idx % self.numOfCols) * width;
        if (idx % self.numOfCols == 0 && idx != 0) {
            y += height;
        }
        UICollectionViewLayoutAttributes *attributes
        = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:idx
                                                                                                     inSection:1]];
        attributes.frame = CGRectMake(x, y, width, height);
        [self.cachedAttributes addObject:attributes];
    }
}


@end

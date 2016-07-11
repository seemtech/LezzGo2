//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTCollectionViewWaterfallCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deletebtn;

@property CGFloat textheight;

@property (nonatomic, strong) UILabel *Newsfeedtextlbl;
@property (nonatomic, strong) NSString *msgtext;

@end

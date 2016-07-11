//
//  ViewController.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CHTCollectionViewWaterfallLayout.h"
#import <UIKit/UICollectionView.h>
#import "AppDelegate.h"
#import <UIKit/UIView.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UICollectionView.h>
#import "AFNetworking.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "MSMenuView.h"
#import "REFrostedViewController.h"
#import "HeaderVC.h"

@interface NewsFeedVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout,MSMenuViewDelegate,HeaderVCDelegate>

//CHTCollectionViewDelegateWaterfallLayout
{
    HeaderVC *header;

    UIRefreshControl *refreshControl;

    NSMutableArray *array_images;
    IBOutlet UIImageView *imgicon;
     NSMutableArray *cellSizes;
   
    UIView*  indicatorFullView;
    UIActivityIndicatorView *spinner;
    NSUInteger CELL_COUNT;
    AppDelegate *delegate;
    NSMutableArray *array;
    IBOutlet UIButton *btnsetting;
    CGFloat height ;
    CGFloat width ;
    
    int pageValue ;
    NSInteger arrayValue;

    
    
}
//collectionView
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)btnSettingClicked:(id)sender;




- (IBAction)btnHomeClicked:(id)sender;
- (IBAction)btnSearchClicked:(id)sender;
- (IBAction)btnStarClicked:(id)sender;
- (IBAction)btnMoreClicked:(id)sender;


@end

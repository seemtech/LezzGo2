//
//  UserProfileVC.h
//  LezzGo2
//
//  Created by Apple on 04/07/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "AppDelegate.h"

@interface UserProfileVC : UIViewController<HeaderVCDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
{
    AppDelegate *delegate;

    IBOutlet UIButton *Bthpost;
    IBOutlet UIButton *BthDetails;
    IBOutlet UIImageView *Btnpostselectimage;
    IBOutlet UIImageView *Btndetailsselectimage;
    HeaderVC *header;
    IBOutlet UIView *PROFILEVIEW;
    UIRefreshControl *refreshControl;
    NSMutableArray *array_images;
    IBOutlet UIImageView *imgicon;
    NSMutableArray *cellSizes;
    UIView *indicatorFullView;
    UIActivityIndicatorView *spinner;
    NSUInteger CELL_COUNT;
    NSMutableArray *array;
    CGFloat height;
    CGFloat width;
    int pageValue;
    NSInteger arrayValue;
    NSString *other1;
    NSString *other2;
    NSString *other3;
    NSString *otheruserid;
    IBOutlet UIScrollView *mainscroll;

}
@property(nonatomic,strong)NSString *otheruserid;
@property(nonatomic,strong)IBOutlet UIScrollView *mainscroll;

@property(nonatomic,strong)IBOutlet UIImageView *Btnpostselectimage;
@property(nonatomic,strong)IBOutlet UIImageView *Btndetailsselectimage;
@property(nonatomic,strong)IBOutlet UIButton *Bthpost;
@property(nonatomic,strong)IBOutlet UIButton *BthDetails;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *arrayImages;
@property(nonatomic,retain) IBOutlet UIView *PROFILEVIEW;
-(IBAction)btnprofileclick:(id)sender;
-(IBAction)btndetailsclick:(id)sender;
@end

//
//  ViewController.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//


#import "NewsFeedVC.H"
#import "MyProfileVC.h"
#import <ImageIO/ImageIO.h>

#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "AppDelegate.h"

#import "DEMORootViewController.h"
#import "DEMONavigationController.h"
#import "MapViewVC.h"
#import "FriendsVC.h"
#import "HeaderVC.h"
#import "AddPostVC.h"

#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"
//#define CELL_COUNT 30
//#define CELL_IDENTIFIER @"WaterfallCell"
//#define HEADER_IDENTIFIER @"WaterfallHeader"
//#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface NewsFeedVC ()
@end

@implementation NewsFeedVC


- (void)gotobackclick
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}
- (void)viewDidLoad {
    
    
    delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.showlefticon=0;
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"News Feeds";
    header.delegate = self;
    [self.view addSubview:header];
    MSMenuView *menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-53, self.view.frame.size.width, 53)];
    menu.selecttag=4;
    menu.delegatemenu = self;
    [self.view addSubview:menu];
    self.collectionView.alwaysBounceVertical = YES;
    array_images=[[NSMutableArray alloc]initWithObjects:@"img.png",@"img2.png",@"img3.png",@"img.png",@"img2.png",@"img3.png",@"img.png",@"img2.png",@"img3.png", nil];
    cellSizes= [[NSMutableArray alloc]init];
    //btnsetting.hidden=YES;
    //imgicon.hidden=YES;
    //[ self photoapi];
    pageValue=0;
    [self.view addSubview:self.collectionView];
    // to get images size by himani
    [self setupimagearrray];
    //    [self.view addSubview:view1];
    [super viewDidLoad];
}
-(void)MapBtnClick
{
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    MapViewVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}
-(void)MyProfileBtnClick
{
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
     MyProfileVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
    
}
-(void)CameraBtnClick
{
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    AddPostVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPostVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}
-(void)NewsBtnClick
{
    
 
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)FriendsBtnClick
{
    
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    FriendsVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendsVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
    
    
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.headerHeight = 0;
        
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        
        
        
        CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
        
        if (screenHeight==480)
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,94, 320, 373-25)   collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER];
            
        }
        
        else if (screenHeight==667)
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,94, 375, 432-25)   collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER];
            
        }
        else if (screenHeight>667&&screenHeight<1024)
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,94,414, 596-25)   collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER];
        }
        else
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,94, 320, 432-25)   collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER];
            
        }
        
    }
    return _collectionView;
}





#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}


- (void)setupimagearrray
{
    for (NSInteger i = 0; i <array_images.count; i++) {
        // NSString *photoName = [NSString stringWithFormat:@"%ld.jpg",i];
        
       // NSString *imagestring = [[delegate.imageArray objectAtIndex:i] valueForKey:@"image_large_url"];
        if(i==0||i==3||i==5)
        {
            NSValue *getsize= [NSValue valueWithCGSize:CGSizeMake(200,150)];
            [cellSizes addObject:getsize];
        }
        else
        {
            NSValue *getsize= [NSValue valueWithCGSize:CGSizeMake(150,150)];
            [cellSizes addObject:getsize];
        }
    
        // UIImage *photo = [UIImage imageNamed:imagestring];
    }
    
    NSLog(@"cellSizes%@",cellSizes);
    [self.collectionView reloadData];

    //NSLog(@"%@",arrayValue);
}



#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [cellSizes[indexPath.item] CGSizeValue];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array_images.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    
   
    
     NSString *imagestring = [array_images objectAtIndex:indexPath.row] ;
    cell.layer.borderWidth=4.0;
    cell.clipsToBounds=YES;
    cell.layer.borderColor=[UIColor whiteColor].CGColor;
    cell.imageView.image = [UIImage imageNamed:imagestring];
    NSString *msgtext=@"VERY NICE! MUST GO TO WATCH";
    CGSize possibleSize = [msgtext sizeWithFont:[UIFont fontWithName:@"BebasNeueBook" size:16] //font you are using
                             constrainedToSize:CGSizeMake(cell.frame.size.width,9999)
                                 lineBreakMode:NSLineBreakByWordWrapping];
    cell.textheight=possibleSize.height;
    cell.Newsfeedtextlbl.text=msgtext;

   /// UIImageView *imageView = [[UIImageView alloc]init];
    
//    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicatorView.color=[UIColor darkGrayColor];
//    activityIndicatorView.frame=CGRectMake( cell.imageView.frame.size.width/2,  cell.imageView.frame.size.height/2, 0, 0);
//    [activityIndicatorView startAnimating];
//    [ cell.imageView addSubview:activityIndicatorView];

    //[self startIndicator:self.view];
//    NSString *imagestring = [[delegate.imageArray objectAtIndex:indexPath.row] valueForKey:@"image_large_url"];
//    
//    if (imagestring !=(NSString *)[NSNull null]) {
//        
//        
//        SDWebImageManager *manager = [SDWebImageManager sharedManager];
//        
//        [manager downloadImageWithURL:[NSURL URLWithString:imagestring]
//                              options:0
//                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                 // progression tracking code
//                             }
//                            completed:^(UIImage *image1, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                if (image1) {
//                                    
//                                    
//                                    [[SDImageCache sharedImageCache] storeImage:image1 forKey:imagestring];
//                                    cell.imageView.image = image1;
//                                    
//                                   
//
//                                     [activityIndicatorView stopAnimating];
//                                    //cell.imageView.frame = CGRectMake(   cell.imageView.f, 0, resizedWidth, resizedHeight);
//                                    //imageView.contentMode=UIViewContentModeScaleAspectFit;
//                                    
//                                    
//                                    
//                                    // do something with image
//                                }
//                            }];
//    }
//    
    //[self dissmissIndicatorr];
    
    //cell.imageView.contentMode=UIViewContentModeScaleAspectFill;
    // cell.imageView.contentMode= UIViewContentModeScaleToFill;
    NSLog(@"indexpath before%ld",(long)indexPath.row);
    
//    if (indexPath.row==(arrayValue -1))
//    {
//        NSLog(@"indexpath of row%ld",(long)indexPath.row);
//        arrayValue= arrayValue+30;
//        //            arrcountValue= arrcountValue+50
//        pageValue++;
//        [self photoapi];
//        //[self getArraydatawithlenth];
//    }
    
    //cell.imageView.image = _photosArray[indexPath.item];
    
    
    
    return cell;
    
}
-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    
    
}


@end

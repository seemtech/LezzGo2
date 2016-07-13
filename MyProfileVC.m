//
//  UserProfileVC.m
//  LezzGo2
//
//  Created by Apple on 04/07/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MyProfileVC.h"
#import "MapViewVC.h"
#import "FriendsVC.h"
#import "NewsFeedVC.h"

#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "DEMONavigationController.h"
#import "AddPostVC.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "CHTCollectionViewWaterfallFooter.h"
@interface MyProfileVC ()

@end

@implementation MyProfileVC
@synthesize PROFILEVIEW,Bthpost,BthDetails,Btnpostselectimage,Btndetailsselectimage,mainscroll;
#define CELL_IDENTIFIER3 @"WaterfallCell"
#define HEADER_IDENTIFIER3 @"WaterfallHeader"
#define FOOTER_IDENTIFIER3 @"WaterfallFooter"
- (void)viewDidLoad {
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    //    [Bthpost setTitleColor:[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    [Bthpost setTitleColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    //    [BthDetails setTitleColor:[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    [BthDetails setTitleColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    Btnpostselectimage.hidden=NO;
    Btndetailsselectimage.hidden=YES;
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"MY PROFILE";
    [super viewWillAppear:YES];

    pageValue=0;
    PROFILEVIEW.hidden=YES;
    header.delegate = self;
    [self.view addSubview:header];
    MSMenuView *menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-53, self.view.frame.size.width, 53)];
    menu.selecttag=2;
    
    menu.delegatemenu = self;
    [self.view addSubview:menu];
    self.collectionView.alwaysBounceVertical = YES;
    array_images=[[NSMutableArray alloc]initWithObjects:@"img.png",@"img2.png",@"img3.png",@"img.png",@"img2.png",@"img3.png",@"img.png",@"img2.png",@"img3.png", nil];
    cellSizes= [[NSMutableArray alloc]init];
    mainscroll.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-grey.png"]];

    [mainscroll addSubview:self.collectionView];
    [self setupimagearrray];
    [self MyProfileDetailsApi];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)MyProfileDetailsApi
{
    NSDictionary *params;
    
    [SVProgressHUD showWithStatus:@"Fetching Details..."];
    
    
    params = @{@"action":@"showuserdetails",@"user_id":delegate.userid};
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            
            NSLog(@"loginResponse object %@",responseObject);
            delegate.logininfo_Array=[responseObject valueForKey:@"show"];

            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    
    
    
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
    
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    NewsFeedVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsFeedVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];

    
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
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,381-64, 320, self.view.frame.size.height)    collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER3];
            
        }
        
        else if (screenHeight==667)
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,381-64, 320, self.view.frame.size.height)    collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER3];
            
        }
        else if (screenHeight>667&&screenHeight<1024)
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,381-64, 320, self.view.frame.size.height)    collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER3];
        }
        else
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,381-64, 320, self.view.frame.size.height)    collectionViewLayout:layout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            _collectionView.backgroundColor = [UIColor clearColor];
            [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
                forCellWithReuseIdentifier:CELL_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER3];
            [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                       withReuseIdentifier:FOOTER_IDENTIFIER3];
            
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
    CGRect frame2=self.collectionView.frame;
    frame2.size.height=150*array_images.count;
    self.collectionView.frame=frame2;
    mainscroll.contentSize=CGSizeMake(self.view.frame.size.width,self.collectionView.frame.size.height);

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
                                                          withReuseIdentifier:HEADER_IDENTIFIER3
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER3
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
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER3
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
-(IBAction)btndetailsclick:(id)sender
{
    
    Btnpostselectimage.hidden=YES;
    Btndetailsselectimage.hidden=NO;
    
    
    PROFILEVIEW.hidden=NO;
    self.collectionView.hidden=YES;
    
}
-(IBAction)btnprofileclick:(id)sender
{
    Btnpostselectimage.hidden=NO;
    Btndetailsselectimage.hidden=YES;
    
    
    PROFILEVIEW.hidden=YES;
    self.collectionView.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

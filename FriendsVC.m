//
//  NewMatchVC.m
//
//  Created by Domain on 3/7/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import "FriendsVC.h"
#import "NewMatchTableViewCell.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SDWebImageManager.h"
#import "MapViewVC.h"
#import "DEMONavigationController.h"
#import "WebServices.h"
#import "NewsFeedVC.h"
#import "UserProfileVC.h"
#import "FriendsVC.h"
#import "NewsFeedVC.h"
#import "MyProfileVC.h"
#import "AddPostVC.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface FriendsVC ()

@end

@implementation FriendsVC
@synthesize lblNoMatchUser,lblNoMatchUser2;
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
- (void)viewDidLoad
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.showlefticon=0;

    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"Friends";
    
    header.delegate = self;
    [self.view addSubview:header];
    MSMenuView *menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-53, self.view.frame.size.width, 53)];
    menu.selecttag=5;
    
    menu.delegatemenu = self;
    [self.view addSubview:menu];
    arrlableData=[[NSMutableArray alloc]init];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet"
                                                        message:@"No internet connection found, please reconnect and try again."
                                                       delegate:self cancelButtonTitle:@"Retry"
                                              otherButtonTitles:nil];
        alert.tag=1001;
        [alert show];
    }
    else
    {
        refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
        [tbloutlet addSubview:refreshControl];
        [self FriendslistApi];
    }
    
    tbloutlet.hidden=NO;
    lblNoMatchUser.hidden=YES;
    lblNoMatchUser2.hidden=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)handleRefresh:(id)sender
{
    // do your refresh here...
    [self FriendslistApi];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1001)
    {
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet"
                                                            message:@"No internet connection found, please reconnect and try again."
                                                           delegate:self cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            alert.tag=1002;
            [alert show];
        }
        else
        {
            [self FriendslistApi];
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrlableData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"settingCell";
    
    NewMatchTableViewCell *obj = (NewMatchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (obj == nil) {
        
        
        NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NewMatchTableViewCell" owner:self options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                obj = (NewMatchTableViewCell *)currentObject;
                
                break;
            }}}
    
    NSMutableDictionary *dicfeeds= [arrlableData objectAtIndex:indexPath.row];
    obj.LblName.text =[dicfeeds valueForKey:@""];
    //obj.LblName.font=[UIFont fontWithName:@"BebasNeueBold" size:16];
    
    obj.LblName.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    obj.userimage.layer.cornerRadius=obj.userimage.frame.size.height/2;
    obj.userimage.clipsToBounds=YES;
    obj.LblTime.textColor=[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0];
    
    
    
    
      //  obj.NewMatchimgs.image=[UIImage imageNamed:[arrImageData objectAtIndex:indexPath.row]];
    
    
        obj.userimage.layer.cornerRadius = obj.userimage.frame.size.height /2;
        obj.userimage.layer.masksToBounds = YES;
    
    
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
        [manager downloadImageWithURL:[NSURL URLWithString:[dicfeeds valueForKey:@""]]
    
                              options:0
    
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
    
                             }
    
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    
                                if (image) {
    
                                    [[SDImageCache sharedImageCache] storeImage:image forKey:[dicfeeds valueForKey:@""]];
                                    if (image==Nil) {
                                        obj.userimage.image=[UIImage imageNamed:@""];
                                    }
                                    else
    
                                        //effectImage =[image applyDarkEffect];
    
                                        obj.userimage.image=image;
    
    
                                }
                            }];
    
    
    return obj;
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    UserProfileVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    delegate.showlefticon=0;
    [self presentViewController:obj animated:YES completion:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FriendslistApi
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSDictionary *params;
  
    [SVProgressHUD showWithStatus:@"Refreshing..."];
    params = @{@"action":@"myfriend",@"user_id":delegate.userid};
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            NSLog(@"loginResponse object %@",responseObject);
            [arrlableData removeAllObjects];
            arrlableData = [responseObject objectForKey:@"show"];

            [refreshControl endRefreshing];
            
            if ([arrlableData count]!=0) {
                
                tbloutlet.hidden=NO;
                lblNoMatchUser.hidden=YES;
                lblNoMatchUser2.hidden=YES;
                [tbloutlet reloadData];
                
            }
            else{
                
                lblNoMatchUser.hidden=NO;
                lblNoMatchUser2.hidden=NO;
                tbloutlet.hidden=YES;
                
            }
            
            
            

  
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];

    
    }



@end

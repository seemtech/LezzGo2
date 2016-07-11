//
//  NewMatchVC.m
//
//  Created by Domain on 3/7/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import "NewMatchVC.h"
#import "NewMatchTableViewCell.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SDWebImageManager.h"
#import "SPHViewController.h"
#import "WebServices.h"
@interface NewMatchVC ()

@end

@implementation NewMatchVC
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

- (void)viewDidLoad
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"CHATS";
    
    header.delegate = self;
    [self.view addSubview:header];
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

        [alert show];    }
    else
    {
        refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
        [tbloutlet addSubview:refreshControl];
//    [self inboxapi];
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
    [self inboxapi];
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
            [self inboxapi];
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
    return 90;
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
    obj.Lblmsg.text =[dicfeeds valueForKey:@""];
    obj.LblTime.text =[dicfeeds valueForKey:@""];

     //obj.LblName.font=[UIFont fontWithName:@"BebasNeueBold" size:16];
    
     obj.LblName.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    obj.userimage.layer.cornerRadius=obj.userimage.frame.size.height/2;
    obj.userimage.clipsToBounds=YES;
    obj.LblTime.textColor=[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0];


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
    
    SPHViewController * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"SPHViewController"];
    
    obj.Reciever_id = [[arrayinbox valueForKey:@"user_id"]objectAtIndex:indexPath.row];
    obj.Sender_id =[delegate.logininfo_Array valueForKey:@"user_id"] ;
     delegate.strChatUsername =[[arrayinbox valueForKey:@"name"]objectAtIndex:indexPath.row];
 ;
    obj.userImageString =[[arrayinbox valueForKey:@"picture1"]objectAtIndex:indexPath.row];
 ;
    obj.arrayforprofile=[arrayinbox objectAtIndex:indexPath.row];

    [self presentViewController:obj animated:NO completion:nil];
    
    
    
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

-(void)inboxapi
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//    NSString *userid=[delegate.logininfo_Array valueForKey:@"user_id"];
    
    NSDictionary *params;
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSString *timevalue = [NSString stringWithFormat:@"%@",timeZone];
    
    NSArray *timezoneindex = [timevalue componentsSeparatedByString:@" "];
    NSString *gmtstring = [timezoneindex objectAtIndex:3];
    
    
    ////
    
   params = @{@"action":@"inbox",@"user_id":delegate.userid,@"gmtvalue":gmtstring};
    
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
      [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [arrayinbox removeAllObjects];
        [tbloutlet reloadData];
        
        
        
        NSLog(@"Reply JSON: %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            NSLog(@"Response object %@",responseObject);
            arrlableData=[[responseObject objectForKey:@"show"] mutableCopy];
            [refreshControl endRefreshing];
            
            if ([arrayinbox count]!=0) {
                
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
        
        
        // [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
}




@end

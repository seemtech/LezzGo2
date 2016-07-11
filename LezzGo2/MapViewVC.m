//
//  MapViewVC.m
//  LezzGo2
//
//  Created by Apple on 28/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MapViewVC.h"
#import "VPPMapHelper.h"
#import "MapAnnotationExample.h"
#import "FilterVC.h"
#import "FriendsVC.h"
#import "DEMONavigationController.h"
#import "NewsFeedVC.h"
#import "MyProfileVC.h"
#import "AddPostVC.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"
#import "SDWebImageManager.h"

@interface MapViewVC ()

@end

@implementation MapViewVC
@synthesize mapView,customcalloutview;
-(float)RandomFloatStart:(float)a end:(float)b {
    float random = ((float) rand()) / (float) RAND_MAX;
    float diff = b - a;
    float r = random * diff;
    return a + r;
}
- (void) open:(id<MKAnnotation>)annotation {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Annotation pressed" message:[NSString stringWithFormat:@"It says: %@",annotation.title] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
    [av release];
}

-(void)likebtn:(id)sender
{
    UIButton *btn=sender;
    NSLog(@"%ldcheckuserid",(long)btn.tag);
    NSString *matchuserid=[NSString stringWithFormat:@"%ld",(long)btn.tag];
    NSDictionary *params;
        [SVProgressHUD showWithStatus:@"Liking..."];
        params = @{@"action":@"like",@"user_id":delegate.userid,@"matched_user_id":matchuserid};
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            
            NSLog(@"loginResponse object %@",responseObject);
            
                UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject valueForKey:@"show"]message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                {
                                                  
                                                    
                                                }];
                [alertcontroller addAction:defaultAction];
                [self presentViewController:alertcontroller animated:YES completion:nil];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    

}

- (BOOL) annotationDroppedByUserShouldOpen:(id<MKAnnotation>)annotation {
    MapAnnotationExample *ann = (MapAnnotationExample*)annotation;
    
    ann.title = @"Hi there!";
    ann.pinAnnotationColor = MKPinAnnotationColorGreen;
    
    return YES;
}


- (IBAction)showMenu
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
    allusersresponse=[[NSMutableArray alloc]init];
    delegate.showlefticon=0;

    MSMenuView *menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-53, self.view.frame.size.width, 53)];
    menu.selecttag=1;

    menu.delegatemenu = self;
    [self.view addSubview:menu];
 
    customcalloutview.layer.cornerRadius = 5;
    customcalloutview.layer.masksToBounds = YES;
    customcalloutview.hidden = YES;
    // sets up the map
        [self NearestUsersApi];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent* )event
{
    customcalloutview.hidden = YES;
}

-(void)MapBtnClick
{
    
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

-(void)NearestUsersApi
{
    
    NSDictionary *params;
    
    [SVProgressHUD showWithStatus:@"Finding Nearest Users..."];
    
    params = @{@"action":@"nearbyuser",@"user_id":delegate.userid};
    
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            NSLog(@"responseObjectresponseObject=%@",responseObject);
            allusersresponse = [responseObject objectForKey:@"show"];
            _mh = [[VPPMapHelper VPPMapHelperForMapView:self.mapView
                                     pinAnnotationColor:MKPinAnnotationColorGreen
                                  centersOnUserLocation:NO
                                  showsDisclosureButton:YES
                                               delegate:self] retain];
            self.mapView.showsUserLocation = YES;
            _mh.userCanDropPin = YES;
            _mh.allowMultipleUserPins = YES;
            _mh.pinDroppedByUserClass = [MapAnnotationExample class];
            

            
        
            [self tonsOfPins];
            [_mh release];

            
            NSLog(@"loginResponse object %@",responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    
    
}
-(IBAction)filterbtn:(id)sender
{
delegate.showlefticon=1;
FilterVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterVC"];
secondViewController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
[self presentViewController:secondViewController animated:YES completion:nil];
}
- (void) tonsOfPins {
    srand((unsigned)time(0));
    
    NSMutableArray *tempPlaces=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < allusersresponse.count; i++) {
        
        NSMutableDictionary *dic=[allusersresponse objectAtIndex:i];
        NSLog(@"%@dicdic",dic);
        MapAnnotationExample *place= [[MapAnnotationExample alloc] init];

        place.coordinate = CLLocationCoordinate2DMake([[dic valueForKey:@"latitude"] doubleValue],[[dic valueForKey:@"longitude"]doubleValue]);
        [place setUsername:[dic valueForKey:@"full_name"]];
        [place setUserage:[dic valueForKey:@"age"]];
        [place setUserid:[dic valueForKey:@"user_id"]];
        [place setLikestatus:[dic valueForKey:@"like_status"]];

        [place setPosttext:[dic valueForKey:@"post_title"]];
        [place setImageurl:[dic valueForKey:@"profile_pic"]];
        [place setTitle:[dic valueForKey:@"full_name"]];
        place.indextag=[NSString stringWithFormat:@"%i",i];

        [tempPlaces addObject:place];
        [place release];
        
    }
    _mh.shouldClusterPins = YES;
    [_mh setMapAnnotations:tempPlaces];
    [tempPlaces release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

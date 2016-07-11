//
//  AppDelegate.m
//
//  Created by Domain on 3/1/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import "AppDelegate.h"
#import "AGPushNoteView.h"
#import "SPHViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "AFNetworkReachabilityManager.h"
#import "Reachability.h"
#import "ViewController.h"
#import "DEMORootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}
@synthesize strCheckTemp,User_id,rangesliderDic,strResetMatch,strChatUsername,AddressString,truncatedString,countrycode,userid,showlefticon,userlogout;


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    [self.shareModel restartMonitoringLocation];
    
    
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    
    
    //Remove the "afterResume" Flag after the app is active again.
    self.shareModel.afterResume = NO;
    
    [self.shareModel startMonitoringLocation];
    
  
    
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    
    
    
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)_deviceToken
{
    
    NSString *deviceToken1 = [[[[_deviceToken description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                              stringByReplacingOccurrencesOfString: @" " withString: @""];
    _device_Id=[deviceToken1 mutableCopy];
    
    NSLog(@"deviceToken : %@", _device_Id);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationIconBadgeNumber = 0;
    
       NSString *lat=_currentLat;
    NSString *longi=_currentLong;
    strResetMatch=@"2";
    self.shareModel = [LocationManager sharedManager];
    self.shareModel.afterResume = NO;
    UIAlertView *alert;
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied) {
        
        //        alert = [[UIAlertView alloc]initWithTitle:@""
        //                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
        //                                         delegate:nil
        //                                cancelButtonTitle:@"Ok"
        //                                otherButtonTitles:nil, nil];
        //        [alert show];
        
    } else if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted) {
        //
        //        alert = [[UIAlertView alloc]initWithTitle:@""
        //                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
        //                                         delegate:nil
        //                                cancelButtonTitle:@"Ok"
        //                                otherButtonTitles:nil, nil];
        //        [alert show];
        
    } else {
        
        // When there is a significant changes of the location,
        // The key UIApplicationLaunchOptionsLocationKey will be returned from didFinishLaunchingWithOptions
        // When the app is receiving the key, it must reinitiate the locationManager and get
        // the latest location updates
        
        // This UIApplicationLaunchOptionsLocationKey key enables the location update even when
        // the app has been killed/terminated (Not in th background) by iOS or the user.
        
        NSLog(@"UIApplicationLaunchOptionsLocationKey : %@" , [launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]);
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            
            // This "afterResume" flag is just to show that he receiving location updates
            // are actually from the key "UIApplicationLaunchOptionsLocationKey"
            self.shareModel.afterResume = YES;
            
            [self.shareModel startMonitoringLocation];
            
        }
    }    ///////// end ///////////
    
    
    // Override point for customization after application launch.
    
    self.window.backgroundColor=[UIColor whiteColor];
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    NSString *str=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginOrLogout"];
    
    if ([str isEqualToString:@"Login"])
    {
        
        NSMutableDictionary *array=[[[NSUserDefaults standardUserDefaults]valueForKey:@"ArrayInfo"]mutableCopy];
        self.logininfo_Array=array;
       userid=[self.logininfo_Array objectForKey:@"user_id"];
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle: nil];
        DEMORootViewController  *obj = [storyboard instantiateViewControllerWithIdentifier:@"rootController"];
        self.window.rootViewController=obj;
        
        
        
        
    }
    else
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        ViewController * obj = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        self.window.rootViewController=obj;
    }
    
    
    
    
    return YES;
    
    
    
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}






- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
    NSLog(@"notification recieve=%@",error);
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"notification recieve=%@",userInfo);
    
    
    
    /*   aps =     {
     alert = "You have new match start a chat now";
     badge = 1;
     sound = default;
     };
     data =     {
     "from_id" = 349;
     msg = "New Match!";
     name = "Shuaib Alam";
     "to_id" = 34;
     type = "start_chat";
     }; */
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"VibrationStatus"];
    
    
    if ([savedValue isEqualToString:@"yes"])
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    else  if ([savedValue isEqualToString:@"no"]){
        
        AudioServicesPlaySystemSound(1007);
        
    }
    
    _Push_dataArray =[[NSMutableDictionary alloc] init];
    _Push_datadic=[userInfo valueForKey:@"aps"];
    _Push_dataArray=[userInfo valueForKey:@"data"];
    
    //  _sendernameString=[_Push_dataArray valueForKey:@"name"];
    _messageType=[_Push_dataArray valueForKey:@"type"];
    
    if ([_messageType isEqualToString:@"chat"]) {
        _Push_Sender_id=[_Push_dataArray valueForKey:@"toUsers_id"];
        
        //        if ([_senderChatid isEqualToString:_Push_Sender_id]){
        
        if ([_delegatePushStr isEqualToString:@"Insinglechat"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PostNotification" object:nil];
            
        }
        
        else
        {
            UIApplicationState statenew = [application applicationState];
            if (statenew == UIApplicationStateActive)
            {
                NSString*showString=[_Push_datadic valueForKey:@"alert"];
                [AGPushNoteView showWithNotificationMessage:showString];
                [AGPushNoteView setMessageAction:^(NSString *message)
                 {
                     
                     [self ShowSimpleChat];
                     
                 }];
            }
            
            else
            {
                
                [self ShowSimpleChat];
                
            }
        }
      
    }
    else if ([_messageType isEqualToString:@"start_chat"]){
        
        UIApplicationState statenew = [application applicationState];
        if (statenew == UIApplicationStateActive)
        {
            NSString*showString=[_Push_datadic valueForKey:@"alert"];
            [AGPushNoteView showWithNotificationMessage:showString];
            [AGPushNoteView setMessageAction:^(NSString *message)
             {
                 
                 
                 [self ShowFirstTimeChat];
                 
             }];
        }
        else{
            
            
            
            [self ShowFirstTimeChat];
            
        }
        
    }
    
    
}

-(void)ShowFirstTimeChat{
    
    
    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"MainIpad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main6" bundle: nil]: screenHeight==736 ? [UIStoryboard storyboardWithName:@"Main6plus" bundle: nil]: [UIStoryboard storyboardWithName:@"Main4" bundle: nil];
    
    SPHViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"SPHViewController"];
    
    strChatUsername=[_Push_dataArray valueForKey:@"name"];
    lvc.Sender_id = [_Push_dataArray valueForKey:@"from_id"];
    lvc.Reciever_id = [_Push_dataArray valueForKey:@"to_id"];
    
    //    self.strRemoveChatPushview = @"pushView";
    [[self topMostController] presentViewController:lvc animated:NO completion:nil];
    
}


-(void)ShowSimpleChat{
    
    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"MainIpad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main6" bundle: nil]: screenHeight==736 ? [UIStoryboard storyboardWithName:@"Main6plus" bundle: nil]: [UIStoryboard storyboardWithName:@"Main4" bundle: nil];
    SPHViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"SPHViewController"];
    
    
    strChatUsername =[_Push_dataArray valueForKey:@"username"];
    
    lvc.Sender_id = [_Push_dataArray valueForKey:@"toUsers_id"];
    lvc.Reciever_id = [_Push_dataArray valueForKey:@"fromUsers_id"];
    
    //    self.strRemoveChatPushview = @"pushView";
    [[self topMostController] presentViewController:lvc animated:NO completion:nil];
    
}


- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}





@end

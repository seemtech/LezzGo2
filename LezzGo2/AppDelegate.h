//
//  AppDelegate.h
//  LezzGo2
//
//  Created by Apple on 24/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CLLocation * newLocation;
    NSString * AddressString;
    NSString *truncatedString;
    
    __block NSString *lastWord;
    
    NSString *userlogout;
    BOOL forLogout;
    UIStoryboard *storyboard;
    
    NSString *countrycode;
    NSString *userid;
    
    int showlefticon;
    NSString *strshowprofileonmap;
    
    NSString *strpushnotificationon;

    
    
}
@property(nonatomic,retain)NSString *strshowprofileonmap;

@property(nonatomic,retain)NSString *strpushnotificationon;

@property    int showlefticon;

@property(nonatomic,retain)NSString *userid;


@property (strong,nonatomic) LocationManager * shareModel;

@property (strong, nonatomic) UIWindow *window;
@property (strong , nonatomic)NSString *AddressString;
@property (strong , nonatomic)NSString *truncatedString;

@property (strong , nonatomic) NSString *device_Id;

@property(nonatomic,strong)NSMutableDictionary *logininfo_Array,*rangesliderDic;

@property (nonatomic ,  strong) NSMutableArray * arraytemp;
@property (strong , nonatomic) NSString * strCheckTemp;


@property (strong , nonatomic) NSString * strGestureRec;


@property (strong , nonatomic) NSString * stralertlike;
@property (strong , nonatomic) NSString * stralertunlike;

@property (strong , nonatomic) NSMutableDictionary * Push_dataArray;
@property (strong , nonatomic) NSMutableDictionary * Push_datadic;

@property (strong , nonatomic) NSString * Push_Sender_id;
@property (strong , nonatomic) NSString * messageType;

@property (strong , nonatomic) NSString * senderChatid;
@property (nonatomic,retain)NSString *delegatePushStr;



@property (strong , nonatomic) NSString * User_id;

@property(nonatomic,strong)NSString*matchLocationLatitude;
@property(nonatomic,strong)NSString*matchLocationLongitude;
@property(nonatomic,strong)NSString*matchLocation;
@property (strong , nonatomic) NSString * currentLat , * currentLong;
@property  (nonatomic,retain)  CLLocationManager *manager;
@property (strong , nonatomic) NSString * strcountry;
@property(nonatomic,retain)NSString *userlogout;
@property(nonatomic,retain) NSString *User_countryName;
@property(nonatomic,retain) NSString *countrycode;
@property (strong, nonatomic) NSString *strResetMatch;

@property (strong, nonatomic) NSString *strChatUsername;


@end



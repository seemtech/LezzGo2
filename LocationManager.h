//
//  LocationShareModel.h
//  Location
//
//  Copyright (c) 2014 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface LocationManager : NSObject
{
  CLLocationCoordinate2D myLocation;
    CLLocation *mynewLocation;
NSString * Latitude_current , * Longitude_current;

}
@property (strong , nonatomic) NSString * Latitude_current , * Longitude_current;

@property (nonatomic)CLLocation *mynewLocation;

@property (nonatomic) CLLocationManager * anotherLocationManager;

@property (nonatomic) CLLocationCoordinate2D myLastLocation;
@property (nonatomic) CLLocationAccuracy myLastLocationAccuracy;

@property (nonatomic) CLLocationCoordinate2D myLocation;
@property (nonatomic) CLLocationAccuracy myLocationAccuracy;

@property (nonatomic) NSMutableDictionary *myLocationDictInPlist;
@property (nonatomic) NSMutableArray *myLocationArrayInPlist;

@property (nonatomic) BOOL afterResume;

+ (id)sharedManager;

- (void)startMonitoringLocation;
- (void)restartMonitoringLocation;


@end

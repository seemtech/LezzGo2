//
//  LocationShareModel.m
//  Location
//
//  Copyright (c) 2014 Location. All rights reserved.
//

#import "LocationManager.h"
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "WebServices.h"

@interface LocationManager () <CLLocationManagerDelegate>

@end


@implementation LocationManager
@synthesize myLocation,mynewLocation,Latitude_current,Longitude_current;
//Class method to make sure the share model is synch across the app
+ (id)sharedManager {
    static id sharedMyModel = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
    });
    
    return sharedMyModel;
}


#pragma mark - CLLocationManager

- (void)startMonitoringLocation {
    if (_anotherLocationManager)
        [_anotherLocationManager stopMonitoringSignificantLocationChanges];
    
    self.anotherLocationManager = [[CLLocationManager alloc]init];
    _anotherLocationManager.delegate = self;
    _anotherLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _anotherLocationManager.activityType = CLActivityTypeOtherNavigation;
    
    if(IS_OS_8_OR_LATER) {
        [_anotherLocationManager requestAlwaysAuthorization];
    }
    [_anotherLocationManager startMonitoringSignificantLocationChanges];
}

- (void)restartMonitoringLocation {
    [_anotherLocationManager stopMonitoringSignificantLocationChanges];
    
    if (IS_OS_8_OR_LATER) {
        [_anotherLocationManager requestAlwaysAuthorization];
    }
    [_anotherLocationManager startMonitoringSignificantLocationChanges];
}


#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"locationManager didUpdateLocations: %@",locations);
    
    for (int i = 0; i < locations.count; i++) {
        CLLocation * newLocation = [locations objectAtIndex:i];
        CLLocationCoordinate2D theLocation = newLocation.coordinate;
        CLLocationAccuracy theAccuracy = newLocation.horizontalAccuracy;
        self.myLocation = theLocation;
        self.mynewLocation=newLocation;
        self.myLocationAccuracy = theAccuracy;
    }
   Longitude_current = [NSString stringWithFormat:@"%.8f", self.myLocation.longitude];
   Latitude_current = [NSString stringWithFormat:@"%.8f", self.myLocation.latitude];


    
    
    NSLog(@"%@self.Longitude_current",self.Longitude_current);
    NSLog(@"%@self.Latitude_current",self.Latitude_current);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.mynewLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       NSLog(@"placemarks=%@",[placemarks objectAtIndex:0]);
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       NSLog(@"placemark.ISOcountryCode =%@",placemark.ISOcountryCode);
                       
                       
                       NSLog(@"placemark.country =%@",placemark.country);
                       
                       NSString *country = placemark.country;
                       //                           NSString *area = placemark.ad
                       NSDictionary *dic = placemark.addressDictionary;
                       
                       AppDelegate *dele=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                       
                       placemark = [placemarks lastObject ];
                       
                       //                firstLet = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
                       //                lastLong= [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
                       
                       NSArray*address=[placemark.addressDictionary valueForKey:@"FormattedAddressLines"];
                       
                       id structureaddress = placemark.addressDictionary;
                       
//                       dele.countrycode = placemark.ISOcountryCode;
                       
                       dele.currentLat= [NSString stringWithFormat:@"%f", self.myLocation.latitude];
                       dele.currentLong= [NSString stringWithFormat:@"%f", self.myLocation.longitude];
                       
                       dele.User_countryName=[address lastObject];
                       NSString *str=[[NSUserDefaults standardUserDefaults]valueForKey:@"LoginOrLogout"];
                       
                       if ([str isEqualToString:@"Login"])
                       {
                       [self performSelectorInBackground:@selector(location_updateAPI1) withObject:nil];
                       }

                       dele.AddressString=@"";
                       for (int i=0; i<address.count; i++) {
                           NSString*adr=[address objectAtIndex:i];
                           NSString*sperate;
                           sperate=[adr stringByAppendingString:@","];
                           
                           dele.AddressString=[dele.AddressString stringByAppendingString:sperate];
                           NSLog(@"AddressString ... %@",dele.AddressString);
                           
                           

                           ///////////////endlast/////////
                       }
                   }];

    
    
//    [self addLocationToPList:_afterResume];
}



#pragma mark - Plist helper methods


-(void)location_updateAPI1
{
    AppDelegate *dele=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSString* updatelatitude= [NSString stringWithFormat:@"%f",self.myLocation.latitude];
    NSString* updatelongitude= [NSString stringWithFormat:@"%f",self.myLocation.longitude];
    
    NSMutableDictionary *array=[[[NSUserDefaults standardUserDefaults]valueForKey:@"ArrayInfo"]mutableCopy];
if(array.count!=0)
{
    NSString *userid=[array valueForKey:@"user_id"];
    
    if (userid.length != 0) {
        NSDictionary *params;
        
        params=@{@"action":@"updatelocation",@"user_id":userid,@"latitude":updatelatitude,@"longitude":updatelongitude,@"location":dele.AddressString};
        //@"device_id":delegate.device_Id,
        NSLog(@"params=%@>>>>>>>>>>",params);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"Reply JSON: %@", responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"Response object %@",responseObject);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];

    }
}
}







@end

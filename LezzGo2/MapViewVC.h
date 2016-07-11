//
//  MapViewVC.h
//  LezzGo2
//
//  Created by Apple on 28/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "VPPMapHelperDelegate.h"
#import "VPPMapHelper.h"
#import "MSMenuView.h"
#import "REFrostedViewController.h"

@interface MapViewVC : UIViewController<VPPMapHelperDelegate,MSMenuViewDelegate>
{
    float   animatedDistance;
    AppDelegate *delegate;
    NSMutableArray *allusersresponse;
    IBOutlet UIView * customcalloutview;
    NSString *indexIs;

@private
VPPMapHelper *_mh;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain)IBOutlet UIView * customcalloutview;

- (IBAction)showMenu;

@end

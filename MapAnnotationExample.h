//
//  MapAnnotation.h
//  VPPLibraries
//
//  Created by Víctor on 20/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "VPPMapCustomAnnotation.h"
#import <UIKit/UIKit.h>

@interface MapAnnotationExample : NSObject <VPPMapCustomAnnotation> {
    NSString *indextag;

}

// if you implement VPPMapCustomAnnotation you can customize the annotation
// as much as you want.

// pin's coordinates (only required property)
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
// pin's title
@property (nonatomic, copy) NSString *title;
// pin's subtitle
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *posttext;

@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy)NSString *indextag;
@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *userage;

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *likestatus;


@end

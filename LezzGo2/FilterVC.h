//
//  FilterVC.h
//  LezzGo2
//
//  Created by Apple on 30/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "AppDelegate.h"

@interface FilterVC : UIViewController<HeaderVCDelegate>
{
    HeaderVC *header;
    AppDelegate *delegate;

}
@end

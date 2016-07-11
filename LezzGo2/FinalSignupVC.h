//
//  FinalSignupVC.h
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "AppDelegate.h"

@interface FinalSignupVC : UIViewController<HeaderVCDelegate>

{
    AppDelegate *delegateapp;
    float   animatedDistance;

    IBOutlet UITextField *tf_CountryCode;
    IBOutlet UITextField *tf_Mobilenumber;
    HeaderVC *header;

    
}

@property (strong, nonatomic)IBOutlet UITextField *tf_CountryCode;

@property (strong, nonatomic)IBOutlet UITextField *tf_Mobilenumber;

-(IBAction)CountryCodePickerAction:(id)sender;
@end

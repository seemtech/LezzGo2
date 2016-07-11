//
//  LoginVC.h
//  LezzGo2
//
//  Created by Apple on 28/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "AppDelegate.h"

@interface LoginVC : UIViewController<HeaderVCDelegate>
{
    float   animatedDistance;
    HeaderVC *header;
    AppDelegate *delegate;
    IBOutlet UITextField *tf_username;
    IBOutlet UITextField *tf_Password;
}
-(IBAction)Loginbtn:(id)sender;
@property (strong, nonatomic)IBOutlet UITextField *tf_username;
@property (strong, nonatomic)IBOutlet UITextField *tf_Password;
@end

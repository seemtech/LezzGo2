//
//  MobileVerifyVC.h
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
@interface MobileVerifyVC : UIViewController<HeaderVCDelegate>
{
    float   animatedDistance;
    HeaderVC *header;
    AppDelegate *delegate;
    IBOutlet UITextField *tf_verificationcode;
    
    
}
@property (strong, nonatomic)IBOutlet UITextField *tf_verificationcode;
-(IBAction)finishedbtn:(id)sender;
-(IBAction)resendcodebtn:(id)sender;

@end

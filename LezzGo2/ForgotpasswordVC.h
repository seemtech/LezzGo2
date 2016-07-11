//
//  ForgotpasswordVC.h
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"

@interface ForgotpasswordVC : UIViewController<HeaderVCDelegate>
{
    float   animatedDistance;

    IBOutlet UILabel *screentextnew;
    IBOutlet UIButton *submitbtnnew;
    HeaderVC *header;
    BOOL stayup;
    AppDelegate *delegate;
    IBOutlet UITextField *tf_useremail;


}
-(IBAction)fotgotpassbtn:(id)sender;
@property (strong, nonatomic)IBOutlet UITextField *tf_useremail;

@property (strong, nonatomic) IBOutlet UILabel *screentextnew;
@property (strong, nonatomic)IBOutlet UIButton *submitbtnnew;

@end

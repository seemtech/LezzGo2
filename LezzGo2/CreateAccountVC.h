//
//  CreateAccountVC.h
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "MSMenuView.h"

@interface CreateAccountVC : UIViewController<HeaderVCDelegate>
{
    IBOutlet UIButton *submitbtn;
    float   animatedDistance;
    HeaderVC *header;
    IBOutlet UIView *keyboardview;
    NSString *username;
    IBOutlet UITextField *tf_username;
    IBOutlet UITextField *tf_fullname;

    IBOutlet UITextField *tf_email;

    IBOutlet UITextField *tf_zipcode;

    IBOutlet UITextField *tf_password;

    IBOutlet UITextField *tf_confirmpassword;
    IBOutlet UITextField *tf_age;

    IBOutlet UIImageView *mainuserimage;
    AppDelegate *delegate;

    IBOutlet UIScrollView *scrollview;
    IBOutlet UILabel *profiletxtlbl;
    NSString *stringmessage;

}
@property(nonatomic,retain)NSString *stringmessage;

@property(nonatomic,retain)IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain)IBOutlet UILabel *profiletxtlbl;

@property(nonatomic,retain)IBOutlet UIImageView *mainuserimage;

@property (strong, nonatomic)IBOutlet UITextField *tf_fullname;

@property (strong, nonatomic)IBOutlet UITextField *tf_username;
@property (strong, nonatomic)IBOutlet UITextField *tf_age;

@property (strong, nonatomic)IBOutlet UITextField *tf_email;

@property (strong, nonatomic)IBOutlet UITextField *tf_zipcode;

@property (strong, nonatomic)IBOutlet UITextField *tf_password;

@property (strong, nonatomic)IBOutlet UITextField *tf_confirmpassword;
@property (strong, nonatomic)IBOutlet UIButton *submitbtn;
@property (strong, nonatomic)IBOutlet UIView *keyboardview;
@property (strong, nonatomic)NSString *username;

@end

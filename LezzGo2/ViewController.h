//
//  ViewController.h
//  LezzGo2
//
//  Created by Apple on 24/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController
{
    float   animatedDistance;
    AppDelegate *delegate;

     IBOutlet UILabel *screentext;
    IBOutlet UIView *RectView;
    IBOutlet UIPageControl *pageController;
    int pagenumber;
    IBOutlet UIButton *startbtn;
    IBOutlet UIView *Loginview;
    IBOutlet UIButton *forgotpasswordbutton;

    IBOutlet UITextField *tf_username;
    IBOutlet UITextField *tf_Password;

    IBOutlet UIImageView *tfbackimage;
    IBOutlet UIImageView *tfcheckmark;
    

    IBOutlet UIImageView *tfpasswordbackimage;
    int changeposition;
    IBOutlet UIButton *btnsubmit;
    IBOutlet UILabel *lblmsg;
    NSString *statusmsg;

}
@property (strong, nonatomic)NSString *statusmsg;

@property (strong, nonatomic)IBOutlet UIButton *forgotpasswordbutton;
@property (strong, nonatomic)IBOutlet UITextField *tf_username;
@property (strong, nonatomic)IBOutlet UITextField *tf_Password;

@property (strong, nonatomic)IBOutlet UIImageView *tfbackimage;
@property (strong, nonatomic)IBOutlet UIImageView *tfcheckmark;
@property (strong, nonatomic)IBOutlet UIButton *btnsubmit;
@property (strong, nonatomic)IBOutlet UILabel *lblmsg;

@property (strong, nonatomic)IBOutlet UIImageView *tfpasswordbackimage;
@property (strong, nonatomic)IBOutlet UIView *RectView;
@property (strong, nonatomic)IBOutlet UIButton *startbtn;
@property (strong, nonatomic)IBOutlet UIView *Loginview;

@property (strong, nonatomic) IBOutlet UILabel *screentext;
@property (strong, nonatomic) IBOutlet UIPageControl *pageController;
-(IBAction)createaccountbtn:(id)sender;
-(IBAction)forgotbtn:(id)sender;

@end


//
//  ViewController.m
//  LezzGo2
//
//  Created by Apple on 24/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CreateAccountVC.h"
#import "ForgotpasswordVC.h"
#import "DEMORootViewController.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"

@interface ViewController ()

@end

@implementation ViewController
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 210;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@synthesize screentext,pageController,RectView,startbtn,Loginview,tf_username,forgotpasswordbutton,tfbackimage,tf_Password,tfcheckmark,tfpasswordbackimage,btnsubmit,lblmsg,statusmsg;
- (void)viewDidLoad
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    pagenumber=0;
    Loginview.hidden=YES;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];

    lblmsg.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];

    lblmsg.font = [UIFont fontWithName:@"BebasNeueBook" size:14];
    lblmsg.hidden=YES;
    screentext.textColor=[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0];
    tf_username.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_Password.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_username.font=[UIFont fontWithName:@"BebasNeueBook" size:16];
    tf_Password.font=[UIFont fontWithName:@"BebasNeueBook" size:16];
    screentext.font = [UIFont fontWithName:@"BebasNeueBook" size:24];
    forgotpasswordbutton.font = [UIFont fontWithName:@"BebasNeueBook" size:14];
    [forgotpasswordbutton setTitleColor:[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [forgotpasswordbutton setTitleColor:[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0] forState:UIControlStateSelected];

   screentext.text=@"NOW, YOU CAN MAKE THE WHOLE WORLD INTO ONE NEIGHBORHOOD.";
    UISwipeGestureRecognizer *swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)changeviewusername
{
//if(tf_username.text.length<2)
//{
//    [btnsubmit setTitle:@"CREATE AN ACCOUNT" forState:UIControlStateNormal];
//    [btnsubmit setTitle:@"CREATE AN ACCOUNT" forState:UIControlStateSelected];
//    tf_username.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
//    tfbackimage.image=[UIImage imageNamed:@"textbox.png"];
//    tfcheckmark.image=[UIImage imageNamed:@"ic-ok.png"];
//    tfcheckmark.hidden=YES;
//    lblmsg.hidden=YES;
//    
//    tfpasswordbackimage.hidden=YES;
//    tf_Password.hidden=YES;
//    if(changeposition==1)
//    {
//        changeposition=0;
//        tfcheckmark.frame=CGRectMake(238, tfcheckmark.frame.origin.y+42, tfcheckmark.frame.size.width, tfcheckmark.frame.size.height);
//        tf_username.frame=CGRectMake(66, tf_username.frame.origin.y+42, tf_username.frame.size.width, tf_username.frame.size.height);
//        tfbackimage.frame=CGRectMake(50, tfbackimage.frame.origin.y+42, tfbackimage.frame.size.width, tfbackimage.frame.size.height);
//        lblmsg.frame=CGRectMake(0, lblmsg.frame.origin.y+42, lblmsg.frame.size.width, lblmsg.frame.size.height);
//        
//        
//    }
//    
//}
  if([statusmsg isEqualToString:@"Username already exists! login now."])
{
    [btnsubmit setTitle:@"LOG IN" forState:UIControlStateNormal];
    [btnsubmit setTitle:@"LOG IN" forState:UIControlStateSelected];
    lblmsg.hidden=NO;
    lblmsg.text=statusmsg;
    lblmsg.textColor=[UIColor redColor];
    
    tf_username.textColor=[UIColor whiteColor];
    tfbackimage.image=[UIImage imageNamed:@"textbox-red.png"];
    tfcheckmark.image=[UIImage imageNamed:@"ic-delete.png"];
    tfcheckmark.hidden=NO;
    if(changeposition!=1)
    {
        changeposition=1;
        
        tfcheckmark.frame=CGRectMake(238, tfcheckmark.frame.origin.y-42, tfcheckmark.frame.size.width, tfcheckmark.frame.size.height);
        tf_username.frame=CGRectMake(66, tf_username.frame.origin.y-42, tf_username.frame.size.width, tf_username.frame.size.height);
        tfbackimage.frame=CGRectMake(50, tfbackimage.frame.origin.y-42, tfbackimage.frame.size.width, tfbackimage.frame.size.height);
        lblmsg.frame=CGRectMake(0, lblmsg.frame.origin.y-42, lblmsg.frame.size.width, lblmsg.frame.size.height);
        
        tfpasswordbackimage.hidden=NO;
        tf_Password.hidden=NO;
    }
}

else
{
    
    lblmsg.hidden=NO;
    lblmsg.text=statusmsg;
    lblmsg.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    [btnsubmit setTitle:@"CREATE AN ACCOUNT" forState:UIControlStateNormal];
    [btnsubmit setTitle:@"CREATE AN ACCOUNT" forState:UIControlStateSelected];
    tf_username.textColor=[UIColor whiteColor];
    tfbackimage.image=[UIImage imageNamed:@"textbox-green.png"];
    tfcheckmark.image=[UIImage imageNamed:@"ic-ok.png"];
    tfcheckmark.hidden=NO;
    tfpasswordbackimage.hidden=YES;
    tf_Password.hidden=YES;
    if(changeposition==1)
    {
        changeposition=0;
        tfcheckmark.frame=CGRectMake(238, tfcheckmark.frame.origin.y+42, tfcheckmark.frame.size.width, tfcheckmark.frame.size.height);
        tf_username.frame=CGRectMake(66, tf_username.frame.origin.y+42, tf_username.frame.size.width, tf_username.frame.size.height);
        tfbackimage.frame=CGRectMake(50, tfbackimage.frame.origin.y+42, tfbackimage.frame.size.width, tfbackimage.frame.size.height);
        lblmsg.frame=CGRectMake(0, lblmsg.frame.origin.y+42, lblmsg.frame.size.width, lblmsg.frame.size.height);
        
        
    }
    
    
    
    
}

}
-(void)checkusernameapi
{
    [self dismissKeyboard];

    NSDictionary *params;
    
    [SVProgressHUD showWithStatus:@"Checking Availability..."];


    params = @{@"action":@"checkusername",@"username":tf_username.text};
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];

            NSLog(@"loginResponse object %@",responseObject);
            statusmsg=[responseObject objectForKey:@"msg"];
            [self changeviewusername];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    
    
    
}

-(void)LoginApi
{
    
//    username , password , device_id , device_type , latitude , longitude
    [self dismissKeyboard];

    
    NSDictionary *params;
    
    [SVProgressHUD showWithStatus:@"Logging..."];
    
    params = @{@"action":@"login",@"username":tf_username.text,@"password":tf_Password.text,@"device_id":delegate.device_Id,@"latitude":delegate.currentLat,@"longitude":delegate.currentLong,@"device_type":@"iPhone",@"location":delegate.AddressString};
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            
            NSLog(@"loginResponse object %@",responseObject);
            if([[responseObject objectForKey:@"msg"] isEqualToString:@"YOU HAVE NOT VERIFY YOUR MOBILE NUMBER YET! DO NOW."])
            {
                delegate.userid=[responseObject objectForKey:@"user_id"];
                delegate.showlefticon=1;
                FinalSignupVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalSignupVC"];
                [self presentViewController:obj animated:YES completion:nil];
            }
            else
            {

                UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject valueForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                {
                                                    if([[responseObject valueForKey:@"msg"]isEqualToString:@"Login Successfilly"])
                                                    {
//                                                        {"show":[{"user_id":"1","username":"kailashchand","full_name":"Kailash saini","password":"admin2","email":"kailashchand61@gmail.com","zip_code":"201002","country_code":"91","mobile_number":"9716866437","profile_pic":"http:\/\/seemcodersapps.com\/lezzgo2\/\/assets\/images\/eb4c6dd1636b92e7b8c24daf46ac2cb0.jpg","age":"28","latitude":"28.667924","longitude":"77.474679","is_showpofilemap":"0","is_notification":"0","verify_status":"1","msg":"Login Successfilly"}]}
//                                                        
//                                                        delegate.logininfo_Array=[responseObject valueForKey:@"show"];
              
                                                        delegate.logininfo_Array=[responseObject valueForKey:@"show"];

                                                        delegate.userid=[delegate.logininfo_Array objectForKey:@"user_id"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setValue:@"Login"  forKey:@"LoginOrLogout"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:delegate.logininfo_Array  forKey:@"ArrayInfo"];
                                                        [[NSUserDefaults standardUserDefaults] synchronize];

                                                        delegate.showlefticon=0;
                                                        DEMORootViewController  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
                                                        [self presentViewController:obj animated:YES completion:nil];
                                                    }
                                                }];
                [alertcontroller addAction:defaultAction];
                [self presentViewController:alertcontroller animated:YES completion:nil];
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    
    
    
}


-(IBAction)forgotbtn:(id)sender
{
    ForgotpasswordVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotpasswordVC"];
    [self presentViewController:obj animated:YES completion:nil];
}
-(IBAction)createaccountbtn:(id)sender
{
    if([lblmsg.text isEqualToString:@"Username already exists! login now."])
    {
        if(tf_Password.text.length!=0&&tf_username.text.length!=0)
        {
        [self LoginApi];
        }
    }
    else
    {
    CreateAccountVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAccountVC"];
    if([statusmsg isEqualToString:@"Username available! Create account now."])
    {
        obj.username=tf_username.text;

    }
    [self presentViewController:obj animated:YES completion:nil];
    }

}
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(pagenumber<2)
    {
    pagenumber=pagenumber+1;
    self.pageController.currentPage=pagenumber;
    if([self.pageController currentPage]==0)
    {
        screentext.text=@"NOW, YOU CAN MAKE THE WHOLE WORLD INTO ONE NEIGHBORHOOD.";
        
    }
    else if([self.pageController currentPage]==1)
    {
        screentext.text=@"FIND OTHER NEARBY ONLINE PEOPLE OR PEOPLE FROM ANOTHER COUNTRY ON YOUR MAP.";
        
    }
    else if([self.pageController currentPage]==2)
    {
        screentext.text=@"GETS MORE LIKES FOR YOUR PHOTOS AND YOU'LL EARN POINTS.";
        
    }
    [self viewSlideInFromRightToLeft:RectView];
    }

}
-(void)dismissKeyboard {
    
    
    [tf_username resignFirstResponder];
    
    [tf_Password resignFirstResponder];

}
-(void)viewSlideInFromRightToLeft:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.5;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromRight;
    transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewSlideInFromLeftToRight:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.5;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(pagenumber<=2&&pagenumber!=0)
    {
    pagenumber=pagenumber-1;
    self.pageController.currentPage=pagenumber;
    if([self.pageController currentPage]==0)
    {
        screentext.text=@"NOW, YOU CAN MAKE THE WHOLE WORLD INTO ONE NEIGHBORHOOD.";
        
    }
    else if([self.pageController currentPage]==1)
    {
        screentext.text=@"FIND OTHER NEARBY ONLINE PEOPLE OR PEOPLE FROM ANOTHER COUNTRY ON YOUR MAP.";
        
    }
    else if([self.pageController currentPage]==2)
    {
        screentext.text=@"GETS MORE LIKES FOR YOUR PHOTOS AND YOU'LL EARN POINTS.";
        
    }
    [self viewSlideInFromLeftToRight:RectView];
    }

}
- (IBAction)btnstart:(id)sender
{
    if(startbtn.selected!=YES)
    {
        startbtn.selected=YES;
    [startbtn setBackgroundImage:[UIImage imageNamed:@"power-bt-red.png"] forState:UIControlStateNormal];
    [startbtn setBackgroundImage:[UIImage imageNamed:@"power-bt-green.png"] forState:UIControlStateSelected];
    tf_username.frame=CGRectMake(66, tf_username.frame.origin.y+42, tf_username.frame.size.width, tf_username.frame.size.height);
        lblmsg.frame=CGRectMake(0, lblmsg.frame.origin.y+42, lblmsg.frame.size.width, lblmsg.frame.size.height);
    tfbackimage.frame=CGRectMake(50, tfbackimage.frame.origin.y+42, tfbackimage.frame.size.width, tfbackimage.frame.size.height);
    tfcheckmark.frame=CGRectMake(238, tfcheckmark.frame.origin.y+42, tfcheckmark.frame.size.width, tfcheckmark.frame.size.height);

    tfcheckmark.hidden=YES;
    tfpasswordbackimage.hidden=YES;
    tf_Password.hidden=YES;
    Loginview.hidden=NO;

    RectView.frame=CGRectMake(0, Loginview.frame.origin.y+160, RectView.frame.size.width, RectView.frame.size.height);
    
    pageController.frame=CGRectMake(20, Loginview.frame.origin.y+230, pageController.frame.size.width, pageController.frame.size.height);
    }

}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void) textFieldDidBeginEditing:(UITextField*)textField
{
    [self slideViewUpForTextField:textField];
    
}

-(void) textFieldDidEndEditing:(UITextField*) textField
{
    // The return animation is far simpler since we've saved the amount to animate.
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    if(textField==tf_username)
    {
        if(textField.text.length!=0)
        {
        [self checkusernameapi];
        }
    }
}

- (void) slideViewUpForTextField:(UITextField *)textField
{
    
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 3.0 * textFieldRect.size.height;
    CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
        heightFraction = 0.0;
    else if (heightFraction > 1.0)
        heightFraction = 1.0;
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    else
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}



@end

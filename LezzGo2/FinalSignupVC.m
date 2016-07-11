//
//  FinalSignupVC.m
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "FinalSignupVC.h"
#import "CountryListViewController.h"
#import "MobileVerifyVC.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"
@interface FinalSignupVC ()

@end

@implementation FinalSignupVC
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 210;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@synthesize tf_CountryCode,tf_Mobilenumber;
- (void)viewDidLoad
{
    delegateapp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@sss",delegateapp.countrycode);
    tf_CountryCode.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_Mobilenumber.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_Mobilenumber.font=[UIFont fontWithName:@"BebasNeueBook" size:16];
    tf_CountryCode.font=[UIFont fontWithName:@"BebasNeueBook" size:16];

    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"MOBILE VERIFICATION";
    
    header.delegate = self;
    [self.view addSubview:header];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)dismissKeyboard {
    
    
    [tf_Mobilenumber resignFirstResponder];
    
    [tf_CountryCode resignFirstResponder];

    
    
}
-(void)MobileVerificationApi
{
    [self dismissKeyboard];
    NSDictionary *params;
    [SVProgressHUD showWithStatus:@"Resending Code..."];
    params = @{@"action":@"mobileverification",@"user_id":delegateapp.userid,@"mobile_number":tf_Mobilenumber.text,@"country_code":tf_CountryCode.text};
    NSLog(@"params=%@>>>>>>>>>>",params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject objectForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                tf_CountryCode.text=@"";
                                                tf_Mobilenumber.text=@"";
                                                if([[responseObject objectForKey:@"msg"]isEqualToString:@"We have send verification code to your mail id"])
                                                {
                                                    MobileVerifyVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"MobileVerifyVC"];
                                                    [self presentViewController:obj animated:YES completion:nil];
                                                }
                                            }];
            [alertcontroller addAction:defaultAction];
            [self presentViewController:alertcontroller animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    
    
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

- (void)gotobackclick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)CountryCodePickerAction:(id)sender
{
    CountryListViewController  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryListViewController"];
    [self presentViewController:obj animated:YES completion:nil];
}
-(IBAction)gotonextstep:(id)sender
{
    if(tf_CountryCode.text.length!=0&&tf_Mobilenumber.text.length!=0)
    {
        [self MobileVerificationApi];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if(delegateapp.countrycode.length!=0)
    {
    tf_CountryCode.text=delegateapp.countrycode;
    }
    [super viewWillAppear:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

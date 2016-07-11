//
//  ForgotpasswordVC.m
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ForgotpasswordVC.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"
@interface ForgotpasswordVC ()

@end

@implementation ForgotpasswordVC
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 210;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@synthesize screentextnew,submitbtnnew,tf_useremail;
- (void)viewDidLoad {
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"FORGOT PASSWORD";
    
    header.delegate = self;
    [self.view addSubview:header];
    submitbtnnew.font = [UIFont fontWithName:@"BebasNeueBold" size:18];
    screentextnew.font=[UIFont fontWithName:@"BebasNeueBold" size:15];
    screentextnew.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)dismissKeyboard {
    
    
    [tf_useremail resignFirstResponder];
    
    
    
    
}
-(IBAction)fotgotpassbtn:(id)sender
{
    if(tf_useremail.text.length!=0)
    {
        [self ForgotpasswordApi];
    }
}
- (void)gotobackclick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)ForgotpasswordApi
{
    [self dismissKeyboard];

    NSDictionary *params;
    
    [SVProgressHUD showWithStatus:@"Sending Link..."];
    
    
    params = @{@"action":@"forgotpassword",@"email":tf_useremail.text};
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            
            NSLog(@"loginResponse object %@",responseObject);
            UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject objectForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                if([[responseObject objectForKey:@"msg"]isEqualToString:@"Your have need to Rest your password..link sent to your email address"])
                                                 {
                                                     delegate.showlefticon=1;
                                                     tf_useremail.text=@"";
                                                     [self dismissViewControllerAnimated:YES completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  LoginVC.m
//  LezzGo2
//
//  Created by Apple on 28/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "LoginVC.h"
#import "DEMORootViewController.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"

@interface LoginVC ()

@end

@implementation LoginVC
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 210;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

-(void)viewDidLoad
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"LOG IN";
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
    
    
    [tf_username resignFirstResponder];
    
    [tf_Password resignFirstResponder];
    
    
    
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
            UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject valueForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                if([[responseObject valueForKey:@"msg"]isEqualToString:@"Login Successfilly"])
                                                {
                                                    
                                                    delegate.logininfo_Array=[responseObject valueForKey:@"show"];

                                                delegate.userid=[delegate.logininfo_Array objectForKey:@"user_id"];
                                                    delegate.strshowprofileonmap=[delegate.logininfo_Array objectForKey:@"is_showpofilemap"];
                                                    
                                                    delegate.strpushnotificationon=[delegate.logininfo_Array objectForKey:@"is_notification"];

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
            NSLog(@"loginResponse object %@",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)gotobackclick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)Loginbtn:(id)sender
{
   if(tf_username.text.length!=0&&tf_Password.text.length!=0)
   {
       [self LoginApi];
   }
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

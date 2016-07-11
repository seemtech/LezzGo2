//
//  CreateAccountVC.m
//  LezzGo2
//
//  Created by Apple on 27/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "CreateAccountVC.h"
#import "FinalSignupVC.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface CreateAccountVC ()

@end

@implementation CreateAccountVC
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 210;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@synthesize submitbtn,keyboardview,username,tf_username,tf_email,tf_zipcode,tf_password,tf_confirmpassword,tf_age,tf_fullname,mainuserimage,scrollview,profiletxtlbl,stringmessage;
-(IBAction)photobtnclick:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel"  destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Existing", nil];
    
    // Show the action sheet
    [sheet showFromToolbar:self.navigationController.toolbar];
}
// Override this method to know if user wants to take a new photo or select from the photo library
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if (imagePicker) {
        // set the delegate and source type, and present the image picker
        imagePicker.delegate = self;
        if (0 == buttonIndex) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
        else if (1 == buttonIndex) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
        else
        {
            
        }
    }
    else {
        // Problem with camera, alert user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Camera" message:@"Please use a camera enabled device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIImagePickerViewControllerDelegate

// For responding to the user tapping Cancel.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// Override this delegate method to get the image that the user has selected and send it view Multipeer Connectivity to the connected peers.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // Don't block the UI when writing the image to documents
    // We only handle a still image
       mainuserimage.image = [self scaleAndRotateImage: [info objectForKey:UIImagePickerControllerOriginalImage]];
    
    // Save the new image to the documents directory
    // Send the resource to the remote peers and get the resulting progress transcript
    
    
}
-(UIImage *)scaleAndRotateImage:(UIImage *)image
{
    
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
- (void)viewDidLoad {
   
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    scrollview.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    submitbtn.font = [UIFont fontWithName:@"BebasNeueBold" size:18];

    
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
   header.msgstr =@"CREATE AN ACCOUNT";

   header.delegate = self;
    [self.view addSubview:header];
    profiletxtlbl.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];

    tf_username.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_email.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];

    
    tf_password.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_age.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_fullname.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_zipcode.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    tf_confirmpassword.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];

    if(username.length!=0)
    {
    tf_username.text=username;
    }
    // Assuming your IBOutlet is a property called menu.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dismissKeyboard {
    
    
    [tf_username resignFirstResponder];
    
    [tf_email resignFirstResponder];
    [tf_age resignFirstResponder];
    [tf_zipcode resignFirstResponder];
    [tf_fullname resignFirstResponder];
    [tf_password resignFirstResponder];
    [tf_confirmpassword resignFirstResponder];


}
- (void)gotobackclick
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)RegistrationApi
{
    [self dismissKeyboard];

    NSDictionary *params;
    //username , full_name , age , password  ,email , zip_code , profile_pic , latitude , longitude
    // action=registration
    NSLog(@"params=%@>>>>>>>>>>",params);
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            [SVProgressHUD dismiss];
//            
//            NSLog(@"loginResponse object %@",responseObject);
//            FinalSignupVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalSignupVC"];
//            [self presentViewController:obj animated:YES completion:nil];
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//        [SVProgressHUD dismiss];
//        NSLog(@"Error: %@", error);
//    }];
//    
    params = @{@"action":@"registration",@"username":tf_username.text,@"full_name":tf_fullname.text,@"age":tf_age.text,@"password":tf_password.text,@"email":tf_email.text,@"latitude":delegate.currentLat,@"longitude":delegate.currentLong,@"zip_code":tf_zipcode.text,@"location":delegate.AddressString};

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:kServerurl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [request setTimeoutInterval:1000000000000000];
        
            if (mainuserimage.image != nil) {
            NSString *names =[NSString stringWithFormat:@"profile_pic"];
            NSString *imgname = [NSString stringWithFormat:@"image.jpeg"];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(mainuserimage.image, 0.5)
                                        name:names
                                    fileName:imgname
                                    mimeType:@"png/jpeg"];
        }
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [SVProgressHUD showWithStatus:@"Registering..."];

    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          
                          //progressDouble = uploadProgress.fractionCompleted;
                          //[self updateProgress:progressDouble];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                    NSLog(@"Response object %@",responseObject);
                      
                      if (error) {
                          
                        [SVProgressHUD dismiss];
                          NSLog(@"Error: %@", error);
                          
                          
                                               } else {
                          
                          
                          [SVProgressHUD dismiss];
                          NSLog(@"Uploaded successfilly.....%@ %@", response, responseObject);
                          //                              NSString * str = [responseObject valueForKey:@"msg"];
                          //
                          UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject objectForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
                          UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                          {
                                                              if([[responseObject objectForKey:@"msg"]isEqualToString:@"Registration successfully"])
                                                              {
                                                              
                                                              delegate.userid=[responseObject objectForKey:@"user_id"];

                                                              delegate.showlefticon=1;
                                                              tf_zipcode.text=@"";
                                                              tf_confirmpassword.text=@"";
                                                              tf_password.text=@"";
                                                              tf_age.text=@"";
                                                              tf_email.text=@"";
                                                              tf_fullname.text=@"";
                                                              tf_username.text=@"";

                                                              mainuserimage.image=[UIImage imageNamed:@"bt-upload-photo.png"];
                                                                     FinalSignupVC  * obj = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalSignupVC"];
                                                                          [self presentViewController:obj animated:YES completion:nil];
                                                              }
                                                          }];
                          [alertcontroller addAction:defaultAction];
                          [self presentViewController:alertcontroller animated:YES completion:nil];
                          
                      }
                  }];
    
    [uploadTask resume];
    

    
}
-(IBAction)gotonextstep:(id)sender
{
        if(tf_username.text.length!=0&&tf_fullname.text.length!=0&&tf_email.text.length!=0&&tf_zipcode.text.length!=0&&tf_age.text.length!=0&&tf_password.text.length!=0&&tf_confirmpassword.text.length!=0&&[tf_password.text isEqualToString:tf_confirmpassword.text])
    {
        [self RegistrationApi];
    }
    else
    {
        
        UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:stringmessage
                                                                                 message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                        }];
        [alertcontroller addAction:defaultAction];
        [self presentViewController:alertcontroller animated:YES completion:nil];
    }
   
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
-(void) textFieldDidBeginEditing:(UITextField*)textField
{
    [self slideViewUpForTextField:textField];
}
-(void) textFieldDidEndEditing:(UITextField*) textField
{
    // The return animation is far simpler since we've saved the amount to animate.
    CGRect viewFrame = keyboardview.frame;
    viewFrame.origin.y += animatedDistance;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [keyboardview setFrame:viewFrame];
    
    [UIView commitAnimations];
    if(textField.text.length==0)
    {
        if(textField==tf_username)
        {
            stringmessage=@"Missing Username";
        }
        if(textField==tf_fullname)
        {
            stringmessage=@"Missing Full Name";
        }
        if(textField==tf_email)
        {
            stringmessage=@"Missing Email";
        }
        if(textField==tf_zipcode)
        {
            stringmessage=@"Missing Zipcode";
        }
        if(textField==tf_age)
        {
            stringmessage=@"Missing Age";
        }
        if(textField==tf_password)
        {
            stringmessage=@"Missing Password";
        }
        if(textField==tf_confirmpassword)
        {
            stringmessage=@"Confirm Your Password";
        }
    }
    else
    {
        if(textField==tf_confirmpassword)
        {
            if(![tf_password.text isEqualToString:tf_confirmpassword.text])
            {
                stringmessage=@"Password Does Not Match";
            }
        }
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length==0)
    {
    if(textField==tf_username)
    {
        stringmessage=@"Missing Username";
    }
    if(textField==tf_fullname)
    {
        stringmessage=@"Missing Full Name";
    }
        if(textField==tf_email)
        {
            stringmessage=@"Missing Email";
        }
        if(textField==tf_zipcode)
        {
            stringmessage=@"Missing Zipcode";
        }
        if(textField==tf_age)
        {
            stringmessage=@"Missing Age";
        }
        if(textField==tf_password)
        {
            stringmessage=@"Missing Password";
        }
        if(textField==tf_confirmpassword)
        {
            stringmessage=@"Confirm Your Password";
        }
    }
    else
    {
    if(textField==tf_confirmpassword)
    {
        if(![tf_password.text isEqualToString:tf_confirmpassword.text])
        {
            stringmessage=@"Password Does Not Match";
        }
    }
    }
    if(textField==tf_age)
    {
    if(textField.text.length>2)
    {
        return NO;
        
    }
    else
    {
        return YES;
    }
    }
    else
    {
        return YES;
    }

}
- (void) slideViewUpForTextField:(UITextField *)textField
{
    
    CGRect textFieldRect = [keyboardview convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [keyboardview convertRect:keyboardview.bounds fromView:keyboardview];
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
    
    CGRect viewFrame = keyboardview.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [keyboardview setFrame:viewFrame];
    
    [UIView commitAnimations];
}

@end

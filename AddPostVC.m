//
//  UserProfileVC.m
//  LezzGo2
//
//  Created by Apple on 04/07/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MyProfileVC.h"
#import "MapViewVC.h"
#import "FriendsVC.h"
#import "NewsFeedVC.h"
#import "AddPostVC.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "DEMONavigationController.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "CHTCollectionViewWaterfallFooter.h"
@interface AddPostVC ()

@end

@implementation AddPostVC
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 210;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
@synthesize Photoview,TextbottomView,mainview,mainimage,descriptiontxt,strpublic,publicswitch;
-(IBAction)photobtnclick:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel"  destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Existing", nil];
    
    // Show the action sheet
    [sheet showFromToolbar:self.navigationController.toolbar];
}
-(IBAction)textbtnclick:(id)sender

{
    cancelbtn.hidden=NO;
    Photoview.hidden=YES;
    mainview.hidden=YES;
    TextbottomView.frame=CGRectMake(TextbottomView.frame.origin.x, TextbottomView.frame.origin.y-Photoview.frame.size.height, TextbottomView.frame.size.width, TextbottomView.frame.size.height);
    TextbottomView.hidden=NO;


}
-(void)buttonbackClickAction:(id)sender

{
    cancelbtn.hidden=YES;

    Photoview.hidden=YES;
    mainview.hidden=NO;
    TextbottomView.frame=CGRectMake(TextbottomView.frame.origin.x, TextbottomView.frame.origin.y+Photoview.frame.size.height, TextbottomView.frame.size.width, TextbottomView.frame.size.height);
    TextbottomView.hidden=YES;
}
- (void)viewDidLoad {
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [publicswitch addTarget:self action:@selector(switchChanged: ) forControlEvents:UIControlEventValueChanged];

    
    
    Photoview.hidden=YES;
    mainview.hidden=NO;
    TextbottomView.hidden=YES;
    //    [Bthpost setTitleColor:[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    [Bthpost setTitleColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    //    [BthDetails setTitleColor:[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    [BthDetails setTitleColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"POST";
    delegate.showlefticon=0;
    header.delegate = self;
    [self.view addSubview:header];
    MSMenuView *menu=[[MSMenuView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-53, self.view.frame.size.width, 53)];
    menu.selecttag=3;
    
    menu.delegatemenu = self;
    [self.view addSubview:menu];
    cancelbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.hidden=YES;
    [cancelbtn setFrame:CGRectMake(self.view.frame.size.width-80, 22, 80, 35)];
    [cancelbtn setTintColor:[UIColor clearColor]];
    [cancelbtn setBackgroundColor:[UIColor clearColor]];
    [cancelbtn setTitleColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateSelected];
    [cancelbtn.titleLabel setFont:[UIFont fontWithName:@"BebasNeueBook" size:18]];
    [cancelbtn setContentVerticalAlignment:UIControlContentHorizontalAlignmentRight];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelbtn setTitle:@"Cancel" forState:UIControlStateSelected];
    [cancelbtn addTarget:self action:@selector(buttonbackClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelbtn];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)AddPostApi
{
    [self dismissKeyboard];
    NSDictionary *params;
    [SVProgressHUD showWithStatus:@"Posting..."];

    //username , full_name , age , password  ,email , zip_code , profile_pic , latitude , longitude
    // action=registration
    NSLog(@"params=%@>>>>>>>>>>",params);
    //user_id , full_name , age , password , is_showpofilemap , is_notification
    
    params = @{@"action":@"profilesetting",@"user_id":delegate.userid,@"text":descriptiontxt.text,@"privacy":strpublic};
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:kServerurl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [request setTimeoutInterval:1000000000000000];
        
        if (mainimage.image != nil) {
            NSString *names =[NSString stringWithFormat:@"picture"];
            NSString *imgname = [NSString stringWithFormat:@"image.jpeg"];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(mainimage.image, 0.5)
                                        name:names
                                    fileName:imgname
                                    mimeType:@"png/jpeg"];
        }
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [SVProgressHUD showWithStatus:@"Updating..."];
    
    
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
                          //{"msg":"Profile updated"}
                          UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject objectForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
                          UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                          {
                                                            
                                                          }];
                          [alertcontroller addAction:defaultAction];
                          [self presentViewController:alertcontroller animated:YES completion:nil];
                          
                      }
                  }];
    
    [uploadTask resume];
    
    
    
}
- (void) switchChanged:(UISwitch *)sender {
    
        if(sender.on==YES)
        {
            strpublic=@"public";
        }
        else
        {
            strpublic=@"private";
            
        }
    
}
#pragma mark - UIActionSheetDelegate methods

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
    cancelbtn.hidden=YES;

    mainview.hidden=NO;
    Photoview.hidden=YES;
    TextbottomView.hidden=YES;
    TextbottomView.frame=CGRectMake(TextbottomView.frame.origin.x, TextbottomView.frame.origin.y+Photoview.frame.size.height, TextbottomView.frame.size.width, TextbottomView.frame.size.height);

    [picker dismissViewControllerAnimated:YES completion:nil];
}

// Override this delegate method to get the image that the user has selected and send it view Multipeer Connectivity to the connected peers.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // Don't block the UI when writing the image to documents
        // We only handle a still image
        cancelbtn.hidden=NO;

        mainview.hidden=YES;
        Photoview.hidden=NO;
        TextbottomView.hidden=NO;
        mainimage.image = [self scaleAndRotateImage: [info objectForKey:UIImagePickerControllerOriginalImage]];
        
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
-(void)MapBtnClick
{
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    MapViewVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}
-(void)MyProfileBtnClick
{
    
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    MyProfileVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
}
-(void)CameraBtnClick
{
    
}
-(void)NewsBtnClick
{
    
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    NewsFeedVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsFeedVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)FriendsBtnClick
{
    
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    FriendsVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendsVC"];
    navigationController.viewControllers = @[secondViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
    
    
}

- (void)gotobackclick
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}
-(void)dismissKeyboard {
    
    
    [descriptiontxt resignFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self slideViewUpForTextView:textView];
}
-(void) textViewDidEndEditing:(UITextView *)textView
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
- (void) slideViewUpForTextView:(UITextView *)textView
{
    CGRect textFieldRect = [self.view convertRect:textView.bounds fromView:textView];
    CGRect viewRect = [self.view convertRect:self.view.bounds fromView:self.view];
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

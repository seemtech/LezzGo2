//
//  SPHViewController.m
//  SPHChatBubble
//
//  Created by Siba Prasad Hota  on 10/18/13.
//  Copyright (c) 2013 Wemakeappz. All rights reserved.
//

#import "SPHViewController.h"
#import "SPHChatData.h"
#import "SPHChatData.h"
#import "SPHBubbleCell.h"
#import "SPHBubbleCellImage.h"
#import "SPHBubbleCellImageOther.h"
#import "SPHBubbleCellOther.h"
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SPHMacro.h"
#import "AFNetworking.h"
#import "SPHBubbleCellByMeViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import "NewMatchVC.h"
#import "Reachability.h"
#import "WebServices.h"

//#import "messageViewController.h"
//#import "DSActivityView.h"
#define messageWidth 260


@interface SPHViewController (){
    UIView *indicatorFullView;
    UIActivityIndicatorView *spinner;
    
    //NSMutableArray * Responce_array;
}
@end

@implementation SPHViewController

@synthesize reloads = reloads_;
@synthesize Sender_id,Reciever_id;
@synthesize imgPicker;
@synthesize Uploadedimage;
@synthesize imagePickerController;



static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 250;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize userImageString,usernameString,reciverUsr_id;

- (void)viewDidLoad
{
    
  //  msg = "New Match!";

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setBackgroundLayerColor:[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    msgId=[[NSMutableArray alloc]init];
    chatImage=[[NSMutableArray alloc]init];
    Responce_array=[[NSMutableArray alloc]init];
    NSLog(@"_ShowMSgArray....%@",_ShowMSgArray);
    NSLog(@"common array result %@%@",_common_Array,_ShowMSgArray);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallTableReload) name:@"PostNotification" object:nil];
    
    delegate.delegatePushStr=@"Insinglechat";
    delegate.senderChatid  = Sender_id;
    
    
    self.view.userInteractionEnabled = YES;
    
    self.sphChatTable.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChatBackground.png"]];
    [self.sphChatTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self    action:@selector(imageSelected)];
    tapped.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapped];
    
    Responce_array = [[NSMutableArray alloc]init];
    
    
    CustomFont=@"RobotoSlab-Regular";
    
    //statusLabl.font==[UIFont fontWithName:CustomFont size:10.0f];
    
    //statusLabl.text = delegate.userChatTime;
    
    Labl_Header.font=[UIFont fontWithName:CustomFont size:18.0f];
  
    Labl_User_Name.text=delegate.strChatUsername;
    usernameString=delegate.strChatUsername;
    
    sphBubbledata=[[NSMutableArray alloc]init];
    ImageArrayByMe=[[NSMutableArray alloc]init];
    imageArrayofvideo=[[NSMutableArray alloc]init];
    UrlArray=[[NSMutableArray alloc]init];
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    
    [self setUpTextFieldforIphone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    //    [textView addDoneOnKeyboardWithTarget:self action:@selector(resignTextView)];
    
    
   // NSString *ImageUrl=self.userImageString;
    
//
//    profileimage.layer.cornerRadius = profileimage.frame.size.height /2;
//    profileimage.layer.masksToBounds = YES;
//    
//    
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    
//    [manager downloadImageWithURL:[NSURL URLWithString:ImageUrl]
//     
//                          options:0
//     
//                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                             
//                             
//                         }
//     
//                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                            
//                            if (image) {
//                                
//                                [[SDImageCache sharedImageCache] storeImage:image forKey:ImageUrl];
//                                if (image==Nil) {
//                                    profileimage.image=[UIImage imageNamed:@""];
//                                }
//                                else
//                                    
//                                    //effectImage =[image applyDarkEffect];
//                                    
//                                    profileimage.image=image;
//                                
//                                
//                            }
//                        }];
//
    
    [super viewDidLoad];
}






- (void)viewWillAppear:(BOOL)animated
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet"
                                                        message:@"No internet connection found, please reconnect and try again."
                                                       delegate:self cancelButtonTitle:@"Retry"
                                              otherButtonTitles:nil];
        alert.tag=1001;
        [alert show];
    }
    else
    {
    [self LoadHistoryApi];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1001)
    {
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet"
                                                            message:@"No internet connection found, please reconnect and try again."
                                                           delegate:self cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            alert.tag=1002;
            [alert show];
        }
        else
        {
            [self LoadHistoryApi];
        }
    }
}
//this for work

-(void)LoadHistoryApi
{
    
    
   // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSDictionary *params;
    
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSString *timevalue = [NSString stringWithFormat:@"%@",timeZone];
    
    NSArray *timezoneindex = [timevalue componentsSeparatedByString:@" "];
    NSString *gmtstring = [timezoneindex objectAtIndex:3];
    
    
    
//    NSLog(@"Users_id...%@", [[delegate.logininfo_Array objectAtIndex:0] valueForKey:@"user_id"]);
////
    
    params = @{@"action":@"mychathistory",@"my_id":Sender_id,@"other_id":Reciever_id,@"gmtvalue":gmtstring};
    
    NSLog(@"parrr: %@", params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
                
        NSLog(@"Reply JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSString *rowNumber=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
            Responce_array=[[responseObject valueForKey:@"show"]mutableCopy];
            
            NSMutableArray *msgdata_send=[[NSMutableArray alloc]init];
            NSMutableArray *msgdata_Recieve=[[NSMutableArray alloc]init];
            //         {"result":[],"msg":"yes"}
            
            
            if (Responce_array.count==0) {
                
                UIAlertView *alertnew=[[UIAlertView alloc]initWithTitle:nil message:@"No message found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alertnew show];
            }
            else{
                
                for (int i=0;i<[Responce_array count];i++) {
                    
                    if ([[[Responce_array valueForKey:@"status"] objectAtIndex:i] isEqualToString:@"sent"])
                    {
                        [msgdata_send addObject:[[Responce_array valueForKey:@"message"] objectAtIndex:i]];
                        
                        [self adddBubbledata:ktextByme mtext:[[Responce_array valueForKey:@"message"] objectAtIndex:i] mtime:[[Responce_array valueForKey:@"timee"] objectAtIndex:i]mimage:Uploadedimage.image msgstatus:kStatusSeding];
                        [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
                        
                        delegate.senderChatid =[delegate.Push_Sender_id mutableCopy];
                        
                        
                        
                    }
                    else{
                        [msgdata_Recieve addObject:[[Responce_array valueForKey:@"message"] objectAtIndex:i]];
                        
                        [self adddBubbledata:ktextbyother mtext:[[Responce_array valueForKey:@"message"] objectAtIndex:i] mtime:[[Responce_array valueForKey:@"timee"] objectAtIndex:i] mimage:Uploadedimage.image msgstatus:kStatusSent ];
                        
                        [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
                        rowNumber=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
                        
                        delegate.senderChatid =[delegate.Push_Sender_id mutableCopy];
                    }
                    
                    
                }
                
                
            }
            
        }
        else{
            
            [self ShowAlertIn:@"Error Occured"];
            
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:@"Network connection error" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            
                                            
                                            
                                        }];
        [alertcontroller addAction:defaultAction];
        [self presentViewController:alertcontroller animated:YES completion:nil];
        
        NSLog(@"Error: %@", error);
    }];
    
}



-(void)ShowAlertIn:(NSString *)messageString{
    
    UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:messageString message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                    }];
    [alertcontroller addAction:defaultAction];
    [self presentViewController:alertcontroller animated:YES completion:nil];
}



//{
//    [self startIndicator:self.view];
//
//    NSString * strin = @"http://www.unionrides.com/ios/viewmessage.php";
//    NSDictionary *params;
//    // [delegate.mainDictonary valueForKey:@"sender_id"]
//    //params = @{@"user_id":@"16",@"api_subject":@"show-messaging"};
//
//    NSLog(@".delegate.User_Id..%@",delegate.User_Id);
//    NSLog(@"..delegate.Push_Sender_id.%@",delegate.Push_Sender_id);
//
//    params = @{ @"users_id":delegate.User_Id, @"id":delegate.Push_Sender_id};
//
//    NSLog(@"params=%@",params);
//
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strin parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    }error:nil];
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//         NSString *rowNumber=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
//         Responce_array=[[json valueForKey:@"result"]mutableCopy];
//
//         NSLog(@"json...%@",json);
//
//
//         NSMutableArray *msgdata_send=[[NSMutableArray alloc]init];
//         NSMutableArray *msgdata_Recieve=[[NSMutableArray alloc]init];
//         //         {"result":[],"msg":"yes"}
//
//
//         if (Responce_array.count==0) {
//
//             UIAlertView *alertnew=[[UIAlertView alloc]initWithTitle:nil message:@"No message found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//             [alertnew show];
//         }
//         else{
//
//             for (int i=0;i<[[Responce_array valueForKey:@"message"] count];i++) {
//
//                 if ([[[Responce_array valueForKey:@"status"] objectAtIndex:i] isEqualToString:@"send"])
//                 {
//                     [msgdata_send addObject:[[Responce_array valueForKey:@"message"] objectAtIndex:i]];
//
//                     [self adddBubbledata:ktextByme mtext:[[Responce_array valueForKey:@"message"] objectAtIndex:i] mtime:[[Responce_array valueForKey:@"timee"] objectAtIndex:i]mimage:Uploadedimage.image msgstatus:kStatusSeding];
//                     [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
//
//                     delegate.senderChatid =delegate.Push_Sender_id;
//
//                 }
//                 else{
//                     [msgdata_Recieve addObject:[[Responce_array valueForKey:@"message"] objectAtIndex:i]];
//
//                     [self adddBubbledata:ktextbyother mtext:[[Responce_array valueForKey:@"message"] objectAtIndex:i] mtime:[[Responce_array valueForKey:@"timee"] objectAtIndex:i] mimage:Uploadedimage.image msgstatus:kStatusSent ];
//
//                     [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
//                     rowNumber=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
//
//                     delegate.senderChatid =delegate.Push_Sender_id;
//                 }
//             }
//         }
//         [self dissmissIndicator];
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         [self dissmissIndicator];
//
//         if([operation.response statusCode] == 403)
//         {
//             //NSLog(@"Upload Failed");
//             return;
//         }
//         //NSLog(@"error: %@", [operation error]);
//     }];
//
//    [operation start];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)imageSelected
{
    [textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTextFieldforIphone
{
    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    if(screenHeight == 667)
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-40, 375, 40)];
        UIView *stripView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 375, 1)];
        stripView.backgroundColor=[UIColor lightGrayColor];
        [containerView addSubview:stripView];
        
        
        containerView.backgroundColor=[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(5, 3, 250+45, 40)];
        textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    if(screenHeight == 736)
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-40, 414, 40)];
        UIView *stripView = [[UIView alloc] initWithFrame:CGRectMake(0,0,414, 1)];
        stripView.backgroundColor=[UIColor lightGrayColor];
        [containerView addSubview:stripView];
        
        
        containerView.backgroundColor=[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(5, 3, 280+45, 40)];
        textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    if (screenHeight==480)
    {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-40, 320, 40)];
       
        UIView *stripView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 1)];
        stripView.backgroundColor=[UIColor lightGrayColor];
        [containerView addSubview:stripView];
        
        
        containerView.backgroundColor=[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(5, 3, 200+45, 40)];
        textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    if (screenHeight==568)
    {
        
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-40, 320, 40)];
        
        UIView *stripView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 1)];
        stripView.backgroundColor=[UIColor lightGrayColor];
        [containerView addSubview:stripView];
        
        containerView.backgroundColor=[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
  
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(5, 3, 265+35-65, 35)];
        textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    // containerView.backgroundColor=[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    textView.returnKeyType = UIReturnKeyDefault; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor=[UIColor blackColor];
    textView.layer.cornerRadius = 5;
    textView.placeholder = @"Type your message";
    textView.layer.masksToBounds = YES;
    
    
    [self.view addSubview:containerView];
    
    if(screenHeight==736)
    {
//        UIImage *rawEntryBackground = [UIImage imageNamed:@""];
//        //MessageEntryInputField.png
//        UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
//        UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
//        entryImageView.frame = CGRectMake(40, 0,240, 40);
//        entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        UIImage *rawBackground = [UIImage imageNamed:@"messagebox.png"];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5,-10,containerView.frame.size.width+30, containerView.frame.size.height+15)];
//        imageView.image = rawBackground;
//        imageView.frame = CGRectMake(0, 0, textView.frame.size.width+80, containerView.frame.size.height);
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [containerView addSubview:imageView];
        [containerView addSubview:textView];
      //  [containerView addSubview:entryImageView];
        
        //        UIImage *sendBtnBackground = [[UIImage imageNamed:@"chat_send.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(335, 2, 75, 37);
        doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        //        [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
        
        [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.7] forState:UIControlStateNormal];
      //  doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
        doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
      //  doneBtn.backgroundColor=[UIColor redColor];
        
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
        
        [containerView addSubview:doneBtn];
        
       
    }
    
   else   if(screenHeight==667)
    {
//        UIImage *rawEntryBackground = [UIImage imageNamed:@""];
//        //MessageEntryInputField.png
//        UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
//        UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
//        entryImageView.frame = CGRectMake(40, 0,240, 40);
//        entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        
//        //        UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
//        
//        
//        UIImage *rawBackground = [UIImage imageNamed:@"messagebox.png"];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5,-10,containerView.frame.size.width+30, containerView.frame.size.height+15)];
//        imageView.image = rawBackground;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        textView.backgroundColor=[UIColor clearColor];
//        
//        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [containerView addSubview:imageView];
        [containerView addSubview:textView];
        //[containerView addSubview:entryImageView];
        
        //        UIImage *sendBtnBackground = [[UIImage imageNamed:@"button_send.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(305, 2, 65, 37);
        doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        //        [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
        
        [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.7] forState:UIControlStateNormal];
       // doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
        doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
         // doneBtn.backgroundColor=[UIColor redColor];
        
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
        //        [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
        
        [containerView addSubview:doneBtn];
        
        
        
      
        
    }
    
    
    else{
        
//        UIImage *rawEntryBackground = [UIImage imageNamed:@""];
//        //MessageEntryInputField.png
//        UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
//        UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
//        entryImageView.frame = CGRectMake(40, 0,240, 40);
//        entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        UIImage *rawBackground = [UIImage imageNamed:@"messagebox.png"];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5,-10,containerView.frame.size.width+30, containerView.frame.size.height+15)];
//        imageView.image = rawBackground;
//        
//        imageView.frame = CGRectMake(0, 0, textView.frame.size.width-22, containerView.frame.size.height);
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [containerView addSubview:imageView];
          [containerView addSubview:textView];
//        [containerView addSubview:entryImageView];
        
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(245,2,70, 35);
       // doneBtn.backgroundColor=[UIColor redColor];
        doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.7] forState:UIControlStateNormal];
     //   doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
        doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        
        [doneBtn setTitle:@"Send" forState:UIControlStateNormal];

       // [doneBtn setImage:[UIImage imageNamed:@"sentchat.png"] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:doneBtn];
       
    }
    
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
}


//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//    if([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    return YES;
//}





- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    if(![textView hasText]) {
        lbl.hidden = NO;
    }
    else{
        lbl.hidden = YES;
    }
}
-(void)resignTextView
{
    
    
    
    if ([textView.text length]<1) {
        
    }
    
    else if([textView.text length]>500){
        
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Please make sure characters should be 500 or less."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }

    else
    {
        chat_Message=textView.text;
        textView.text=@"";
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSString *rowNumber=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
        [self adddBubbledata:ktextByme mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:kStatusSeding];
        
        [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:2.0];
        [self chatApi];
    }
    
    
    
}
-(void)chatApi
{
    [self performSelectorInBackground:@selector(loadChatAPI) withObject:nil];
}


//this for work

-(void)loadChatAPI  {
    
    
    
    NSDictionary *params;
    
    
  
    NSLog(@"chat_Message...%@",chat_Message);
    NSLog(@"commonString...%@",delegate.Push_Sender_id);
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSString *timevalue = [NSString stringWithFormat:@"%@",timeZone];
    
    NSArray *timezoneindex = [timevalue componentsSeparatedByString:@" "];
    NSString *gmtstring = [timezoneindex objectAtIndex:3];
    
    
    //    NSLog(@"Users_id...%@", [[delegate.logininfo_Array objectAtIndex:0] valueForKey:@"user_id"]);
    ////
    
    
    params=@{@"action":@"chatmessage",@"from_id":Sender_id,@"message":chat_Message,@"to_id":Reciever_id,@"gmtvalue":gmtstring};
    

    
    NSLog(@"parrr: %@", params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSLog(@"Reply JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            
//            arr_inboxMessage = [[responseObject objectForKey:@"show"] mutableCopy];
//            [tbl_inboxTable reloadData];
            
        }
        else{
            
            [self ShowAlertIn:@"Error Occured"];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:@"Network connection error" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                        {
                                            
                                            
                                            
                                        }];
        [alertcontroller addAction:defaultAction];
        [self presentViewController:alertcontroller animated:YES completion:nil];
        
        NSLog(@"Error: %@", error);
    }];
    
}
//
//-(void)loadChatAPI{
//    
//    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

//    NSDictionary *params;
//        params = @{@"from_id":delegate.userId,@"message":chat_Message,@"to_id":delegate.Push_Sender_id};
//    
//    
//    NSLog(@"params=%@",params);
//    
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:kServerurl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    }error:nil];
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//         NSLog(@"response: %@",json);
//     }
//                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         if([operation.response statusCode] == 403)
//         {
//             //NSLog(@"Upload Failed");
//             return;
//         }
//         //NSLog(@"error: %@", [operation error]);
//         
//     }];
//    
//    [operation start];
//    
//    
//}

//{
//
//    NSString * strin =@"http://www.unionrides.com/ios/sendmessage.php";
//    NSDictionary *params;
//    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//
//    NSLog(@"delegate.User_Id...%@",delegate.User_Id);
//    NSLog(@"chat_Message...%@",chat_Message);
//    NSLog(@"commonString...%@",commonString);
//
//    params = @{@"users_id":delegate.User_Id,@"message":chat_Message,@"touser_id":delegate.Push_Sender_id};
//
//    // NSLog(@"http://www.unionrides.com/ios/sendmessage.php=%@",params);
//
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strin parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    }error:nil];
//
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//         NSLog(@"response: %@",json);
//
//
//         NSString*msg=[json valueForKey:@"msg"];
//         if ([msg isEqualToString:@"Send msg successfully!"]) {
//
//             //
//             //             UIAlertView*alertx=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//             //            [alertx show];
//
//         }
//         else{
//             //             alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//             // [alert show];
//
//         }
//     }
//            failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         [self dissmissIndicator];
//
//         if([operation.response statusCode] == 403)
//         {
//             //NSLog(@"Upload Failed");
//             return;
//         }
//         //NSLog(@"error: %@", [operation error]);
//
//     }];
//
//    [operation start];
//}

-(IBAction)messageSent:(id)sender
{
    // NSLog(@"row= %@", sender);
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:[sender intValue]];
    feed_data.messagestatus=@"Sent";
    [sphBubbledata replaceObjectAtIndex:[sender intValue] withObject:feed_data ];
    
    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:[sender intValue] inSection:0];
    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
    [self.sphChatTable reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
    
    
}


-(IBAction)uploadImage:(id)sender
{
    //    if ([UIImagePickerController isSourceTypeAvailable:
    //         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    //    {
    //        UIImagePickerController *imagePicker =
    //        [[UIImagePickerController alloc] init];
    //        imagePicker.delegate = self;
    //        imagePicker.sourceType =
    //        UIImagePickerControllerSourceTypePhotoLibrary;
    //        imgPicker.mediaTypes = [NSArray arrayWithObjects:
    //                                (NSString *) kUTTypeImage,
    //                                nil];
    //        imagePicker.allowsEditing = NO;
    //        [self presentViewController:imagePicker animated:YES completion:nil];
    //        newMedia = NO;
    //    }
    
    //@@@@@@@//Sumit verma
    
    //    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Please select to attachment" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:Nil otherButtonTitles:@"Take Photo or Video",@"Choose Existing Photo",@"Choose Existing video",nil];
    //    //delete_all_chat_messages.php?dest_user_id=
    //[action showInView:self.view];
    ////Sumit verma
    
}


-(void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"value of %@",self.imagePickerController.mediaTypes);
//    
//    if(buttonIndex == [actionSheet destructiveButtonIndex])
//    {
//    }
//    if (buttonIndex==0) {
//        
//        sendType=1;
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//            
//            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:self.imagePickerController animated:NO completion:nil];
//        }
//        
//    }
//    if (buttonIndex==1) {
//        
//        sendType=2;
//        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        self.imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
//        [self presentViewController:self.imagePickerController animated:YES completion:nil];
//        
//    }
//    if (buttonIndex==2) {
//        
//        sendType=3;
//        self.imagePickerController.allowsEditing = YES;
//        self.imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeMovie];
//        [self presentViewController:self.imagePickerController animated:NO completion:nil];
//        
//    }
//}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    imageShowTag=FALSE;
    
    if (sendType==1) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        NSString *mediaType = [info
                               objectForKey:UIImagePickerControllerMediaType];
        
        
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImage *image = [info
                              objectForKey:UIImagePickerControllerOriginalImage];
            
            
            Uploadedimage.image=image;
            seletecedImage=image;
            
            [ImageArrayByMe addObject:image];
            [imageArrayofvideo addObject:@""];
            
            if (newMedia)
                UIImageWriteToSavedPhotosAlbum(image,
                                               self,
                                               @selector(image:finishedSavingWithError:contextInfo:),
                                               nil);
            
            
            TagType=12;
            
            [self chatApi];
            
        }
        
        
    }
    
    
    
    if (sendType==2) {
        
        NSString *mediaType = [info
                               objectForKey:UIImagePickerControllerMediaType];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImage *image = [info
                              objectForKey:UIImagePickerControllerOriginalImage];
            
            
            
            
            Uploadedimage.image=image;
            seletecedImage=image;
            
            
            [imageArrayofvideo addObject:@""];
            [ImageArrayByMe addObject:image];
            
            if (newMedia)
                UIImageWriteToSavedPhotosAlbum(image,
                                               self,
                                               @selector(image:finishedSavingWithError:contextInfo:),
                                               nil);
            
            
            TagType=12;
            [self chatApi];
        }
        
    }
    
    if (sendType==3) {
        
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            //NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
            
            
            NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
            if([mediaType isEqualToString:@"public.movie"])
            {
                NSLog(@"came to video select...");
                
                videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
                NSLog(@"Got Movie Url==%@",videoUrl);
                
                
            }
            
            /*
             
             //..add here video compress code...........
             
             */
            
            AVAsset *asset = [AVAsset assetWithURL:videoUrl];// url= give your url video here
            AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
            CMTime time = CMTimeMake(1, 5);//it will create the thumbnail after the 5 sec of video
            CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
            
            UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
            UIImage * LandscapeImage = thumbnail;
            
            PortraitImage = [[UIImage alloc] initWithCGImage: LandscapeImage.CGImage
                                                       scale: 1.0
                                                 orientation: UIImageOrientationRight];
            NSData *imageDataForResize = UIImageJPEGRepresentation(LandscapeImage,0.1);
            UIImage *img=[UIImage imageWithData:imageDataForResize];
            
            
            CGRect rect = CGRectMake(0,0,img.size.width/6,img.size.height/6);
            UIGraphicsBeginImageContext( rect.size );
            [img drawInRect:rect];
            // UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //NSData *imageDataForResizeTwo = UIImageJPEGRepresentation(picture1,0.1);
            //UIImage *imgTwo=[UIImage imageWithData:imageDataForResizeTwo];
            
            
            //image_data = [[NSData dataWithData:UIImagePNGRepresentation(imgTwo)]mutableCopy];
            [ImageArrayByMe addObject:@""];
            [imageArrayofvideo addObject:PortraitImage];
            
            
            TagType=14;
            [self chatApi];
            
        }
    }
    
    
    [self performSelector:@selector(uploadToServer) withObject:nil afterDelay:0.1];
}

-(void)uploadToServer
{
    chat_Message=textView.text;
    textView.text=@"";
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"hh:mm a"];
    
    NSString *rowNumber=[NSString stringWithFormat:@"%d",(int)sphBubbledata.count];
    
    NSLog(@"rowNumber....%@",rowNumber);
    
    if (sendType==1) {
        
        sendType=23;
        [self adddBubbledata:kImageByme mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:kStatusSeding];
    }
    
    if (sendType==2) {
        
        sendType=23;
        [self adddBubbledata:kImageByme mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:kStatusSeding];
    }
    
    else if (sendType==3){
        
        sendType=23;
        [self adddBubbledata:kVideobyme mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:kStatusSeding];
        
    }
    
    
    
    [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        alert = [[UIAlertView alloc]
                 initWithTitle: @"Save failed"
                 message: @"Failed to save image"\
                 delegate: nil
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil];
        [alert show];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return sphBubbledata.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    if ([feed_data.messageType isEqualToString:ktextByme])
    {
        float cellHeight;
        // text
        NSString *messageText = feed_data.messageText;
        CGSize boundingSize = CGSizeMake(messageWidth-20, 100000);
        CGSize itemTextSize = [messageText sizeWithFont:[UIFont systemFontOfSize:16]
                                      constrainedToSize:boundingSize
                                          lineBreakMode:NSLineBreakByWordWrapping];
        // plain text
        cellHeight = itemTextSize.height;
        return  cellHeight +40;
        
        
        //        if (cellHeight<=90) {
        //
        //            return cellHeight+35;
        //
        //            // 70;
        //        }
        //
        //        else if (cellHeight>90 & cellHeight<150)
        //        {
        //
        //            return cellHeight+35;
        //
        //            // 70;
        //        }
        //
        //
        //        else if (cellHeight>150 & cellHeight<250)
        //        {
        //
        //            return cellHeight+20;
        //
        //            // 70;
        //        }
        //
        //        else if (cellHeight>250 & cellHeight<350)
        //        {
        //
        //            return cellHeight+20;
        //
        //            // 70;
        //        }
        //        else if (cellHeight>350 & cellHeight<450)
        //        {
        //
        //            return cellHeight+15;
        //
        //            // 70;
        //        }
        //
        //
        //        else
        //        {
        //            return cellHeight-10;
        //        }
        //
        
        
        
    }
    else if ([feed_data.messageType isEqualToString:ktextbyother]) {
        
        float cellHeight;
        // text
        NSString *messageText = feed_data.messageText;
        CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
        CGSize itemTextSize = [messageText sizeWithFont:[UIFont systemFontOfSize:16]
                                      constrainedToSize:boundingSize
                                          lineBreakMode:NSLineBreakByWordWrapping];
        // plain text
        cellHeight = itemTextSize.height;
        
        return cellHeight+40;
        //        if (cellHeight<=90) {
        //
        //            return cellHeight+45;
        //
        //            // 70;
        //        }
        //
        //        else if (cellHeight>90 & cellHeight<150)
        //        {
        //
        //            return cellHeight+35;
        //
        //            // 70;
        //        }
        //
        //
        //        else if (cellHeight>150 & cellHeight<250)
        //        {
        //
        //            return cellHeight+20;
        //
        //            // 70;
        //        }
        //
        //        else if (cellHeight>250 & cellHeight<350)
        //        {
        //
        //            return cellHeight+20;
        //
        //            // 70;
        //        }
        //        else if (cellHeight>350 & cellHeight<450)
        //        {
        //
        //            return cellHeight+15;
        //
        //            // 70;
        //        }
        //
        //
        //        else
        //        {
        //            return cellHeight+10;
        //        }
        //
        
        
    }
    
    
    else if ([feed_data.messageType isEqualToString:kVideobyme]){
        
        return 140;
        
    }
    
    
    else{
        
        return 140;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    
    // NSLog(@"%@feed_datafeed_data",feed_data);
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    
    
    if ([feed_data.messageType isEqualToString:ktextByme])
    {
        SPHBubbleCellOther  *cell = (SPHBubbleCellOther *)[self.sphChatTable dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPHBubbleCellOther" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        [cell SetCellData:feed_data targetedView:self Atrow:indexPath.row];
        
        return cell;
        
    }
    
    
    if ([feed_data.messageType isEqualToString:ktextbyother])
    {
        SPHBubbleCell  *cell = (SPHBubbleCell *)[self.sphChatTable dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPHBubbleCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        [cell SetCellData:feed_data targetedView:self Atrow:indexPath.row];
        
        //        index=indexPath.row;
        
        return cell;
    }
    
    
    return nil;
}





-(void)adddBubbledata:(NSString*)messageType  mtext:(NSString*)messagetext mtime:(NSString*)messageTime mimage:(UIImage*)messageImage  msgstatus:(NSString*)status;
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data.messageText=messagetext;
    feed_data.messageImageURL=messagetext;
    feed_data.messageImage=messageImage;
    feed_data.messageTime=messageTime;
    feed_data.messageType=messageType;
    feed_data.messagestatus=status;
    
    //  NSLog(@"feed_data===%@",feed_data);
    [sphBubbledata addObject:feed_data];
    [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
}

-(void)adddBubbledataatIndex:(NSInteger)rownum messagetype:(NSString*)messageType  mtext:(NSString*)messagetext mtime:(NSString*)messageTime mimage:(UIImage*)messageImage  msgstatus:(NSString*)status;
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data.messageText=messagetext;
    feed_data.messageImageURL=messagetext;
    feed_data.messageImage=messageImage;
    feed_data.messageTime=messageTime;
    feed_data.messageType=messageType;
    feed_data.messagestatus=status;
    // [Delegate.Push_dataArray  replaceObjectAtIndex:rownum withObject:feed_data];
    
    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rownum inSection:0];
    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
    [self.sphChatTable reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
    
    [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.1];
}



//this for work
-(void)CallTableReload
{
    
  //  NSLog(@"lkjfsdlkjf%@",delegate.Push_dataArray);
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self adddBubbledata:ktextbyother mtext:[delegate.Push_dataArray valueForKey:@"message"] mtime:[delegate.Push_dataArray valueForKey:@"timee"] mimage:Uploadedimage.image msgstatus:kStatusSent];
    
    [self.sphChatTable reloadData];
    
}

-(void)HandelPush_Messages{
    
    
    
    
    
}

-(IBAction)bookmarkClicked:(id)sender
{
    NSLog( @"Book mark clicked at row : %d",selectedRow);
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(void)scrollTableview
{
    [self.sphChatTable reloadData];
    NSInteger lastSection=[self.sphChatTable numberOfSections]-1;
    NSInteger lastRowNumber = [self.sphChatTable numberOfRowsInSection:lastSection]-1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:lastSection];
    [self.sphChatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

-(void) keyboardWillShow:(NSNotification *)note
{
    
    // [self setUpTextFieldforIphone];
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height-(keyboardBounds.size.height + containerFrame.size.height);
    CGRect tableviewframe=self.sphChatTable.frame;
    tableviewframe.size.height-=250;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    containerView.frame = containerFrame;
    self.sphChatTable.frame=tableviewframe;
    [UIView commitAnimations];
    
    if (sphBubbledata.count>2)
        
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
    
}

-(void) keyboardWillHide:(NSNotification *)note
{
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    // get a rect for the textView frame
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    CGRect tableviewframe=self.sphChatTable.frame;
    tableviewframe.size.height+=250;
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    // set views with new info
    self.sphChatTable.frame=tableviewframe;
    containerView.frame = containerFrame;
    // commit animations
    [UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
}




-(IBAction)endViewedit:(id)sender
{
    [self.view endEditing:YES];
}
-(IBAction)btn_back:(id)sender
{
    
    [self performSelector:@selector(backcontroller) withObject:nil afterDelay:0.0];
    
    
    
    
    // [self presentViewController:obj animated:NO completion:nil];
}

//this for work

-(void)backcontroller
{
    [textView resignFirstResponder];
    
    
     delegate.delegatePushStr = nil;
    //_delegatePushStr
    
    [sphBubbledata removeAllObjects];
    [Responce_array removeAllObjects];
    [chatImage removeAllObjects];
    [reversed removeAllObjects];
    
    
    //    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    //
    //    UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main_iphone6" bundle: nil] : screenHeight==736 ?[UIStoryboard storyboardWithName:@"Main_iphone6plus" bundle: nil]:[UIStoryboard storyboardWithName:@"Main4" bundle: nil];
    //
    //    messageViewController * obj = [storyboard instantiateViewControllerWithIdentifier:@"messageViewController"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)startIndicator:(UIView *)sender
{
    indicatorFullView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    indicatorFullView.frame=self.view.frame;
    [indicatorFullView setBackgroundColor:[UIColor grayColor]];
    indicatorFullView.alpha=.5;
    [self.view addSubview:indicatorFullView];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //spinner.backgroundColor=[UIColor grayColor];
    [spinner setCenter:CGPointMake(self.view.frame.size.width/2.0,self.view.frame.size.height/2.0)];
    [self.view addSubview:spinner];
    [spinner startAnimating];
}
-(void)dissmissIndicator
{
    [spinner stopAnimating];
    
    [spinner removeFromSuperview];
    [indicatorFullView removeFromSuperview];
}


- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    [textView resignFirstResponder];
    
    return YES;
}
//-(void) textFieldDidBeginEditing:(UITextField*)textField
//{
//    
// //   [self slideViewUpForTextField:textField];
//    
//}
//
//-(void) textViewDidEndEditing:(UITextView *) textField
//{
//    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y += animatedDistance;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
//    
//    [self.view setFrame:viewFrame];
//    
//    [UIView commitAnimations];
//    
//}
//
//
//
//
//- (void) slideViewUpForTextView:(UITextView *)textField
//{
//    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
//    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
//    
//    CGFloat midline = textFieldRect.origin.y + 3.0 * textFieldRect.size.height;
//    CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
//    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
//    CGFloat heightFraction = numerator / denominator;
//    
//    if (heightFraction < 0.0)
//        heightFraction = 0.0;
//    else if (heightFraction > 1.0)
//        heightFraction = 1.0;
//    
//    UIInterfaceOrientation orientation =
//    [[UIApplication sharedApplication] statusBarOrientation];
//    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
//        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
//    else
//        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
//    
//    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y -= animatedDistance;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
//    
//    [self.view setFrame:viewFrame];
//    
//    [UIView commitAnimations];
//    
//}


- (IBAction)btnBackClicked:(id)sender {
    
    
    
    delegate.delegatePushStr = nil;
    
    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"MainIpad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main6" bundle: nil]: screenHeight==736 ? [UIStoryboard storyboardWithName:@"Main6plus" bundle: nil]: [UIStoryboard storyboardWithName:@"Main4" bundle: nil];
    
    NewMatchVC * obj = [storyboard instantiateViewControllerWithIdentifier:@"NewMatchVC"];
    [self presentViewController:obj animated:NO completion:nil];
    
}



- (IBAction)btn_moreaction:(id)sender {
    NSArray* firstLastStrings = [usernameString componentsSeparatedByString:@" "];
    NSString* firstName = [firstLastStrings objectAtIndex:0];
    
   // usernameString
    
    NSString* s = firstName;
    
    s = [@"Show " stringByAppendingString:s];
   other1=[s stringByAppendingString:@"'s Profile"];
   other2=[@"Report " stringByAppendingString:firstName];
   other3=[@"Unmatch " stringByAppendingString: firstName];

    

   UIActionSheet* actionSheet = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"Cancel"
                   destructiveButtonTitle:nil
                   otherButtonTitles:other3,other2,other1,nil];
    
    
    [actionSheet showInView:self.view];
    

    

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:other1])
    {
        
//        CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
//        UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"MainIpad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main6" bundle: nil]: screenHeight==736 ? [UIStoryboard storyboardWithName:@"Main6plus" bundle: nil]: [UIStoryboard storyboardWithName:@"Main4" bundle: nil];
//        
//        ProfileInfoVC * obj = [storyboard instantiateViewControllerWithIdentifier:@"ProfileInfoVC"];
//        
//        obj.strid=self.Reciever_id;
//        obj.comingfrom=@"fromchat";
//        [self presentViewController:obj animated:NO completion:nil];

    }
    else if([buttonTitle isEqualToString:other2])
    {
        
         [self reportAPI];

    }
    else if([buttonTitle isEqualToString:other3])
    {
      
         [self likeDislikeAPI];

    }
    
}

-(void)reportAPI
{
    
    
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userid=[delegate.logininfo_Array valueForKey:@"user_id"];
    
    
    NSDictionary *params;
    
    params = @{@"user_id":userid,@"reported_id":Reciever_id,@"device_id":delegate.device_Id};
    
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSLog(@"Reply JSON: %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            
            // [self dissmissIndicator];
            
            
            [self logSuccessfullyResult:responseObject];
            
            NSLog(@"Response object %@",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
}



-(void)logSuccessfullyResult:(NSDictionary *)result {
    
    
    NSString *msg=[result  valueForKey:@"msg"];
    
    
    if([msg isEqualToString:@"Reorted Successfully"] )
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:msg
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }
    else if([msg isEqualToString:@"Your account has been suspended"] )
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"Logout"  forKey:@"LoginOrLogout"];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"ArrayInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:msg
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}


-(void)likeDislikeAPI
{
    
    
        
        delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *userid=[delegate.logininfo_Array valueForKey:@"user_id"];
        
        NSDictionary *params;
    
   
    
    
    //    NSLog(@"Users_id...%@", [[delegate.logininfo_Array objectAtIndex:0] valueForKey:@"user_id"]);
    ////
    
    
        params = @{@"user_id":userid,@"matched_user_id":Reciever_id,@"type":@"0",@"device_id":delegate.device_Id};
        
        NSLog(@"params=%@>>>>>>>>>>",params);
        
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
 
    [SVProgressHUD showWithStatus:@"Checking.."];
    
   	[SVProgressHUD show];
        
        
        
        [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@""
                                              message:@"You successfully unmatched with this user"
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         
                                         
                                         [SVProgressHUD dismiss];
                                         
                                         CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
                                         UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"MainIpad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main6" bundle: nil]: screenHeight==736 ? [UIStoryboard storyboardWithName:@"Main6plus" bundle: nil]: [UIStoryboard storyboardWithName:@"Main4" bundle: nil];
                                         
                                         NewMatchVC * obj = [storyboard instantiateViewControllerWithIdentifier:@"NewMatchVC"];
                                         
                                         
                                         [self presentViewController:obj animated:NO completion:nil];
                                        
                                         
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];
    
    
    
}


- (IBAction)btnNameClicked:(id)sender {
   
//    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
//    UIStoryboard *storyboard=UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad?[UIStoryboard storyboardWithName:@"MainIpad" bundle: nil]:screenHeight==568 ? [UIStoryboard storyboardWithName:@"Main" bundle: nil] : screenHeight==667 ? [UIStoryboard storyboardWithName:@"Main6" bundle: nil]: screenHeight==736 ? [UIStoryboard storyboardWithName:@"Main6plus" bundle: nil]: [UIStoryboard storyboardWithName:@"Main4" bundle: nil];
//    
//    ProfileInfoVC * obj = [storyboard instantiateViewControllerWithIdentifier:@"ProfileInfoVC"];
//    
//    obj.strid=self.Reciever_id;
//    obj.comingfrom=@"fromchat";
//    [self presentViewController:obj animated:NO completion:nil];
    
}
@end

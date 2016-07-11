//
//  SPHViewController.h
//  SPHChatBubble
//
//  Created by Siba Prasad Hota  on 10/18/13.
//  Copyright (c) 2013 Wemakeappz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@class AppDelegate;

@class QBPopupMenu;

@interface SPHViewController : UIViewController<HPGrowingTextViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate, UIAlertViewDelegate,HPGrowingTextViewDelegate,UITextViewDelegate>
{
    
    CGFloat animatedDistance;
    IBOutlet UILabel *username;
     AppDelegate *delegate;
     NSMutableArray *sphBubbledata;
    NSMutableArray* reversed;
    
    
    
    
    NSArray *array ;
    
    NSMutableArray *newmutarray;
    
   
         int selectedRow;
     BOOL newMedia;
     NSMutableArray *Responce_array;
    NSArray *testing;
    NSString *chat_Message;
        NSString *usernameString,* CustomFont;
    NSString *userImageString;
    NSString *reciverUsr_id;
IBOutlet UILabel *statusLabl;
IBOutlet UIImageView *profileimage;
IBOutlet UILabel *Labl_User_Name;
 IBOutlet UILabel *Labl_Header;
    UIImage *seletecedImage;
    int TagType;
    BOOL imageShowTag;
    NSMutableArray *ImageArrayByMe;
    UIImagePickerController *imagePickerController;
    UIImage*myimage;
    int sendType;
    NSURL *videoUrl;
    NSMutableArray *UrlArray;
    UIImage * PortraitImage;
    NSMutableArray *imageArrayofvideo;
    NSString*commonString;
    long index;
    UIAlertView*alert;
    UILabel*lbl;
    HPGrowingTextView *textView;
    UIView*containerView;
    NSMutableArray *chatImage;
    NSMutableArray*msgId;
    
    
    NSString *other1;
    NSString *other2;
    NSString *other3;
}
@property(nonatomic,retain) UIImagePickerController *imagePickerController;

@property(nonatomic,retain) NSString *reciverUsr_id;
@property(nonatomic,retain) NSString *usernameString;
@property(nonatomic,retain) NSString *userImageString;
@property (nonatomic,retain)NSMutableArray*ShowMSgArray;
@property(assign)long msgcount;
@property (nonatomic,retain)NSString *Sender_id;
@property (nonatomic,retain)NSString *Reciever_id;
@property(assign)int swither;

@property (nonatomic, readwrite, assign) NSUInteger reloads;
@property(nonatomic,strong)NSMutableArray*common_Array;
@property (weak, nonatomic) IBOutlet UIImageView *Uploadedimage;
@property (nonatomic, strong) QBPopupMenu *popupMenu;
@property (weak, nonatomic) IBOutlet UITableView *sphChatTable;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property(assign)long indexCount;
-(IBAction)btn_back:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendbtn;

-(void)adddBubbledata:(NSString*)messageType  mtext:(NSString*)messagetext mtime:(NSString*)messageTime mimage:(UIImage*)messageImage  msgstatus:(NSString*)status;
- (IBAction)endViewedit:(id)sender;

//- (void) handleURL:(NSURL *)url;


/// PUSH HANDEL BY MUSEER
//-(void)HandelPush_Messages;
-(void)resignTextView;
-(void)HandelPush_Messages;
@property (nonatomic,strong)SPHViewController *CHATVC;

@property (nonatomic , strong) NSString * User_chattingName;
- (IBAction)SendChat:(id)sender;

- (IBAction)btnBackClicked:(id)sender;
@property (nonatomic , strong) NSString * otheruser_id;
- (IBAction)btn_moreaction:(id)sender;
@property(nonatomic,strong)NSMutableArray*arrayforprofile;

- (IBAction)btnNameClicked:(id)sender;

@end

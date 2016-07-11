//
//  UserProfileVC.h
//  LezzGo2
//
//  Created by Apple on 04/07/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "MSMenuView.h"
#import "REFrostedViewController.h"

@interface AddPostVC : UIViewController<HeaderVCDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout,MSMenuViewDelegate>
{
    UIButton *cancelbtn;
    HeaderVC *header;
        AppDelegate *delegate;
    IBOutlet UIView *Photoview;
    IBOutlet UIView *TextbottomView;
    IBOutlet UIView *mainview;

    IBOutlet UIImageView *mainimage;
    
    IBOutlet UITextView *descriptiontxt;

}
@property(nonatomic,retain)IBOutlet UITextView *descriptiontxt;

@property(nonatomic,retain)IBOutlet UIImageView *mainimage;
@property(nonatomic,retain)IBOutlet UIView *mainview;

@property(nonatomic,retain)  IBOutlet UIView *Photoview;
@property(nonatomic,retain)IBOutlet UIView *TextbottomView;
-(IBAction)photobtnclick:(id)sender;
-(IBAction)textbtnclick:(id)sender;
@end

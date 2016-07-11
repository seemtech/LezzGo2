//
//  FriendsVC.h
//  LezzGo2
//
//  Created by Apple on 30/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "HeaderVC.h"
#import "MSMenuView.h"

@interface FriendsVC : UIViewController<HeaderVCDelegate,MSMenuViewDelegate>
{
    UIRefreshControl *refreshControl;
    IBOutlet UITableView *tbloutlet;
    AppDelegate *delegate;
    NSMutableArray *arrlableData;
    NSMutableArray *arrImageData;
    NSMutableArray *arrayinbox;
    HeaderVC *header;
    
}

@property (weak, nonatomic) IBOutlet UILabel *lblNoMatchUser;
@property (weak, nonatomic) IBOutlet UILabel *lblNoMatchUser2;

@end
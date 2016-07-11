//
//  NewMatchVC.h
//
//  Created by Domain on 3/7/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "HeaderVC.h"

@interface NewMatchVC : UIViewController<HeaderVCDelegate>
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

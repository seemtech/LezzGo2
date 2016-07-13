//
//  SettingsVC.h
//  ToothBrush
//
//  Created by seemtech on 4/7/16.
//  Copyright © 2016 com.seemtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "HeaderVC.h"
@interface SettingsVC : UIViewController<UITableViewDelegate,UITableViewDataSource,HeaderVCDelegate>
{
    HeaderVC *header;
    NSMutableArray * ArraySetting1;
    NSMutableArray * ArraySetting2;
    NSMutableArray * ArraySetting3;
     AppDelegate *delegate;

    IBOutlet UILabel *lbl_header;
    BOOL menuopen;


}
@property (retain, nonatomic) NSMutableArray *transcripts;

@property (weak, nonatomic) IBOutlet UITableView *Table;
@end

//
//  SettingsCell.h
//  ToothBrush
//
//  Created by seemtech on 4/7/16.
//  Copyright © 2016 com.seemtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lbl_Name;
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;

@property (weak, nonatomic) IBOutlet UISwitch *btn_SwitchClicked;


@end

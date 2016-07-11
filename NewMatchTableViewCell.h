//
//  NewMatchTableViewCell.h
//
//  Created by Domain on 3/7/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMatchTableViewCell : UITableViewCell
@property (strong,nonatomic)IBOutlet UILabel *LblName;
@property (strong,nonatomic)IBOutlet UILabel *LblTime;
@property (strong,nonatomic)IBOutlet UILabel *Lblmsg;
@property (strong,nonatomic)IBOutlet UILabel *Lblmsgcount;

@property (strong,nonatomic)IBOutlet UIImageView *userimage;

@end

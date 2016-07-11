//
//  SPHBubbleCellByMeViewController.h
//  GIBBERISH
//
//  Created by Deepak Singh Rawat on 30/04/15.
//  Copyright (c) 2015 MK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPHChatData.h"

@interface SPHBubbleCellByMeViewController : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Buble_image;
@property (weak, nonatomic) IBOutlet UIImageView *Avatar_Image;
@property (weak, nonatomic) IBOutlet UIImageView *message_Image;
@property (weak, nonatomic) IBOutlet UILabel *time_Label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *statusindicator;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@property(nonatomic,retain) IBOutlet UIImageView *mainImage;

-(void)SetCellData:(SPHChatData *)feed_data;

@end

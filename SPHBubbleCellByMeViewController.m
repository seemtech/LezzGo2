//
//  SPHBubbleCellByMeViewController.m
//  GIBBERISH
//
//  Created by Deepak Singh Rawat on 30/04/15.
//  Copyright (c) 2015 MK. All rights reserved.
//

#import "SPHBubbleCellByMeViewController.h"
#import "SPHMacro.h"

@interface SPHBubbleCellByMeViewController ()

@end

@implementation SPHBubbleCellByMeViewController

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)SetCellData:(SPHChatData *)feed_data
{
    
    if ([feed_data.messagestatus isEqualToString:kStatusSent]) {
        
        self.statusindicator.alpha=0.0;
        [self.statusindicator stopAnimating];
        self.statusImage.alpha=1.0;
        [self.statusImage setImage:[UIImage imageNamed:@"success"]];
        
    }else  if ([feed_data.messagestatus isEqualToString:kStatusSeding])
    {
        self.statusImage.alpha=0.0;
        self.statusindicator.alpha=1.0;
        [self.statusindicator startAnimating];
        self.message_Image.image=[UIImage imageNamed:@""];
        
    }
    else
    {
        self.statusindicator.alpha=0.0;
        [self.statusindicator stopAnimating];
        self.statusImage.alpha=1.0;
        [self.statusImage setImage:[UIImage imageNamed:@"failed"]];
        
    }
    self.Avatar_Image.layer.cornerRadius = 20.0;
    self.Avatar_Image.layer.masksToBounds = YES;
    self.Avatar_Image.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Avatar_Image.layer.borderWidth = 2.0;
    self.Avatar_Image.image=[UIImage imageNamed:@"Customer_icon"];
    self.time_Label.text=feed_data.messageTime;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
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

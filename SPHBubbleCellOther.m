//
//  SPHBubbleCellOther.m
//  ChatBubble
//
//  Created by ivmac on 10/2/13.
//  Copyright (c) 2013 Conciergist. All rights reserved.
//

#import "SPHBubbleCellOther.h"

#define messageWidth 260
#import "SPHMacro.h"

@implementation SPHBubbleCellOther

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
    }
    return self;
}

-(void)SetCellData:(SPHChatData *)feed_data targetedView:(id)ViewControllerObject Atrow:(NSInteger)indexRow;
{
    NSString *messageText = feed_data.messageText;
    CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
    CGSize itemTextSize = [messageText boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:15.0]} context:nil].size;
;
    float textHeight = itemTextSize.height+7;
 
    CGFloat screenHeight=[UIScreen mainScreen].bounds.size.height;
    if(screenHeight ==667)
    {
        UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bubbleMine"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
        bubbleImage.tag=55;
        [self.contentView addSubview:bubbleImage];
        //anuj chat
        [bubbleImage setFrame:CGRectMake(330-itemTextSize.width,7,itemTextSize.width+40,textHeight+4)];
    }
   else if (screenHeight==736)
    {
        UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bubbleMine"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
        bubbleImage.tag=55;
        [self.contentView addSubview:bubbleImage];
        //anuj chat
        [bubbleImage setFrame:CGRectMake(370-itemTextSize.width,7,itemTextSize.width+40,textHeight+4)];
    }
    else if (screenHeight ==568)
    {
//        UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bubbleMine"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
//        bubbleImage.tag=55;
//        [self.contentView addSubview:bubbleImage];
//        [bubbleImage setFrame:CGRectMake(270-itemTextSize.width,7,itemTextSize.width+40,textHeight+4)];
        
        
        UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bubbleMine"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
        bubbleImage.tag=55;
        [self.contentView addSubview:bubbleImage];
        [bubbleImage setFrame:CGRectMake(270-itemTextSize.width,7,itemTextSize.width+40,textHeight+4)];
    }
    else
    {
        UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bubbleMine"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
        bubbleImage.tag=55;
        [self.contentView addSubview:bubbleImage];
        [bubbleImage setFrame:CGRectMake(270-itemTextSize.width,7,itemTextSize.width+40,textHeight+4)];

    }
    
    
    
   // UITextView *messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(275 - itemTextSize.width+5,2,itemTextSize.width+10, textHeight+10)];
    
    UITextView *messageTextview;
    if(screenHeight==667)
    {
        messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(335 - itemTextSize.width+5,2,itemTextSize.width+10, textHeight+10)];
    }
    else if (screenHeight==736)
    {
        messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(375 - itemTextSize.width+5,2,itemTextSize.width+10, textHeight+10)];
    }
    else
    {
        messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(270 - itemTextSize.width+5,2,itemTextSize.width+10, textHeight+10)];
    }
    
    [self.contentView addSubview:messageTextview];
    messageTextview.editable=NO;
    messageTextview.text = messageText;
    messageTextview.dataDetectorTypes=UIDataDetectorTypeAll;
    messageTextview.textAlignment=NSTextAlignmentJustified;
    
    //museer controll send msg text by_me
    messageTextview.font=[UIFont fontWithName:@"Helvetica Neue" size:15.0];
    messageTextview.backgroundColor=[UIColor clearColor];
    messageTextview.tag=indexRow;
    messageTextview.textColor = [UIColor blackColor];
   
    self.Avatar_Image.image=[UIImage imageNamed:@"Customer_icon"];
    
   // self.time_Label.text=feed_data.messageTime;
    //[self.time_Label setTextColor:[UIColor lightGrayColor]];
    
    UILabel*timeLabel;
    if(screenHeight==667)
    {
        self.time_Label.text=@"";
        timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-55,messageTextview.frame.size.height,100, 20)];
    }
    else if ( screenHeight==736)
    {
        self.time_Label.text=@"";
        timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-20,messageTextview.frame.size.height,100, 20)];
    }
    else
    {
        self.time_Label.text=@"";
        
        timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-130,messageTextview.frame.size.height,100, 20)];
        
    }
    
    
    timeLabel.textColor=[UIColor grayColor];
    timeLabel.textAlignment=NSTextAlignmentRight;
    [timeLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12.0f]];
    [timeLabel setText:feed_data.messageTime];
    [self.contentView addSubview:timeLabel];
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    messageTextview.scrollEnabled=NO;
    
    if ([feed_data.messagestatus isEqualToString:kStatusSent]) {
        
        self.statusindicator.alpha=0.0;
        [self.statusindicator stopAnimating];
        self.statusImage.alpha=1.0;
        //museer remove status image
        
        [self.statusImage setImage:nil];
        
    }else  if ([feed_data.messagestatus isEqualToString:kStatusSeding])
    {
        self.statusImage.alpha=0.0;
        self.statusindicator.alpha=1.0;
        
        //museer remove status indicator
        [self.statusindicator startAnimating];
        
    }
    else
    {
        self.statusindicator.alpha=0.0;
        [self.statusindicator stopAnimating];
        self.statusImage.alpha=1.0;
        [self.statusImage setImage:[UIImage imageNamed:kStatusFailed]];
        
    }
    
    self.Avatar_Image.layer.cornerRadius = 20.0;
    self.Avatar_Image.layer.masksToBounds = YES;
    self.Avatar_Image.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Avatar_Image.layer.borderWidth = 2.0;
    
    
    //UITapGestureRecognizer *singleFingerTap =
    //[[UITapGestureRecognizer alloc] initWithTarget:ViewControllerObject action:@selector(tapRecognized:)];
    //[messageTextview addGestureRecognizer:singleFingerTap];
   // singleFingerTap.delegate = ViewControllerObject;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

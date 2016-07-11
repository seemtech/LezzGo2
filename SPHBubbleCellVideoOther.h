//
//  SPHBubbleCellImageOther.h
//  ChatBubble
//
//  Created by ivmac on 10/2/13.
//  Copyright (c) 2013 Conciergist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHBubbleCellVideoOther : UITableViewCell

@property(weak,nonatomic) IBOutlet UIButton *videPlayButton;

@property (weak, nonatomic) IBOutlet UIImageView *videoThumb;
@property (weak, nonatomic) IBOutlet UIImageView *Buble_image;

@property (weak, nonatomic) IBOutlet UILabel *time_Label;
@property(weak,nonatomic) IBOutlet UILabel *SenderNameLable;

@property(weak,nonatomic)IBOutlet UIImageView *PlayImage;
@property(weak,nonatomic)IBOutlet UIActivityIndicatorView *IndercatorBeforeLoding;

@property(weak,nonatomic)IBOutlet UILabel *LenghtVideo;

@end

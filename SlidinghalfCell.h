//
//  HomeCell.h
//  RealStateApp
//
//  Created by versha on 12/17/12.
//  Copyright (c) 2012 versha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidinghalfCell : UITableViewCell {
    IBOutlet UILabel *NameTxt;
    IBOutlet UIImageView *image;
    IBOutlet UIImageView *sliderimage;

  
}
@property(nonatomic,retain)IBOutlet UILabel *NameTxt;
@property(nonatomic,retain)IBOutlet UIImageView *image;

@property(nonatomic,retain)IBOutlet UIImageView *sliderimage;
-(void)setName:(NSString *)_text;

@end




//
//  myView.h
//  LezzGo2
//
//  Created by Apple on 06/07/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myView : UIView
{
    IBOutlet UILabel *postlbl;

    IBOutlet UILabel *usernamelbl;
    IBOutlet UIButton *likebtn;
    IBOutlet UIButton *unlikebtn;

}
@property (strong, nonatomic)IBOutlet UILabel *postlbl;

@property (strong, nonatomic) IBOutlet UILabel *usernamelbl;
@property (strong, nonatomic) IBOutlet UIButton *likebtn;
@property (strong, nonatomic) IBOutlet UIButton *unlikebtn;
@end

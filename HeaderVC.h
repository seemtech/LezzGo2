//
//  RateView.h
//  CustomView
//
//  Created by Ray Wenderlich on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class HeaderVC;

@protocol HeaderVCDelegate
- (void)gotobackclick;
@end

@interface HeaderVC : UIView
{
    AppDelegate *delegateappnew;

}

@property (strong, nonatomic)UIButton *LeftBtn;
@property (strong, nonatomic)UILabel *headerlbl;
@property (strong, nonatomic)NSString *msgstr;

@property (assign) id <HeaderVCDelegate> delegate;

@end

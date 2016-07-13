//
//  AboutAppVC.h
//  halalHitch
//
//  Created by Domain on 3/7/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderVC.h"
#import "AppDelegate.h"

@interface AboutAppVC : UIViewController
{
    IBOutlet UIWebView *AppWebview;
    NSString *strUrl;
    NSString *strHeader;
    HeaderVC *header;
    AppDelegate *delegate;

}
@property(nonatomic,strong)IBOutlet UIWebView *AppWebview;

@property(nonatomic,strong)NSString *strUrl;
@property(nonatomic,strong)NSString *strHeader;

- (IBAction)back_btn:(id)sender;




@end

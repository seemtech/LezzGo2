//
//  AboutAppVC.m
//  halalHitch
//
//  Created by Domain on 3/7/16.
//  Copyright © 2016 Domain. All rights reserved.
//

#import "AboutAppVC.h"

@interface AboutAppVC ()

@end

@implementation AboutAppVC
@synthesize strHeader,strUrl,AppWebview;

- (void)viewDidLoad
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];


    AppWebview.delegate = self;
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [AppWebview loadRequest:urlRequest];
    
    
    
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =strHeader;
    header.delegate = self;
    [self.view addSubview:header];
    
    delegate.showlefticon=1;

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)gotobackclick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    delegate.showlefticon=0;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

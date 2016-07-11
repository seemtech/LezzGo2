//
//  FilterVC.m
//  LezzGo2
//
//  Created by Apple on 30/06/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "FilterVC.h"

@interface FilterVC ()

@end

@implementation FilterVC

- (void)viewDidLoad {
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"FILTER";
    
    header.delegate = self;
    [self.view addSubview:header];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)gotobackclick
{
    delegate.showlefticon=0;

    [self dismissViewControllerAnimated:YES completion:nil];
    
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

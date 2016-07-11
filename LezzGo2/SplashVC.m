//
//  SplashVC.m
//  LezzGo2
//
//  Created by Apple on 05/07/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "SplashVC.h"
#import "ViewController.h"
@interface SplashVC ()

@end

@implementation SplashVC

- (void)viewDidLoad {
    [self performSelector:@selector(callnextpage) withObject:nil afterDelay:2.0];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)callnextpage

{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    SplashVC * obj = [storyboard instantiateViewControllerWithIdentifier:@"SplashVC"];
    [self presentViewController:obj animated:YES completion:nil];

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

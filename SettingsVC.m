//
//  SettingsVC.m
//  ToothBrush
//
//  Created by seemtech on 4/7/16.
//  Copyright © 2016 com.seemtech. All rights reserved.
//
@import MultipeerConnectivity;

#import "SettingsVC.h"
#import "SettingsCell.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"
#import "SDWebImageManager.h"
#import "ViewController.h"
#import "AboutAppVC.h"
#import "EditAccountVC.h"

@interface SettingsVC ()
{
     
}
@end
@implementation SettingsVC
@synthesize Table;
-(void)gotobackclick
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    [self performSelectorInBackground:@selector(updateprofileinbackgroud) withObject:nil];

}
-(void)giveratingtoapp
{
    NSString * appId = @"931876873";
    NSString * theUrl = [NSString  stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",appId];
    if ([[UIDevice currentDevice].systemVersion integerValue] > 6) theUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];
}
-(void)deleteapi
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userid=[delegate.logininfo_Array valueForKey:@"user_id"];
    
    NSDictionary *params;
    
    params = @{@"action":@"deleteaccount",@"user_id":userid,@"device_id":delegate.device_Id};
    
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [SVProgressHUD showWithStatus:@"Deleting Account..."];

    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        [SVProgressHUD dismiss];
        
        
        NSLog(@"Reply JSON: %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject valueForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                if([[responseObject valueForKey:@"msg"]isEqualToString:@"Deleted successfully"])
                                                {
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setValue:@"Logout"  forKey:@"LoginOrLogout"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"ArrayInfo"];
                                                    [[NSUserDefaults standardUserDefaults] synchronize];
                                                    
                                                    
                                                    ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                                                    [self presentViewController:VC animated:YES completion:nil];
                                                    
                                                }
                                            }];
            [alertcontroller addAction:defaultAction];
            [self presentViewController:alertcontroller animated:YES completion:nil];
            NSLog(@"loginResponse object %@",responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        // [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
}
-(void)LogoutApi
{
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *userid=[delegate.logininfo_Array valueForKey:@"user_id"];
    
    NSDictionary *params;
    
    params = @{@"action":@"logout",@"user_id":userid,@"device_id":delegate.device_Id};
    
    NSLog(@"params=%@>>>>>>>>>>",params);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [SVProgressHUD showWithStatus:@"Logout.."];
    
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        [SVProgressHUD dismiss];
        
        
        NSLog(@"Reply JSON: %@", responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            UIAlertController* alertcontroller = [UIAlertController alertControllerWithTitle:[responseObject valueForKey:@"msg"]message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                            {
                                                if([[responseObject valueForKey:@"msg"]isEqualToString:@"Logout successfully"])
                                                {
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setValue:@"Logout"  forKey:@"LoginOrLogout"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"ArrayInfo"];
                                                    [[NSUserDefaults standardUserDefaults] synchronize];

                                                    
                                                    ViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                                                    [self presentViewController:VC animated:YES completion:nil];
                                                    
                                                }
                                            }];
            [alertcontroller addAction:defaultAction];
            [self presentViewController:alertcontroller animated:YES completion:nil];
            NSLog(@"loginResponse object %@",responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [SVProgressHUD dismiss];
        // [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad
{
     delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    header=[[HeaderVC alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    header.msgstr =@"ACCOUNT SETTINGS";
    
    header.delegate = self;
    [self.view addSubview:header];
    
    
     ArraySetting1=[[NSMutableArray alloc]init];
    ArraySetting2=[[NSMutableArray alloc]init];
    ArraySetting3=[[NSMutableArray alloc]init];

     _transcripts = [NSMutableArray new];

    [lbl_header setFont:[UIFont fontWithName:@"BebasNeueBook" size:12]];
    ArraySetting1=[[NSMutableArray alloc]initWithObjects:@"MY ACCOUNT",@"FAQ",@"TERMS OF USE",@"GIVE RATING",nil];
     ArraySetting2=[[NSMutableArray alloc]initWithObjects:@"SHOW PROFILE ON MAP",@"PUSH NOTIFICATION",nil];
    ArraySetting3=[[NSMutableArray alloc]initWithObjects:@"DELETE MY ACCOUNT",@"LOGOUT",nil];

    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{

     [super viewWillAppear:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return ArraySetting1.count;
    else if (section == 1)
        return ArraySetting2.count;
    else
        return ArraySetting3.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    headerView.backgroundColor=[UIColor clearColor];
    UILabel *lbl_headers=[[UILabel alloc]initWithFrame:CGRectMake(18,5,300, 18)];
    
  if (section == 0)
    {
        lbl_headers.text=@"ABOUT ME AND APP";
    }
  else if (section == 1)
    {
        lbl_headers.text=@"PUSH AND PRIVACY";
    }
  else  {
        lbl_headers.text=@"KEEP ME OUT";
    }
    lbl_headers.font=[UIFont fontWithName:@"BebasNeueBook" size:12];

    lbl_headers.textColor=[UIColor darkGrayColor];
    [headerView addSubview:lbl_headers];
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier =@"Cell";
    
    SettingsCell *cell = (SettingsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SettingsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    switch (indexPath.section)
    {    case 0:
            cell.btn_SwitchClicked.hidden=YES;

            cell.lbl_Name.text = [ArraySetting1 objectAtIndex:indexPath.row];
           

                       break;
        case 1:
         {
            cell.btn_SwitchClicked.hidden=NO;
             if(indexPath.row==0)
             {
                 if([delegate.strshowprofileonmap isEqualToString:@"1"])
                 {
                     cell.btn_SwitchClicked.on=YES;
                 }
                 else{
                     cell.btn_SwitchClicked.on=NO;
                     
                 }
             }
             else if(indexPath.row==1)
                 {
                     if([delegate.strpushnotificationon isEqualToString:@"1"])
                     {
                         cell.btn_SwitchClicked.on=YES;
                     }
                     else{
                         cell.btn_SwitchClicked.on=NO;
                         
                     }

                 }
             cell.btn_SwitchClicked.tag=indexPath.row;
             [cell.btn_SwitchClicked addTarget:self action:@selector(switchChanged: ) forControlEvents:UIControlEventValueChanged];
             cell.lbl_Name.text = [ArraySetting2 objectAtIndex:indexPath.row];
         }

 break;
        case 2:
         {
             cell.btn_SwitchClicked.hidden=YES;
             cell.lbl_Name.text = [ArraySetting3 objectAtIndex:indexPath.row];

             
        
         }
              
        default:
            break;

    }
    cell.lbl_Name.font=[UIFont fontWithName:@"BebasNeueBook" size:18];
    cell.lbl_Name.textColor=[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0];

[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void) switchChanged:(UISwitch *)sender {
    int rowIndex =[sender tag];
    if(rowIndex==0)
    {
        if(sender.on==YES)
        {
            delegate.strshowprofileonmap=@"1";
        }
        else
        {
            delegate.strshowprofileonmap=@"0";

        }
    }
    else     if(rowIndex==1)

    {
        if(sender.on==YES)
        {
            delegate.strpushnotificationon=@"1";

        }
        else
        {
            delegate.strpushnotificationon=@"0";

        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section)
    {    case 0:
            
if(indexPath.row==0)
{
    EditAccountVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditAccountVC"];
    [self presentViewController:VC animated:YES completion:nil];
}
else if(indexPath.row==1)
{
    
    AboutAppVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutAppVC"];
    VC.strUrl=[NSString stringWithFormat:@"%@",@"http://seemcodersapps.com/lezzgo2/faq"];
    VC.strHeader=@"FAQ";
    [self presentViewController:VC animated:YES completion:nil];
}
else if(indexPath.row==2)
{
    AboutAppVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutAppVC"];
    VC.strUrl=[NSString stringWithFormat:@"%@",@"http://seemcodersapps.com/lezzgo2/terms"];
    VC.strHeader=@"TERMS OF USE";
    [self presentViewController:VC animated:YES completion:nil];
}
else if(indexPath.row==3)
{
    [self giveratingtoapp];
}
    
            break;
        case 1:
        {
            if(indexPath.row==0)
            {
                
            }
            
            else if(indexPath.row==1)
            {
                
            }
        }
            
            break;
        case 2:
        {
            if(indexPath.row==0)
            {
                [self deleteaccout];
            }
            
            else if(indexPath.row==1)
            {
                [self logoutmethod];

            }
            
            
            
        }
            break;
    }
    


}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Logout"])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self LogoutApi];
    }
    
    else if ([buttonTitle isEqualToString:@"Delete Account"])
    {
        [self deleteapi];
    }
    else
    {
        
    }
}
-(void)logoutmethod

{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"You really want to logout?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Logout"
                                                    otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
}
-(void)updateprofileinbackgroud
{
    
    NSDictionary *params;
    params = @{@"action":@"profilesetting",@"user_id":delegate.userid,@"is_showpofilemap":delegate.strshowprofileonmap,@"is_notification":delegate.strpushnotificationon};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"loginResponse object %@",responseObject);
           
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Error: %@", error);
    }];
    
    
}
-(void)deleteaccout
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"if you delete your account, you will permanently lose your profile, messages, photos, and matches. Are you sure you want to delete your account?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Delete Account"
                                                    otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

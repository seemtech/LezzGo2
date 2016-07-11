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


@interface SettingsVC ()
{
     
}
@end
@implementation SettingsVC
@synthesize Table,batterypercentage;
-(void)gotobackclick
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

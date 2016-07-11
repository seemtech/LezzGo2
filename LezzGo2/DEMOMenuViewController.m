//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "SlidinghalfCell.h"
#import "DEMONavigationController.h"
#import "DEMORootViewController.h"
#import "NewMatchVC.h"
#import "SettingsVC.h"
#import "ViewController.h"
#import "SDWebImageManager.h"

@interface DEMOMenuViewController ()

@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    self.tableView.separatorColor = [UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        imageuserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageuserView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageuserView.layer.masksToBounds = YES;
        imageuserView.layer.cornerRadius = 50.0;
        imageuserView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageuserView.layer.borderWidth = 3.0f;
        imageuserView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageuserView.layer.shouldRasterize = YES;
        imageuserView.clipsToBounds = YES;
        [self loadimage];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text =[delegate.logininfo_Array valueForKey:@"full_name"];
        
        label.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
        
        label.font=[UIFont fontWithName:@"BebasNeueBook" size:21];

        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageuserView];
        [view addSubview:label];
        view;
    });
}
-(void)loadimage
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString: [delegate.logininfo_Array valueForKey:@"profile_pic"] ]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                [[SDImageCache sharedImageCache] storeImage:image forKey:[delegate.logininfo_Array valueForKey:@"profile_pic"]];
                                
                                
                                
                                
                                imageuserView.image = image;
                                                   
                                                   
                                                   // do something with image
                                                   }
                                                   
                                                   }];

}
#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
     cell.textLabel.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];

    cell.textLabel.font=[UIFont fontWithName:@"BebasNeueBook" size:20];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    
    if ( indexPath.row == 0) {
        DEMORootViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
        navigationController.viewControllers = @[secondViewController];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
      
    }
    
   else if ( indexPath.row == 1) {
        NewMatchVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMatchVC"];
        navigationController.viewControllers = @[secondViewController];
        
       self.frostedViewController.contentViewController = navigationController;
       [self.frostedViewController hideMenuViewController];
    }
   else if ( indexPath.row == 2) {
       SettingsVC *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
       navigationController.viewControllers = @[secondViewController];
       
       self.frostedViewController.contentViewController = navigationController;
       [self.frostedViewController hideMenuViewController];
   }
   else if ( indexPath.row == 3) {
       [[NSUserDefaults standardUserDefaults] setValue:@"Logout"  forKey:@"LoginOrLogout"];
       
       [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"ArrayInfo"];
       [[NSUserDefaults standardUserDefaults] synchronize];
       [self.frostedViewController hideMenuViewController];

       ViewController *Newnavigationvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
       navigationController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
       [self presentViewController:Newnavigationvc animated:YES completion:nil];
       
       
   }
  

}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    
    
    SlidinghalfCell *cell = (SlidinghalfCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SlidinghalfCell_iPad" owner:self options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (SlidinghalfCell *)currentObject;
                    //	cell=tblCell;
                    break;
                }
            }
        }
        else
        {
            NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SlidinghalfCell" owner:self options:nil];
            
            for(id currentObject in topLevelObjects)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (SlidinghalfCell *)currentObject;
                    //	cell=tblCell;
                    break;
                }
            }
        }
        
        
    }
    
    
    NSArray *titles = @[@"MAP", @"CHATS", @"ACCOUNT SETTINGS",@"LOGOUT"];
    NSArray *titlesimages = @[@"menu-ic-map.png", @"menu-ic-chat.png", @"menu-ic-setting.png",@"menu-ic-logout.png"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.NameTxt.text = titles[indexPath.row];
    cell.image.image=[UIImage imageNamed:titlesimages[indexPath.row]];
    cell.NameTxt.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    
    cell.NameTxt.font=[UIFont fontWithName:@"BebasNeueBook" size:20];
    
    
    return cell;
}


@end

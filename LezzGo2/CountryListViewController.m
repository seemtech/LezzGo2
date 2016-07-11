//
//  CountryListViewController.m
//  Country List
//
//  Created by Pradyumna Doddala on 18/12/13.
//  Copyright (c) 2013 Pradyumna Doddala. All rights reserved.
//

#import "CountryListViewController.h"
#import "CountryCell.h"
#import "WebServices.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "FinalSignupVC.h"
@interface CountryListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataRows;
@end

@implementation CountryListViewController
@synthesize  searchBar, searchDC, searchResult;
#define kCountryNEWName        @"country_name"
#define kCountryNEWCallingCode @"country_code"

-(void)viewWillAppear:(BOOL)animated
{
    // Add keyboard observer:
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}
- (void)keyboardWillAppear:(NSNotification *)notification
{
    [searchBar setShowsCancelButton:NO animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterSearchArray:searchString];
    return YES;
}


- (void)filterSearchArray:(NSString *)searchText
{
    NSPredicate *resultPredicate =  [NSPredicate predicateWithFormat:@"country_name contains[c] %@", searchText];
    searchResult = [self.dataRows filteredArrayUsingPredicate:resultPredicate];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil delegate:(id)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        _delegate = delegate;
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad
{
   // [self setNeedsStatusBarAppearanceUpdate];
    
    delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    getindex=@"0";
    searchFlag=FALSE;
    
    // Instantiate the search bar
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 63.0, self.view.frame.size.width, 44.0)];
    [self.view addSubview:searchBar];
    
    // Instantiate the search display controller and set the delegate and such
    searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDC.searchResultsDataSource = self;
    searchDC.searchResultsDelegate = self;
    searchDC.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self CountryApi];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource
-(void)CountryApi
{
    NSDictionary *params;
    [SVProgressHUD showWithStatus:@"Fetching Countries..."];
    params = @{@"action":@"country"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:kServerurl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD dismiss];
            NSArray *parsedObject=[responseObject objectForKey:@"show"];
            _dataRows = parsedObject;
            [_tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD dismiss];
    }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"value of search result=%@",searchResult);
    
    //NSLog(@"value of search data rows =%@",self.dataRows);
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searchFlag=TRUE;
        return [searchResult count];
        
    }
    else
    {
        searchFlag=FALSE;
        
        return [self.dataRows count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[CountryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    
    // Check if we're in search mode. If we are, return the result rows
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //NSLog(@"value of search result=%@",searchResult);
        
        cell.textLabel.text = [[searchResult objectAtIndex:indexPath.row] valueForKey:kCountryNEWName];
        cell.detailTextLabel.text = [[searchResult objectAtIndex:indexPath.row] valueForKey:kCountryNEWCallingCode];
        ;
    }
    else
    {
        cell.textLabel.text = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryNEWName];
      //  cell.detailTextLabel.text = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryCallingCode];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryNEWCallingCode]];
        ;
    }
    
    
    
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    getindex=[NSString stringWithFormat:@"%li",(long)indexPath.row];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        //NSLog(@"value of search result=%@",searchResult);
       // cell.textLabel.text = [[searchResult objectAtIndex:indexPath.row] valueForKey:kCountryName];
        delegate.countrycode = [[searchResult objectAtIndex:indexPath.row] valueForKey:kCountryNEWCallingCode];
        ;
    }
    else
    {
        //cell.textLabel.text = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryName];
        delegate.countrycode = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryNEWCallingCode];
    }
    NSLog(@"delegate.countryCode...%@",delegate.countrycode);
}
#pragma mark -
#pragma mark Actions

- (IBAction)done:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didSelectCountry:)]) {
        
        //NSLog(@"value of done index=%@",[NSString stringWithFormat:@"%@",getindex]);
        
        NSInteger newindex=[getindex integerValue];
        
        ////NSLog(@"value of index=%@",[NSString stringWithFormat:@"%d",);
        if (searchFlag==TRUE) {
            if ([searchResult count]==0) {
                
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Search Data" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//                [alert show];
//                
            }
            else
            {
            [self.delegate didSelectCountry:[searchResult objectAtIndex:newindex]];
            }
            
        }
        else if(searchFlag==FALSE)
        {
            [self.delegate didSelectCountry:[_dataRows objectAtIndex:newindex]];
        }
        
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        
        NSLog(@"shuiab");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)Cancal:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

//
//  CountryListViewController.h
//  Country List
//
//  Created by Pradyumna Doddala on 18/12/13.
//  Copyright (c) 2013 Pradyumna Doddala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol CountryListViewDelegate <NSObject>
- (void)didSelectCountry:(NSDictionary *)country;
@end
@interface CountryListViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UISearchBar *searchBar;
    UISearchDisplayController *searchDC;
    NSArray *searchResults;
    BOOL searchFlag;
    NSString *getindex;
    AppDelegate *delegate;
}
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchDC;
@property (nonatomic, retain) NSArray *searchResult;
- (void)filterSearchArray:(NSString *)searchText;
- (IBAction)done:(id)sender;
- (IBAction)Cancal:(id)sender;
@property (nonatomic, assign) id<CountryListViewDelegate>delegate;
-(id)initWithNibName:(NSString *)nibNameOrNil delegate:(id)delegate;
@end

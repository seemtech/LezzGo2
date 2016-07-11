//
//  HomeCell.m
//  RealStateApp
//
//  Created by versha on 12/17/12.
//  Copyright (c) 2012 versha. All rights reserved.
//

#import "SlidinghalfCell.h"

@interface SlidinghalfCell ()

@end

@implementation SlidinghalfCell

@synthesize NameTxt,image,sliderimage;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self) {
    
 // Custom initialization.
 }
 return self;
 }


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


-(void)setName:(NSString *)_text{
	
	NameTxt.text=_text;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */



- (void)dealloc {
    //[super dealloc];
}


@end
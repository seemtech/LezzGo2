//
//  RateView.m
//  CustomView
//
//  Created by Ray Wenderlich on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeaderVC.h"

@implementation HeaderVC

@synthesize LeftBtn = _LeftBtn;
@synthesize headerlbl = _headerlbl;
@synthesize msgstr = _msgstr;
@synthesize delegate = _delegate;

- (void)baseInit {

    _delegate = nil;    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    delegateappnew=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    self.userInteractionEnabled = true;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *backimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 375, 63)];
    backimage.image=[UIImage imageNamed:@"headerbg.png"];
    
    backimage.userInteractionEnabled=true;
    
    
    if(delegateappnew.userid.length!=0&&delegateappnew.showlefticon==0)
    {
        _LeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_LeftBtn setFrame:CGRectMake(2, 17, 45, 45)];
        [_LeftBtn setTag:1];
        [_LeftBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_LeftBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        _LeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"header-menu.png"] forState:UIControlStateNormal];
        
        [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"header-menu.png"] forState:UIControlStateSelected];
        [_LeftBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [backimage addSubview:_LeftBtn];
    }
  
    else
    {
        _LeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_LeftBtn setFrame:CGRectMake(2, 17, 45, 45)];
        [_LeftBtn setTag:1];
        [_LeftBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_LeftBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        _LeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"header-bt-back.png"] forState:UIControlStateNormal];
        
        [_LeftBtn setBackgroundImage:[UIImage imageNamed:@"header-bt-back.png"] forState:UIControlStateSelected];
        [_LeftBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [backimage addSubview:_LeftBtn];
    }
    
    
    _headerlbl =[[UILabel alloc]initWithFrame:CGRectMake(70, 22,200,35)];
    _headerlbl.textAlignment=NSTextAlignmentCenter;
    _headerlbl.text=_msgstr;
    _headerlbl.font=[UIFont fontWithName:@"BebasNeueBold" size:20];
    _headerlbl.textColor=[UIColor colorWithRed:140.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
    [backimage addSubview:_headerlbl];
    
    
    [self addSubview:backimage];
    
}

- (void)buttonClickAction:(id)sender
{
    [self.delegate gotobackclick];
}
@end

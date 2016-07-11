//
// MSMenuView.m
// MSMenuView
//
// Copyright (c) 2013 Selvam Manickam (https://github.com/selvam4274)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "MSMenuView.h"

@implementation MSMenuView
@synthesize delegatemenu = _delegatemenu;

@synthesize  MapBtn,MyProfileBtn,CameraBtn,selecttag,FriendsBtn,NewsBtn,msglbl;

- (void)baseInit {
    
    _delegatemenu = nil;
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
    //    [self changeColor];
    self.userInteractionEnabled = YES;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        CGRect frame1=CGRectMake( self.frame.origin.x,  self.frame.origin.y, 768, 110);
        
    }
    else
    {
        CGRect frame1=CGRectMake( self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 53);
    }
        arrayimage=[[NSMutableArray alloc]initWithObjects:@"tab-map.png",@"tab-myprofile.png",@"tab-eagle.png",@"tab-news.png",@"tab-friends.png", nil];
        arrayimageselected=[[NSMutableArray alloc]initWithObjects:@"tab-map-active.png",@"tab-myprofile-active.png",@"tab-eagle.png",@"tab-news-active.png",@"tab-friends-active.png", nil];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            
            [self setBackgroundColor:[UIColor clearColor]];
            
            MapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [MapBtn setFrame:CGRectMake(0, 0, 156, 110)];
            [MapBtn setTag:1];
            [MapBtn setBackgroundColor:[UIColor clearColor]];
            [MapBtn setTintColor:[UIColor clearColor]];

            [MapBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
            [MapBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            MapBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [MapBtn setBackgroundImage:[UIImage imageNamed:@"tab-map.png"] forState:UIControlStateNormal];
            [MapBtn setBackgroundImage:[UIImage imageNamed:@"tab-map-active.png"] forState:UIControlStateSelected];
            [MapBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:MapBtn];
            
            MyProfileBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [MyProfileBtn setFrame:CGRectMake(156, 0, 153, 110)];
            [MyProfileBtn setTag:2];
            [MyProfileBtn setBackgroundColor:[UIColor clearColor]];
            [MyProfileBtn setTintColor:[UIColor clearColor]];

            [MyProfileBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
            [MyProfileBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            MyProfileBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [MyProfileBtn setBackgroundImage:[UIImage imageNamed:@"tab-myprofile.png"] forState:UIControlStateNormal];
            [MyProfileBtn setBackgroundImage:[UIImage imageNamed:@"tab-myprofile-active.png"] forState:UIControlStateSelected];
            [MyProfileBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:MyProfileBtn];
            
            CameraBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [CameraBtn setFrame:CGRectMake(309, 0, 153, 110)];
            [CameraBtn setTag:3];
            [CameraBtn setBackgroundColor:[UIColor clearColor]];
            [CameraBtn setTintColor:[UIColor clearColor]];

            [CameraBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
            [CameraBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            CameraBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
            [CameraBtn setBackgroundImage:[UIImage imageNamed:@"tab-eagle.png"] forState:UIControlStateNormal];
            [CameraBtn setBackgroundImage:[UIImage imageNamed:@"tab-eagle.png"] forState:UIControlStateSelected];
            [CameraBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:CameraBtn];
            
            NewsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [NewsBtn setFrame:CGRectMake(462, 0, 153, 110)];
            [NewsBtn setTag:4];
            [NewsBtn setBackgroundColor:[UIColor clearColor]];
            [NewsBtn setTintColor:[UIColor clearColor]];

            [NewsBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
            [NewsBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            NewsBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [NewsBtn setBackgroundImage:[UIImage imageNamed:@"tab-news.png"] forState:UIControlStateNormal];
            [NewsBtn setBackgroundImage:[UIImage imageNamed:@"tab-news-active.png"] forState:UIControlStateSelected];
            [NewsBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:NewsBtn];
            
            
            FriendsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [FriendsBtn setFrame:CGRectMake(615, 0, 153, 110)];
            [FriendsBtn setTag:5];
            [FriendsBtn setBackgroundColor:[UIColor clearColor]];
            [FriendsBtn setTintColor:[UIColor clearColor]];

            [FriendsBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
            [FriendsBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            FriendsBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [FriendsBtn setBackgroundImage:[UIImage imageNamed:@"tab-friends.png"] forState:UIControlStateNormal];
            [FriendsBtn setBackgroundImage:[UIImage imageNamed:@"tab-friends-active.png"] forState:UIControlStateSelected];
            [FriendsBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];

            
            //            if(delegateapp.msgcount==NULL)
            //            {
            //
            //            }
            //            else  if([delegateapp.msgcount isEqualToString:@"0"])
            //
            //            {
            //
            //            }
            //            else
            //            {
            //
            //                msglbl = [[UILabel alloc] initWithFrame:CGRectMake(MoreBtn.frame.size.width/2,12, 60,60)];
            //                msglbl.layer.cornerRadius=msglbl.frame.size.width/2;
            //                msglbl.layer.masksToBounds=YES;
            //                [msglbl setFont:[UIFont boldSystemFontOfSize:20.0]];
            //                [msglbl setTextColor:[UIColor whiteColor]];
            //                [msglbl setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Comment-Box-Bg.png"]]];
            //                msglbl.textAlignment=UITextAlignmentCenter;
            //                [msglbl setText:delegateapp.msgcount];
            //                [MoreBtn addSubview:msglbl];
            //
            //            }
            [self addSubview:FriendsBtn];
            
            
            
            
        }
        else
        {
            
            
            
            
            [self setBackgroundColor:[UIColor clearColor]];
            
            MapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [MapBtn setFrame:CGRectMake(0, 0, 64, 53)];
            [MapBtn setTag:1];
            [MapBtn setTintColor:[UIColor clearColor]];
            [MapBtn setBackgroundColor:[UIColor clearColor]];

            [MapBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [MapBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            MapBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [MapBtn setBackgroundImage:[UIImage imageNamed:[arrayimage objectAtIndex:0]] forState:UIControlStateNormal];
            [MapBtn setBackgroundImage:[UIImage imageNamed:[arrayimageselected objectAtIndex:0]] forState:UIControlStateSelected];
            [MapBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:MapBtn];
            
            MyProfileBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [MyProfileBtn setFrame:CGRectMake(64, 0, 64, 53)];
            [MyProfileBtn setTag:2];
            [MyProfileBtn setBackgroundColor:[UIColor clearColor]];
            [MyProfileBtn setTintColor:[UIColor clearColor]];

            [MyProfileBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [MyProfileBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            MyProfileBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [MyProfileBtn setBackgroundImage:[UIImage imageNamed:[arrayimage objectAtIndex:1]] forState:UIControlStateNormal];
            [MyProfileBtn setBackgroundImage:[UIImage imageNamed:[arrayimageselected objectAtIndex:1]] forState:UIControlStateSelected];
            [MyProfileBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:MyProfileBtn];
            
            CameraBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [CameraBtn setFrame:CGRectMake(128, -11, 64, 64)];
            [CameraBtn setTag:3];
            [CameraBtn setBackgroundColor:[UIColor clearColor]];
            [CameraBtn setTintColor:[UIColor clearColor]];

            [CameraBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [CameraBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            CameraBtn.contentEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0);
            [CameraBtn setBackgroundImage:[UIImage imageNamed:[arrayimage objectAtIndex:2]] forState:UIControlStateNormal];
            
            [CameraBtn setBackgroundImage:[UIImage imageNamed:[arrayimageselected objectAtIndex:2]] forState:UIControlStateSelected];
            [CameraBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:CameraBtn];
            
            NewsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [NewsBtn setFrame:CGRectMake(192, 0, 64, 53)];
            [NewsBtn setTag:4];
            [NewsBtn setBackgroundColor:[UIColor clearColor]];

            [NewsBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [NewsBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            NewsBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [NewsBtn setBackgroundImage:[UIImage imageNamed:[arrayimage objectAtIndex:3]] forState:UIControlStateNormal];
            [NewsBtn setBackgroundImage:[UIImage imageNamed:[arrayimageselected objectAtIndex:3]] forState:UIControlStateSelected];
            [NewsBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:NewsBtn];
            
            
            FriendsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [FriendsBtn setFrame:CGRectMake(256, 0, 64, 53)];
            [FriendsBtn setTag:5];
            [FriendsBtn setBackgroundColor:[UIColor clearColor]];
            [FriendsBtn setTintColor:[UIColor clearColor]];

            [FriendsBtn setBackgroundColor:[UIColor clearColor]];
            [FriendsBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [FriendsBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
            FriendsBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [FriendsBtn setBackgroundImage:[UIImage imageNamed:[arrayimage objectAtIndex:4]] forState:UIControlStateNormal];
            [FriendsBtn setBackgroundImage:[UIImage imageNamed:[arrayimageselected objectAtIndex:4]] forState:UIControlStateSelected];
            [FriendsBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            //            NSLog(@"%@msgcount",delegateapp.msgcount);
            //            if(delegateapp.msgcount==NULL)
            //            {
            //
            //            }
            //            else   if([delegateapp.msgcount isEqualToString:@"0"])
            //
            //            {
            //
            //            }
            //            else
            //            {
            //
            //                msglbl = [[UILabel alloc] initWithFrame:CGRectMake(MoreBtn.frame.size.width/2,6, 30,30)];
            //                msglbl.layer.cornerRadius=msglbl.frame.size.width/2;
            //                msglbl.layer.masksToBounds=YES;
            //                [msglbl setFont:[UIFont boldSystemFontOfSize:12.0]];
            //                [msglbl setTextColor:[UIColor whiteColor]];
            //                [msglbl setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Comment-Box-Bg.png"]]];
            //                msglbl.textAlignment=UITextAlignmentCenter;
            //                [msglbl setText:delegateapp.msgcount];
            //                [MoreBtn addSubview:msglbl];
            //
            //
            //            }
            [self addSubview:FriendsBtn];
            
            
            
            
            
            
            
            
        
        
    }
    [self checkselectbutton];

}
-(void)checkselectbutton{
    
    if (selecttag==1) {
        
        MapBtn.selected=YES;
        
        MyProfileBtn.selected=NO;
        CameraBtn.selected=NO;
        NewsBtn.selected=NO;
        FriendsBtn.selected=NO;
    }
    else if (selecttag==2) {
        MyProfileBtn.selected=YES;
        MapBtn.selected=NO;
        CameraBtn.selected=NO;
        NewsBtn.selected=NO;
        FriendsBtn.selected=NO;

    }
    else if (selecttag==3) {
        
        CameraBtn.selected=YES;
        MyProfileBtn.selected=NO;
        MapBtn.selected=NO;
        NewsBtn.selected=NO;
        FriendsBtn.selected=NO;
    }
    else if (selecttag==4) {
        
        NewsBtn.selected=YES;
        MyProfileBtn.selected=NO;
        MapBtn.selected=NO;
        CameraBtn.selected=NO;
        FriendsBtn.selected=NO;
    }
    else if (selecttag==5) {
        
        FriendsBtn.selected=YES;
        MyProfileBtn.selected=NO;
        MapBtn.selected=NO;
        NewsBtn.selected=NO;
        CameraBtn.selected=NO;
    }

}
//Need to add tag
-(void)checkSelectedBtn:(UIButton *)sender{
    int buttonTag=sender.tag;
    
    if (MapBtn.selected && MapBtn.tag!=buttonTag) {
      
        MapBtn.selected=NO;
        
        
    }
    else if (MyProfileBtn.selected && MyProfileBtn.tag!=buttonTag) {
                MyProfileBtn.selected=NO;
    }
   else if (CameraBtn.selected && CameraBtn.tag!=buttonTag) {
     
       CameraBtn.selected=NO;
    }
   else if (NewsBtn.selected && NewsBtn.tag!=buttonTag) {
      
       NewsBtn.selected=NO;
   }
   else if (FriendsBtn.selected &&FriendsBtn.tag!=buttonTag) {
       
       FriendsBtn.selected=NO;
   }

}
-(void)callButtonAction:(UIButton *)sender{
    int value=sender.tag;
    if (value==1) {
        [_delegatemenu MapBtnClick];
    }
    if (value==2) {
        [self.delegatemenu MyProfileBtnClick];
      }
    if (value==3) {
        [self.delegatemenu CameraBtnClick];
    }
    if (value==4) {
        [self.delegatemenu NewsBtnClick];
    }
    if (value==5) {
        [self.delegatemenu FriendsBtnClick];
     }
}

-(void)buttonClickAction:(id)sender{
        UIButton *btn=(UIButton *)sender;
    
            btn.selected=YES;
            [self checkSelectedBtn:btn];
            [self  callButtonAction:btn];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

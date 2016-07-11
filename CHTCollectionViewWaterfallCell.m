//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"

@implementation CHTCollectionViewWaterfallCell

#pragma mark - Accessors
- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height-30)];
      _imageView.tag=121;

    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //_imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  return _imageView;
}
- (UILabel *)Newsfeedtextlbl {
    if (!_Newsfeedtextlbl) {
        _Newsfeedtextlbl = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.size.height-30, self.contentView.frame.size.width, 30)];
        _Newsfeedtextlbl.numberOfLines=2;
        _Newsfeedtextlbl.backgroundColor=[UIColor whiteColor];
        _Newsfeedtextlbl.font=[UIFont fontWithName:@"BebasNeueBook" size:16];
        _Newsfeedtextlbl.textColor=[UIColor colorWithRed:147.0/255.0 green:149.0/255.0 blue:152.0/255.0 alpha:1.0];
        _Newsfeedtextlbl.tag=123;
        _Newsfeedtextlbl.textAlignment=NSTextAlignmentCenter;
        _Newsfeedtextlbl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //_imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _Newsfeedtextlbl;
}
- (UIButton *)deletebtn
{
    if (!_deletebtn) {
        _deletebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deletebtn setFrame:CGRectMake(self.contentView.frame.size.width-30, self.contentView.frame.origin.y+5, 24, 24)];
        _deletebtn.tag=122;
        _deletebtn.backgroundColor=[UIColor clearColor];
        _deletebtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_deletebtn setBackgroundImage:[UIImage imageNamed:@"ic-dislike.png"] forState:UIControlStateNormal];
        [_deletebtn setBackgroundImage:[UIImage imageNamed:@"ic-dislike.png"] forState:UIControlStateSelected];
        [_deletebtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        //_imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _deletebtn;
}
-(void)buttonClickAction:(id)sender
{
    
}
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
     
//      [[self.contentView viewWithTag:121] removeFromSuperview];
//      [[self.contentView viewWithTag:122] removeFromSuperview];
//      [[self.contentView viewWithTag:123] removeFromSuperview];
//      [self.contentView clearsContextBeforeDrawing];
      [self.contentView addSubview:self.Newsfeedtextlbl];
      [self.imageView addSubview:self.deletebtn];
      [self.contentView addSubview:self.imageView];


  }
  return self;
}

@end

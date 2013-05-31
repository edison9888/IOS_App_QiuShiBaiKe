//
//  ContentCell.m
//  NetDemo
//
//  Created by Michael on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContentCell.h"

#import "CommentsView.h"
#import "PhotoViewer.h"
#import "MyNavigationView.h"

#define FGOOD       101
#define FBAD        102
#define FCOMMITE    103
#define FSave       104


@interface ContentCell()
-(void) BtnClicked:(id)sender;
-(void) ImageBtnClicked:(id)sender;
@end;

@implementation ContentCell
@synthesize txtContentLabel,txtAnchor,headPhotoImageView,footView,centerimageView,TagPhoto;
@synthesize commentsbtn,badbtn,goodbtn,imgUrl,txtTag,txtTime;
@synthesize imgPhoto,imgMidUrl;
@synthesize photoview = _photoview;
@synthesize saveBtn = _saveBtn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
//        NSLog(@"init ContentCell");

        UIImage *centerimage = [UIImage imageNamed:@"block_center_background.png"];
        centerimageView = [[UIImageView alloc]initWithImage:centerimage];
        [centerimageView setFrame:CGRectMake(0, 0, 320, 220)];
        [self addSubview:centerimageView];
 
        
        txtContentLabel = [[UILabel alloc]init];
        [txtContentLabel setBackgroundColor:[UIColor clearColor]];
        [txtContentLabel setFrame:CGRectMake(20, 10, 280, 220)];
        [txtContentLabel setFont:[UIFont fontWithName:@"微软雅黑" size:14]];
        [txtContentLabel setLineBreakMode:UILineBreakModeTailTruncation];
        [self addSubview:txtContentLabel];
    
        imgPhoto = [[EGOImageButton alloc]initWithPlaceholderImage:[UIImage imageNamed:@"thumb_pic.png"] delegate:self];
        [imgPhoto setFrame:CGRectMake(0, 0, 0, 0)];
       
        [imgPhoto addTarget:self action:@selector(ImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];        
        [self addSubview:imgPhoto];
        
        headPhotoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 24, 24)];
        [headPhotoImageView setImage:[UIImage imageNamed:@"thumb_avatar.png"]];
        [self addSubview:headPhotoImageView];
    
        txtAnchor = [[UILabel alloc]initWithFrame:CGRectMake(45,5, 240-45, 30)];
        [txtAnchor setText:@"匿名"];
        [txtAnchor setFont:[UIFont fontWithName:@"微软雅黑" size:14]];
        [txtAnchor setBackgroundColor:[UIColor clearColor]];
        [txtAnchor setTextColor:[UIColor brownColor]];
        [self addSubview:txtAnchor];
        
        //发布时间
        txtTime = [[UILabel alloc]initWithFrame:CGRectMake(240, 5, 90, 32)];
//        [txtTime setText:@"12-08-14 10:06"];
        [txtTime setFont:[UIFont fontWithName:@"微软雅黑" size:10]];
        [txtTime setBackgroundColor:[UIColor clearColor]];
        [txtTime setTextColor:[UIColor brownColor]];
        [self addSubview:txtTime];

        
        
        txtTag = [[UILabel alloc]initWithFrame:CGRectMake(45,200, 200, 30)];
        [txtTag setText:@""];
        [txtTag setFont:[UIFont fontWithName:@"微软雅黑" size:14]];
        [txtTag setBackgroundColor:[UIColor clearColor]];
        [txtTag setTextColor:[UIColor brownColor]];
        [self addSubview:txtTag];
        
        TagPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(15, 200, 24, 24)];
        [TagPhoto setImage:[UIImage imageNamed:@"icon_tag.png"]];
        [self addSubview:TagPhoto];
        
        UIImage *footimage = [UIImage imageNamed:@"block_foot_background.png"];
        footView = [[UIImageView alloc]initWithImage:footimage];
        [footView setFrame:CGRectMake(0, txtContentLabel.frame.size.height, 320, 15)];
        [self addSubview:footView];
       
        //添加Button，顶，踩，评论  
        goodbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [goodbtn setFrame:CGRectMake(10,txtContentLabel.frame.size.height-30,70,32)];
        [goodbtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [goodbtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [goodbtn setImage:[UIImage imageNamed:@"icon_for_good.png"] forState:UIControlStateNormal];
        [goodbtn setImageEdgeInsets:UIEdgeInsetsMake(0, .5, 0, 0)];
        [goodbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        [goodbtn setTitle:@"0" forState:UIControlStateNormal];
        [goodbtn.titleLabel setFont:[UIFont fontWithName:@"微软雅黑" size:14]];
        [goodbtn.titleLabel setTextAlignment:UITextAlignmentRight];
        [goodbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [goodbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goodbtn];
        
        badbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [badbtn setFrame:CGRectMake(90,txtContentLabel.frame.size.height-30,70,32)];
        [badbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        [badbtn setImageEdgeInsets:UIEdgeInsetsMake(0, .5, 0, 0)];
        [badbtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [badbtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [badbtn setImage:[UIImage imageNamed:@"icon_for_bad.png"] forState:UIControlStateNormal];
        [badbtn setTitle:@"0" forState:UIControlStateNormal];
        [badbtn.titleLabel setFont:[UIFont fontWithName:@"微软雅黑" size:14]];
        [badbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [badbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:badbtn];
        
        commentsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentsbtn setFrame:CGRectMake(170,txtContentLabel.frame.size.height-30,70,32)];
        [commentsbtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [commentsbtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [commentsbtn setImage:[UIImage imageNamed:@"icon_for_comment.png"] forState:UIControlStateNormal];
        [commentsbtn setImageEdgeInsets:UIEdgeInsetsMake(0, .5, 0, 0)];
        [commentsbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        [commentsbtn.titleLabel setFont:[UIFont fontWithName:@"微软雅黑" size:14]];
        [commentsbtn setTitle:@"0" forState:UIControlStateNormal];
        [commentsbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [commentsbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [commentsbtn setTag:FCOMMITE];
        [self addSubview:commentsbtn];
     
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setFrame:CGRectMake(260,txtContentLabel.frame.size.height-30,25,25)];
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"button_vote.png"] forState:UIControlStateNormal];
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"button_vote_active.png"] forState:UIControlStateHighlighted];
        [_saveBtn setImage:[UIImage imageNamed:@"button_save.png"] forState:UIControlStateNormal];
        [_saveBtn setTag:FSave];
        [self addSubview:_saveBtn];
    }
    return self;
}


//自适应高度
-(void) resizeTheHeight:(int)type
{
    
    //内容高度自适应
    UIFont *font = [UIFont fontWithName:@"微软雅黑" size:14];
    //宽度280
    CGFloat contentWidth = 280;
    //计算高度
    CGSize contentSize = CGSizeMake(0, 0);
    if (type == kTypeMain)
    {
        contentSize = [txtContentLabel.text sizeWithFont:font
                           constrainedToSize:CGSizeMake(contentWidth, 220)
                               lineBreakMode:UILineBreakModeTailTruncation];
        NSLog(@"kTypeMain高度=%f",contentSize.height);
    }else if (type == kTypeContent)
    {
        contentSize = [txtContentLabel.text sizeWithFont:font
                           constrainedToSize:CGSizeMake(contentWidth, (txtContentLabel.text.length * 14 * 0.05 + 1 ) * 14) lineBreakMode:UILineBreakModeTailTruncation];
        NSLog(@"kTypeContent高度=%f",contentSize.height);
    }
    
    
    [txtContentLabel setFrame:CGRectMake(20, 10, contentWidth, contentSize.height+60)];
    
    if (imgUrl!=nil&&![imgUrl isEqualToString:@""]) {
       [imgPhoto setFrame:CGRectMake(30, contentSize.height+70, 72, 72)];
       [centerimageView setFrame:CGRectMake(0, 0, 320, contentSize.height+200)];
       [imgPhoto setImageURL:[NSURL URLWithString:imgUrl]];
       [self imageButtonLoadedImage:imgPhoto];
    }
    else
    {
        [imgPhoto cancelImageLoad];
        [imgPhoto setFrame:CGRectMake(120, contentSize.height, 0, 0)];
        [centerimageView setFrame:CGRectMake(0, 0, 320, contentSize.height+120)];
    }
    
    [footView setFrame:CGRectMake(0, centerimageView.frame.size.height, 320, 15)];
    [goodbtn setFrame:CGRectMake(10,centerimageView.frame.size.height-28,70,32)];
    [badbtn setFrame:CGRectMake(90,centerimageView.frame.size.height-28,70,32)];
    [commentsbtn setFrame:CGRectMake(170,centerimageView.frame.size.height-28,70,32)];
    [_saveBtn setFrame:CGRectMake(260, centerimageView.frame.size.height-28, 25, 25)];
    [txtTag setFrame:CGRectMake(40,centerimageView.frame.size.height-50,200, 30)];
    [TagPhoto setFrame:CGRectMake(15,centerimageView.frame.size.height-50,24, 24)];
    
}

-(void) ImageBtnClicked:(id)sender
{
    
    
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    _photoview = [[PhotoViewer alloc]initWithNibName:@"PhotoViewer" bundle:nil];
    _photoview.imgUrl = self.imgMidUrl;
    DLog(@"self.imgMidUrl:%@",self.imgMidUrl);
    _photoview.placeholderImage = [[self.imgPhoto imageView] image];
    [[delegate navController] presentModalViewController:_photoview animated:YES];


    
    
}

-(void) BtnClicked:(id)sender
{
    UIButton *btn =(UIButton *) sender;
    switch (btn.tag) {
        case FGOOD:    //顶
        {
            
        }break;
        case FBAD:     //踩 
        {
            
        }break;
        case FCOMMITE: //评论 
        {
            
       
        }break;
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - delegate

- (void)imageButtonLoadedImage:(EGOImageButton*)imageButton
{
     // NSLog(@" Did finish load %@",imgUrl);
    UIImage *image = imageButton.imageView.image;
    CGFloat w = 1.0f;
    CGFloat h = 1.0f;
    if (image.size.width>280) {
        w = image.size.width/280;
    }
    if (image.size.height>72) {
        h = image.size.height/72;
    }
    CGFloat scole = w>h ? w:h;
    
    CGRect rect = CGRectMake(30 ,imageButton.frame.origin.y,image.size.width/scole,image.size.height/scole);
    [imgPhoto setFrame:rect];
   
}

- (void)imageButtonFailedToLoadImage:(EGOImageButton*)imageButton error:(NSError*)error;
{
    [imageButton cancelImageLoad];
    //NSLog(@"Failed to load %@", imgUrl);
}

- (void)dealloc
{
    _photoview = nil;
//    NSLog(@"dealloc ContentCell");
}

#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif

@end

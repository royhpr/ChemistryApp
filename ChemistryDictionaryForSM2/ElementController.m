//
//  ElementController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 23/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ElementController.h"

@interface ElementController ()

@end

@implementation ElementController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setElementDetails:(NSString*)newElementEnglish : (NSString*)newElementChinese : (NSString*)newPhanetic : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese
{
    _elementEnglish = newElementEnglish;
    _elementChinese = newElementChinese;
    _phanetic = newPhanetic;
    _pinyin = newPinyin;
    _descriptionEnglish = newDescriptionEnglish;
    _descriptionChinese = newDescriptionChinese;
}

-(void)setViewTitle:(NSString*)title
{
    _currentTitle = title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    UIView* rightItems = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 40)];
    rightItems.userInteractionEnabled = YES;
    
    //back
    UIImageView* backView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backView.frame=CGRectMake(0, 0, 40, 40);
    backView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToChapter)];
    [singleTapBack setNumberOfTapsRequired:1];
    [backView addGestureRecognizer:singleTapBack];
    
    //home
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(45, 0, 40, 40);
    homeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToMain)];
    [singleTapHome setNumberOfTapsRequired:1];
    [homeView addGestureRecognizer:singleTapHome];
    
    //add to view items
    [rightItems addSubview:backView];
    [rightItems addSubview:homeView];
    
    UIBarButtonItem* navButton = [[UIBarButtonItem alloc]initWithCustomView:rightItems];
    self.navigationItem.rightBarButtonItem = navButton;
    
    [self initializeViewComponents];
}

-(void)initializeViewComponents
{
    _elementInChinese = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, ELEMENT_START_POSITION_Y, ELEMENT_WIDTH, ELEMENT_HEIGHT)];
    NSMutableString* chineseLabelText = [[NSMutableString alloc]initWithString:self.elementChinese];
    [chineseLabelText appendString:NEW_LINE];
    [chineseLabelText appendString:self.pinyin];
    _elementInChinese.text = chineseLabelText;
    _elementInChinese.font = [UIFont boldSystemFontOfSize:ELEMENT_VIEW_BODY_FONT_SIZE];
    _elementInChinese.numberOfLines = 0;
    [_elementInChinese setTextAlignment:NSTextAlignmentCenter];
    [_elementInChinese sizeToFit];
    
    _elementInEnglish = [[UILabel alloc]initWithFrame:CGRectMake(_elementInChinese.frame.origin.x + _elementInChinese.frame.size.width + ELEMENT_COMPONENT_GAP, ELEMENT_START_POSITION_Y, ELEMENT_WIDTH, ELEMENT_HEIGHT)];
    NSMutableString* englishLabelText = [[NSMutableString alloc]initWithString:self.elementEnglish];
    [englishLabelText appendString:NEW_LINE];
    [englishLabelText appendString:self.phanetic];
    _elementInEnglish.text = englishLabelText;
    _elementInEnglish.font = [UIFont boldSystemFontOfSize:ELEMENT_VIEW_BODY_FONT_SIZE];
    _elementInEnglish.numberOfLines = 0;
    [_elementInEnglish setTextAlignment:NSTextAlignmentCenter];
    [_elementInEnglish sizeToFit];
    
    UIImage* image = [UIImage imageNamed:@"chapteraudio"];
    _sound = [[UIImageView alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, ELEMENT_START_POSITION_Y + _elementInChinese.frame.size.height + ELEMENT_COMPONENT_GAP, image.size.width/SCALE_DOWN_FACTOR, image.size.height/SCALE_DOWN_FACTOR)];
    [_sound setImage:image];
    
    _elementDescription = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, _sound.frame.size.height + _sound.frame.origin.y + ELEMENT_COMPONENT_GAP, ELEMENT_DESCRIP_WIDTH, ELEMENT_DESCRIP_HEIGHT)];
    NSMutableString* description = [[NSMutableString alloc]initWithString:self.descriptionEnglish];
    [description appendString:NEW_LINE];
    [description appendString:NEW_LINE];
    [description appendString:self.descriptionChinese];
    _elementDescription.text = description;
    _elementDescription.numberOfLines = 0;
    [_elementDescription setLineBreakMode:NSLineBreakByWordWrapping];
    [_elementDescription setTextAlignment:NSTextAlignmentLeft];
    _elementDescription.font = [UIFont fontWithName:APP_FONT size:ELEMENT_VIEW_BODY_FONT_SIZE];
    [_elementDescription sizeToFit];
    
    [[self view]addSubview:_elementInChinese];
    [[self view]addSubview:_elementInEnglish];
    [[self view]addSubview:_sound];
    [[self view]addSubview:_elementDescription];
}

-(void)goBackToChapter
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goBackToMain
{
    [_delegate returnToMainInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ElementController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 23/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ElementController.h"

@interface ElementController ()

@property(strong,nonatomic) UILabel* elementInChinese;
@property(strong,nonatomic) UILabel* elementPinying;
@property(strong,nonatomic) UILabel* elementInEnglish;
@property(strong,nonatomic) UILabel* elementPhanetic;
@property(strong,nonatomic) UIImageView* sound;
@property(strong,nonatomic) UILabel* elementDescription;

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

-(void)setElementDetails:(NSString*)newElementEnglish : (NSString*)newElementChinese : (NSString*)newPhanetic : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese : (NSString*)newSoundName : (NSString*)imageName
{
    _elementEnglish = newElementEnglish;
    _elementChinese = newElementChinese;
    _phanetic = newPhanetic;
    _pinyin = newPinyin;
    _descriptionEnglish = newDescriptionEnglish;
    _descriptionChinese = newDescriptionChinese;
    _soundName = newSoundName;
    _sketchName = imageName;
}

-(void)setViewTitle:(NSString*)title
{
    _currentTitle = title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [self initializeViewTitle];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.mainScrollView.userInteractionEnabled = YES;
    self.mainScrollView.scrollEnabled = YES;
    [self initializeViewComponents];
}

- (void)initializeViewTitle
{
    //initialize title
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    title.font = [UIFont boldSystemFontOfSize:13.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    title.text = _currentTitle;
    UIBarButtonItem* navButton = [[UIBarButtonItem alloc]initWithCustomView:title];
    self.navigationItem.leftBarButtonItem = navButton;
}

- (void)initializeChinese
{
    //initialize body
    self.elementInChinese = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.mainScrollView.frame.origin.y + ELEMENT_START_POSITION_Y, ELEMENT_WIDTH, ELEMENT_HEIGHT)];
    NSMutableString* chineseLabelText = [[NSMutableString alloc]initWithString:self.elementChinese];
    self.elementInChinese.text = chineseLabelText;
    self.elementInChinese.font = [UIFont boldSystemFontOfSize:18.0];
    self.elementInChinese.numberOfLines = 0;
    [self.elementInChinese setTextAlignment:NSTextAlignmentCenter];
    [self.elementInChinese sizeToFit];
}

-(void)initializePinying
{
    //initialize body
    self.elementPinying = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.elementInChinese.frame.origin.y + self.elementInChinese.frame.size.height, ELEMENT_WIDTH, ELEMENT_HEIGHT)];
    NSMutableString* pinyingLabelText = [[NSMutableString alloc]initWithString:self.pinyin];
    self.elementPinying.text = pinyingLabelText;
    self.elementPinying.font = [UIFont boldSystemFontOfSize:15.0];
    self.elementPinying.numberOfLines = 0;
    [self.elementPinying setTextAlignment:NSTextAlignmentCenter];
    [self.elementPinying sizeToFit];
    
    if(self.elementPinying.frame.size.width > self.elementInChinese.frame.size.width)
    {
        self.elementInChinese.frame = CGRectMake(self.elementInChinese.frame.origin.x + ((self.elementPinying.frame.size.width - self.elementInChinese.frame.size.width)/2), self.elementInChinese.frame.origin.y,self.elementInChinese.frame.size.width,self.elementInChinese.frame.size.height);
    }
}

- (void)initializeEnglish
{
    self.elementInEnglish = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.elementPinying.frame.size.height + self.elementPinying.frame.origin.y + ELEMENT_COMPONENT_GAP, ELEMENT_WIDTH, ELEMENT_HEIGHT)];
    NSMutableString* englishLabelText = [[NSMutableString alloc]initWithString:self.elementEnglish];
    self.elementInEnglish.text = englishLabelText;
    self.elementInEnglish.font = [UIFont boldSystemFontOfSize:18.0];
    self.elementInEnglish.numberOfLines = 0;
    [self.elementInEnglish setTextAlignment:NSTextAlignmentCenter];
    [self.elementInEnglish sizeToFit];
}

-(void)initializePhanetic
{
    //initialize body
    self.elementPhanetic = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.elementInEnglish.frame.origin.y + self.elementInEnglish.frame.size.height, ELEMENT_WIDTH, ELEMENT_HEIGHT)];
    NSMutableString* phaneticLabelText = [[NSMutableString alloc]initWithString:self.phanetic];
    self.elementPhanetic.text = phaneticLabelText;
    self.elementPhanetic.font = [UIFont boldSystemFontOfSize:15.0];
    self.elementPhanetic.numberOfLines = 0;
    [self.elementPhanetic setTextAlignment:NSTextAlignmentCenter];
    [self.elementPhanetic sizeToFit];
    
    if(self.elementInEnglish.frame.size.width > self.elementPhanetic.frame.size.width)
    {
        self.elementPhanetic.frame = CGRectMake(self.elementPhanetic.frame.origin.x + ((self.elementInEnglish.frame.size.width - self.elementPhanetic.frame.size.width)/2), self.elementPhanetic.frame.origin.y, self.elementPhanetic.frame.size.width, self.elementPhanetic.frame.size.height);
    }
}

- (void)initializeSoundImage
{
    UIImage* image = [UIImage imageNamed:@"audiobutton.jpg"];
    self.sound = [[UIImageView alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.mainScrollView.frame.origin.y + ELEMENT_START_POSITION_Y + self.elementInChinese.frame.size.height + ELEMENT_COMPONENT_GAP, image.size.width/SCALE_DOWN_FACTOR, image.size.height/SCALE_DOWN_FACTOR)];
    [self.sound setImage:image];
    self.sound.userInteractionEnabled = YES;
    
    self.sound.frame = CGRectMake(self.view.frame.size.width - self.sound.frame.size.width - ELEMENT_START_POSITION_X,  self.mainScrollView.frame.origin.y + ELEMENT_START_POSITION_Y, self.sound.frame.size.width, self.sound.frame.size.height);
    
    UITapGestureRecognizer* tapToPlaySound = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playSound)];
    tapToPlaySound.numberOfTapsRequired = 1;
    tapToPlaySound.numberOfTouchesRequired = 1;
    
    [self.sound addGestureRecognizer:tapToPlaySound];
}

-(void)playSound
{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURL;
    soundFileURL = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef)self.soundName, CFSTR("mp3"), NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURL, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)initializeDescription
{
    self.elementDescription = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.elementPhanetic.frame.size.height + self.elementPhanetic.frame.origin.y + ELEMENT_COMPONENT_GAP, ELEMENT_DESCRIP_WIDTH, ELEMENT_DESCRIP_HEIGHT)];
    NSMutableString* description = [[NSMutableString alloc]initWithString:self.descriptionEnglish];
    [description appendString:NEW_LINE];
    [description appendString:NEW_LINE];
    [description appendString:self.descriptionChinese];
    self.elementDescription.text = description;
    self.elementDescription.numberOfLines = 0;
    [self.elementDescription setLineBreakMode:NSLineBreakByWordWrapping];
    [self.elementDescription setTextAlignment:NSTextAlignmentLeft];
    self.elementDescription.font = [UIFont systemFontOfSize:16.0];
    [self.elementDescription sizeToFit];
}

-(void)initializeSketch
{
    if(![self.sketchName isEqualToString:@"-"])
    {
        NSMutableString* imageName = [NSMutableString stringWithString:self.sketchName];
        [imageName appendString:@".tiff"];
        UIImage* image = [UIImage imageNamed:imageName];
        float imageWidth = image.size.width / 2.75;
        float imageHeight = image.size.height / 2.75;
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.elementDescription.frame.origin.y+self.elementDescription.frame.size.height + ELEMENT_COMPONENT_GAP, imageWidth, imageHeight)];
        [imageView setImage:image];
        
        [[self mainScrollView]addSubview:imageView];
        self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width, imageView.frame.origin.y + imageView.frame.size.height);
    }
}

-(void)initializeViewComponents
{
    [self initializeChinese];
    [[self mainScrollView]addSubview:self.elementInChinese];
    
    [self initializeSoundImage];
    [[self mainScrollView]addSubview:self.sound];
    
    [self initializePinying];
    [[self mainScrollView]addSubview:self.elementPinying];
    
    [self initializeEnglish];
    [[self mainScrollView]addSubview:self.elementInEnglish];
    
    [self initializePhanetic];
    [[self mainScrollView]addSubview:self.elementPhanetic];
    
    [self initializeDescription];
    [[self mainScrollView]addSubview:self.elementDescription];
    
    [self initializeSketch];
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

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end

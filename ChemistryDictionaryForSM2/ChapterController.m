//
//  ChapterController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ChapterController.h"

@interface ChapterController ()

@property(strong, nonatomic)UITableView* searchResultTableView;

@end

@implementation ChapterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    UITapGestureRecognizer* singleTapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToSyllabus)];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)goBackToMain
{
    [_delegate returnToMainInterface];
}

-(void)goBackToSyllabus
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setChapterNumber: (int)currentChapterNumber
{
    _chapterNumber = currentChapterNumber + 1;
    [self updateCurrentTitle];
}

-(void)updateCurrentTitle
{
    UIView* leftItem = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    title.font = [UIFont boldSystemFontOfSize:13.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    switch (_chapterNumber)
    {
        case 1:
            title.text = CHAPTER_1;
            break;
        case 2:
            title.text = CHAPTER_2;
            break;
        case 3:
            title.text = CHAPTER_3;
            break;
        case 4:
            title.text = CHAPTER_4;
            break;
        case 5:
            title.text = CHAPTER_5;
            break;
        case 6:
            title.text = CHAPTER_6;
            break;
        case 7:
            title.text = CHAPTER_7;
            break;
        case 8:
            title.text = CHAPTER_8;
            break;
        case 9:
            title.text = CHAPTER_9;
            break;
        case 10:
            title.text = CHAPTER_10;
            break;
        case 11:
            title.text = CHAPTER_11;
            break;
        case 12:
            title.text = CHAPTER_12;
            break;
        case 13:
            title.text = CHAPTER_13;
            break;
        case 14:
            title.text = CHAPTER_14;
            break;
        case 15:
            title.text = CHAPTER_15;
            break;
        case 16:
            title.text = CHAPTER_16;
            break;
        case 17:
            title.text = CHAPTER_17;
            break;
            
        default:
            break;
    }
    _currentTitle = title.text;
    [leftItem addSubview:title];
    UIBarButtonItem* navButton = [[UIBarButtonItem alloc]initWithCustomView:leftItem];
    self.navigationItem.leftBarButtonItem = navButton;
}

-(void)populateElementList
{
    _currentChapterElements = [[NSMutableArray alloc]init];
    _database = [NSArray arrayWithArray:[[DictionaryDB database]elementList]];
    
    for(ElementModel* currentElement in _database)
    {
        NSString* number = [NSString stringWithFormat:@"%d",_chapterNumber];
        
        if([number isEqualToString:currentElement.chapter])
        {
            NSMutableString* element = [NSMutableString stringWithString:currentElement.elementEnglish];
            [element appendString:@" "];
            [element appendString:currentElement.elementChinese];
            [_currentChapterElements addObject:element];
        }
    }
    
    if(_currentChapterElements.count != 0)
    {
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [_currentChapterElements sortUsingDescriptors:sortDescriptors];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    _searchResult = (NSMutableArray*)[_currentChapterElements filteredArrayUsingPredicate:resultPredicate];
    
    [self.searchResultTableView reloadData];
}

-(void)returnToMainInterface
{
    [_delegate returnToMainInterface];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchResultTableView)
    {
        return _searchResult.count;
    }
    return _currentChapterElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* element;
    
    if(tableView == self.searchResultTableView)
    {
        element = [_searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        element = [_currentChapterElements objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = element;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchResultTableView)
    {
        _selectedElement = [_searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        _selectedElement = [_currentChapterElements objectAtIndex:indexPath.row];
    }
    
    [self performSegueWithIdentifier:@"FromChapterToElement" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromChapterToElement"])
    {
        ElementController* element = [segue destinationViewController];
        element.delegate = self;
        [self goBackToNormalMode];
        
        for(ElementModel* currentElement in _database)
        {
            NSMutableString* expectedElement = [NSMutableString stringWithString:currentElement.elementEnglish];
            [expectedElement appendString:@" "];
            [expectedElement appendString:currentElement.elementChinese];
            if([currentElement.chapter isEqualToString: [NSString stringWithFormat:@"%d", _chapterNumber]] && [expectedElement isEqualToString:_selectedElement])
            {
                [element setViewTitle:_currentTitle];
                [element setElementDetails:currentElement.elementEnglish :currentElement.elementChinese :currentElement.phanetic :currentElement.pinyin :currentElement.descriptionEnglish :currentElement.descriptionChinese : currentElement.sound : currentElement.sketch];
            }
        }
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.elementSearchBar.showsCancelButton = YES;
    
    if(self.searchResultTableView == nil)
    {
        self.searchResultTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        CGRect frame = self.searchResultTableView.frame;
        frame.origin.x = self.elementSearchBar.frame.origin.x;
        frame.origin.y = self.elementSearchBar.frame.origin.y + self.elementSearchBar.frame.size.height;
        frame.size.width = self.elementListTableView.frame.size.width;
        frame.size.height = self.elementListTableView.frame.size.height;
    
        self.searchResultTableView.frame = frame;
    
        self.searchResultTableView.rowHeight = 44.0;
        self.searchResultTableView.scrollEnabled = YES;
        self.searchResultTableView.showsVerticalScrollIndicator = YES;
        self.searchResultTableView.userInteractionEnabled = YES;
        self.searchResultTableView.bounces = YES;
        self.searchResultTableView.delegate = self;
        self.searchResultTableView.dataSource = self;
        [self.searchResultTableView dequeueReusableCellWithIdentifier:@"Cell"];
    }

    [self.elementListTableView setHidden:YES];
    [self.view addSubview:self.searchResultTableView];
    
    return YES;
}

- (void)goBackToNormalMode
{
    [self.elementSearchBar resignFirstResponder];
    
    _searchResult = [[NSMutableArray alloc]init];
    [self.searchResultTableView reloadData];
    
    [self.searchResultTableView removeFromSuperview];
    [self.elementListTableView setHidden:NO];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self goBackToNormalMode];
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.elementSearchBar.showsCancelButton = NO;
    
    [self.elementSearchBar setText:@""];
    
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self populateElementList];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
    {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    }
    else
    {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    self.searchResultTableView.contentInset = contentInsets;
    self.searchResultTableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, 0);
    self.searchResultTableView.contentInset = edge;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

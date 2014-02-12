//
//  DictionaryController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 4/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "DictionaryController.h"

@interface DictionaryController ()

@property(strong, nonatomic)UITableView* searchResultTableView;

@end

@implementation DictionaryController

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
    
    //set up right item
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(0, 0, 40, 40);
    homeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToMain)];
    [singleTapHome setNumberOfTapsRequired:1];
    [homeView addGestureRecognizer:singleTapHome];
    
    UIBarButtonItem* rightNavButton = [[UIBarButtonItem alloc]initWithCustomView:homeView];
    self.navigationItem.rightBarButtonItem = rightNavButton;
    
    //set up left item
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 260, 60)];
    title.font = [UIFont boldSystemFontOfSize:20.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    title.text = @"Dictionary Search 字典搜索";
    UIBarButtonItem* leftNavButton = [[UIBarButtonItem alloc]initWithCustomView:title];
    self.navigationItem.leftBarButtonItem = leftNavButton;
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)populateElementList
{
    _elementList = [[NSMutableArray alloc]init];
    _database = [NSArray arrayWithArray:[[DictionaryDB database]elementList]];
    
    for(ElementModel* currentElement in _database)
    {
        NSMutableString* chinesePlusEnglish = [NSMutableString stringWithString:currentElement.elementEnglish];
        [chinesePlusEnglish appendString:@" "];
        [chinesePlusEnglish appendString:currentElement.elementChinese];
        
        if(![_elementList containsObject:chinesePlusEnglish])
        [_elementList addObject:chinesePlusEnglish];
    }
    
    if(_elementList.count != 0)
    {
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"" ascending:YES];
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [_elementList sortUsingDescriptors:sortDescriptors];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self populateElementList];
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    _searchResult = (NSMutableArray*)[_elementList filteredArrayUsingPredicate:resultPredicate];
    [self.searchResultTableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    return YES;
}

-(void)returnToMainInterface
{
    [self.delegate returnToMainInterface];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == self.searchResultTableView)
    {
        return _searchResult.count;
    }
    return _elementList.count;
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
        element = [_elementList objectAtIndex:indexPath.row];
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
        _selectedElement = [_elementList objectAtIndex:indexPath.row];
    }

    
    [self performSegueWithIdentifier:@"FromDictionaryToElement" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromDictionaryToElement"])
    {
        ElementController* element = [segue destinationViewController];
        element.delegate = self;
        [self goBackToNormalMode];
        
        for(ElementModel* currentElement in _database)
        {
            NSMutableString* expectedElement = [NSMutableString stringWithString:currentElement.elementEnglish];
            [expectedElement appendString:@" "];
            [expectedElement appendString:currentElement.elementChinese];
            
            if([expectedElement isEqualToString:_selectedElement])
            {
                [element setViewTitle: SEARCH_DIC_LABEL];
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


@end

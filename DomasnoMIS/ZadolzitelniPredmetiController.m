//
//  ZadolzitelniPredmetiController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import "ZadolzitelniPredmetiController.h"
#import "PredmetiDetaliController.h"
#import "PredmetiController.h"

@implementation ZadolzitelniPredmetiController
@synthesize names;
@synthesize keys;
@synthesize zadolzitelni;
@synthesize table;
@synthesize parrent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    names = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
    for(NSDictionary *a in zadolzitelni){
        NSString *semestar = [a objectForKey:@"semestar"];
        NSArray *pre = [a objectForKey:@"predmeti"];
        [names setObject:pre forKey:semestar];
    }
    keys = [[NSMutableArray alloc] initWithArray:[[names allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    table.dataSource = self;
    table.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [keys count]; 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section]; 
    NSArray *nameSection = [names objectForKey:key]; 
    return [nameSection count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    NSUInteger section = [indexPath section]; 
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section]; 
    NSArray *nameSection = [names objectForKey:key];
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier"; 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier]; 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier];
    }
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.text = [[nameSection objectAtIndex:row] objectForKey:@"ime"];
    return cell; 
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    NSString *keyt = [keys objectAtIndex:section];
    NSString *key = [[NSString alloc] initWithFormat:@"Семестар %@",keyt];
    return key;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void) tableView:(UITableView *) tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*PredmetiController *nov = [[PredmetiController alloc] init];
    [self.navigationController pushViewController:nov animated:YES];*/
    PredmetiDetaliController *pr = [[PredmetiDetaliController alloc] init];
    NSUInteger section = [indexPath section]; 
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section]; 
    NSArray *nameSection = [names objectForKey:key];
    pr.title = [[nameSection objectAtIndex:row] objectForKey:@"ime"];
    pr.url = [[nameSection objectAtIndex:row] objectForKey:@"url"];
    pr.idpredmet = [[nameSection objectAtIndex:row] objectForKey:@"id"];
    [parrent pushStack:pr];
    //NSLog(@"%@",self.view.window.rootViewController.parentViewController);
    //[self.navigationController pushViewController:pr animated:YES];
}

@end

//
//  IzborniPredmetiController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import "IzborniPredmetiController.h"
#import "PredmetiDetaliController.h"

@implementation IzborniPredmetiController
@synthesize izborni;
@synthesize table;
@synthesize names;
@synthesize keys;
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
    [super viewDidLoad];
    table.delegate = self;
    table.dataSource = self;
    names = [[NSMutableDictionary alloc] init ];
    // Do any additional setup after loading the view from its nib.
    for(NSDictionary *a in izborni){
        NSString *semestar = [a objectForKey:@"semestar"];
        NSArray *pre = [a objectForKey:@"predmeti"];
        [names setObject:pre forKey:semestar];
    }
    keys = [[NSMutableArray alloc] initWithArray:[[names allKeys] sortedArrayUsingSelector:@selector(compare:)]];
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
    NSString *key;
    if([keys count] != 1){
        key = [[NSString alloc] initWithFormat:@"Семестар %@",keyt];}
    else{
        key = [[NSString alloc] initWithFormat:@"Изборни предмети"];
    }
    return key;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void) tableView:(UITableView *) tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*PredmetiController *nov = [[PredmetiController alloc] init];
     [self.navigationController pushViewController:nov animated:YES];*/
    /*Predmeti *pr = [[Predmeti alloc] init];
    NSUInteger section = [indexPath section]; 
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section]; 
    NSArray *nameSection = [names objectForKey:key];
    pr.title = [[nameSection objectAtIndex:row] objectForKey:@"ime"];
    pr.url = [[nameSection objectAtIndex:row] objectForKey:@"url"];
    pr.idpredmet = [[nameSection objectAtIndex:row] objectForKey:@"id"];
    [self.navigationController pushViewController:pr animated:YES];*/
    PredmetiDetaliController *pr = [[PredmetiDetaliController alloc] init];
    NSUInteger section = [indexPath section]; 
    NSUInteger row = [indexPath row];
    NSString *key = [keys objectAtIndex:section]; 
    NSArray *nameSection = [names objectForKey:key];
    pr.title = [[nameSection objectAtIndex:row] objectForKey:@"ime"];
    pr.url = [[nameSection objectAtIndex:row] objectForKey:@"url"];
    pr.idpredmet = [[nameSection objectAtIndex:row] objectForKey:@"id"];
    [parrent pushStack:pr];
    
}


@end

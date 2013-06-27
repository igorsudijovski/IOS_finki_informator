//
//  StudiskiProgramiFirstController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kBgQueueCelosno dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1


#import "StudiskiProgramiFirstController.h"
#import "PredmetiController.h"

@implementation StudiskiProgramiFirstController
@synthesize tabelaStudii;
@synthesize keys;
@synthesize names;
@synthesize predmeti;
@synthesize loaddata;


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
    /*names = [[NSMutableDictionary alloc] init];
    [names setObject:[NSArray arrayWithObjects:@"nesto1", @"nesto2", @"nesto3", nil] forKey:@"prvo"];
    [names setObject:[NSArray arrayWithObjects:@"nesto4", @"nesto5", @"nesto6", nil] forKey:@"vtoro"];
    predmeti = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *izborni = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *zadolzitelni = [[NSMutableDictionary alloc] init];
    [izborni setObject:[NSArray arrayWithObjects:@"izboren1", @"izboren2", nil] forKey:@"predmeti"];
    [zadolzitelni setObject:[NSArray arrayWithObjects:@"zad1",@"zad2", nil] forKey:@"1 semestar"];
    [zadolzitelni setObject:[NSArray arrayWithObjects:@"zad3",@"zad4", nil] forKey:@"2 semestar"];
    [zadolzitelni setObject:[NSArray arrayWithObjects:@"zad5",@"zad6", nil] forKey:@"3 semestar"];
    [predmeti setObject:izborni forKey:@"izborni"];
    [predmeti setObject:zadolzitelni forKey:@"zadolzitelni"];
    keys = [[NSMutableArray alloc] initWithArray:[names allKeys]];*/
    loaddata = NO;
    names = [[NSMutableDictionary alloc] init ];
    predmeti = [[NSMutableDictionary alloc] init];
    keys = [[NSMutableArray alloc] initWithArray:[names allKeys]];
    dispatch_async(kBgQueue, ^{
        NSURL *url = [NSURL URLWithString:@"http://finkiservices.zzl.org/getStudii.php"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    dispatch_async(kBgQueueCelosno, ^{
        NSURL *url = [NSURL URLWithString:@"http://finkiservices.zzl.org/getAllStudii.php"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedDataAll:) withObject:data waitUntilDone:YES];
    });
    
    // Do any additional setup after loading the view from its nib.
}

-(void) fetchedData:(NSData *) responseData{
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    for(NSDictionary *tmp in json){
        NSArray *ar = [[NSArray alloc] initWithArray:[tmp objectForKey:@"nasoki"]];
        [names setObject:ar forKey:[tmp objectForKey:@"fakultet"]];
    }
    keys = [[NSMutableArray alloc] initWithArray:[names allKeys]];
    [tabelaStudii reloadData];
    
    
}

-(void) fetchedDataAll: (NSData *) responseData{
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    for(NSDictionary *tmp in json){
        NSMutableDictionary *sitepredmeti = [[NSMutableDictionary alloc] init];
        NSArray *jsonzadolzitelni = [tmp objectForKey:@"zadolzitelni"];
        NSArray *jsonizborni = [tmp objectForKey:@"izborni"];
        //NSString *nasoki = [tmpp objectForKey:@"nasoki"];
        /*NSString *tmpcountzad = [[jsonzadolzitelni objectAtIndex:[jsonzadolzitelni count] -1] objectForKey:@"semestar"];
        int length = [tmpcountzad intValue] + 1;
        NSMutableArray *zadolzitelniarray = [[NSMutableArray alloc] initWithCapacity:length];
        tmpcountzad = [jsonizborni objectAtIndex:[jsonizborni count] -1];
        NSMutableArray *izborniarray = [[NSMutableArray alloc] initWithCapacity:[jsonizborni count]];
        for(NSDictionary *semestri in jsonzadolzitelni){
            NSMutableArray *predmetitmp = [[NSMutableArray alloc] init];
            NSString *semStr = [semestri objectForKey:@"semestar"];
            int semestar = [semStr intValue];
            for(NSDictionary *predmet in [semestri objectForKey:@"predmeti"]){
                [predmetitmp addObject:predmet];
            }
            [zadolzitelniarray insertObject:predmetitmp atIndex:semestar - 1];
        }
        for(NSDictionary *semestri in izborniarray){
            NSMutableArray *predmetitmp = [[NSMutableArray alloc] init];
            NSString *semStr = [semestri objectForKey:@"semestar"];
            int semestar = [semStr intValue];
            if(semestar != 0){
                semestar = semestar - 1;
            }
            for(NSDictionary *predmet in [semestri objectForKey:@"predmeti"]){
                [predmetitmp addObject:predmet];
            }
            [izborniarray insertObject:predmetitmp atIndex:semestar];
        }*/
        [sitepredmeti setObject:jsonzadolzitelni forKey:@"zadolzitelni"];
        [sitepredmeti setObject:jsonizborni forKey:@"izborni"];
        NSString *nasoka = [tmp objectForKey:@"nasoka"];
        [predmeti setObject:sitepredmeti forKey:nasoka];
        loaddata = YES;
    }
}

- (void)viewDidUnload
{
    [self setTabelaStudii:nil];
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
    cell.textLabel.text = [nameSection objectAtIndex:row];
    return cell; 
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    NSString *key = [keys objectAtIndex:section]; 
    return key;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void) tableView:(UITableView *) tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(loaddata){
    PredmetiController *nov = [[PredmetiController alloc] init];
    NSString *nasoka = [[names objectForKey:[keys objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    nov.zadolzitelnipredmeti = [[predmeti objectForKey:nasoka] objectForKey:@"zadolzitelni"];
    nov.izbornipredmeti = [[predmeti objectForKey:nasoka] objectForKey:@"izborni"];
    nov.title = @"Задолжителни";
    [self.navigationController pushViewController:nov animated:YES];
    }else{
        NSString *message = [[NSString alloc] initWithFormat: @"Ве молиме почекајте се процесира барањето"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Процесирање"
                                                        message:message
                                                       delegate:nil cancelButtonTitle:@"Во ред"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end

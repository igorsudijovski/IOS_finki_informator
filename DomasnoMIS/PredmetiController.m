//
//  PredmetiController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import "PredmetiController.h"
#import "IzborniPredmetiController.h"
#import "ZadolzitelniPredmetiController.h"

@implementation PredmetiController
@synthesize izborniController;
@synthesize zadolzitelni;
@synthesize buttonSwitch;
@synthesize zadolzitelnipredmeti;
@synthesize izbornipredmeti;
@synthesize names;
@synthesize keys;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"PredmetiController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    if(self.zadolzitelni.view.superview == nil){
        self.zadolzitelni = nil;
    }else{
        self.izborniController = nil;
    }
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
     [super viewDidLoad];
    for(NSDictionary *a in zadolzitelnipredmeti){
        NSString *semestar = [a objectForKey:@"semestar"];
        NSArray *pre = [a objectForKey:@"predmeti"];
        [names setObject:pre forKey:semestar];
    }
    keys = [[NSMutableArray alloc] initWithArray:[[names allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    self.zadolzitelni = [[ZadolzitelniPredmetiController alloc] initWithNibName:@"ZadolzitelniPredmetiController" bundle:nil];
    self.title = @"Задолжителни";
    self.zadolzitelni.zadolzitelni = zadolzitelnipredmeti;
    buttonSwitch.title = @"Изборни";
    self.zadolzitelni.parrent = self;
    [self.view insertSubview:self.zadolzitelni.view atIndex:0];
    /*UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;*/
    
   
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setButtonSwitch:nil];
    [self setButtonSwitch:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)switchView:(id)sender{
    [UIView beginAnimations:@"View Flip" context:NULL]; 
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(self.izborniController.view.superview == nil){
        if(self.izborniController == nil){
            self.izborniController = [[IzborniPredmetiController alloc] initWithNibName:@"IzborniPredmetiController" bundle:nil];
            self.izborniController.izborni = izbornipredmeti;
        }
        self.izborniController.parrent = self;
        buttonSwitch.title = @"Задолжителни";
        self.title = @"Изборни";
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [zadolzitelni.view removeFromSuperview];
        
        [self.view insertSubview:self.izborniController.view atIndex:0];
        
    }else{
        if(self.zadolzitelni == nil){
            self.zadolzitelni = [[ZadolzitelniPredmetiController alloc] initWithNibName:@"ZadolzitelniPredmetiController" bundle:nil];
            self.zadolzitelni.zadolzitelni = zadolzitelnipredmeti;
        }
        self.zadolzitelni.parrent = self;
        buttonSwitch.title = @"Изборни";
        self.title = @"Задолжителни";
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [izborniController.view removeFromSuperview];
        
        [self.view insertSubview:zadolzitelni.view atIndex:0];
    }
    [UIView commitAnimations];
    
}

-(void) pushStack:(UIViewController *) controller{
    [self.navigationController pushViewController:controller animated:YES];
}



@end

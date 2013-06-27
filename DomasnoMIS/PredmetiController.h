//
//  PredmetiController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IzborniPredmetiController;
@class ZadolzitelniPredmetiController;

@interface PredmetiController : UIViewController
@property (strong, nonatomic) IzborniPredmetiController *izborniController;
@property (strong, nonatomic) ZadolzitelniPredmetiController *zadolzitelni;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonSwitch;
@property (strong, nonatomic) NSMutableArray *zadolzitelnipredmeti;
@property (strong, nonatomic) NSMutableArray *izbornipredmeti;
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableArray *keys;
-(IBAction)switchView:(id)sender;
-(void) pushStack:(UIViewController *) controller;

@end

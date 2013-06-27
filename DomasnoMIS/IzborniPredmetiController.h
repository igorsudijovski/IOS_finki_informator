//
//  IzborniPredmetiController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PredmetiController.h"

@interface IzborniPredmetiController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSMutableArray *izborni;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) PredmetiController *parrent;

@end

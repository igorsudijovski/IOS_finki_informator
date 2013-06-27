//
//  VestiController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/27/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VestiController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *vesti;
@property (strong, nonatomic) IBOutlet UITableView *tableVesti;

@end

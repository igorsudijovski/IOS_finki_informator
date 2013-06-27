//
//  Twitter.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/26/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Twitter/Twitter.h"

@interface Twitter : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *array;
- (IBAction)tweet:(id)sender;



@end

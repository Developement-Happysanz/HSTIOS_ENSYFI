//
//  ExamDetailViewController.h
//  EducationApp
//
//  Created by HappySanz on 17/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamDetailViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)backButton:(id)sender;

@end

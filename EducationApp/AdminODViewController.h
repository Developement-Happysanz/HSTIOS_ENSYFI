//
//  AdminODViewController.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminODViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)segmentBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

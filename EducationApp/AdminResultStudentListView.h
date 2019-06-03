//
//  AdminResultStudentListView.h
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminResultStudentListView : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;

@end

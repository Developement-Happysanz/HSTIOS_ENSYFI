//
//  AdminStudentInfo.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminStudentInfo : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

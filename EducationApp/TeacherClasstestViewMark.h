//
//  TeacherClasstestViewMark.h
//  EducationApp
//
//  Created by HappySanz on 09/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherClasstestViewMark : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;

@end

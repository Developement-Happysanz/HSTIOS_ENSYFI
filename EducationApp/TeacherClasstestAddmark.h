//
//  TeacherClasstestAddmark.h
//  EducationApp
//
//  Created by HappySanz on 09/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherClasstestAddmark : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)saveBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UILabel *testDateLabel;
- (IBAction)backBtn:(id)sender;

@end

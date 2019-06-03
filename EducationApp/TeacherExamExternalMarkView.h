//
//  TeacherExamExternalMarkView.h
//  EducationApp
//
//  Created by HappySanz on 11/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherExamExternalMarkView : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
- (IBAction)plusBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

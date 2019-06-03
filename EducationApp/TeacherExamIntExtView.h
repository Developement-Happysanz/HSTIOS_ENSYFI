//
//  TeacherExamIntExtView.h
//  EducationApp
//
//  Created by HappySanz on 12/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherExamIntExtView : UIViewController<UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
- (IBAction)saveBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  ClassTeacherStudentListView.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 20/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTeacherStudentListView : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
@end

//
//  TeacherExamViewController.h
//  EducationApp
//
//  Created by HappySanz on 10/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherExamViewController : UIViewController<UIGestureRecognizerDelegate,NIDropDownDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NIDropDown *dropDown;

}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
@property (strong, nonatomic) IBOutlet UIButton *classSectionOtlet;
@property (strong, nonatomic) IBOutlet UIButton *subjectOtlet;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)classSectionBtn:(id)sender;
- (IBAction)subjectBtn:(id)sender;

@end

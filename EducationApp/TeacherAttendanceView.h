//
//  TeacherAttendanceView.h
//  EducationApp
//
//  Created by HappySanz on 23/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherAttendanceView : UIViewController<UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UIDatePicker *datePicker;
    NIDropDown *dropDown;
}

@property (strong, nonatomic) IBOutlet UIImageView *selectMonthImg;
@property (strong, nonatomic) IBOutlet UIButton *selectMonthOtlet;
- (IBAction)selectMonthBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dayTextfiled;
@property (strong, nonatomic) IBOutlet UIImageView *calenderImg;
- (IBAction)segementButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *selectBtnOtlet;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
- (IBAction)selectBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)plusBtn:(id)sender;

@end

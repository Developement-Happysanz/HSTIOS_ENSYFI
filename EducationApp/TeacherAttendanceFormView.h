//
//  TeacherAttendanceFormView.h
//  EducationApp
//
//  Created by HappySanz on 03/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherAttendanceFormView : UIViewController<UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NIDropDown *dropDown;
    UIPickerView *datapickerView;
    UIToolbar *toolbar;
}
- (IBAction)backBtn:(id)sender;
- (IBAction)saveBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *selectBtnOtlet;
- (IBAction)selectBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

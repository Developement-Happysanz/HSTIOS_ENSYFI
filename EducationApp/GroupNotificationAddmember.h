//
//  GroupNotificationAddmember.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 10/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNotificationAddmember : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *pickerView;
    UIToolbar *toolbar;
}
- (IBAction)checkBoxButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *checkBoxOutlet;
- (IBAction)sendButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *studentArrowImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *studentTxtField;
@property (weak, nonatomic) IBOutlet UITextField *teacherTxtField;
@property (weak, nonatomic) IBOutlet UITextField *leadName;
@property (weak, nonatomic) IBOutlet UITextField *titleTxtField;

@end

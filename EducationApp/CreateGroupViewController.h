//
//  CreateGroupViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateGroupViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *pickerView;
    UIToolbar *toolbar;
}
@property (weak, nonatomic) IBOutlet UITextField *LeadName;
@property (weak, nonatomic) IBOutlet UITextField *titleTxtfield;
- (IBAction)backButton:(id)sender;
- (IBAction)createButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *createOutlet;
- (IBAction)switchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switchOutlet;
@end

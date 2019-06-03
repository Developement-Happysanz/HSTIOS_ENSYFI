//
//  TeacherClassTestMarkView.h
//  EducationApp
//
//  Created by HappySanz on 07/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherClassTestMarkView : UIViewController<NIDropDownDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NIDropDown *dropDown;
    UIDatePicker *datePicker;
    UIToolbar *toolBar;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *classSectionOtlet;
@property (strong, nonatomic) IBOutlet UIButton *subjectOtlet;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentOtlet;
@property (strong, nonatomic) IBOutlet UILabel *subjectNameLabel;
@property (strong, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UITextView *topicTxtView;

@property (strong, nonatomic) IBOutlet UITextField *dateTextfld;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitOtlet;
@property (weak, nonatomic) IBOutlet UITextView *detailtextView;
- (IBAction)classSectionBtn:(id)sender;
- (IBAction)subjectBtn:(id)sender;
- (IBAction)segmentBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
- (IBAction)submitBtn:(id)sender;

@end

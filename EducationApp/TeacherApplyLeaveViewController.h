//
//  TeacherApplyLeaveViewController.h
//  EducationApp
//
//  Created by HappySanz on 20/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherApplyLeaveViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,NIDropDownDelegate>
{
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    NIDropDown *dropDown;

}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *requestOtlet;
@property (strong, nonatomic) IBOutlet UILabel *detailsTXT;
@property (strong, nonatomic) IBOutlet UIView *toTimeView;
@property (strong, nonatomic) IBOutlet UIView *fromTimeView;
@property (strong, nonatomic) IBOutlet UILabel *toTimeTXT;
@property (strong, nonatomic) IBOutlet UILabel *fromTimeTXT;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *selectOtlet;
- (IBAction)selectBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *startdateTxt;
@property (strong, nonatomic) IBOutlet UITextField *endDatetxt;
@property (strong, nonatomic) IBOutlet UITextField *fromTime;
@property (strong, nonatomic) IBOutlet UITextField *toTime;
@property (strong, nonatomic) IBOutlet UITextView *detailsTxtView;
- (IBAction)requestBtn:(id)sender;
@property (nonatomic, assign) NSInteger datePickerType;
@property (nonatomic, assign) NSInteger timePickerType;

@property (strong, nonatomic) IBOutlet UILabel *startDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *endDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *toTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *startImg;
@property (strong, nonatomic) IBOutlet UIImageView *endImg;
@property (strong, nonatomic) IBOutlet UIImageView *fromImg;
@property (strong, nonatomic) IBOutlet UIImageView *toImg;
@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *startImageViewOne;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabelViewOne;
@property (weak, nonatomic) IBOutlet UITextField *startDateTxtViewOne;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabelViewOne;
@property (weak, nonatomic) IBOutlet UITextField *toDateTxtViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *toDateImgViewOne;
@property (weak, nonatomic) IBOutlet UITextView *textViewViewOne;
- (IBAction)requestBtnViewOne:(id)sender;

@end

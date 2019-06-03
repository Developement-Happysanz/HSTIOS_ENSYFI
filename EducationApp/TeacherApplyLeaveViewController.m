//
//  TeacherApplyLeaveViewController.m
//  EducationApp
//
//  Created by HappySanz on 20/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherApplyLeaveViewController.h"

@interface TeacherApplyLeaveViewController ()
{
    AppDelegate *appDel;
    
    NSString *startDate;
    NSString *endDate;
    
    NSString *fromTimePicker;
    NSString *toTimePicker;
    
    NSMutableArray *leave_id;
    NSMutableArray *leave_title;
    NSMutableArray *leave_type;

    NSMutableArray *leavetypes;
}
@end

@implementation TeacherApplyLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    leave_id = [[NSMutableArray alloc]init];
    leave_title = [[NSMutableArray alloc]init];
    leave_type = [[NSMutableArray alloc]init];
    leavetypes = [[NSMutableArray alloc]init];
    leavetypes = [[NSUserDefaults standardUserDefaults]objectForKey:@"leaveTitle_key"];
    
    _selectOtlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _selectOtlet.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _selectOtlet.layer.borderWidth = 1.0f;
    [_selectOtlet.layer setCornerRadius:10.0f];
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    
    timePicker=[[UIDatePicker alloc]init];
    timePicker.datePickerMode=UIDatePickerModeTime;
    
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", dateString);
    
    NSDate *todayTime = [NSDate date];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm a"];
    NSString *timeString = [timeFormat stringFromDate:todayTime];
    NSLog(@"time: %@", timeString);
    
    self.startdateTxt.inputView = datePicker;
    self.startdateTxt.inputAccessoryView = toolBar;
    
    self.startDateTxtViewOne.inputView = datePicker;
    self.startDateTxtViewOne.inputAccessoryView   = toolBar;
    
    self.endDatetxt.inputView = datePicker;
    self.endDatetxt.inputAccessoryView = toolBar;
    
    self.toDateTxtViewOne.inputView = datePicker;
    self.toDateTxtViewOne.inputAccessoryView = toolBar;
    
    self.fromTime.inputView = timePicker;
    self.fromTime.inputAccessoryView  = toolBar;
    
    self.toTime.inputView = timePicker;
    self.toTime.inputAccessoryView  = toolBar;
        
    self.startdateTxt.delegate = self;
    self.endDatetxt.delegate = self;
    self.startDateTxtViewOne.delegate = self;
    self.toDateTxtViewOne.delegate  = self;
    
    self.detailsTxtView.delegate = self;
    self.textViewViewOne.delegate = self;

    self.startDateLabel.backgroundColor = [UIColor grayColor];
    self.endDateLabel.backgroundColor = [UIColor grayColor];
    
    self.startDateLabelViewOne.backgroundColor = [UIColor grayColor];
    self.toDateLabelViewOne.backgroundColor = [UIColor grayColor];
    
    self.fromTimeLabel.backgroundColor = [UIColor grayColor];
    self.toTimeLabel.backgroundColor = [UIColor grayColor];
    
    self.startDateTxtViewOne.text = dateString;
    self.endDatetxt.text = dateString;
    
    self.startdateTxt.text = dateString;
    self.toDateTxtViewOne.text = dateString;

    self.fromTime.text = timeString;
    self.toTime.text = timeString;
    
    _detailsTxtView.layer.cornerRadius = 10.0;
    _detailsTxtView.clipsToBounds = YES;
    
    _textViewViewOne.layer.cornerRadius = 10.0;
    _textViewViewOne.clipsToBounds = YES;
    
    _viewTwo.hidden = YES;
    _viewOne.hidden = NO;
    
    self.scrollView.contentSize=CGSizeMake(320, 600);
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
}
//-(void)dismissKeyboard
//{
//    [_detailsTxtView resignFirstResponder];
//    [_textViewViewOne resignFirstResponder];
//}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,700);    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)ShowSelectedDate
{
    if (self.startdateTxt.isFirstResponder)
    {
        self.datePickerType = 1;
    }
    if (self.startDateTxtViewOne.isFirstResponder)
    {
        self.datePickerType = 2;
    }
    if (self.endDatetxt.isFirstResponder)
    {
        self.datePickerType = 3;
    }
    if (self.toDateTxtViewOne.isFirstResponder)
    {
        self.datePickerType = 4;
    }
    if (self.fromTime.isFirstResponder)
    {
        self.timePickerType = 5;
    }
    if (self.toTime.isFirstResponder)
    {
        self.timePickerType = 6;
    }
    if (self.datePickerType == 1)
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        startDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        NSArray * arr = [startDate componentsSeparatedByString:@" "];
        self.startdateTxt.text = [arr objectAtIndex:0];
        self.startDateLabel.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.startdateTxt.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.startImg.image = [UIImage imageNamed:@"od calender-01.png"];
        self.datePickerType = 0;
        [self.startdateTxt resignFirstResponder];
    }
    else if (self.datePickerType == 2)
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        endDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        NSArray * arr = [endDate componentsSeparatedByString:@" "];
        self.startDateTxtViewOne.text = [arr objectAtIndex:0];
        self.startDateLabelViewOne.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.startDateTxtViewOne.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.startImageViewOne.image = [UIImage imageNamed:@"od calender-01.png"];
        self.datePickerType = 0;
        [self.startDateTxtViewOne resignFirstResponder];
    }
    else if (self.datePickerType == 3)
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        endDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        NSArray * arr = [endDate componentsSeparatedByString:@" "];
        self.endDatetxt.text = [arr objectAtIndex:0];
        self.endDateLabel.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.endDatetxt.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.endImg.image = [UIImage imageNamed:@"od calender-01.png"];
        self.datePickerType = 0;
        [self.endDatetxt resignFirstResponder];
    }
    else if (self.datePickerType == 4)
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        endDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        NSArray * arr = [endDate componentsSeparatedByString:@" "];
        self.toDateTxtViewOne.text = [arr objectAtIndex:0];
        self.toDateLabelViewOne.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.toDateTxtViewOne.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.toDateImgViewOne.image = [UIImage imageNamed:@"od calender-01.png"];
        self.datePickerType = 0;
        [self.toDateTxtViewOne resignFirstResponder];
    }
    else if (self.timePickerType == 5)
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm a"];
        fromTimePicker=[NSString stringWithFormat:@"%@",[formatter stringFromDate:timePicker.date]];
        NSArray * arr = [fromTimePicker componentsSeparatedByString:@" "];
        self.fromTime.text = [arr objectAtIndex:0];
        self.fromTimeLabel.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.fromTimeLabel.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.fromImg.image = [UIImage imageNamed:@"od calender-01.png"];
        self.timePickerType = 0;
        [self.fromTime resignFirstResponder];
    }
    else if (self.timePickerType == 6)
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"hh:mm a"];
        toTimePicker=[NSString stringWithFormat:@"%@",[formatter stringFromDate:timePicker.date]];
        NSArray * arr = [toTimePicker componentsSeparatedByString:@" "];
        self.toTime.text = [arr objectAtIndex:0];
        
        self.toTimeLabel.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.toTimeLabel.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.toImg.image = [UIImage imageNamed:@"od calender-01.png"];
        self.timePickerType = 0;
        [self.toTime resignFirstResponder];
    }
}
- (IBAction)selectBtn:(id)sender
{
    if(dropDown == nil)
    {
        CGFloat f = 150;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :leavetypes :nil :@"down"];
        [[NSUserDefaults standardUserDefaults]setObject:@"applyLeave" forKey:@"applyLeave_key"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void)niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}
-(void)rel
{
    dropDown = nil;
    [self funcTime];
}
-(void)funcTime
{
    NSString *reStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"applyLeaveAns_key"];
    
    if ([reStr isEqualToString:@"HourPermission"])
    {
        _viewTwo.hidden = NO;
        _viewOne.hidden = YES;
    }
    else
    {
        _viewTwo.hidden = YES;
        _viewOne.hidden = NO;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
//-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
//{
//    if (theTextField == self.resonTextfield)
//    {
//        [theTextField resignFirstResponder];
//    }
//    return YES;
//}
- (IBAction)requestBtn:(id)sender
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSDate *dtOne=[format dateFromString:self.startdateTxt.text];
    NSDate *dtTwo=[format dateFromString:self.endDatetxt.text];
    
    NSComparisonResult resultDate;
    resultDate = [dtOne compare:dtTwo];
    
    NSDateFormatter *formattime = [[NSDateFormatter alloc] init];
    [formattime  setDateFormat:@"hh:mm a"];
    NSDate *dtOnetime =[format dateFromString:self.fromTime.text];
    NSDate *dtTwotime =[format dateFromString:self.toTime.text];
    
    NSComparisonResult resulttime;
    resulttime = [dtOnetime compare:dtTwotime];
    
    if ([self.startdateTxt.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select from Date"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.endDatetxt.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select To Date"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (resultDate == NSOrderedDescending)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"ToDate should not lesser than FromDate"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (resulttime == NSOrderedDescending)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"ToDate should not lesser than FromDate"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.fromTime.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select from time"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.toTime.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select To time"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.detailsTxtView.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Enter Valid leave details"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
//          NSString *reStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"applyLeaveAns_key"];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSString *leave_type_str = [[NSUserDefaults standardUserDefaults]objectForKey:@"applyLeaveAns_key"];
            NSArray *leave_id_arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"leave_id_key"];
            NSUInteger intergerid = [leavetypes indexOfObject:leave_type_str];
            NSString *leavemaster_id = leave_id_arr[intergerid];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:appDel.user_id forKey:@"user_id"];
            [parameters setObject:leavemaster_id forKey:@"leave_master_id"];
            [parameters setObject:leave_type_str  forKey:@"leave_type"];
            [parameters setObject:self.startdateTxt.text forKey:@"date_from"];
            [parameters setObject:self.endDatetxt.text forKey:@"date_to"];
            [parameters setObject:self.fromTime.text forKey:@"fromTime"];
            [parameters setObject:self.toTime.text forKey:@"toTime"];
            [parameters setObject:self.detailsTxtView.text forKey:@"description"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            /* concordanate with baseurl */
            NSString *Userleaves = @"/apiteacher/add_Userleaves/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,Userleaves, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 
                 if ([msg isEqualToString:@"Leave Added"] && [status isEqualToString:@"success"])
                 {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"ENSYFI"
                                                message:msg
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                                              TeacherApplyLeave *teacherApplyLeave = (TeacherApplyLeave *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherApplyLeave"];
                                              [self.navigationController pushViewController:teacherApplyLeave animated:YES];
                                          }];
                     
                     [alert addAction:ok];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        }
}
- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)requestBtnViewOne:(id)sender
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSDate *dtOne=[format dateFromString:self.startDateTxtViewOne.text];
    NSDate *dtTwo=[format dateFromString:self.toDateTxtViewOne.text];
    
    NSComparisonResult resultDate;
    resultDate = [dtOne compare:dtTwo];
    
    if ([self.startDateTxtViewOne.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select from Date"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.toDateTxtViewOne.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Select To Date"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (resultDate == NSOrderedDescending)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"ToDate should not lesser than FromDate"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.textViewViewOne.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Enter Valid leave details"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *leave_type_str = [[NSUserDefaults standardUserDefaults]objectForKey:@"applyLeaveAns_key"];
        NSArray *leave_id_arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"leave_id_key"];
        NSUInteger intergerid = [leavetypes indexOfObject:leave_type_str];
        NSString *leavemaster_id = leave_id_arr[intergerid];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:leavemaster_id forKey:@"leave_master_id"];
        [parameters setObject:leave_type_str forKey:@"leave_type"];
        [parameters setObject:self.startdateTxt.text forKey:@"date_from"];
        [parameters setObject:self.endDatetxt.text forKey:@"date_to"];
        [parameters setObject:@"" forKey:@"fromTime"];
        [parameters setObject:@"" forKey:@"toTime"];
        [parameters setObject:self.textViewViewOne.text forKey:@"description"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *Userleaves = @"/apiteacher/add_Userleaves/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,Userleaves, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             if ([msg isEqualToString:@"Leave Added"] && [status isEqualToString:@"success"])
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:msg
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                                          TeacherApplyLeave *teacherApplyLeave = (TeacherApplyLeave *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherApplyLeave"];
                                          [self.navigationController pushViewController:teacherApplyLeave animated:YES];
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [self.scrollView setContentOffset:CGPointMake(0, 120 ) animated:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
@end

//
//  OnDutyViewController.m
//  EducationApp
//
//  Created by HappySanz on 12/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "OnDutyViewController.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface OnDutyViewController ()
{
    AppDelegate *appDel;
    NSString *startDate;
    NSString *endDate;
    
    NSDate *nsstartdate;
    NSDate *nsenddate;

}
@end

@implementation OnDutyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    
    
    self.startDateText.inputView            = datePicker;
    self.startDateText.inputAccessoryView   = toolBar;
    
    self.endDateText.inputView              = datePicker;
    self.endDateText.inputAccessoryView     = toolBar;

    self.startDateText.tag     = 1;
    self.endDateText.tag        = 2;
    
    self.startDateText.delegate    = self;
    self.endDateText.delegate       = self;
    self.resonText.delegate       = self;
    self.detailsTextView.delegate       = self;

    self.startdateLabel.backgroundColor = [UIColor grayColor];
    self.enddateLabel.backgroundColor = [UIColor grayColor];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", dateString);
    
    self.startDateText.text = dateString;
    self.endDateText.text = dateString;
    
    _requestOtlet.layer.cornerRadius = 5; // this value vary as per your desire
    _requestOtlet.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (self.startDateText.isFirstResponder)
    {
        self.datePickerType = 1;
    }
    
    if (self.endDateText.isFirstResponder)
    {
        self.datePickerType = 2;
    }
    
    if (self.datePickerType == 1)
    {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        startDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        NSArray * arr = [startDate componentsSeparatedByString:@" "];
        self.startDateText.text = [arr objectAtIndex:0];
        
        
        self.startdateLabel.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.startDateText.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.strtImg.image = [UIImage imageNamed:@"od calender-01.png"];
        [self.startDateText resignFirstResponder];
    }
    else if (self.datePickerType == 2) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        endDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        NSArray * arr = [endDate componentsSeparatedByString:@" "];
        self.endDateText.text = [arr objectAtIndex:0];
        self.enddateLabel.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.endDateText.textColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1];
        self.endImg.image = [UIImage imageNamed:@"od calender-01.png"];
        [self.endDateText resignFirstResponder];

    }

}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)requestBtn:(id)sender
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    NSDate *dtOne=[format dateFromString:self.startDateText.text];
    NSDate *dtTwo=[format dateFromString:self.endDateText.text];
    
    NSComparisonResult result;
    result = [dtOne compare:dtTwo];
    
    if ([self.resonText.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Type your Reason"
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
    else if (result == NSOrderedDescending)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"TODate should not lesser than FromDate"
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
    
    else if([self.startDateText.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please your From date"
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
    else if ([self.endDateText.text isEqualToString:@""])
    {
    
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please your End date"
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
    else if([self.detailsTextView.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Type Your Descripition"
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
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if ([appDel.user_type isEqualToString:@"2"])
        {
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
            NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_id forKey:@"user_id"];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:self.resonText.text forKey:@"od_for"];
            [parameters setObject:self.startDateText.text forKey:@"from_date"];
            [parameters setObject:self.endDateText.text forKey:@"to_date"];
            [parameters setObject:self.detailsTextView.text forKey:@"notes"];
            [parameters setObject:@"Pending" forKey:@"status"];
            [parameters setObject:appDel.user_id forKey:@"created_by"];
            [parameters setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"created_at"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            
            /* concordanate with baseurl */
            NSString *OnDuty = @"/apimain/add_Onduty/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,OnDuty, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status =[responseObject objectForKey:@"status"];
                 
                 
                 if ([msg isEqualToString:@"Onduty Added"])
                 {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"ENSYFI"
                                                message:status
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"onDutyformView"];
                                              //                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                              //                OnDutyTableViewController *exam = (OnDutyTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"OnDutyTableViewController"];
                                              //                [self.navigationController pushViewController:exam animated:YES];
                                              [self dismissViewControllerAnimated:YES completion:Nil];
                                              
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
        else
        {
           
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
            NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_id forKey:@"user_id"];
            [parameters setObject:appDel.user_type forKey:@"user_type"];
            [parameters setObject:self.resonText.text forKey:@"od_for"];
            [parameters setObject:self.startDateText.text forKey:@"from_date"];
            [parameters setObject:self.endDateText.text forKey:@"to_date"];
            [parameters setObject:self.detailsTextView.text forKey:@"notes"];
            [parameters setObject:@"Pending" forKey:@"status"];
            [parameters setObject:appDel.student_id forKey:@"created_by"];
            [parameters setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"created_at"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            
            /* concordanate with baseurl */
            NSString *OnDuty = @"/apimain/add_Onduty/";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,OnDuty, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status =[responseObject objectForKey:@"status"];
                 
                 
                 if ([msg isEqualToString:@"Onduty Added"])
                 {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"ENSYFI"
                                                message:status
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"onDutyformView"];
                                              //                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                              //                OnDutyTableViewController *exam = (OnDutyTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"OnDutyTableViewController"];
                                              //                [self.navigationController pushViewController:exam animated:YES];
                                              [self dismissViewControllerAnimated:YES completion:Nil];
                                              
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
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.resonText)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
       
    [textView resignFirstResponder];
    return YES;
}
-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect textFieldRect = [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if(heightFraction < 0.0){
        
        heightFraction = 0.0;
        
    }else if(heightFraction > 1.0){
        
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown){
        
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        
    }else{
        
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}
-(void)hideKeyBoard
{
    [self.resonText resignFirstResponder];
    
    [self.startDateText resignFirstResponder];
    
    [self.enddateLabel resignFirstResponder];
    
    [self.detailsTextView resignFirstResponder];

    
}
@end

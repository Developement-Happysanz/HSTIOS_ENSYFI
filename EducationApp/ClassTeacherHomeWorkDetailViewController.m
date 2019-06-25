//
//  ClassTeacherHomeWorkDetailViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 03/07/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ClassTeacherHomeWorkDetailViewController.h"

@interface ClassTeacherHomeWorkDetailViewController ()
{
    AppDelegate *appDel;
    NSString *smsFlag;
    NSString *mailFlag;
    NSString *notificationFlag;
    
    NSString *selectSms;
    NSString *selectMail;
    NSString *selectNotification;
    
    NSMutableArray *values;

}
@end

@implementation ClassTeacherHomeWorkDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.typeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"hw_type_key"];
    self.titleLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"title_key"];
    self.teachetLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"name_key"];
    self.subjectLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_key"];
    self.descripitionLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"hw_details_key"];
    
    self.popupView.layer.cornerRadius = 8.0f;
    self.popupView.clipsToBounds = YES;
    
    self.popupView.layer.shadowRadius  = 5.5f;
    self.popupView.layer.shadowColor   = UIColor.grayColor.CGColor;
    self.popupView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    self.popupView.layer.shadowOpacity = 0.6f;
    self.popupView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.popupView.bounds, shadowInsets)];
    self.popupView.layer.shadowPath    = shadowPath.CGPath;
    
    smsFlag = @"0";
    mailFlag = @"0";
    notificationFlag = @"0";
    
    _sendOutlet.layer.cornerRadius = 5.0;
    _sendOutlet.clipsToBounds = YES;
    
    self.popupView.hidden = YES;
    
    
    selectSms = @"NO";
    selectMail = @"NO";
    selectNotification = @"NO";
    
    [values removeAllObjects];
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

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)closeBtn:(id)sender
{
    self.popupView.hidden = YES;
}
- (IBAction)sendpopBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *atten_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_attendId"];
    if ([selectSms isEqualToString:@"NO"])
    {
        
    }
    else
    {
        [values addObject:selectSms];
    }
    if ([selectMail isEqualToString:@"NO"])
    {
        
    }
    else
    {
        [values addObject:selectMail];
        
    }
    if ([selectNotification isEqualToString:@"NO"])
    {
    }
    else
    {
        [values addObject:selectNotification];
    }
       // NSString *msg_Type = [NSString stringWithFormat:@"%@,%@,%@",selectSms,selectMail,selectNotification];
        NSArray *myArray = [[NSArray alloc] initWithObjects:values, nil];
        NSString *greeting = [myArray componentsJoinedByString:@" "];
        NSLog(@"%@",greeting);
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:atten_id forKey:@"attend_id"];
        [parameters setObject:greeting forKey:@"msg_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *send_attendance_parents = @"/apiteacher/send_attendance_parents";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,send_attendance_parents, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             if ([msg isEqualToString:@"Attendance Send to Parents"] && [status isEqualToString:@"success"])
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
                                          [self performSegueWithIdentifier:@"to_List" sender:self];
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
}
- (IBAction)notificationBtn:(id)sender
{
    if ([notificationFlag isEqualToString:@"0"])
    {
        notificationFlag = @"1";
        self.notificationImageView.image = [UIImage imageNamed:@"notification1.png"];
        selectNotification = @"Notification";
    }
    else
    {
        notificationFlag = @"0";
        self.notificationImageView.image = [UIImage imageNamed:@"notification.png"];
        selectNotification = @"";
    }
}
- (IBAction)mailBtn:(id)sender
{
    if ([mailFlag isEqualToString:@"0"])
    {
        mailFlag = @"1";
        self.mail_ImageView.image = [UIImage imageNamed:@"mail1.png"];
        selectMail = @"Mail";
        
    }
    else
    {
        mailFlag = @"0";
        self.mail_ImageView.image = [UIImage imageNamed:@"mail.png"];
        selectMail = @"";
        
    }
}
- (IBAction)smsBtn:(id)sender
{
    if ([smsFlag isEqualToString:@"0"])
    {
        smsFlag = @"1";
        self.smsImageView.image = [UIImage imageNamed:@"sms1.png"];
        selectSms = @"SMS";
    }
    else
    {
        smsFlag = @"0";
        self.smsImageView.image = [UIImage imageNamed:@"sms.png"];
        selectSms = @"";
        
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
- (IBAction)sendBtn:(id)sender
{
    self.popupView.hidden = NO;

}
@end

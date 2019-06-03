//
//  TeachernotificationViewController.m
//  EducationApp
//
//  Created by HappySanz on 18/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "GroupNotificationSendViewController.h"

@interface GroupNotificationSendViewController ()
{
    AppDelegate *appDel;
    NSString *imgSmsButton;
    NSString *SmsButton;
    NSString *SmsButtonValue;
    NSString *imgmailButton;
    NSString *mailButton;
    NSString *MailButtonValue;
    NSString *imgnotification;
    NSString *notificationButton;
    NSString *notificationButnValue;
    NSString *group_idFlag;
    NSString *notificationTypeFlag;
}

@end

@implementation GroupNotificationSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_sendOtlet.layer setCornerRadius:8.0f];
    _sendOtlet.clipsToBounds = YES;
    _descriptionTextview.layer.cornerRadius = 10.0;
    _descriptionTextview.clipsToBounds = YES;
    _descriptionTextview.delegate=self;
    imgSmsButton = @"0";
    SmsButton = @"0";
    imgmailButton = @"0";
    mailButton = @"0";
    imgnotification = @"0";
    notificationButton = @"0";
    SmsButtonValue =@"0";
    MailButtonValue = @"0";
    notificationButnValue = @"0";
    notificationTypeFlag = @"";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    group_idFlag = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_StrGroup_id"];

}
-(void)dismissKeyboard
{
    [_descriptionTextview resignFirstResponder];
 
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

- (IBAction)smsImgButton:(id)sender
{
    if ([imgSmsButton isEqualToString:@"0"])
    {
        SmsButtonValue = @"1";
        imgSmsButton =@"1";
        notificationTypeFlag = @"SMS";
        [_imgSmsOtlet setSelected:YES];
        
    }
    else
    {
        SmsButtonValue = @"0";
        imgSmsButton =@"0";
        notificationTypeFlag = @"";
        [_imgSmsOtlet setSelected:NO];
    }
}
- (IBAction)smsButton:(id)sender
{
    if ([SmsButton isEqualToString:@"0"])
    {
        SmsButtonValue = @"1";
        SmsButton =@"1";
        notificationTypeFlag = @"SMS";
        [_imgSmsOtlet setSelected:YES];
    }
    else
    {
        SmsButtonValue = @"0";
        SmsButton =@"0";
        notificationTypeFlag = @"";
        [_imgSmsOtlet setSelected:NO];
    }
}

- (IBAction)mainImg:(id)sender
{
    if ([imgmailButton isEqualToString:@"0"])
    {
        imgmailButton = @"1";
        MailButtonValue = @"1";
        notificationTypeFlag = @"Mail";
        [_mailImgOtlet setSelected:YES];

    }
    else
    {
        imgmailButton = @"0";
        MailButtonValue = @"0";
        notificationTypeFlag = @"";
        [_mailImgOtlet setSelected:NO];

    }
}
- (IBAction)mailButton:(id)sender
{
    if ([mailButton isEqualToString:@"0"])
    {
        mailButton = @"1";
        MailButtonValue = @"1";
        notificationTypeFlag = @"Mail";
        [_mailImgOtlet setSelected:YES];
    }
    else
    {
        mailButton = @"0";
        MailButtonValue = @"0";
        notificationTypeFlag = @"";
        [_mailImgOtlet setSelected:NO];
    }
}
- (IBAction)notifiButton:(id)sender
{
    if ([notificationButton isEqualToString:@"0"])
    {
        notificationButton = @"1";
        notificationButnValue = @"1";
        notificationTypeFlag = @"Notification";
        [_imgNotification setSelected:YES];
        
        
    }
    else
    {
        notificationButton = @"0";
        notificationButnValue = @"0";
        notificationTypeFlag = @"";
        [_imgNotification setSelected:NO];
    }
}

- (IBAction)notiImgButton:(id)sender
{
    if ([imgnotification isEqualToString:@"0"])
    {
        imgnotification = @"1";
        notificationButnValue = @"1";
        notificationTypeFlag = @"Notification";
        [_imgNotification setSelected:YES];

    }
    else
    {
        imgnotification = @"0";
        notificationButnValue = @"0";
        notificationTypeFlag = @"Notification";
        [_imgNotification setSelected:NO];
    }
}

- (IBAction)sendButton:(id)sender
{
    if ([self.descriptionTextview.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Enter valid message"
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
    else if ([notificationTypeFlag isEqualToString:@"0"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Select at least one mode"
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:group_idFlag forKey:@"group_id"];
        [parameters setObject:self.descriptionTextview.text forKey:@"note"];
        [parameters setObject:notificationTypeFlag forKey:@"notification_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        
        /* concordanate with baseurl */
        NSString *forGroupmessage = @"apiadmin/group_msg_send";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forGroupmessage, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
        
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             
             if ([msg isEqualToString:@"Group Notification Send Sucessfully"])
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
                                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                                          AdminNotificationTableViewController *adminNotificationTableViewController = (AdminNotificationTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminNotificationTableViewController"];
                                          [self.navigationController pushViewController:adminNotificationTableViewController animated:YES];
                                          
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             else
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Error"
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
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
- (IBAction)backBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
    TeacherNotificationTableViewController *teacherNotificationTableViewController = (TeacherNotificationTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherNotificationTableViewController"];
    [self.navigationController pushViewController:teacherNotificationTableViewController animated:YES];}
@end

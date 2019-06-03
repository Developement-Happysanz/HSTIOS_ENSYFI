//
//  TeachernotificationViewController.m
//  EducationApp
//
//  Created by HappySanz on 18/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeachernotificationViewController.h"

@interface TeachernotificationViewController ()
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

}

@end

@implementation TeachernotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectButton.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _selectButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _selectButton.layer.borderWidth = 1.0f;
    [_selectButton.layer setCornerRadius:10.0f];
    
    [_sendOtlet.layer setCornerRadius:10.0f];
    
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
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
        
        [_imgSmsOtlet setSelected:YES];
        
    }
    else
    {
        SmsButtonValue = @"0";
        imgSmsButton =@"0";
        [_imgSmsOtlet setSelected:NO];

    }
    
}

- (IBAction)smsButton:(id)sender
{
    if ([SmsButton isEqualToString:@"0"])
    {
        SmsButtonValue = @"1";
        SmsButton =@"1";
        [_imgSmsOtlet setSelected:YES];


    }
    else
    {
        SmsButtonValue = @"0";
        SmsButton =@"0";
        [_imgSmsOtlet setSelected:NO];

        
    }
}

- (IBAction)mainImg:(id)sender
{
    if ([imgmailButton isEqualToString:@"0"])
    {
        imgmailButton = @"1";
        MailButtonValue = @"1";
        [_mailImgOtlet setSelected:YES];

    }
    else
    {
        imgmailButton = @"0";
        MailButtonValue = @"0";
        [_mailImgOtlet setSelected:NO];

    }
    
}

- (IBAction)mailButton:(id)sender
{
    if ([mailButton isEqualToString:@"0"])
    {
        mailButton = @"1";
        MailButtonValue = @"1";
        [_mailImgOtlet setSelected:YES];


    }
    else
    {
        mailButton = @"0";
        MailButtonValue = @"0";
        [_mailImgOtlet setSelected:NO];

    }
    
}
- (IBAction)notifiButton:(id)sender
{
    if ([notificationButton isEqualToString:@"0"])
    {
        notificationButton = @"1";
        notificationButnValue = @"1";
        
        [_imgNotification setSelected:YES];
        
        
    }
    else
    {
        notificationButton = @"0";
        notificationButnValue = @"0";
        [_imgNotification setSelected:NO];
    }
}

- (IBAction)notiImgButton:(id)sender
{
    if ([imgnotification isEqualToString:@"0"])
    {
        imgnotification = @"1";
        notificationButnValue = @"1";
        [_imgNotification setSelected:YES];

    }
    else
    {
        imgnotification = @"0";
        notificationButnValue = @"0";
        [_imgNotification setSelected:NO];

    }
}

- (IBAction)sendButton:(id)sender
{
    NSString *resultstr = [[NSUserDefaults standardUserDefaults]objectForKey:@"notificationAns_key"];
    
    if ([resultstr isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@""
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
    else if ([self.descriptionTextview.text isEqualToString:@""])
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
    else if ([SmsButtonValue isEqualToString:@"0"] && [MailButtonValue isEqualToString:@"0"] && [notificationButnValue isEqualToString:@"0"])
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
        
        NSArray *groupTitle = [[NSUserDefaults standardUserDefaults]objectForKey:@"groupTitle_key"];
        NSArray *groupid = [[NSUserDefaults standardUserDefaults]objectForKey:@"groupid_key"];
        
        NSUInteger valueInteger = [groupTitle indexOfObject:resultstr];
        
        NSString *group_title_id = groupid[valueInteger];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:group_title_id forKey:@"group_title_id"];
        [parameters setObject:SmsButtonValue forKey:@"messagetype_sms"];
        [parameters setObject:MailButtonValue forKey:@"messagetype_mail"];
        [parameters setObject:notificationButnValue forKey:@"messagetype_notification"];
        [parameters setObject:self.descriptionTextview.text forKey:@"message_details"];
        [parameters setObject:appDel.user_id forKey:@"created_by"];

        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        
        /* concordanate with baseurl */
        NSString *forGroupmessage = @"/apimain/send_Groupmessage/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forGroupmessage, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
        
             
             NSLog(@"%@",responseObject);
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             NSString *group_history_id = [responseObject objectForKey:@"last_group_history_id"];
             NSLog(@"%@",group_history_id);
             
             if ([status isEqualToString:@"success"])
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
                                          TeacherNotificationTableViewController *teacherNotificationTableViewController = (TeacherNotificationTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherNotificationTableViewController"];
                                          [self.navigationController pushViewController:teacherNotificationTableViewController animated:YES];
                                          
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
- (IBAction)selectBtn:(id)sender
{
    NSArray *getValues = [[NSUserDefaults standardUserDefaults]objectForKey:@"groupTitle_key"];
    
    if(dropDown == nil)
    {
        CGFloat f = 60;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :getValues :nil :@"down"];
        [[NSUserDefaults standardUserDefaults]setObject:@"notification" forKey:@"notification_key"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}
-(void)rel
{
    dropDown = nil;
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

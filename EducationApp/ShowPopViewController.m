//
//  ShowPopViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 20/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ShowPopViewController.h"

@interface ShowPopViewController ()
{
    AppDelegate *appDel;
    NSString *smsFlag;
    NSString *mailFlag;
    NSString *notificationFlag;
    
    NSString *selectSms;
    NSString *selectMail;
    NSString *selectNotification;

}
@end

@implementation ShowPopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popupView.layer.cornerRadius = 12.0;
    self.popupView.clipsToBounds = YES;
    smsFlag = @"0";
    mailFlag = @"0";
    notificationFlag = @"0";
    
    _sendOutlet.layer.cornerRadius = 5.0;
    _sendOutlet.clipsToBounds = YES;
}
- (void)didReceiveMemoryWarning
{
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

- (IBAction)closeBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];    
}
- (IBAction)sendBtn:(id)sender
{
    if ([selectSms isEqualToString:@""])
    {
        
    }
    else if ([selectMail isEqualToString:@""])
    {
        
    }
    else if ([selectNotification isEqualToString:@""])
    {
        
    }
    else
    {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *atten_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_attendId"];
    NSString *msg_Type = [NSString stringWithFormat:@"%@,%@,%@",selectSms,selectMail,selectNotification];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:atten_id forKey:@"attend_id"];
    [parameters setObject:msg_Type forKey:@"msg_type"];

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
}
- (IBAction)notificationBtn:(id)sender
{
    if ([notificationFlag isEqualToString:@"0"])
    {
        notificationFlag = @"1";
        self.notificationImageView.image = [UIImage imageNamed:@"ensyfi message screen icons-01.png"];
        selectNotification = @"Notification";
    }
    else
    {
        notificationFlag = @"0";
        self.notificationImageView.image = [UIImage imageNamed:@"ensyfi message screen icons-03.png"];
        selectNotification = @"";
    }
}

- (IBAction)mailBtn:(id)sender
{
    if ([mailFlag isEqualToString:@"0"])
    {
        mailFlag = @"1";
        self.mail_ImageView.image = [UIImage imageNamed:@"ensyfi message screen icons-01.png"];
        selectMail = @"Mail";

    }
    else
    {
        mailFlag = @"0";
        self.mail_ImageView.image = [UIImage imageNamed:@"ensyfi message screen icons-03.png"];
        selectMail = @"";

    }
}

- (IBAction)smsBtn:(id)sender
{
    if ([smsFlag isEqualToString:@"0"])
    {
        smsFlag = @"1";
        self.smsImageView.image = [UIImage imageNamed:@"ensyfi message screen icons-01.png"];
        selectSms = @"SMS";
    }
    else
    {
        smsFlag = @"0";
        self.smsImageView.image = [UIImage imageNamed:@"ensyfi message screen icons-03.png"];
        selectSms = @"";
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

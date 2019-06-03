//
//  GroupNotificationStatusViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "GroupNotificationStatusViewController.h"

@interface GroupNotificationStatusViewController ()
{
    AppDelegate *appDel;
    NSString *group_id_Flag;
    NSString *switchFlag;
    NSString *editButtonFlag;
    NSString *group_lead_id;
    NSString *buttonFlag;

}
@end

@implementation GroupNotificationStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _updateOutlet.layer.cornerRadius = 8.0;
    _updateOutlet.clipsToBounds = YES;
    _titleTxtfield.delegate = self;
    
    _LeadTxtfield.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _LeadTxtfield.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _LeadTxtfield.layer.borderWidth = 1.0f;
    [_LeadTxtfield.layer setCornerRadius:10.0f];
    
    self.titleTxtfield.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_Group_title"];
    self.deactiveLeadLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_lead_name"];
    self.statusLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_status"];
    self.addMemberOutlet.enabled = YES;
    self.notificationOutlet.enabled = YES;
    self.titleDownView.hidden = NO;
    self.LeadTxtfield.hidden = YES;
    self.dropDownImageView.hidden = YES;
    self.switchOutlet.hidden = YES;
    group_id_Flag = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_StrGroup_id"];
    group_lead_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"GN_lead_id"];
    NSString *stat_View = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([stat_View isEqualToString:@"teachers"])
    {

        [self.editButtonOutlet setEnabled:NO];
        [self.editButtonOutlet setTintColor: [UIColor clearColor]];
    }
    else
    {
        [self.editButtonOutlet setEnabled:YES];
        [self.editButtonOutlet setTintColor: [UIColor whiteColor]];
    }
    editButtonFlag = @"YEs";
    buttonFlag = @"NO";
    [_updateOutlet setTitle:@"View Group Members" forState:UIControlStateNormal];
    self.titleTxtfield.enabled = NO;
    self.LeadTxtfield.enabled = NO;
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
- (IBAction)backButton:(id)sender
{
    NSString *stat_View  = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    if ([stat_View isEqualToString:@"teachers"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"stat_user_type"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)switchButton:(id)sender
{
    if ([self.switchOutlet isOn])
    {
        switchFlag = @"Active";
    }
    else
    {
        switchFlag = @"Deactive";
    }
}
- (IBAction)editButton:(id)sender
{
    if ([editButtonFlag isEqualToString:@"YES"])
    {
        [_updateOutlet setTitle:@"Update" forState:UIControlStateNormal];
        self.updateOutlet.bounds = CGRectMake(139, 218, 98, 45);
        self.deactiveLeadLabel.hidden = YES;
        self.dropDownImageView.hidden = NO;
        self.titleTxtfield.enabled = YES;
        self.titleDownView.hidden = NO;
        self.LeadTxtfield.hidden = NO;
        self.LeadTxtfield.enabled = YES;
        self.statusLabel.hidden = YES;
        self.switchOutlet.hidden = NO;
        self.switchOutlet.enabled = YES;
        editButtonFlag = @"NO";
        buttonFlag = @"YES";
        [_titleTxtfield becomeFirstResponder];

    }
    else
    {
        [_titleTxtfield resignFirstResponder];
        self.updateOutlet.bounds = CGRectMake(52, 218, 271, 45);
        [_updateOutlet setTitle:@"View Group Members" forState:UIControlStateNormal];
        self.deactiveLeadLabel.hidden = NO;
        self.statusLabel.hidden = NO;
        self.dropDownImageView.hidden = YES;
        self.titleDownView.hidden = YES;
        self.titleTxtfield.enabled = NO;
        self.LeadTxtfield.enabled = NO;
        self.LeadTxtfield.hidden = YES;
        self.switchOutlet.enabled = NO;
        self.switchOutlet.hidden = YES;
        editButtonFlag = @"YES";
        buttonFlag = @"NO";
    }
}

- (IBAction)updateButton:(id)sender
{
    if ([buttonFlag isEqualToString:@"YES"])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:group_id_Flag forKey:@"group_id"];
        [parameters setObject:self.titleTxtfield.text forKey:@"group_title"];
        [parameters setObject:group_lead_id forKey:@"group_lead_id"];
        [parameters setObject:switchFlag forKey:@"status"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *update_groupmaster = @"apiadmin/update_groupmaster";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,update_groupmaster, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"Group Master Updated"])
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
                                          [self dismissViewControllerAnimated:YES completion:nil];
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
    else
    {
        [self performSegueWithIdentifier:@"viewGroupMembers" sender:self];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.titleTxtfield)
    {
        [_titleTxtfield resignFirstResponder];
    }
    return YES;
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

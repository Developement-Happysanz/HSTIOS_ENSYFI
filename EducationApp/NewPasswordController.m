//
//  NewPasswordController.m
//  EducationApp
//
//  Created by HappySanz on 26/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "NewPasswordController.h"

@interface NewPasswordController ()
{
    AppDelegate *appDel;
}
@end

@implementation NewPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.navigationItem.hidesBackButton = YES;
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
//    NSString *stat_user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
//    
//    if ([stat_user_type isEqualToString:@"admin"])
//    {
//        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"stat_user_type"];
//        
//        
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
//                                                                             imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
//        
//        self.navigationItem.leftBarButtonItem = backButton;
//        
//        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
//        
//    }
    
    
    _newpswd.layer.borderColor = [UIColor colorWithRed:120/255.0f green:67/255.0f blue:154/255.0f alpha:1.0].CGColor;
    _newpswd.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _newpswd.layer.borderWidth = 1.0f;
    [_newpswd.layer setCornerRadius:10.0f];
    
    _confrmpswd.layer.borderColor = [UIColor colorWithRed:120/255.0f green:67/255.0f blue:154/255.0f alpha:1.0].CGColor;
    _confrmpswd.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _confrmpswd.layer.borderWidth = 1.0f;
    [_confrmpswd.layer setCornerRadius:10.0f];
    
    _cnfrmOutlet.layer.borderColor = [UIColor colorWithRed:120/255.0f green:67/255.0f blue:154/255.0f alpha:1.0].CGColor;
    _cnfrmOutlet.layer.cornerRadius = 10;
    _cnfrmOutlet.layer.borderWidth = 1.0f;
    _cnfrmOutlet.clipsToBounds = YES;
    
    _newpswd.delegate = self;
    _confrmpswd.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)dismissKeyboard
{
    [_newpswd resignFirstResponder];
    [_confrmpswd resignFirstResponder];
}
-(IBAction)Back
{
    
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

- (IBAction)confrmBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([self.newpswd.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Type Your New Password"
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
    else if ([self.newpswd.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Type Your Confirm Password"
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
    else if ([self.newpswd.text isEqualToString:self.confrmpswd.text])
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:self.confrmpswd.text forKey:@"password"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forEvent = @"/apimain/reset_Password/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *status = [responseObject objectForKey:@"status"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *email = [responseObject objectForKey:@"Email"];
             
             NSLog(@"%@%@",email,msg);
             
             if ([status isEqualToString:@"sucess"])
             {
                 
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Password Successfully reset. Perform Login in again"
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [self performSegueWithIdentifier:@"to_loginPage" sender:self];
                                          [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"forgotPasswordKey"];

                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
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
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"NewPassword and confirm Password Mismatched"
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
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.newpswd)
    {
        [_confrmpswd becomeFirstResponder];
    }
    else if (theTextField == self.confrmpswd)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
-(void)hideKeyBoard
{
    [self.newpswd resignFirstResponder];
 
    [self.confrmpswd resignFirstResponder];

}

@end

//
//  ForgotPasswordController.m
//  EducationApp
//
//  Created by HappySanz on 26/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ForgotPasswordController.h"

@interface ForgotPasswordController ()
{
    AppDelegate *appDel;
}
@end

@implementation ForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"forgotPasswordKey"];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    _username.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _username.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _username.layer.borderWidth = 1.0f;
    [_username.layer setCornerRadius:10.0f];
    
    _username.delegate = self;
    
    _conformOutlet.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _conformOutlet.layer.cornerRadius = 10;
    _conformOutlet.layer.borderWidth = 1.0f;
    _conformOutlet.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

}
-(void)dismissKeyboard
{
    [_username resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.username)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
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
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"forgotPasswordKey"];

    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)conformBtn:(id)sender
{
    
    if ([self.username.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Alert"
                                   message:@"Please Enter your username."
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
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:self.username.text forKey:@"user_name"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forEvent = @"/apimain/forgot_Password/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *status = [responseObject objectForKey:@"status"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *email = [responseObject objectForKey:@"Email"];
             
             NSLog(@"%@%@",msg,email);
             
             if ([status isEqualToString:@"sucess"])
             {
                 
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Password reset link sent to your Email id successfully"
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                        {

                                          [self performSegueWithIdentifier:@"pswd_login" sender:self];
                                            [[NSUserDefaults standardUserDefaults]setObject:@"From_pswd" forKey:@"From_pswd_key"];

                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }
             else
             {
                 
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:@"Invalid Username"
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
             
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];

    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
-(void)hideKeyBoard
{
    [self.username resignFirstResponder];
    
}
@end

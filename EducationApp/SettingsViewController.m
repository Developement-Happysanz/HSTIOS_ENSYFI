//
//  SettingsViewController.m
//  EducationApp
//
//  Created by HappySanz on 27/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *changepswrd_key = [[NSUserDefaults standardUserDefaults]objectForKey:@"changepswrd_key"];
    
    if ([changepswrd_key isEqualToString:@"yes"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"changepswrd_key"];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage
                                                                             imageNamed:@"back-01.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
        
        self.navigationItem.leftBarButtonItem = backButton;
        
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    else
    {
        SWRevealViewController *revealViewController = self.revealViewController;
        if ( revealViewController )
        {
            [self.sidebarButton setTarget: self.revealViewController];
            [self.sidebarButton setAction: @selector( revealToggle: )];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
        
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        tap.delegate = self;
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

    
    _username.layer.borderColor = [UIColor colorWithRed:120/255.0f green:67/255.0f blue:154/255.0f alpha:1.0].CGColor;
    _username.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _username.layer.borderWidth = 1.0f;
    [_username.layer setCornerRadius:10.0f];
    
    _password.layer.borderColor = [UIColor colorWithRed:120/255.0f green:67/255.0f blue:154/255.0f alpha:1.0].CGColor;
    _password.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _password.layer.borderWidth = 1.0f;
    [_password.layer setCornerRadius:10.0f];
    
    _conformPaswrd.layer.borderColor = [UIColor colorWithRed:120/255.0f green:67/255.0f blue:154/255.0f alpha:1.0].CGColor;
    _conformPaswrd.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _conformPaswrd.layer.borderWidth = 1.0f;
    [_conformPaswrd.layer setCornerRadius:10.0f];
    
    _updateOutlet.layer.cornerRadius = 10;
    _updateOutlet.clipsToBounds = YES;
    
    _username.delegate = self;
    _password.delegate = self;
    _conformPaswrd.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)dismissKeyboard
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    [_conformPaswrd resignFirstResponder];

}
- (IBAction)Back
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ProfileViewController *profileViewController = (ProfileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
//    [self.navigationController pushViewController:profileViewController animated:YES];
    // ios 6
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)updateBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *ogpaswrd = [[NSUserDefaults standardUserDefaults]objectForKey:@"paswrd_key"];
    NSString *curentpaswd = self.username.text;
    NSString *paswd = self.password.text;
    NSString *cnfrmpaswd = self.conformPaswrd.text;

    if ([curentpaswd isEqualToString:@" "])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"please enter Your Old Password"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.username.text = @"";
                                 self.password.text =@"";
                                 self.conformPaswrd.text= @"";
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([paswd isEqualToString:@" "])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Please Enter Your Password"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.username.text = @"";
                                 self.password.text =@"";
                                 self.conformPaswrd.text= @"";
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([cnfrmpaswd isEqualToString:@" "])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"please Enter Confirm Password"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.username.text = @"";
                                 self.password.text =@"";
                                 self.conformPaswrd.text= @"";
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (paswd.length < 8)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Short password are easy to guess! Try one with at above 8 characters.."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.username.text = @"";
                                 self.password.text =@"";
                                 self.conformPaswrd.text= @"";
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (cnfrmpaswd.length < 8)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"Short password are easy to guess! Try one with at above 8 characters.."
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.username.text = @"";
                                 self.password.text =@"";
                                 self.conformPaswrd.text= @"";
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (![paswd isEqualToString:cnfrmpaswd])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"ENSYFI"
                                   message:@"New Password and Confirm Password Mismatched"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 self.username.text = @"";
                                 self.password.text =@"";
                                 self.conformPaswrd.text= @"";
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        [parameters setObject:ogpaswrd forKey:@"old_password"];
        [parameters setObject:self.password.text forKey:@"password"];
        
        [[NSUserDefaults standardUserDefaults]setObject:self.password.text forKey:@"paswrd_key"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forEvent = @"/apimain/change_Password/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forEvent, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *status = [responseObject objectForKey:@"status"];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *email = [responseObject objectForKey:@"Email"];
             
             NSLog(@"%@",email);
             
             if ([status isEqualToString:@"sucess"])
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
                                          if ([appDel.user_type isEqualToString:@"1"])
                                          {
                                              
                                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                                              SWRevealViewController *reveal = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewControllerAdmin"];
                                              [self.navigationController presentViewController:reveal animated:YES completion:nil];
                                          }
                                          else if ([appDel.user_type isEqualToString:@"2"])
                                          {
                                          
                                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                                              SWRevealViewController *reveal = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewControllerTeacher"];
                                              [self.navigationController presentViewController:reveal animated:YES completion:nil];
                                          }
                                          else if ([appDel.user_type isEqualToString:@"3"])
                                          {
                                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                              SWRevealViewController *reveal = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                                              [self.navigationController presentViewController:reveal animated:YES completion:nil];
                                          }
                                          else if ([appDel.user_type isEqualToString:@"4"])
                                          {
                                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                              SWRevealViewController *reveal = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                                              [self.navigationController presentViewController:reveal animated:YES completion:nil];
                                          }
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
             }
             else
             {
                 self.username.text = @"";
                 self.password.text =@"";
                 self.conformPaswrd.text= @"";
             
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"ENSYFI"
                                            message:msg
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *ok = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          
                                      }];
                 
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
-(void)viewDidLayoutSubviews
{
    self.scrollview.contentSize = CGSizeMake(self.view.frame.size.width,803);
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.username)
    {
        [_password becomeFirstResponder];
    }
    else if (theTextField == self.password)
    {
        [_conformPaswrd becomeFirstResponder];
    }
    else if (theTextField == self.conformPaswrd)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollview.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollview.contentInset = contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollview.contentInset = contentInsets;
}
-(void)hideKeyBoard
{
    [self.username resignFirstResponder];
    
    [self.password resignFirstResponder];
    
    [self.conformPaswrd resignFirstResponder];

}
@end

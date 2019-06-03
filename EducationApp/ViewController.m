//
//  ViewController.m
//  EducationApp
//
//  Created by HappySanz on 03/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    AppDelegate *appDel;
}


@property(strong) Reachability * googleReach;
@property(strong) Reachability * localWiFiReach;
@property(strong) Reachability * internetConnectionReach;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Rounded corners and border color for Textfield
    
//    _idTextfield.layer.borderColor = [UIColor whiteColor].CGColor;
//    _idTextfield.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.10f];
//    _idTextfield.layer.borderWidth = 1.0f;
//    [_idTextfield.layer setCornerRadius:10.0f];
    
    _frwdBtnOtlet.layer.cornerRadius = 2.0f;
    _frwdBtnOtlet.clipsToBounds = YES;

    [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

    
    // dismiss keypad
    
    _idTextfield.delegate = self;
    
    // lift the keypad up
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    __weak typeof(self) weakSelf = self;

    
    self.googleReach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    self.googleReach.reachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"GOOGLE Block Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        
        // to update UI components from a block callback
        // you need to dipatch this to the main thread
        // this uses NSOperationQueue mainQueue
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
        }];
    };
    
    self.googleReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"GOOGLE Block Says Unreachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        
        // to update UI components from a block callback
        // you need to dipatch this to the main thread
        // this one uses dispatch_async they do the same thing (as above)
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           UIAlertController *alert= [UIAlertController
                                                      alertControllerWithTitle:@"ENSYFI"
                                                      message:@"Please Check Your Internet connection"
                                                      preferredStyle:UIAlertControllerStyleAlert];
                           
                           UIAlertAction *ok = [UIAlertAction
                                                actionWithTitle:@"OK"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                                                {
                                                    
                                                }];
                           
                           [alert addAction:ok];
                           [weakSelf presentViewController:alert animated:YES completion:nil];
                       });
    };
    
    [self.googleReach startNotifier];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)frwdBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"chkInstid" forKey:@"func_name"];
    [parameters setObject:self.idTextfield.text forKey:@"InstituteID"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [manager POST:appBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"%@",responseObject);
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        NSString *msg = [responseObject objectForKey:@"msg"];
        NSString *status = [responseObject objectForKey:@"status"];
        NSDictionary *dictionary = [responseObject objectForKey:@"userData"];
        NSLog(@"%@%@",dictionary,status);
        
        if ([msg isEqualToString:@"Institute code is valid."])
        {
            /*implemet to store valus in nsobject Class */
            
            NSString *institute_name = [dictionary objectForKey:@"institute_name"];
            NSString *institute_id = [dictionary objectForKey:@"institute_id"];
            NSString *institute_code = [dictionary objectForKey:@"institute_code"];
            NSString *institute_logo = [dictionary objectForKey:@"institute_logo"];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:institute_name forKey:@"institute_name_Key"];
            [[NSUserDefaults standardUserDefaults]setObject:institute_id forKey:@"institute_id_Key"];
            [[NSUserDefaults standardUserDefaults]setObject:institute_code forKey:@"institute_code_Key"];
            
            appDel =  (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            appDel.institute_code = [[NSUserDefaults standardUserDefaults]objectForKey:@"institute_code_Key"];
            NSLog(@"%@",appDel.institute_code);
            /* concordanate the imagepath and baseurl */
            
            NSArray *components = [NSArray arrayWithObjects:baseUrl,@"institute_logo/",institute_logo, nil];
            NSString *institute_logo_url = [NSString pathWithComponents:components];
            NSLog(@"%@",institute_logo_url);

            [[NSUserDefaults standardUserDefaults]setObject:institute_logo_url forKey:@"institute_logo_url"];

            [self performSegueWithIdentifier:@"toLoginview" sender:self];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else
        {

            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"ENSYFI"
                                       message:@"Institute Id cannot be empty"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [MBProgressHUD hideHUDForView:self.view animated:YES];

                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            self.idTextfield.text= @"";
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"error: %@", error);
    }];
    
    
}

#pragma mark TextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    
    if (theTextField == self.idTextfield)
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
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

-(void)hideKeyBoard
{
    [self.idTextfield resignFirstResponder];
}
@end

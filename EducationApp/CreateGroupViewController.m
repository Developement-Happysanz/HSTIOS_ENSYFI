//
//  CreateGroupViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "CreateGroupViewController.h"

@interface CreateGroupViewController ()
{
    AppDelegate *appDel;
    NSString *switchFlag;
    NSString *slectedTeacherName;
    NSMutableArray *name;
    NSMutableArray *user_id;
}
@end

@implementation CreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.titleTxtfield.delegate = self;
    self.LeadName.delegate = self;
    
    _createOutlet.layer.cornerRadius = 8.0;
    _createOutlet.clipsToBounds = YES;
    
    name = [[NSMutableArray alloc]init];
    user_id = [[NSMutableArray alloc]init];

    _LeadName.layer.borderColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0].CGColor;
    _LeadName.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _LeadName.layer.borderWidth = 1.0f;
    [_LeadName.layer setCornerRadius:10.0f];
    
    switchFlag = @"Deactive";
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedTeacherName)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.LeadName setInputView:pickerView];
    [self.LeadName setInputAccessoryView:toolbar];

}
-(void)viewWillAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"1" forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *get_allteachersuserid = @"apiadmin/get_allteachersuserid";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_allteachersuserid, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         [name removeAllObjects];
         [user_id removeAllObjects];
         if ([msg isEqualToString:@"Teacher Details"])
         {
             NSArray *dataArray = [responseObject valueForKey:@"teacherList"];
             for (int i = 0;i < [dataArray count];i++)
             {
                 NSArray *Data = [dataArray objectAtIndex:i];
                 NSString *strName = [Data valueForKey:@"name"];
                 NSString *strUser_id = [Data valueForKey:@"user_id"];
                 
                 [name addObject:strName];
                 [user_id addObject:strUser_id];
             }
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self->pickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self->pickerView)
    {
        if([self.LeadName isFirstResponder])
        {
            return [name count];
        }
    }
    return 0;
    
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self->pickerView)
    {
        if([self.LeadName isFirstResponder])
        {
            return name[row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self->pickerView)
    {
        if([self.LeadName isFirstResponder])
        {
            slectedTeacherName = name[row];
        }
    }
}
-(void)SelectedTeacherName
{
    if([self.LeadName isFirstResponder])
    {
        self.LeadName.text = slectedTeacherName;
        [self.LeadName resignFirstResponder];
    }
}
-(void)CancelButton
{
    if([self.LeadName isFirstResponder])
    {
        [self.LeadName resignFirstResponder];        
    }
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
- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)createButton:(id)sender
{
    if ([self.titleTxtfield.text isEqualToString:@""])
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
    else if ([self.LeadName.text isEqualToString:@""])
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
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUInteger index = [name indexOfObject:slectedTeacherName];
        NSString *lead_id = user_id[index];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"1" forKey:@"user_id"];
        [parameters setObject:self.titleTxtfield.text forKey:@"group_title"];
        [parameters setObject:lead_id forKey:@"group_lead_id"];
        [parameters setObject:switchFlag forKey:@"status"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        /* concordanate with baseurl */
        NSString *add_groupmaster = @"apiadmin/add_groupmaster";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,add_groupmaster, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"Group Master Added"])
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
             else
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
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.titleTxtfield)
    {
        [_LeadName becomeFirstResponder];
    }
    return YES;
}
@end

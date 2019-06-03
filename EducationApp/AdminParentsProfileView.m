//
//  AdminParentsProfileView.m
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminParentsProfileView.h"

@interface AdminParentsProfileView ()
{
    AppDelegate *appDel;
}
@end

@implementation AdminParentsProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.admissionID forKey:@"admission_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_parent_details = @"/apiadmin/get_parent_details";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_parent_details, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);

         [MBProgressHUD hideHUDForView:self.view animated:YES];

         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *parentProfile = [responseObject objectForKey:@"parentProfile"];
         NSArray *fatherProfile = [parentProfile valueForKey:@"fatherProfile"];
//         NSArray *guardianProfile = [parentProfile valueForKey:@"guardianProfile"];
//         NSArray *motherProfile = [parentProfile valueForKey:@"motherProfile"];
//         NSArray *studentsdetails = [parentProfile valueForKey:@"studentsdetails"];

         if ([msg isEqualToString:@"userdetailfound"])
         {
             NSString *name = [fatherProfile valueForKey:@"name"];
             NSString *home_address = [fatherProfile valueForKey:@"home_address"];
             NSString *email = [fatherProfile valueForKey:@"email"];
             NSString *occupation = [fatherProfile valueForKey:@"occupation"];
             NSString *income = [fatherProfile valueForKey:@"income"];
             NSString *mobile = [fatherProfile valueForKey:@"mobile"];
             NSString *home_phone = [fatherProfile valueForKey:@"home_phone"];
             NSString *office_phone = [fatherProfile valueForKey:@"office_phone"];
             
             self.nameLabel.text = name;
             self.addresslabel.text = home_address;
             self.maillabel.text = email;
             self.occupationLabel.text = occupation;
             self.incomelabel.text = income;
             self.mobilelabel.text = mobile;
             self.homePhone.text = home_phone;
             self.officePhone.text = office_phone;

         }

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];

    [MBProgressHUD hideHUDForView:self.view animated:YES];

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

- (IBAction)fatherBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.admissionID forKey:@"admission_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_parent_details = @"/apiadmin/get_parent_details";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_parent_details, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         
         NSLog(@"%@",responseObject);
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *parentProfile = [responseObject objectForKey:@"parentProfile"];
         NSArray *fatherProfile = [parentProfile valueForKey:@"fatherProfile"];
         
//       NSArray *guardianProfile = [parentProfile valueForKey:@"guardianProfile"];
//       NSArray *motherProfile = [parentProfile valueForKey:@"motherProfile"];
//       NSArray *studentsdetails = [parentProfile valueForKey:@"studentsdetails"];
         
         if ([msg isEqualToString:@"userdetailfound"])
         {
             NSString *name = [fatherProfile valueForKey:@"name"];
             NSString *home_address = [fatherProfile valueForKey:@"home_address"];
             NSString *email = [fatherProfile valueForKey:@"email"];
             NSString *occupation = [fatherProfile valueForKey:@"occupation"];
             NSString *income = [fatherProfile valueForKey:@"income"];
             NSString *mobile = [fatherProfile valueForKey:@"mobile"];
             NSString *home_phone = [fatherProfile valueForKey:@"home_phone"];
             NSString *office_phone = [fatherProfile valueForKey:@"office_phone"];
             
             self.nameLabel.text = name;
             self.addresslabel.text = home_address;
             self.maillabel.text = email;
             self.occupationLabel.text = occupation;
             self.incomelabel.text = income;
             self.mobilelabel.text = mobile;
             self.homePhone.text = home_phone;
             self.officePhone.text = office_phone;
             
         }

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (IBAction)guardianBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.admissionID forKey:@"admission_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_parent_details = @"/apiadmin/get_parent_details";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_parent_details, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         
         NSLog(@"%@",responseObject);
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];

         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *parentProfile = [responseObject objectForKey:@"parentProfile"];
         NSArray *guardianProfile = [parentProfile valueForKey:@"guardianProfile"];
         
         if ([msg isEqualToString:@"userdetailfound"])
         {
             NSString *name = [guardianProfile valueForKey:@"name"];
             NSString *home_address = [guardianProfile valueForKey:@"home_address"];
             NSString *email = [guardianProfile valueForKey:@"email"];
             NSString *occupation = [guardianProfile valueForKey:@"occupation"];
             NSString *income = [guardianProfile valueForKey:@"income"];
             NSString *mobile = [guardianProfile valueForKey:@"mobile"];
             NSString *home_phone = [guardianProfile valueForKey:@"home_phone"];
             NSString *office_phone = [guardianProfile valueForKey:@"office_phone"];
             
             self.nameLabel.text = name;
             self.addresslabel.text = home_address;
             self.maillabel.text = email;
             self.occupationLabel.text = occupation;
             self.incomelabel.text = income;
             self.mobilelabel.text = mobile;
             self.homePhone.text = home_phone;
             self.officePhone.text = office_phone;
             
         }

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (IBAction)motherBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.admissionID forKey:@"admission_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *get_parent_details = @"/apiadmin/get_parent_details";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_parent_details, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         
         NSLog(@"%@",responseObject);
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];

         NSString *msg = [responseObject objectForKey:@"msg"];
         NSArray *parentProfile = [responseObject objectForKey:@"parentProfile"];
         NSArray *motherProfile = [parentProfile valueForKey:@"motherProfile"];
         
         if ([msg isEqualToString:@"userdetailfound"])
         {
             
             @try
             {
                 
                 NSString *name = [motherProfile valueForKey:@"name"];
                 NSString *home_address = [motherProfile valueForKey:@"home_address"];
                 NSString *email = [motherProfile valueForKey:@"email"];
                 NSString *occupation = [motherProfile valueForKey:@"occupation"];
                 NSString *income = [motherProfile valueForKey:@"income"];
                 NSString *mobile = [motherProfile valueForKey:@"mobile"];
                 NSString *home_phone = [motherProfile valueForKey:@"home_phone"];
                 NSString *office_phone = [motherProfile valueForKey:@"office_phone"];

                 self.nameLabel.text = name;
                 self.addresslabel.text = home_address;
                 self.maillabel.text = email;
                 self.occupationLabel.text = occupation;
                 self.incomelabel.text = income;
                 self.mobilelabel.text = mobile;
                 self.homePhone.text = home_phone;
                 self.officePhone.text = office_phone;
             }
             @catch (NSException *exception)
             {
                 
             }
             
             
         }

     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (IBAction)viewStudentinfo:(id)sender
{
    [self performSegueWithIdentifier:@"to_Adminparent_studentProf" sender:self];
    
}

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

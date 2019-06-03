//
//  ODPermisionViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 30/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ODPermisionViewController.h"

@interface ODPermisionViewController ()
{
     AppDelegate *appDel;
}
@end

@implementation ODPermisionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _acceptOutlet.layer.cornerRadius = 8.0;
    _acceptOutlet.clipsToBounds = YES;
    
    _declineOutlet.layer.cornerRadius = 8.0;
    _declineOutlet.clipsToBounds = YES;
    
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"odName"];
    self.dateLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"oddate"];
    self.decrptionTxtView.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"odStatus"];
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

- (IBAction)acceptBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *od_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"OD_id"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:od_id forKey:@"od_id"];
    [parameters setObject:@"Approved" forKey:@"status"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *disp_Leavetype = @"apiadmin/update_teachers_od/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Leavetype, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         if ([msg isEqualToString:@"Onduty Updated"])
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
- (IBAction)declineBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *od_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"OD_id"];
    [parameters setObject:od_id forKey:@"od_id"];
    [parameters setObject:@"Rejected" forKey:@"status"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *disp_Leavetype = @"apiadmin/update_teachers_od/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_Leavetype, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"Onduty Updated"])
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
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

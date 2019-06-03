 //
//  AdminLeaveApproveViewController.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 30/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "AdminLeaveApproveViewController.h"

@interface AdminLeaveApproveViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation AdminLeaveApproveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _acceptOutlet.layer.cornerRadius = 8.0;
    _acceptOutlet.clipsToBounds = YES;
    
    _declineOutlet.layer.cornerRadius = 8.0;
    _declineOutlet.clipsToBounds = YES;
    
    self.subView.layer.cornerRadius = 5.0;
    self.subView.clipsToBounds = YES;
    
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminLeave_Name"];
    self.dateLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminLeave_date"];
    self.textView.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminLeave_Title"];
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
    NSString *strLeave_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminLeave_id"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:strLeave_id forKey:@"leave_id"];
    [parameters setObject:@"Approved" forKey:@"status"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *get_teachers_leaves = @"/apiadmin/update_teachers_leaves/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_teachers_leaves, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         if ([msg isEqualToString:@"leavesfound"])
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
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *strLeave_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"adminLeave_id"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:strLeave_id forKey:@"leave_id"];
    [parameters setObject:@"Rejected" forKey:@"status"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *get_teachers_leaves = @"/apiadmin/update_teachers_leaves/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_teachers_leaves, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"leavesfound"])
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

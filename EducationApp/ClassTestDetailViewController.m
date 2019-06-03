//
//  ClassTestDetailViewController.m
//  EducationApp
//
//  Created by HappySanz on 20/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ClassTestDetailViewController.h"

@interface ClassTestDetailViewController ()
{
    AppDelegate *appDel;
}

@end

@implementation ClassTestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mainView.layer.cornerRadius = 5;
    _mainView.layer.masksToBounds = true;
    
    NSString *hwType = [[NSUserDefaults standardUserDefaults]objectForKey:@"hw_type_Key"];
    NSString *mark_status = [[NSUserDefaults standardUserDefaults]objectForKey:@"mark_status_key"];
    
    if ([mark_status isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"mark_status_key"];

        self.markOutlet.hidden = NO;
        self.markLabel.hidden = NO;
        self.markLineLabel.hidden = NO;
        
        self.remarksOtlet.hidden = NO;
        self.remarks.hidden = NO;
        self.remarksLineLabel.hidden = NO;
        
        NSString *hw_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"hw_id_Key"];
        NSString *registered_id_key = [[NSUserDefaults standardUserDefaults]objectForKey:@"registered_id_key"];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:registered_id_key forKey:@"entroll_id"];
        [parameters setObject:hw_id forKey:@"hw_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *forHomeWork = @"/apistudent/disp_Ctestmarks/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forHomeWork, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSArray *array_ctestmarkDetails = [responseObject objectForKey:@"ctestmarkDetails"];
             NSDictionary *classTest = [array_ctestmarkDetails objectAtIndex:0];
             NSString *msg = [responseObject objectForKey:@"msg"];
             if ([msg isEqualToString:@"View Class Test"])
             {
                 NSString *marksStr = [classTest objectForKey:@"marks"];
                 self.markLabel.text = [NSString stringWithFormat:@"%@",marksStr];
                 self.remarks.text = [classTest valueForKey:@"remarks"];
                 
                 if ([self.remarks.text isEqualToString:@""])
                 {
                     self.remarksOtlet.hidden = YES;
                     self.remarks.hidden = YES;
                     self.remarksLineLabel.hidden = YES;
                 }
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

        self.markOutlet.hidden = YES;
        self.markLabel.hidden = YES;
        self.markLineLabel.hidden = YES;
        
        self.remarksOtlet.hidden = YES;
        self.remarks.hidden = YES;
        self.remarksLineLabel.hidden = YES;
    }
    
    if ([hwType isEqualToString:@"HT"])
    {        
    self.navigationItem.title = @"Class Test";
    
    }
    else
    {
        self.navigationItem.title = @"Home Work";
        
        self.markOutlet.hidden = YES;
        self.markLabel.hidden = YES;
        self.markLineLabel.hidden = YES;
        
        self.remarksOtlet.hidden = YES;
        self.remarks.hidden = YES;
        self.remarksLineLabel.hidden = YES;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *subjectname = [[NSUserDefaults standardUserDefaults]objectForKey:@"subjectNameKey"];
    NSString *title = [[NSUserDefaults standardUserDefaults]objectForKey:@"subjectTitleKey"];
    NSString *descrp = [[NSUserDefaults standardUserDefaults]objectForKey:@"hw_details_Str_Key"];
    
    self.subjectTitle.text = subjectname;
    self.titleLabel.text = title;
    self.descriptionView.text = descrp;

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

- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLayoutSubviews
{
    [self.descriptionView setContentOffset:CGPointZero animated:NO];
    [self.remarks setContentOffset:CGPointZero animated:NO];

}
@end

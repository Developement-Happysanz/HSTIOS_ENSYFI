//
//  TeacherTimeTableAddNotes.m
//  EducationApp
//
//  Created by HappySanz on 14/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherTimeTableAddNotes.h"

@interface TeacherTimeTableAddNotes ()
{
    AppDelegate *appdel;
}
@end

@implementation TeacherTimeTableAddNotes

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *className = [[NSUserDefaults standardUserDefaults]objectForKey:@"clasName_key"];
    NSString *subjecName = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_key"];
    NSString *period = [[NSUserDefaults standardUserDefaults]objectForKey:@"period_key"];
    
    self.classNameLabel.text = className;
    self.subjectnameLabel.text = subjecName;
    self.periodlabel.text = period;

    self.detailstxtview.delegate = self;
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

- (IBAction)submitBtn:(id)sender
{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", dateString);
    
    NSString *class_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_id_key"];
    NSString *subject_id =[[NSUserDefaults standardUserDefaults]objectForKey:@"subject_id_key"];
    
    appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:dateString forKey:@"time_date"];
    [parameters setObject:class_id forKey:@"class_id"];
    [parameters setObject:subject_id forKey:@"subject_id"];
    [parameters setObject:@"2" forKey:@"user_type"];
    [parameters setObject:appdel.user_id forKey:@"user_id"];
    [parameters setObject:self.detailstxtview.text forKey:@"comments"];
    [parameters setObject:dateString forKey:@"created_at"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forEvent = @"/apiteacher/add_Timetablereview/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appdel.institute_code,forEvent, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];

         NSString *msg = [responseObject objectForKey:@"msg"];
         if ([msg isEqualToString:@"Timetablereview Added"])
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
                                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
                                      TeachersTimeTableView *teachersTimeTableView = (TeachersTimeTableView *)[storyboard instantiateViewControllerWithIdentifier:@"TeachersTimeTableView"];
                                      [self.navigationController pushViewController:teachersTimeTableView animated:YES];
                                      
                                  }];
             
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
         else
         {
             
         }
     
     }
     
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
@end

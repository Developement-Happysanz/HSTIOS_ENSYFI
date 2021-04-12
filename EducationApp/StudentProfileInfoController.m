//
//  StudentProfileInfoController.m
//  EducationApp
//
//  Created by HappySanz on 11/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "StudentProfileInfoController.h"

@interface StudentProfileInfoController ()
{
    AppDelegate *appDel;
    NSString *student_pic;
}
@end

@implementation StudentProfileInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    
    self.mainView.layer.shadowRadius  = 5.5f;
    self.mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    self.mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    self.mainView.layer.shadowOpacity = 0.6f;
    self.mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.mainView.bounds, shadowInsets)];
    self.mainView.layer.shadowPath    = shadowPath.CGPath;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    NSString *admission_id_key = [[NSUserDefaults standardUserDefaults]objectForKey:@"admission_id_key"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.admissionID forKey:@"stud_admission_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forStudentProfile = @"/apistudent/showStudentProfile/";
//    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forStudentProfile, nil];
    NSArray *components = [NSArray arrayWithObjects:baseUrl,forStudentProfile, nil];

    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         NSArray *Profile = [responseObject objectForKey:@"studentProfile"];
         NSArray *studentProfile = [Profile objectAtIndex:0];
         NSLog(@"%@",status);
         
         if ([msg isEqualToString:@"Student Profile"])
         {
             
             NSString *admDate = [studentProfile valueForKey:@"admisn_date"];
             NSString *admNo = [studentProfile valueForKey:@"admisn_no"];
             NSString *admYear = [studentProfile valueForKey:@"admisn_year"];
             NSString *admid = [studentProfile valueForKey:@"admission_id"];
             NSString *age = [studentProfile valueForKey:@"age"];
             NSString *comunity = [studentProfile valueForKey:@"community"];
             NSString *comu_class = [studentProfile valueForKey:@"community_class"];
             NSString *dob = [studentProfile valueForKey:@"dob"];
             NSString *email = [studentProfile valueForKey:@"email"];
             NSString *emsi = [studentProfile valueForKey:@"emsi_num"];
             NSString *language = [studentProfile valueForKey:@"language"];
             NSString *lastSch_name = [studentProfile valueForKey:@"last_sch_name"];
             NSString *mob = [studentProfile valueForKey:@"mobile"];
             NSString *mothertonque = [studentProfile valueForKey:@"mother_tongue"];
             NSString *name = [studentProfile valueForKey:@"name"];
             NSString *nationality = [studentProfile valueForKey:@"nationality"];
             NSString *parentStatus = [studentProfile valueForKey:@"parents_status"];
             NSString *parent_guardn = [studentProfile valueForKey:@"parnt_guardn"];
             NSString *parent_guardn_id = [studentProfile valueForKey:@"parnt_guardn_id"];
             NSString *qualified = [studentProfile valueForKey:@"qualified_promotion"];
             NSString *record_shet = [studentProfile valueForKey:@"record_sheet"];
             NSString *religion = [studentProfile valueForKey:@"religion"];
             NSString *sec_email = [studentProfile valueForKey:@"sec_email"];
             NSString *sec_mob = [studentProfile valueForKey:@"sec_mobile"];
             NSString *sex = [studentProfile valueForKey:@"sex"];
             NSString *status = [studentProfile valueForKey:@"status"];
             NSString *tc = [studentProfile valueForKey:@"transfer_certificate"];
             
             self->student_pic  = [studentProfile valueForKey:@"student_pic"];
             self.admisnDate.text = admDate;
             self.admisonNumber.text = admNo;
             self.admisionYear.text = admYear;
             self.admisionID.text = admid;
             self.age.text = age;
             self.comunity.text = comunity;
             self.caste.text = comu_class;
             self.dob.text = dob;
             self.mail.text = email;
             self.emsiNum.text = emsi;
             self.laungage.text = language;
             self.previousSchool.text = lastSch_name ;
             self.mobile.text = mob;
             self.motherTongue.text = mothertonque;
             self.name.text = name;
             self.nationality.text = nationality;
             self.parentStatus.text = parentStatus;
             self.parentOrguardian.text = parent_guardn;
             self.parentOrGuardianId.text = parent_guardn_id;
             self.promotionStatus.text = qualified ;
             self.recordSheet.text = record_shet;
             self.religion.text = religion;
             self.secondaryMail.text = sec_email;
             self.secondaryMobile.text = sec_mob ;
             self.gender.text = sex;
             self.status.text = status;
             self.tc.text = tc;
             
//             appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//             
//             if ([student_pic isEqualToString:@""])
//             {
//                 
//             }
//             else
//             {
//                 NSArray *studentPicComponets = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,student_profile,student_pic, nil];
//                 NSString *sfullpath= [NSString pathWithComponents:studentPicComponets];
//                 NSURL *url = [NSURL URLWithString:sfullpath];
//                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                     NSData *studentImageData = [NSData dataWithContentsOfURL:url];
//                     
//                     dispatch_async(dispatch_get_main_queue(), ^{
//                         // Update the UI
//                         self.studentImg.image = [UIImage imageWithData:studentImageData];
//                         //            self.studentImg.layer.cornerRadius = 50.0;
//                         self.studentImg.clipsToBounds = YES;
//                     });
//                 });
//             }
//             
//
         }
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
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
-(void)viewDidLayoutSubviews
{
   // self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,967);
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
    [self dismissViewControllerAnimated:YES completion:Nil];
}
@end

//
//  TimeTableViewController.m
//  EducationApp
//
//  Created by HappySanz on 20/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TimeTableViewController.h"

@interface TimeTableViewController ()
{
    AppDelegate *appDel;
    NSArray *period;
    NSArray *subject_name;
}
@end

@implementation TimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
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
    
    period = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.class_id forKey:@"class_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    /* concordanate with baseurl */
    NSString *forExam = @"/apistudent/disp_Timetable/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forExam, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSArray *arr_timeTable = [responseObject objectForKey:@"timeTable"];
         NSString *msg = [responseObject objectForKey:@"msg"];
         
         if ([msg isEqualToString:@"View Timetable"])
         {
             self->period = [arr_timeTable valueForKey:@"subject_name"];
             self->subject_name = [arr_timeTable valueForKey:@"subject_name"];
             
             @try
             {
                 self.oneperiodLabel1.text = [self->subject_name objectAtIndex:0];
                 self.oneperiodLabel2.text = [self->subject_name objectAtIndex:1];
                 self.oneperiodLabe3.text = [self->subject_name objectAtIndex:2];
                 self.oneperiodLabel4.text = [self->subject_name objectAtIndex:3];
                 self.oneperiodLabel5.text = [self->subject_name objectAtIndex:4];
                 self.oneperiodLabel6.text = [self->subject_name objectAtIndex:5];
                 self.oneperiodLabel7.text = [self->subject_name objectAtIndex:6];
                 self.oneperiodLabel8.text = [self->subject_name objectAtIndex:7];
                 self.twoperiodLabel1.text = [self->subject_name objectAtIndex:8];
                 self.twoperiodLabel2.text = [self->subject_name objectAtIndex:9];
                 self.twoperiodLabel3.text = [self->subject_name objectAtIndex:10];
                 self.twoperiodLabel4.text = [self->subject_name objectAtIndex:11];
                 self.twoperiodLabel5.text = [self->subject_name objectAtIndex:12];
                 self.twoperiodLabel6.text = [self->subject_name objectAtIndex:13];
                 self.twoperiodLabel7.text = [self->subject_name objectAtIndex:14];
                 self.twoperiodLabel8.text = [self->subject_name objectAtIndex:15];
                 self.threperiodLabel1.text = [self->subject_name objectAtIndex:16];
                 self.threperiodLabel2.text = [self->subject_name objectAtIndex:17];
                 self.threperiodLabel3.text = [self->subject_name objectAtIndex:18];
                 self.threperiodLabel4.text = [self->subject_name objectAtIndex:19];
                 self.threperiodLabel5.text = [self->subject_name objectAtIndex:20];
                 self.threperiodLabel6.text = [self->subject_name objectAtIndex:21];
                 self.threperiodLabel7.text = [self->subject_name objectAtIndex:22];
                 self.threperiodLabel8.text = [self->subject_name objectAtIndex:23];
                 self.fourperiodLabel1.text = [self->subject_name objectAtIndex:24];
                 self.fourperiodLabel2.text = [self->subject_name objectAtIndex:25];
                 self.fourperiodLabel3.text = [self->subject_name objectAtIndex:26];
                 self.fourperiodLabel4.text = [self->subject_name objectAtIndex:27];
                 self.fourperiodLabel5.text = [self->subject_name objectAtIndex:28];
                 self.fourperiodLabel6.text = [self->subject_name objectAtIndex:29];
                 self.fourperiodLabel7.text = [self->subject_name objectAtIndex:30];
                 self.fourperiodLabel8.text = [self->subject_name objectAtIndex:31];
                 self.fiveperiodLabel1.text = [self->subject_name objectAtIndex:32];
                 self.fiveperiodLabel2.text = [self->subject_name objectAtIndex:33];
                 self.fiveperiodLabel3.text = [self->subject_name objectAtIndex:34];
                 self.fiveperiodLabel4.text = [self->subject_name objectAtIndex:35];
                 self.fiveperiodLabel5.text = [self->subject_name objectAtIndex:36];
                 self.fiveperiodLabel6.text = [self->subject_name objectAtIndex:37];
                 self.fiveperiodLabel7.text = [self->subject_name objectAtIndex:38];
                 self.fiveperiodLabel8.text = [self->subject_name objectAtIndex:39];
                 
                 self.sixperiodLabel1.text = [self->subject_name objectAtIndex:40];
                 self.sixperiodLabel2.text = [self->subject_name objectAtIndex:41];
                 self.sixperiodLabel3.text = [self->subject_name objectAtIndex:42];
                 self.sixperiodLabel4.text = [self->subject_name objectAtIndex:43];
                 self.sixperiodLabel5.text = [self->subject_name objectAtIndex:44];
                 self.sixperiodLabel6.text = [self->subject_name objectAtIndex:45];
                 self.sixperiodLabel7.text = [self->subject_name objectAtIndex:46];
                 self.sixperiodLabel8.text = [self->subject_name objectAtIndex:47];

             }
             @catch (NSException *exception)
             {
                 
             }
             
         }

         
         
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
-(void)viewDidLayoutSubviews
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))
        {
            self.scrollView.contentSize = CGSizeMake(1753,400);

        }
        else
        {
            self.scrollView.contentSize = CGSizeMake(1453,400);

        }
    }
    else
    {
        self.scrollView.contentSize = CGSizeMake(1053,400);

    }
    
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

@end

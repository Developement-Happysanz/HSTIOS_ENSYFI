
//
//  MainViewController.m
//  EducationApp
//
//  Created by HappySanz on 12/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()
{
    AppDelegate *appDel;
    NSArray *menuImages;
    NSArray *menuTitles;

    NSMutableArray *ab_date;
    NSMutableArray *student_id;
}
@end

@implementation MainViewController

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

    ab_date = [[NSMutableArray alloc]init];
    
    menuImages = [NSArray arrayWithObjects:@"attendance.png",@"classtest-01.png",@"exam-01.png",@"timetable-01.png",@"Events.png",@"communication-01.png",nil];
    menuTitles= [NSArray arrayWithObjects:@"ATTENDANCE",@"CLASS TEST & HOMEWORK",@"EXAM & RESULT",@"TIME TABLE",@"EVENTS",@"CIRCULAR", nil];
    
    //...For Tapping cells....
    
    [tap setCancelsTouchesInView:NO];
}
- (void)viewWillLayoutSubviews;
{
    [super viewWillLayoutSubviews];
    UICollectionViewFlowLayout *flowLayout = (id)self.collectionView.collectionViewLayout;
    
    if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))
    {
        flowLayout.itemSize = CGSizeMake(500.f, 500.f);
        
        flowLayout.sectionInset = UIEdgeInsetsMake(60, 30, 60, 30);
    } else
    {
//        flowLayout.itemSize = CGSizeMake(192.f, 192.f);
    }
    
    [flowLayout invalidateLayout]; //force the elements to get laid out again with the new size
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [menuImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [cell.imageview setFrame:CGRectMake(38, 25, 130, 130)];

    }
    cell.cellview.layer.borderWidth = 1.0f;
    cell.cellview.layer.borderColor = [UIColor grayColor].CGColor;
    cell.cellview.layer.cornerRadius = 10.0f;
    cell.imageview.image = [UIImage imageNamed:menuImages[indexPath.row]];
    cell.menuTitles.text = [menuTitles objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0)
    {

//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
//        [parameters setObject:appDel.class_id forKey:@"class_id"];
//        [parameters setObject:appDel.student_id forKey:@"stud_id"];
//        
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        
//        
//        /* concordanate with baseurl */
//        NSString *forAttendance = @"/apistudent/disp_Attendence/";
//        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,forAttendance, nil];
//        NSString *api = [NSString pathWithComponents:components];
//        
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
//         {
//             
//             NSLog(@"%@",responseObject);
//             
//             NSArray *arr_Attendance = [responseObject objectForKey:@"attendenceDetails"];
//             NSString *msg = [responseObject objectForKey:@"msg"];
//             
//             if ([msg isEqualToString:@"View Attendence"])
//             {
//                 
//                 NSArray *attendenceHistory = [responseObject objectForKey:@"attendenceHistory"];
//                 NSString *absent_days = [attendenceHistory valueForKey:@"absent_days"];
//                 NSString *leave_days = [attendenceHistory valueForKey:@"leave_days"];
//                 NSString *od_days = [attendenceHistory valueForKey:@"od_days"];
//                 NSString *present_days = [attendenceHistory valueForKey:@"present_days"];
//                 NSString *total_working_days = [attendenceHistory valueForKey:@"total_working_days"];
//                 
//                 
//                 for (int i = 0; i < [arr_Attendance count]; i++)
//                 {
//                     NSDictionary *dict = [arr_Attendance objectAtIndex:i];
//                     NSString *abDate= [dict valueForKey:@"abs_date"];
//                     [ab_date addObject:abDate];
//                     
//                 }
//
//                 NSArray *abs_date = [NSArray arrayWithArray:ab_date];
//
//                 [[NSUserDefaults standardUserDefaults] setObject:abs_date forKey:@"abs_date_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:absent_days forKey:@"absent_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:leave_days forKey:@"leave_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:od_days forKey:@"od_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:present_days forKey:@"present_days_Key"];
//                 [[NSUserDefaults standardUserDefaults] setObject:total_working_days forKey:@"total_working_days_Key"];
        

                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 AttendanceViewController *attendance = (AttendanceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AttendanceViewController"];
                 [self.navigationController pushViewController:attendance animated:YES];
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
//             }
//             else
//             {
//                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                 AttendanceViewController *attendance = (AttendanceViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AttendanceViewController"];
//                 [self.navigationController pushViewController:attendance animated:YES];
//                 
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
//                 
//             }
//             
//             [[NSUserDefaults standardUserDefaults] setObject:msg forKey:@"msg_attendance_Key"];
//
//             
//         }
//              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
//         {
//             NSLog(@"error: %@", error);
//         }];

    }
    else if (indexPath.row == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ClassTestViewController *classTest = (ClassTestViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ClassTestViewController"];
        [self.navigationController pushViewController:classTest animated:YES];
    }
    else if (indexPath.row == 2)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExamsViewController *exam = (ExamsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ExamsViewController"];
        [self.navigationController pushViewController:exam animated:YES];

    }
    else if (indexPath.row == 3)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TimeTableViewController *exam = (TimeTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TimeTableViewController"];
        [self.navigationController pushViewController:exam animated:YES];
        
    }
    else if (indexPath.row == 4)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EventViewController *eventView = (EventViewController *)[storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
        [self.navigationController pushViewController:eventView animated:YES];
        
    }
    else if (indexPath.row == 5)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommunicationViewController *eventView = (CommunicationViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CommunicationViewController"];
        [self.navigationController pushViewController:eventView animated:YES];
        
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))
        {
            return UIEdgeInsetsMake(60, 30, 60, 30);

        }
     
        return UIEdgeInsetsMake(40, 50, 40, 50);

    }
    else
    {

        
        return UIEdgeInsetsMake(20, 10, 20, 10);

    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
     // The device is an iPad running iOS 3.2 or later.
        
        return 15;

    }
    else
    {
        // The device is an iPhone or iPod touch
        
        return 15;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iOS 3.2 or later.
       
        return CGSizeMake(310.f,310.f);

    }

    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        
        return CGSizeMake(140.f, 140.f);

    }
    
    return CGSizeMake(170.f, 170.f);

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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

@end

//
//  AdminViewController.m
//  EducationApp
//
//  Created by HappySanz on 17/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController ()
{
    AppDelegate *appDel;
    NSArray *menuImages;
    NSArray *menuTitles;
    NSMutableArray *class_id;
    NSMutableArray *class_name;
}
@end

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebar setTarget: self.revealViewController];
        [self.sidebar setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    class_id = [[NSMutableArray alloc]init];
    class_name = [[NSMutableArray alloc]init];
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    
    menuImages = [NSArray arrayWithObjects:@"students.png",@"Teacher",@"Parents-01.png",@"Class.png",@"exam-01 (1).png",@"exam-01.png",@"Events.png",@"communication-01.png",nil];
    menuTitles= [NSArray arrayWithObjects:@"STUDENTS",@"TEACHERS",@"PARENTS",@"CLASSES",@"EXAMS",@"RESULT",@"EVENT",@"CIRCULAR", nil];
    //...For Tapping cells....
    
    [tap setCancelsTouchesInView:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [menuTitles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AdminCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [cell.imageView setFrame:CGRectMake(38, 25, 130, 130)];
        
    }
    cell.cellView.layer.borderWidth = 1.0f;
    cell.cellView.layer.borderColor = [UIColor grayColor].CGColor;
    cell.cellView.layer.cornerRadius = 10.0f;
    cell.imageView.image = [UIImage imageNamed:menuImages[indexPath.row]];
    cell.title.text = [menuTitles objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0)
    {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];

             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                 AdminStudentViewController *adminStudent = (AdminStudentViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminStudentViewController"];
                 [self.navigationController pushViewController:adminStudent animated:YES];

                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
        
    }
    else if (indexPath.row == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        AdminTeacherView *adminTeacher = (AdminTeacherView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminTeacherView"];
        [self.navigationController pushViewController:adminTeacher animated:YES];
    }
    else if (indexPath.row == 2)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                 AdminParentsViewController *adminParents = (AdminParentsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminParentsViewController"];
                 [self.navigationController pushViewController:adminParents animated:YES];
                 
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else if (indexPath.row == 3)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                 AdminClassesViewController *adminClasses = (AdminClassesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminClassesViewController"];
                 [self.navigationController pushViewController:adminClasses animated:YES];
                 
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];

        
    }
    else if (indexPath.row == 4)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                 AdminExamViewController *adminExam = (AdminExamViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminExamViewController"];
                 [self.navigationController pushViewController:adminExam animated:YES];
                 
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
    else if (indexPath.row == 5)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_id forKey:@"user_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        /* concordanate with baseurl */
        NSString *get_all_classes = @"/apiadmin/get_all_classes/";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSArray *data = [responseObject objectForKey:@"data"];
             
             if ([msg isEqualToString:@"success"])
             {
                 for (int i = 0;i < [data count] ; i++)
                 {
                     NSDictionary *dict = [data objectAtIndex:i];
                     NSString *clas_id = [dict objectForKey:@"class_id"];
                     NSString *clas_name = [dict objectForKey:@"class_name"];
                     
                     [class_id addObject:clas_id];
                     [class_name addObject:clas_name];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:class_id forKey:@"admin_class_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:class_name forKey:@"admin_class_name"];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
                 AdminResultView *adminResultView = (AdminResultView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminResultView"];
                 [self.navigationController pushViewController:adminResultView animated:YES];
                 
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             
             
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
     else if (indexPath.row == 6)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
        AdminEventTableViewController *adminEventTableView = (AdminEventTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdminEventTableViewController"];
        [self.navigationController pushViewController:adminEventTableView animated:YES];
    }
    else if (indexPath.row == 7)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommunicationViewController *admin_communication = (CommunicationViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CommunicationViewController"];
        [self.navigationController pushViewController:admin_communication animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

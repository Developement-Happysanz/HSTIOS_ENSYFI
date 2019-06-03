//
//  TeacherViewController.m
//  EducationApp
//
//  Created by HappySanz on 02/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherViewController.h"

@interface TeacherViewController ()
{
    AppDelegate *appDel;
    NSArray *menuImages;
    NSArray *menuTitles;
}
@end

@implementation TeacherViewController

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
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    menuImages = [NSArray arrayWithObjects:@"attendance.png",@"classtest-01.png",@"exam-01.png",@"timetable-01.png",@"Events.png",@"communication-01.png",nil];
    
    menuTitles= [NSArray arrayWithObjects:@"ATTENDANCE",@"CLASS TEST & HOMEWORK",@"EXAM & RESULT",@"TIME TABLE",@"EVENTS",@"CIRCULAR", nil];
    
    //...For Tapping cells....    
    [tap setCancelsTouchesInView:NO];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

    appDel.user_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_name_key"];
    appDel.user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id_key"];
    appDel.user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_type_key"];
    appDel.user_type_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_type_name_key"];
    
    appDel.user_password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password_status_key"];
    appDel.user_picture = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"];
    appDel.name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name_key"];
    appDel.institute_code = [[NSUserDefaults standardUserDefaults]objectForKey:@"institute_code_Key"];
    NSLog(@"%@",appDel.institute_code);
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"teacher_attendance_resultKey"];
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
     TeacherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
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
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherAttendanceView *teacherAttendanceView = (TeacherAttendanceView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherAttendanceView"];
        [self.navigationController pushViewController:teacherAttendanceView animated:YES];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }
    else if (indexPath.row == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherClasstestHomeWorkView *teacherClasstestHomeWorkView = (TeacherClasstestHomeWorkView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClasstestHomeWorkView"];
        [self.navigationController pushViewController:teacherClasstestHomeWorkView animated:YES];
    }
    else if (indexPath.row == 2)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
         TeacherExamViewController *teacherExamViewController = (TeacherExamViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamViewController"];
        [self.navigationController pushViewController:teacherExamViewController animated:YES];
        
    }
    else if (indexPath.row == 3)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeachersTimeTableView *teachersTimeTableView = (TeachersTimeTableView *)[storyboard instantiateViewControllerWithIdentifier:@"TeachersTimeTableView"];
        [self.navigationController pushViewController:teachersTimeTableView animated:YES];
        
    }
    else if (indexPath.row == 4)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherEventViewController *teacherEventViewController = (TeacherEventViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherEventViewController"];
        [self.navigationController pushViewController:teacherEventViewController animated:YES];
        
    }
    else if (indexPath.row == 5)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherCirularTableViewController *teacherCirularTableViewController = (TeacherCirularTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherCirularTableViewController"];
        [self.navigationController pushViewController:teacherCirularTableViewController animated:YES];
        
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

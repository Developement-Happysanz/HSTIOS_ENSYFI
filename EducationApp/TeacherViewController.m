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
    
   
    [_classAttendanceOutlet.layer setCornerRadius:08.0f];
    [_classAssignmentOutlet.layer setCornerRadius:08.0f];

    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    menuImages = [NSArray arrayWithObjects:@"attendance.png",@"exam.png",@"result.png",@"timetable.png",@"event.png",@"circular.png",nil];
    
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
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    
    _mainView.layer.shadowRadius  = 5.5f;
    _mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _mainView.layer.shadowOpacity = 0.6f;
    _mainView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_mainView.bounds, shadowInsets)];
    _mainView.layer.shadowPath    = shadowPath.CGPath;
    
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
//    cell.cellView.layer.borderWidth = 1.0f;
//    cell.cellView.layer.borderColor = [UIColor grayColor].CGColor;
//    cell.cellView.layer.cornerRadius = 10.0f;
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
        
        [[NSUserDefaults standardUserDefaults]setObject:@"mainMenu" forKey:@"view_selection"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherAttendanceView *teacherAttendanceView = (TeacherAttendanceView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherAttendanceView"];
        [self.navigationController pushViewController:teacherAttendanceView animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }
    else if (indexPath.row == 1)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"mainMenu" forKey:@"view_selection"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherClasstestHomeWorkView *teacherClasstestHomeWorkView = (TeacherClasstestHomeWorkView *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherClasstestHomeWorkView"];
        [self.navigationController pushViewController:teacherClasstestHomeWorkView animated:YES];
    }
    else if (indexPath.row == 2)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"mainMenu" forKey:@"view_selection"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
         TeacherExamViewController *teacherExamViewController = (TeacherExamViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherExamViewController"];
        [self.navigationController pushViewController:teacherExamViewController animated:YES];
        
    }
    else if (indexPath.row == 3)
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"mainMenu" forKey:@"view_selection"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeachersTimeTableView *teachersTimeTableView = (TeachersTimeTableView *)[storyboard instantiateViewControllerWithIdentifier:@"TeachersTimeTableView"];
        [self.navigationController pushViewController:teachersTimeTableView animated:YES];
        
    }
    else if (indexPath.row == 4)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"mainMenu" forKey:@"view_selection"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        TeacherEventViewController *teacherEventViewController = (TeacherEventViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TeacherEventViewController"];
        [self.navigationController pushViewController:teacherEventViewController animated:YES];
        
    }
    else if (indexPath.row == 5)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"mainMenu" forKey:@"view_selection"];
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
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    else
    {
        
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        // The device is an iPad running iOS 3.2 or later.
        
        return 1;
        
    }
    else
    {
        // The device is an iPhone or iPod touch
        
        return 1;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        // The device is an iPad running iOS 3.2 or later.
        
        return 1.0;
        
    }
    else
    {
        // The device is an iPhone or iPod touch
        return 1.0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iOS 3.2 or later.
        
        return CGSizeMake(349.5f,349.5f);
    }
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        
        return CGSizeMake(140.f, 140.f);
        
    }
    
    return CGSizeMake(153.f, 153.f);
    
    
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

- (IBAction)classAttendanceBtn:(id)sender
{
    [self performSegueWithIdentifier:@"classtestatendanceView" sender:self];
}

- (IBAction)classAssignBtn:(id)sender
{
    [self performSegueWithIdentifier:@"classassignmentView" sender:self];
}
@end

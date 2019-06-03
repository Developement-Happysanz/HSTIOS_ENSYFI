//
//  TeacherCircularDetailViewController.m
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherCircularDetailViewController.h"

@interface TeacherCircularDetailViewController ()

@end

@implementation TeacherCircularDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *navigationbar;
    [navigationbar setToolbarHidden:YES animated:YES];
    
    
    self.titleLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"title_Key"];
    self.date.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"date_Key"];
    self.details.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"details_Key"];
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
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

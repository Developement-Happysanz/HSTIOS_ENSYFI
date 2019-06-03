//
//  AdminTeacherTimeTableView.m
//  EducationApp
//
//  Created by HappySanz on 07/08/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminTeacherTimeTableView.h"

@interface AdminTeacherTimeTableView ()
{
    AppDelegate *appDel;
}
@end

@implementation AdminTeacherTimeTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
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

- (IBAction)backBtn:(id)sender {
}
@end

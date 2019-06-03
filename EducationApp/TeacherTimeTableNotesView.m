//
//  TeacherTimeTableNotesView.m
//  EducationApp
//
//  Created by HappySanz on 13/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherTimeTableNotesView.h"

@interface TeacherTimeTableNotesView ()

@end

@implementation TeacherTimeTableNotesView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *class_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"class_section_name_key"];
    NSString *subjec_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"subject_name_key"];
    NSString *period_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"period_name_key"];
    NSString *details_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"details_key"];
    NSString *remarks_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"remarks_key"];

    self.classnameLabel.text = class_name;
    self.subjectName.text = subjec_name;
    self.periodLabel.text = period_name;
    self.detailsLabel.text = details_name;
    self.remarksLabel.text = remarks_name;

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

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

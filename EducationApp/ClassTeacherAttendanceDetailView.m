 //
//  ClassTeacherAttendanceDetailView.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 19/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ClassTeacherAttendanceDetailView.h"

@interface ClassTeacherAttendanceDetailView ()

@end

@implementation ClassTeacherAttendanceDetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    self.subView.layer.cornerRadius = 8.0;
    self.subView.clipsToBounds = YES;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",@"Date : ",[[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_date"]];
    self.noPresentLabel.text = [NSString stringWithFormat:@"%@%@",@"No. of Present : ",[[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_present"]];
    self.noBasentLabel.text = [NSString stringWithFormat:@"%@%@",@"No. of Absent : ",[[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_absent"]];
    self.totalStudentLabel.text = [NSString stringWithFormat:@"%@%@",@"Total Students : ",[[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_totalStudents"]];
    self.takenByLabel.text = [NSString stringWithFormat:@"%@%@",@"Taken By : ",[[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_name"]];
    
    NSString *status = [[NSUserDefaults standardUserDefaults]objectForKey:@"ctView_status"];
    if ([status isEqualToString:@"1"])
    {
        self.sendreportImg.hidden = YES;
        self.sendreportLabel.hidden = YES;
        self.sendReportOulet.enabled = NO;
    }
    else
    {
        self.sendreportImg.hidden = NO;
        self.sendreportLabel.hidden = NO;
        self.sendReportOulet.enabled = YES;
    }
        
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

- (IBAction)sendReportBtn:(id)sender
{
}
- (IBAction)viewAttendanceBtn:(id)sender
{
    
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

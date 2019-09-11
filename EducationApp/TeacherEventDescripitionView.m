//
//  TeacherEventDescripitionView.m
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherEventDescripitionView.h"

@interface TeacherEventDescripitionView ()

@end

@implementation TeacherEventDescripitionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
//    NSString *eventName = [[NSUserDefaults standardUserDefaults]objectForKey:@"event_NameKey"];
    
    NSString *eventDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"eventDateKey"];
    
    NSString *eventdiscrp = [[NSUserDefaults standardUserDefaults]objectForKey:@"descripitionKey"];
    
    self.eventDate.text = [NSString stringWithFormat:@"%@ : %@",@"Date",eventDate];
    
    self.eventdescrp.text = eventdiscrp;
    
//    self.eventName.text = eventName;
    
    NSString *sub_events = [[NSUserDefaults standardUserDefaults]objectForKey:@"sub_events_Key"];
    
    if ([sub_events isEqualToString:@"0"])
    {
        self.viewOrganiserOtlet.hidden = YES;
    }
    else
    {
        self.viewOrganiserOtlet.hidden = NO;
        
        self.viewOrganiserOtlet.layer.cornerRadius = 5.0f;
        self.viewOrganiserOtlet.clipsToBounds = YES;

    }
    
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

}
- (void)viewDidLayoutSubviews
{
    [self.eventdescrp setContentOffset:CGPointZero animated:NO];
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

- (IBAction)OrganiserButton:(id)sender
{
    [self performSegueWithIdentifier:@"toOrganiserView" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

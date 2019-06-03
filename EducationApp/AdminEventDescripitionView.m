//
//  AdminEventDescripitionView.m
//  EducationApp
//
//  Created by HappySanz on 18/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminEventDescripitionView.h"

@interface AdminEventDescripitionView ()

@end

@implementation AdminEventDescripitionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    NSString *eventName = [[NSUserDefaults standardUserDefaults]objectForKey:@"event_NameKey"];
    
    NSString *eventDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"eventDateKey"];
    
    NSString *eventdiscrp = [[NSUserDefaults standardUserDefaults]objectForKey:@"descripitionKey"];
    
    self.eventdiscrpDateLabel.text = eventDate;
    
    self.eventdescrp.text = eventdiscrp;
    
    self.eventName.text = eventName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews {
    [self.eventdescrp setContentOffset:CGPointZero animated:NO];
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
    [self performSegueWithIdentifier:@"admin_organiser" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

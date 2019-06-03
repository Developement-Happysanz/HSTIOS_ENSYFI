//
//  GIFViewController.m
//  EducationApp
//
//  Created by HappySanz on 29/06/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "GIFViewController.h"
#import "UIImage+animatedGIF.h"

@interface GIFViewController ()

@end

@implementation GIFViewController
@synthesize gifimageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ensyfi flash screen ios-5" withExtension:@"gif"];
    self.gifimageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)targetMethod:(NSTimer *)timer
{
    NSString *login_status = [[NSUserDefaults standardUserDefaults]objectForKey:@"Login_status"];
    if ([login_status isEqualToString:@"LogedIn_Teacher"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"teachers" bundle:nil];
        SWRevealViewController *teacher = (SWRevealViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewControllerTeacher"];
        [self presentViewController:teacher animated:YES completion:nil];
    }
    else
    {
           [self performSegueWithIdentifier:@"toSchooidVIew" sender:self];

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
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end

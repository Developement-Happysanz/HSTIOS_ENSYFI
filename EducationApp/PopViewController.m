//
//  PopViewController.m
//  EducationApp
//
//  Created by HappySanz on 10/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;    
    NSString *guardian = [[NSUserDefaults standardUserDefaults]objectForKey:@"guardianProfile_Key"];
    if ([guardian isEqualToString:@"guardian"])
    {
        self.navigationItem.title = @"GUARDIAN PROFILE";
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"guardianProfile_Key"];
        
        self.motherImg.hidden = YES;
        self.motherBtnOtlet.enabled = NO;
        self.motherOtlet.hidden = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [self.fatherImg setFrame:CGRectMake(327,18,100,100)];
            [self.fatherOtlet setFrame:CGRectMake(327, 125, 97, 23)];
            self.fatherOtlet.text = @"Guardian";
        }
        else
        {
            [self.fatherImg setFrame:CGRectMake(107,8,100,100)];
            [self.fatherOtlet setFrame:CGRectMake(110, 100, 97, 23)];
            self.fatherOtlet.text = @"Guardian";
        }

        self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gName_key"];
        self.adressLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"g_Home_address_key"];
        self.mailLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gEmail_key"];
        self.ocupationLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gOccupation_key"];
        self.incomeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gIncome_key"];
        self.mobileLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gMobile_key"];
        self.ofcPhonelabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gOffice_phone_key"];
        self.homeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gHome_phone_key"];

    }
    else
    {
        self.navigationItem.title = @"PARENTS PROFILE";
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
        
        self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fName_key"];
        self.adressLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fhome_address_key"];
        self.mailLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"femail_key"];
        self.ocupationLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fOcupation_key"];
        self.incomeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fincome_key"];
        self.mobileLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fmobile_key"];
        self.ofcPhonelabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fOffice_phone_key"];
        self.homeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fhome_phone_key"];
    
    }
    
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,436);
    
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

- (IBAction)closeBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (IBAction)motherBtn:(id)sender
{
    
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mName_key"];
    self.adressLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"m_Home_address_key"];
    self.mailLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mEmail_key"];
    self.ocupationLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mOccupation_key"];
    self.incomeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mIncome_key"];
    self.mobileLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mMobile_key"];
    self.ofcPhonelabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mOffice_phone_key"];
    self.homeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"mHome_phone_key"];

}
- (IBAction)fatherBtn:(id)sender
{
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fName_key"];
    self.adressLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fhome_address_key"];
    self.mailLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"femail_key"];
    self.ocupationLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fOcupation_key"];
    self.incomeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fincome_key"];
    self.mobileLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fmobile_key"];
    self.ofcPhonelabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fOffice_phone_key"];
    self.homeLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fhome_phone_key"];
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
@end

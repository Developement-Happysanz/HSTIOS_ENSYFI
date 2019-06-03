//
//  TeacherProfileViewController.m
//  EducationApp
//
//  Created by HappySanz on 21/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherProfileViewController.h"

@interface TeacherProfileViewController ()
{
    AppDelegate *appDel;
    UIImage *chosenImage;
    NSData *image;
}
@end

@implementation TeacherProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
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
    
    self.userImage.layer.cornerRadius = 50.0;
    self.userImage.clipsToBounds = YES;
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

    self.username.text = appDel.name;
    self.userType.text = appDel.user_type_name;
    
    self.userNameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_name_key"];
    
    NSLog(@"%@",self.userNameLabel.text);
    
    self.userNameLabel.enabled = NO;
    
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,teacher_profile,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"], nil];
    NSString *fullpath= [NSString pathWithComponents:components];
    NSURL *url = [NSURL URLWithString:fullpath];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.userImage.image = [UIImage imageWithData:imageData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    });
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

- (IBAction)changePasswordBtn:(id)sender
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"ENSYFI"
                               message:@"Would You like to Change Password ??"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             [[NSUserDefaults standardUserDefaults]setObject:@"teachers" forKey:@"stat_user_type"];
                             
                             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             SettingsViewController *settingsViewController = (SettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
                             [self.navigationController pushViewController:settingsViewController animated:YES];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)teacherprofileBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"teachers" forKey:@"stat_user_type"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
    AdminTeacherProfileView *adminTeacherProfileView = (AdminTeacherProfileView *)[storyboard instantiateViewControllerWithIdentifier:@"AdminTeacherProfileView"];
    [self.navigationController pushViewController:adminTeacherProfileView animated:YES];
}

- (IBAction)imageViewBtn:(id)sender
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                  
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  imagePickerController.delegate = self;
                                  alert.popoverPresentationController.sourceView = self.imageBtnOtlet;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose From Gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                  
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  imagePickerController.delegate = self;
                                  alert.popoverPresentationController.sourceView = self.imageBtnOtlet;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    alert.popoverPresentationController.sourceView = self.imageBtnOtlet;
    [self presentViewController:alert animated:YES completion:nil];
}
-(UIImage *)scaleAndRotateImage:(UIImage *)image{
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    chosenImage = info[UIImagePickerControllerOriginalImage];
    self.userImage.image = chosenImage;
    chosenImage=[self scaleAndRotateImage:chosenImage];
    image = UIImageJPEGRepresentation(chosenImage, 0.1);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    UIGraphicsBeginImageContextWithOptions(self.userImage.bounds.size, NO, [UIScreen mainScreen].scale);

    [[UIBezierPath bezierPathWithRoundedRect:self.userImage.bounds
                                cornerRadius:50.0] addClip];
    [chosenImage drawInRect:self.userImage.bounds];

    self.userImage.image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    [self profile_Pic];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)profile_Pic
{
    CGImageRef cgref = [chosenImage CGImage];
    CIImage *cim = [chosenImage CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        
    }
    else
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *url = [NSString stringWithFormat:@"%@%@%@%@/%@",baseUrl,[[NSUserDefaults standardUserDefaults]objectForKey:@"institute_code_Key"],update_profilePicture,appDel.user_id,appDel.user_type];

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_pic\"; filename=\"%@\"\r\n", @"473.png"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:image]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error)
                                              {
                                                  NSLog(@"%@", error);
                                              }
                                              else
                                              {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                      NSLog(@"%@", text);
                                                      NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                      NSLog(@"%@", result);
                                                      NSString *img = result[@"user_picture"];
                                                      appDel.user_picture = img;
                                                      [[NSUserDefaults standardUserDefaults]setObject:img forKey:@"user_pic_key"];
                                                      NSLog(@"%@%@",result, appDel.user_picture);
                                                      [MBProgressHUD hideHUDForView:self.view animated:YES];

                                                  });
                                              }
                                          }];
        [dataTask resume];

    }
    
}
@end

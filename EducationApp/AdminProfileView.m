//
//  AdminProfileView.m
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdminProfileView.h"

@interface AdminProfileView ()
{
    AppDelegate *appDel;
    UIImage *chosenImage;
    NSData *image;

}
@end

@implementation AdminProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    self.imageView.layer.cornerRadius = 50.0;
    self.imageView.clipsToBounds = YES;
    
    //setup the page...
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.userName.text = appDel.name;
    self.userTypeName.text = appDel.user_type_name;
    self.username.text = appDel.user_name;
    
    
NSArray *components = [NSArray arrayWithObjects:baseUrl,[[NSUserDefaults standardUserDefaults]objectForKey:@"institute_code_Key"],admin_profile,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_pic_key"], nil];
    NSString *institute_logo_url = [NSString pathWithComponents:components];

    NSURL *url = [NSURL URLWithString:institute_logo_url];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            
            self.imageView.image = [UIImage imageWithData:imageData];
            _imageView.layer.cornerRadius = 50.0;
            _imageView.clipsToBounds = YES;
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
- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil]; // ios 6
}
- (IBAction)changePaswrdBTn:(id)sender
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"ENSYFI"
                               message:@"Password will be Reset. Do you still wish to continue.."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [[NSUserDefaults standardUserDefaults]setObject:@"admin" forKey:@"stat_user_type"];

                             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             SettingsViewController *settingsViewController = (SettingsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
                             [self.navigationController pushViewController:settingsViewController animated:YES];
                         }];
    
    UIAlertAction *cancel = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];

//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ENSYFI" message:@"Password will be Reset. Do you still wish to continue.." preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Button 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        // action 1
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Button 2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        // action 2
//    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)imageBtn:(id)sender
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
    self.imageView.image = chosenImage;
    chosenImage=[self scaleAndRotateImage:chosenImage];
    image = UIImageJPEGRepresentation(chosenImage, 0.1);
    
//    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
//
//    // Add a clip before drawing anything, in the shape of an rounded rect
//    [[UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds
//                                cornerRadius:50.0] addClip];
//    // Draw your image
//    [chosenImage drawInRect:self.imageView.bounds];
//
//    // Get the image, here setting the UIImageView image
//    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//
//    // Lets forget about that we were drawing
//    UIGraphicsEndImageContext();
    _imageView.layer.cornerRadius = 50.0;
    _imageView.clipsToBounds = YES;
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        //        NSData *imageData = UIImagePNGRepresentation(chosenImage);
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
                                                  NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"%@", text);
                                                  NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                  NSLog(@"%@", result);
                                                  NSString *img = result[@"user_picture"];
                                                  [[NSUserDefaults standardUserDefaults]setObject:img forKey:@"user_pic_key"];                                                  NSLog(@"%@%@",result,img);
                                                  
                                              }
                                          }];
        
        [dataTask resume];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end

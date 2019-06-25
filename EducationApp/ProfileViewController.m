//
//  ProfileViewController.m
//  EducationApp
//
//  Created by HappySanz on 12/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
{
    AppDelegate *appDel;
    UIImage *chosenImage;
    NSData *image;

}

@property (nonatomic) UIPopoverController *popover;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
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
    
    self.mainView.layer.cornerRadius = 8.0f;
    self.mainView.clipsToBounds = YES;
    _mainView.layer.shadowRadius  = 5.5f;
    _mainView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _mainView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _mainView.layer.shadowOpacity = 0.6f;
    _mainView.layer.masksToBounds = NO;
    
    self.parentView.layer.cornerRadius = 8.0f;
    self.parentView.clipsToBounds = YES;
    _parentView.layer.shadowRadius  = 5.5f;
    _parentView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _parentView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _parentView.layer.shadowOpacity = 0.6f;
    _parentView.layer.masksToBounds = NO;
    
    self.guardianView.layer.cornerRadius = 8.0f;
    self.guardianView.clipsToBounds = YES;
    _guardianView.layer.shadowRadius  = 5.5f;
    _guardianView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _guardianView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _guardianView.layer.shadowOpacity = 0.6f;
    _guardianView.layer.masksToBounds = NO;
    
    self.studentView.layer.cornerRadius = 8.0f;
    self.studentView.clipsToBounds = YES;
    _studentView.layer.shadowRadius  = 5.5f;
    _studentView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _studentView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _studentView.layer.shadowOpacity = 0.6f;
    _studentView.layer.masksToBounds = NO;
    
    
    self.feeView.layer.cornerRadius = 8.0f;
    self.feeView.clipsToBounds = YES;
    _feeView.layer.shadowRadius  = 5.5f;
    _feeView.layer.shadowColor   = UIColor.grayColor.CGColor;
    _feeView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    _feeView.layer.shadowOpacity = 0.6f;
    _feeView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath;
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_mainView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_guardianView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_parentView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_feeView.bounds, shadowInsets)];
    shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(_studentView.bounds, shadowInsets)];
    _mainView.layer.shadowPath    = shadowPath.CGPath;
    _guardianView.layer.shadowPath    = shadowPath.CGPath;
    _parentView.layer.shadowPath    = shadowPath.CGPath;
    _feeView.layer.shadowPath    = shadowPath.CGPath;
    _studentView.layer.shadowPath    = shadowPath.CGPath;

    
    self.imageView.layer.cornerRadius = 50.0;
    self.imageView.clipsToBounds = YES;
    
    //setup the page...
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.userName.text =appDel.name;
    self.userTypeName.text = appDel.user_type_name;
    self.username.text = appDel.user_name;

    if ([appDel.user_type isEqualToString:@"3"])
    {
        if ([appDel.user_picture isEqualToString:@""])
        {
            self.imageView.image = [UIImage imageNamed:@"user small-01.png"];

        }
        else
        {
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,student_profile,appDel.user_picture, nil];
            NSString *fullpath= [NSString pathWithComponents:components];
            NSURL *url = [NSURL URLWithString:fullpath];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update the UI
                    self.imageView.image = [UIImage imageWithData:imageData];
                    _imageView.layer.cornerRadius = 50.0;
                    _imageView.clipsToBounds = YES;
                    if (self.imageView.image == nil)
                    {
                        self.imageView.image = [UIImage imageNamed:@"user small-01.png"];
                    }
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
            });
        }
        
    }
    else if ([appDel.user_type isEqualToString:@"4"])
    {
        if ([appDel.user_picture isEqualToString:@""])
        {
                self.imageView.image = [UIImage imageNamed:@"user small-01.png"];
        }
        else
        {
            NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,parents_profile,appDel.user_picture, nil];
            NSString *fullpath= [NSString pathWithComponents:components];
            NSURL *url = [NSURL URLWithString:fullpath];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update the UI
                    self.imageView.image = [UIImage imageWithData:imageData];
                    _imageView.layer.cornerRadius = 50.0;
                    _imageView.clipsToBounds = YES;
                    
                    if (self.imageView.image == nil)
                    {
                        self.imageView.image = [UIImage imageNamed:@"user small-01.png"];
                    }
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                });
            });
        }
    }
    
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,436);

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

-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults]setObject:@" " forKey:@"guardian_Key"];
}
- (IBAction)changePaswrdBtn:(id)sender
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
                             [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"changepswrd_key"];
                             [self performSegueWithIdentifier:@"to_ChangePassword" sender:self];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)fessBtn:(id)sender
{
    [self performSegueWithIdentifier:@"to_fess" sender:self];
}

- (IBAction)studentBtn:(id)sender
{
    [self performSegueWithIdentifier:@"toStudent_Profile" sender:self];
}

- (IBAction)guardianBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"guardian" forKey:@"guardianProfile_Key"];
    [self performSegueWithIdentifier:@"to_popupView" sender:self];

}

- (IBAction)parentsinfoBtn:(id)sender
{
    [self performSegueWithIdentifier:@"to_popupView" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;

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
    
//    chosenImage = info[UIImagePickerControllerOriginalImage];
//    self.imageView.image = chosenImage;
//
//    chosenImage=[self scaleAndRotateImage:chosenImage];
//    image = UIImageJPEGRepresentation(chosenImage, 0.1);
//
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

    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (self.popover.isPopoverVisible) {
            [self.popover dismissPopoverAnimated:NO];
        }
        
    //    [self updateEditButtonEnabled];
        
        [self openEditor:nil];
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
  
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)ImageUpload
{
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
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
    [body appendData:[NSData dataWithData:imageData]];
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
                                              NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                              NSLog(@"%@", text);
                                              NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                              NSLog(@"%@", result);
                                              NSString *img = result[@"user_picture"];
                                              appDel.user_picture = img;
                                              [[NSUserDefaults standardUserDefaults]setObject:img forKey:@"user_pic_key"];
                                              appDel.user_picture = [NSString stringWithFormat:@"%@",data];
                                          }
                                      }];
    [dataTask resume];
}
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
//    self.imageView.image = ;
    
    chosenImage = croppedImage;
    self.imageView.image = chosenImage;
    image = UIImageJPEGRepresentation(chosenImage, 0.1);
    [self ImageUpload];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
       // [self updateEditButtonEnabled];
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      //  [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Action methods

- (IBAction)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.imageView.image;
    
    UIImage *image = self.imageView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}
@end

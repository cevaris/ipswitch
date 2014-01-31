//
//  SelectProfileImageViewController.h
//  ipswitch
//
//  Created by Cevaris on 12/12/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectProfileImageViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (strong, nonatomic) UIImagePickerController *picker;
@property(nonatomic) UIImagePickerControllerSourceType sourceType;

@end

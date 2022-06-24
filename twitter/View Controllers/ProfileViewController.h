//
//  ProfileViewController.h
//  twitter
//
//  Created by Laura Jankowski on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) User *user;

@end

NS_ASSUME_NONNULL_END

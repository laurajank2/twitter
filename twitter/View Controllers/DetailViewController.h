//
//  DetailViewController.h
//  twitter
//
//  Created by Laura Jankowski on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewControllerDelegate

- (void)didDismiss;

@end

@interface DetailViewController : UIViewController
@property (strong, nonatomic) Tweet *tweet;

@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

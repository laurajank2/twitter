//
//  ProfileViewController.m
//  twitter
//
//  Created by Laura Jankowski on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextView *bio;
@property (weak, nonatomic) IBOutlet UILabel *joinedDate;
@property (weak, nonatomic) IBOutlet UILabel *followingNum;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersNum;
@property (weak, nonatomic) IBOutlet UILabel *followerslabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //names
    self.screenName.text = self.tweet.user.screenName;
    self.userName.text = self.tweet.user.name;
    //images
    NSString *URLString = self.tweet.user.profileBanner;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.backgroundView setImageWithURL:url];
    URLString = self.tweet.user.profilePicture;
    url = [NSURL URLWithString:URLString];
    [self.profileImage setImageWithURL:url];
    self.profileImage.layer.cornerRadius = CGRectGetHeight(self.profileImage.frame) / 2;
    self.profileImage.clipsToBounds = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

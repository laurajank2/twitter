//
//  ProfileViewController.m
//  twitter
//
//  Created by Laura Jankowski on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *postContent;
@property (weak, nonatomic) IBOutlet UILabel *joinedDate;
@property (weak, nonatomic) IBOutlet UILabel *followingNum;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersNum;
@property (weak, nonatomic) IBOutlet UILabel *followerslabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //back button title
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc]
    initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //names
    self.screenName.text = self.user.screenName;
    self.userName.text = self.user.name;
    //images
    NSString *URLString = self.user.profileBanner;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.backgroundView setImageWithURL:url];
    URLString = self.user.profilePicture;
    url = [NSURL URLWithString:URLString];
    [self.profileImage setImageWithURL:url];
    self.profileImage.layer.cornerRadius = CGRectGetHeight(self.profileImage.frame) / 2;
    self.profileImage.clipsToBounds = YES;
    //bio
    self.postContent.text = self.user.bio;
    //counts
    self.followersNum.text = self.user.followers_count;
    self.followingNum.text = self.user.following_count;
    //date
    //formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.user.join_date];
    NSString *dateJoined = [dateFormatter stringFromDate:date];
    self.joinedDate.text = [NSString stringWithFormat:@"%@%@", @"Joined ", dateJoined];
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

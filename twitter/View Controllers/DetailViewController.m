//
//  DetailViewController.m
//  twitter
//
//  Created by Laura Jankowski on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *authorDetail;
@property (weak, nonatomic) IBOutlet UILabel *handleDetail;
@property (weak, nonatomic) IBOutlet UILabel *dateDetail;
@property (weak, nonatomic) IBOutlet UIButton *replyDetail;
@property (weak, nonatomic) IBOutlet UIButton *retweetDetail;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *messageDetail;
@property (weak, nonatomic) IBOutlet UILabel *textDetail;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.authorDetail.text = self.tweet.user.name;
    self.handleDetail.text = self.tweet.user.screenName;
    self.textDetail.text = self.tweet.text;
    //date
    NSLog(@"Here is the orig date");
    NSLog(@"%@", self.tweet.createdAtString);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.tweet.createdAtString];
    //NSLog(@"%@", date);
    NSString *shortTimeAgo = [date timeAgoSinceNow];
    NSLog(@"time ago");
    NSLog(@"%@", shortTimeAgo);
    self.dateDetail.text = shortTimeAgo;
    //image
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [self.detailImage setImageWithURL:url];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    NSString *numLiked = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    [self.favoriteButton setTitle:numLiked forState:UIControlStateNormal];
    [self.retweetDetail setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    NSString *numreTweet = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    [self.retweetDetail setTitle:numreTweet forState:UIControlStateNormal];
    
    
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

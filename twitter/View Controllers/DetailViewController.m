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
#import "APIManager.h"

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
- (IBAction)tapDetailFav:(id)sender {
    NSLog(@"@%@", self.tweet.idStr);
    self.favoriteButton = (UIButton*)sender;
    if( [[self.favoriteButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"favor-icon.png"]]) {
        NSLog(@"Should change to red");
           [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
           // other statements
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            // TODO: Send a POST request to the POST favorites/create endpoint
            [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                 if(error){
                      NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                 }
                 else{
                     NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                 }
            }];
        }
     else
       {
           [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
           // other statements
           self.tweet.favorited = YES;
           self.tweet.favoriteCount -= 1;
           [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                     NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                }
           }];
       }
    
    //refresh data
    NSString *numLiked = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    NSLog(@"The value of favoriteCount is %i", self.tweet.favoriteCount);
    [self.favoriteButton setTitle:numLiked forState:UIControlStateNormal];
}
- (IBAction)tapDetailRetweet:(id)sender {
    if( [[self.retweetDetail imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"retweet-icon.png"]]) {
        NSLog(@"Should change to green");
           [self.retweetDetail setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
           // other statements
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            // TODO: Send a POST request to the POST favorites/create endpoint
            [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                 if(error){
                      NSLog(@"Error retweeting: %@", error.localizedDescription);
                 }
                 else{
                     NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                 }
             }];
        }
     else
       {
           [self.retweetDetail setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
           // other statements
           self.tweet.retweeted = YES;
           self.tweet.retweetCount -= 1;
           // TODO: Send a POST request to the POST favorites/create endpoint
           [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if(error){
                     NSLog(@"Error unretweeting: %@", error.localizedDescription);
                }
                else{
                    NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                }
            }];
       }
    
    //refresh data
    NSString *numReTweet = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    NSLog(@"The value of retweetCount is %i", self.tweet.retweetCount);
    [self.retweetDetail setTitle:numReTweet forState:UIControlStateNormal];
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
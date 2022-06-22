//
//  TweetCell.m
//  twitter
//
//  Created by Laura Jankowski on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
   
    // TODO: Update cell UI
    NSLog(@"@%@", self.tweet.idStr);
    self.likeButton = (UIButton*)sender;
    if( [[self.likeButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"favor-icon.png"]]) {
        NSLog(@"Should change to red");
           [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
           // other statements
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
        }
     else
       {
           [self.likeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
           // other statements
           self.tweet.favorited = YES;
           self.tweet.favoriteCount -= 1;
       }
    
    //refresh data
    NSString *numLiked = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    NSLog(@"The value of favoriteCount is %i", self.tweet.favoriteCount);
    [self.likeButton setTitle:numLiked forState:UIControlStateNormal];
    
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

- (IBAction)didTapReTweet:(id)sender {
    // TODO: Update the local tweet model
    // TODO: Update cell UI
    if( [[self.retweetButton imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"retweet-icon.png"]]) {
        NSLog(@"Should change to red");
           [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
           // other statements
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        }
     else
       {
           [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
           // other statements
           self.tweet.retweeted = YES;
           self.tweet.retweetCount -= 1;
       }
    
    //refresh data
    NSString *numReTweet = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    NSLog(@"The value of retweetCount is %i", self.tweet.retweetCount);
    [self.retweetButton setTitle:numReTweet forState:UIControlStateNormal];
    
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


- (void)setDate {
    NSLog(@"Here is the orig date");
    NSLog(@"%@", self.tweet.createdAtString);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.tweet.createdAtString];
    //NSLog(@"%@", date);
    NSString *shortTimeAgo = [date timeAgoSinceNow];
    NSLog(@"time ago");
    NSLog(@"%@", shortTimeAgo);
    self.date.text = shortTimeAgo;
    
}




@end

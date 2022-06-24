//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"

@interface TimelineViewController () <DetailViewControllerDelegate, ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.navigationController.navigationBar.translucent = NO;
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    cell.tweet = tweet;
    cell.author.text = tweet.user.name;
    [cell setDate];
    cell.userName.text = tweet.user.screenName;
    cell.postContent.text = tweet.text;
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    [cell.userPhoto setImageWithURL:url];
    if (cell.tweet.favorited) {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    } else {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    if (cell.tweet.retweeted) {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    } else {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    NSString *numLiked = [NSString stringWithFormat:@"%i", cell.tweet.favoriteCount];
    [cell.likeButton setTitle:numLiked forState:UIControlStateNormal];
    NSString *numreTweet = [NSString stringWithFormat:@"%i", cell.tweet.retweetCount];
    [cell.retweetButton setTitle:numreTweet forState:UIControlStateNormal];
    cell.delegate = self;
    return cell;
}

- (void) viewDidAppear:(BOOL) animated{
    NSLog(@"view did appear");
    [super viewDidAppear: animated];
    // Get timeline
    [self fetchTweets];
}

// Makes a network request to get updated data
 // Updates the tableView with the new data
 // Hides the RefreshControl
- (void)fetchTweets {

    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (NSDictionary *dictionary in tweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
            self.arrayOfTweets = (NSMutableArray*) tweets;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
    }];
    
}

- (void)didDismiss {
    [self fetchTweets];
}

- (void)didTweet:(Tweet *)tweet {
    NSLog(@"did tweet");
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{}];
    
    [self.arrayOfTweets insertObject:tweet atIndex:0];
//    [self fetchTweets];
    [self.tableView reloadData];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"profileSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        ProfileViewController *profileVC = [ segue destinationViewController];
        profileVC.tweet = self.arrayOfTweets[indexPath.row];
        NSLog(@"profile id");
        NSLog(@"@%@", profileVC.tweet.idStr);
    } else if([sender isKindOfClass:[TweetCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        DetailViewController *detailVC = [ segue destinationViewController];
        detailVC.tweet = self.arrayOfTweets[indexPath.row];
        NSLog(@"@%@", detailVC.tweet.idStr);
        detailVC.delegate = self;
    }  else if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        UINavigationController *navigationController = [segue destinationViewController];
        //below didn't work to fix translucent
//        [navigationController.navigationBar  setTranslucent:NO];
//        navigationController.navigationBar.barTintColor=[UIColor groupTableViewBackgroundColor];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        
    }
}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // TODO: Perform segue to profile view controller
    NSLog(@"did tap");
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
    NSLog(@"did tap");
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}
@end

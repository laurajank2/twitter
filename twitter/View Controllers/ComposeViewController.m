//
//  ComposeViewController.m
//  twitter
//
//  Created by Laura Jankowski on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "UITextView+Placeholder/UITextView+Placeholder.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTweet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UILabel *tweetStatus;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeTweet.placeholder = @"Type Tweet here";
    self.composeTweet.placeholderColor = [UIColor lightGrayColor];
    //janky code to make navbar opaque
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                         forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.composeTweet.delegate = self;

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Set the max character limit
    int characterLimit = 281;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.composeTweet.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update character count label

    // Should the new text should be allowed? True/False
    if( newText.length == characterLimit){
        self.tweetStatus.text = @"Tweet is at character limit!";
    } else {
        NSString *strCurrText = [NSString stringWithFormat:@"%d",newText.length];
        NSString *status = [NSString stringWithFormat:@"%@%@%@", @"You have ", strCurrText, @" out of 280 characters"];
        self.tweetStatus.text = status;
    }
    return newText.length < characterLimit;
    
    // TODO: Allow or disallow the new text
}


- (IBAction)didClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];

}
- (IBAction)didTapPost:(id)sender {
    [[APIManager shared]postStatusWithText:self.composeTweet.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];            
            NSLog(@"Compose Tweet Success!");
        }
    }];
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

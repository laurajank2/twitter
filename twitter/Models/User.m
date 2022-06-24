//
//  User.m
//  twitter
//
//  Created by Laura Jankowski on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.profileBanner = dictionary[@"profile_banner_url"];
        self.bio = dictionary[@"description"];
        NSNumber* followers_int = dictionary[@"followers_count"];
        self.followers_count = [followers_int stringValue];
        NSNumber* following_int = dictionary[@"friends_count"];
        self.following_count = [following_int stringValue];
        self.join_date = dictionary[@"created_at"];
        // Initialize any other properties
    }
    return self;
}
@end

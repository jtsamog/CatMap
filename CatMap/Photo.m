//
//  Photo.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "Photo.h"

@interface Photo()
@property (nonatomic, strong) NSString *urlServer;
@property (nonatomic, strong) NSString *urlFarm;
@property (nonatomic, strong) NSString *urlID;
@property (nonatomic, strong) NSString *urlSecret;
@end

@implementation Photo

- (instancetype)initWithInfo:(NSDictionary *)info {
  self = [super init];
  if (self) {
    _urlFarm = info[@"farm"];
    _urlServer = info[@"server"];
    _urlID = info[@"id"];
    _urlSecret = info[@"secret"];
    _urlTitle = info[@"title"];
    _url = [self creatURL];
  }
  return self;
}


- (NSURL *)creatURL {
  return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.urlFarm, self.urlServer, self.urlID, self.urlSecret]];
  
}
@end

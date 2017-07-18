//
//  Photo.h
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Photo : NSObject
@property (nonatomic, strong) NSString *urlServer;
@property (nonatomic, strong) NSString *urlFarm;
@property (nonatomic, strong) NSString *urlID;
@property (nonatomic, strong) NSString *urlSecret;
@property (nonatomic, strong) NSString *urlTitle;
@property (nonatomic, strong) UIImage *catImage;


- (instancetype)initWithInfo:(NSDictionary *)info;
- (NSURL *)url;
@end

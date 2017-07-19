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
@property (nonatomic, strong) NSString *urlTitle;
@property (nonatomic, strong) UIImage *catImage;
- (instancetype)initWithInfo:(NSDictionary *)info;
@property (nonatomic) NSURL *url;
@property (nonatomic)int counter;
@end

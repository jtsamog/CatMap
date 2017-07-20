//
//  Photo.h
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import MapKit;

@interface Photo : NSObject
@property (nonatomic, strong) NSString *urlTitle;
@property (nonatomic, strong) UIImage *catImage;
@property (nonatomic, strong) NSString *urlID;
@property (nonatomic) NSURL *url;
@property (nonatomic)int counter;
@property(nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithInfo:(NSDictionary *)info;


+ (NSArray *)makePhotoArray:(NSArray *)aPhotoArray;
 

@end

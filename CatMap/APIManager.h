//
//  APIManager.h
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface APIManager : NSObject

+ (void)createPhotoFromFlickrAPI:(NSString *)tags withBlock:(void (^)(NSArray *tempCatPhotos))completion;

+ (void)downloadPhotos:(NSURL *)url completion:(void (^)(UIImage * image))completion;
@end

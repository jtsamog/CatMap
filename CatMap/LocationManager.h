//
//  LocationManager.h
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface LocationManager : NSObject

+ (void)getPictureLocationData:(Photo*)picture completion:(void (^)(CLLocationCoordinate2D))completion;
@end

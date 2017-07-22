//
//  LocationManager.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "LocationManager.h"
#import "ApiKeys.h"

@implementation LocationManager

+ (void)getPictureLocationData:(Photo*)picture completion:(void (^)(CLLocationCoordinate2D catLocation))completion
{
  
  NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",FLICKR_APIKEY,picture.urlID];
  

  
  
  NSURL *locationURL = [NSURL URLWithString:urlString];
  
  NSURLRequest *requestURL = [NSURLRequest requestWithURL:locationURL];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *sessionConfiguration = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *dataTask = [sessionConfiguration
                                    dataTaskWithRequest:requestURL
                                    completionHandler:^ (NSData * _Nullable data,
                                                         NSURLResponse * _Nullable response,
                                                         NSError * _Nullable error) {
                                      
                                      if (error) {
                                        
                                        NSLog(@"error: %@", error.localizedDescription);
                                        return;
                                        
                                      }
                                      
                                      NSError *jsonError = nil;
                                      
                                      NSDictionary *getThatJSON = [NSJSONSerialization
                                                                   JSONObjectWithData:data
                                                                   options:0
                                                                   error:&jsonError];
                                      
                                      if (jsonError) {
                                        
                                        NSLog(@"error: %@", jsonError.localizedDescription);
                                        return;
                                        
                                      }
                                      
                                      NSDictionary *photoDictionary = getThatJSON[@"photo"];
                                      NSDictionary *locationDictionary = photoDictionary[@"location"];
                                      
                                      double latitude = [[locationDictionary valueForKey:@"latitude"]doubleValue];
                                      double longitude = [[locationDictionary valueForKey:@"longitude"]doubleValue];
                                      
                                      CLLocationCoordinate2D catLocation = CLLocationCoordinate2DMake(latitude, longitude);
                                      
                                      [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                        completion(catLocation);
                                        
                                      }];
                                      
                                    }];
  
  [dataTask resume];
}

@end

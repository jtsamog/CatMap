//
//  APIManager.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "APIManager.h"
#import "ApiKeys.h"
#import "Photo.h"

@implementation APIManager

+ (void)createPhotoFromFlickrAPI:(NSString *)tags withBlock:(void (^)(NSArray *tempCatPhotos))completion {
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=%@&has_geo=1&extras=url_m", FLICKR_APIKEY, tags]];
  
  
  NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"error: %@", error.localizedDescription);
      return ;
    }
    NSError *jsonError = nil;
    NSDictionary *jsonData = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
      NSLog(@"jsonError: %@", jsonError.localizedDescription);
      return;
    }
    
    NSMutableArray *tempCatPhotos = [@[] mutableCopy];
    //    NSArray *json = jsonData[@"photos"][@"photo"];
    NSArray *json = [jsonData valueForKeyPath:@"photos.photo"];
    
    NSLog(@"%@", json);
    int counter = 0;
    for (NSDictionary *info in json) { //using fast enumeration
      Photo *photo = [[Photo alloc] initWithInfo:info]; //fetch the photos from url
      photo.counter = counter;
      counter += 1;
      [tempCatPhotos addObject:photo]; //add photo to temp array
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      completion(tempCatPhotos);
    }];
//    dispatch_queue_t mainQ = dispatch_get_main_queue();
//    dispatch_async(mainQ, ^{
//      self.catPhotos = [tempCatPhotos copy];
//      [self.collectionView reloadData];
   

  }];

  [dataTask resume];
  
}


+ (void)downloadPhotos:(NSURL *)url completion:(void (^)(UIImage * image))completion{
  
  NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *configureSession = [NSURLSession sessionWithConfiguration:configure];
  
  
  NSURLSessionDownloadTask *downloadPhotos = [configureSession
                                              downloadTaskWithURL:url
                                              completionHandler:^(NSURL * _Nullable location,
                                                                  NSURLResponse * _Nullable response,
                                                                  NSError * _Nullable error) {
                                                
                                                if (error) {
                                                  
                                                  NSLog(@"%@", error.localizedDescription);
                                                  return;
                                                  
                                                }
                                                
                                                NSData *pictureData = [NSData dataWithContentsOfURL:url];
                                                UIImage *picture = [UIImage imageWithData:pictureData];
                                                
                                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                  
                                                  completion(picture);
                                                  
                                                }];
                                                
                                              }];
  
  [downloadPhotos resume];
}

@end

//
//  ViewController.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CatViewCell.h"
#import "DetailViewController.h"
#import "ApiKeys.h"

@interface ViewController ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <Photo*>*catPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.dataSource = self;
  [self createDataFromFlickrAPI];
  
}
- (void)createDataFromFlickrAPI {
  
  self.catPhotos = @[];
  
  // 1. Create a new NSURL object from the url string.
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=cat",FLICKR_APIKEY]];
  
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
    NSArray *json = jsonData[@"photos"][@"photo"];
    NSLog(@"%@", json);
    int counter = 0;
    for (NSDictionary *info in json) { //using fast enumeration
      Photo *photo = [[Photo alloc] initWithInfo:info]; //fetch the photos from url
      photo.counter = counter;
      counter += 1;
      [tempCatPhotos addObject:photo]; //add photo to temp array
    }
    
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    dispatch_async(mainQ, ^{
      self.catPhotos = [tempCatPhotos copy];
      [self.collectionView reloadData];
    });
    
  }];
  
  //6. A task is created in a suspended state, so we need to resume it
  [dataTask resume];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return self.catPhotos.count;
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  CatViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  Photo *photo = self.catPhotos[indexPath.row];
  if (photo.catImage == nil) {
    NSData *imgData  = [[NSData alloc]initWithContentsOfURL:photo.url]; //download photo from url
    photo.catImage = [UIImage imageWithData:imgData]; //set image ppty on photo object to downloaded image, then use it to set the cell outlet
  }
  cell.photo = photo;
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UICollectionViewCell *)sender {
  if ([segue.identifier isEqualToString:@"DetailViewController"]) {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    Photo *photo = self.catPhotos[indexPath.row];
    DetailViewController *dvc = [segue destinationViewController];
    dvc.photo = photo;
  }
  
}

@end

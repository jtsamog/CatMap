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
#import "APIManager.h"
#import "LocationManager.h"

@interface ViewController ()<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <Photo*>*catPhotos;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.dataSource = self;
  
  self.catPhotos = @[];
  
  [APIManager createPhotoFromFlickrAPI:@"Cat" withBlock:^(NSArray *tempCatPhotos) {
    self.catPhotos = [NSArray arrayWithArray:tempCatPhotos];
    [self.collectionView reloadData];
  }];
  
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

//
//  DetailViewController.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "DetailViewController.h"
#import "Photo.h"
#import "LocationManager.h"
#import "APIManager.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDvc;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelDvc;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *photoLocationMap;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  

  // Do any additional setup after loading the view.
  self.titleLabelDvc.text = self.photo.urlTitle;
  self.imageViewDvc.image = self.photo.catImage;
  
  
  
  self.navigationItem.title = self.photo.urlTitle;
  
  [LocationManager getPictureLocationData:self.photo completion:^(CLLocationCoordinate2D coordinate) {
    self.photo.coordinate = coordinate;
    self.latitudeLabel.text = [NSString stringWithFormat:@"Latitude: %f", self.photo.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %f", self.photo.coordinate.longitude];
    
    [self setMapView];
  }];
  
  [self configureCell];
  
}

- (void) configureCell{
  [APIManager downloadPhotos:self.photo.url completion:^(UIImage *image) {
    self.imageViewDvc.image = image;
  }];
}

-(void) setMapView{
  MKCoordinateSpan span = MKCoordinateSpanMake(0.5f, 0.5f);
  self.photoLocationMap.region = MKCoordinateRegionMake(self.photo.coordinate, span);
  [self.photoLocationMap addAnnotation:self.photo];
}

@end

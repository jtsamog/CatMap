//
//  DetailViewController.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "DetailViewController.h"
#import "Photo.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDvc;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelDvc;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.titleLabelDvc.text = self.photo.urlTitle;
  self.imageViewDvc.image = self.photo.catImage;
  
}

- (void)dealloc {
  
}

@end

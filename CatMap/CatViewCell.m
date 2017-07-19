//
//  CatViewCell.m
//  CatMap
//
//  Created by Endeavour2 on 7/18/17.
//  Copyright © 2017 SamOg. All rights reserved.
//

#import "CatViewCell.h"
#import "Photo.h"


@interface CatViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *titleLabelCell;


@end


@implementation CatViewCell

- (void)setPhoto:(Photo *)photo {
  self.imageViewCell.image = photo.catImage;
  self.titleLabelCell.text = photo.urlTitle;
  _photo = photo;
}


@end

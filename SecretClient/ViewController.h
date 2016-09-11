//
//  ViewController.h
//  SecretClient
//
//  Created by Kwanghwi Kim on 2016. 9. 10..
//  Copyright © 2016년 favorie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>

@interface ViewController : UIViewController  <AGSMapViewLayerDelegate, AGSMapViewTouchDelegate, AGSWebMapDelegate, AGSCalloutDelegate, AGSPopupsContainerDelegate, UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet AGSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *showCountyPicker;
@property (nonatomic, strong) AGSLocation *currentLocation;

@end


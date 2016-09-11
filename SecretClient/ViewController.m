//
//  ViewController.m
//  SecretClient
//
//  Created by Kwanghwi Kim on 2016. 9. 10..
//  Copyright © 2016년 favorie. All rights reserved.
//

#import "ViewController.h"


static NSString * const kWebmapId = @"5fed751f6fcd46d59a087c30e59a7d1a";

@interface ViewController ()
@property (nonatomic, strong) AGSWebMap *webMap;
@property (nonatomic, strong) AGSQueryTask* queryTask;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add a basemap tiled layer
    NSURL* url = [NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer"];
    AGSTiledMapServiceLayer *tiledLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url];
    [self.mapView addMapLayer:tiledLayer withName:@"Basemap Tiled Layer"];

    
    
    AGSGraphicsLayer* myGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:myGraphicsLayer withName:@"Graphics Layer"];

    
    //2. Set the map view's layerDelegate
    self.mapView.layerDelegate = self;
    


    [self queryTest];
}

- (void)queryTest {
    NSURL* url = [NSURL URLWithString: @"https://services2.arcgis.com/aul9vc2gUsuK2PDq/arcgis/rest/services/Hints/FeatureServer/0"];
    self.queryTask = [AGSQueryTask queryTaskWithURL: url];
    self.queryTask.delegate = self;

    
    AGSQuery *selectQuery = [AGSQuery query];
    selectQuery.whereClause = [NSString stringWithFormat:@"score > 0"];
//
//    selectQuery.objectIds = @[@"1", @"2", @"3"];
    selectQuery.outFields = [NSArray arrayWithObjects:@"*", nil];
    [selectQuery setReturnGeometry:YES];
    [self.queryTask executeWithQuery:selectQuery];
}


// AGSQueryDelegate

- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didExecuteWithFeatureSetResult:(AGSFeatureSet *)featureSet{
    
    NSArray *features = featureSet.features;
    for (AGSGraphic *feature in features) {
        NSLog(@"%@", feature);
    }
}

- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}


//3. Implement the layer delegate method
- (void)mapViewDidLoad:(AGSMapView *) mapView {
    //do something now that the map is loaded
    //for example, show the current location on the map
    NSLog(@"loaded");
    
    [mapView.locationDisplay startDataSource];
    
}



- (IBAction)handleShowButton:(id)sender {
    self.webMap = [AGSWebMap webMapWithItemId:kWebmapId credential:nil];
    
    // Set self as the webmap's delegate so that we get notified
    // if the web map opens successfully or if errors are encounterer
    self.webMap.delegate = self;
    
    // Open the webmap
    [self.webMap openIntoMapView:self.mapView];
//    [self.mapView zoomToGeometry:self.mapView.locationDisplay.mapLocation withPadding:0 animated:YES];
  
}


- (void) webMap:(AGSWebMap *)webMap didFailToLoadWithError:(NSError *)error {
    
    NSLog(@"Error while loading webMap: %@",[error localizedDescription]);
    
    // If we have an error loading the webmap due to an invalid or missing credential
    // prompt the user for login information
    if (error.ags_isAuthenticationError) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please sign in to access the web map" message:@"Tip: use 'AGSSample' and 'agssample'" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
        [alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        //Set tag so we know which action this alertview is being shown for
        [alertView setTag:@"33"];
        [alertView show];
        
    }
    // For any other error alert the user
    else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                     message:@"Failed to load the webmap"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
}


-(void)featureLayer:(AGSFeatureLayer *)featureLayer operation:(NSOperation *)op didSelectFeaturesWithFeatureSet:(AGSFeatureSet *)featureSet
{
    
    // ZOOM TO SELECTED DATA
    AGSMutableEnvelope *env = nil;
    for (AGSGraphic *selectedFeature in featureSet.features)
    {
        if (env)
            [env unionWithEnvelope:selectedFeature.geometry.envelope];
        else
            env = [selectedFeature.geometry.envelope mutableCopy];
    }
    [self.mapView zoomToGeometry:env withPadding:20 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

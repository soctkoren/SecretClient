//
//  ViewController.m
//  SecretClient
//
//  Created by Kwanghwi Kim on 2016. 9. 10..
//  Copyright © 2016년 favorie. All rights reserved.
//

#import "ViewController.h"
#import "MessageTableViewCell.h"
#import "ColorHelper.h"
#import "CBZSplashView.h"


static NSString * const kWebmapId = @"5fed751f6fcd46d59a087c30e59a7d1a";


@interface ViewController ()
@property (nonatomic, strong) AGSWebMap *webMap;
@property (nonatomic, strong) AGSQueryTask* queryTask;
@property (nonatomic, strong) AGSEnvelope *envelope;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightOfBottomView;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;
@property (weak, nonatomic) IBOutlet UILabel *labelScore;
@property (weak, nonatomic) IBOutlet UIImageView *bottomViewBar;
@property (nonatomic, strong) NSString *selectedMessage;
@property (nonatomic, strong) NSNumber *selectedScore;
@property (nonatomic, strong) NSString *selectedSentiment;
@property (nonatomic, strong) NSString *selectedAuthor;

@property (nonatomic, strong) NSArray *features;

@property (nonatomic, strong) NSMutableArray *simpleSymbols;
@property (nonatomic, strong) NSMutableArray *fixedSymbols;
@property (nonatomic, strong) NSMutableArray *textSymbols;
@property (nonatomic, strong) NSMutableArray *compositeSymbols;
@property (nonatomic, strong) NSMutableArray *graphics;

@property (assign) NSInteger minScore;
@property (assign) NSInteger maxScore;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *icon = [UIImage imageNamed:@"launchIcon"];
    UIColor *color = [UIColor colorWithRed:135/255.f green:190/255.f blue:240/255.f alpha:1.0];
    CBZSplashView *splashView = [CBZSplashView splashViewWithIcon:icon backgroundColor:color];
    
    // customize duration, icon size, or icon color here;
    
    [self.view addSubview:splashView];
    [splashView startAnimation];
    
    //Add a basemap tiled layer
    NSURL* url = [NSURL URLWithString:@"http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer"];
    AGSTiledMapServiceLayer *tiledLayer = [AGSTiledMapServiceLayer tiledMapServiceLayerWithURL:url];
    [self.mapView addMapLayer:tiledLayer withName:@"Basemap Tiled Layer"];

    
    
    
    AGSGraphicsLayer* myGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:myGraphicsLayer withName:@"GraphicsLayer"];
    
    //2. Set the map view's layerDelegate
    self.mapView.layerDelegate = self;
    self.mapView.callout.delegate = self;
    [self queryTest];
    self.constraintHeightOfBottomView.constant = 0;

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
    self.features = features;
    for (AGSGraphic *feature in features) {
        NSLog(@"%@", feature);
    }
    [self drawGraphicsLayerFeatures:features];

}

- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation *)op didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}



- (void)drawGraphicsLayerFeatures:(NSArray *)features{
    
    AGSGraphicsLayer *graphicLayer = (AGSGraphicsLayer *)[self.mapView mapLayerForName:@"GraphicsLayer"];
    
    double xmin = DBL_MAX;
    double ymin = DBL_MAX;
    double xmax = -DBL_MAX;
    double ymax = -DBL_MAX;
    self.minScore = INT_MAX;
    self.maxScore = INT_MIN;
    
    self.simpleSymbols = [NSMutableArray array];
    self.fixedSymbols = [NSMutableArray array];
    self.textSymbols = [NSMutableArray array];
    self.compositeSymbols = [NSMutableArray array];
    self.graphics = [NSMutableArray array];

    for (AGSGraphic *feature in features) {
        
        AGSCompositeSymbol *compositeSymbol = [AGSCompositeSymbol compositeSymbol];
        NSString *sentiment = [feature attributeAsStringForKey:@"sentiment"];
        
        AGSSimpleMarkerSymbol *simpleSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbol];
        simpleSymbol.color = [ColorHelper colorWithSentiment:sentiment andAlpha:0.5];
        simpleSymbol.size = CGSizeMake(20, 20);
        simpleSymbol.outline.width = 0;
        simpleSymbol.style = AGSSimpleMarkerSymbolStyleCircle;
        [compositeSymbol addSymbol:simpleSymbol];
        [self.simpleSymbols addObject:simpleSymbol];
        [self.compositeSymbols addObject:compositeSymbol];
        
        
        AGSSimpleMarkerSymbol *fixedSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbol];
        fixedSymbol.color = [ColorHelper colorWithSentiment:sentiment];
        fixedSymbol.size = CGSizeMake(25, 25);
        fixedSymbol.outline.width = 0;
        fixedSymbol.style = AGSSimpleMarkerSymbolStyleCircle;
        [compositeSymbol addSymbol:fixedSymbol];
        [self.fixedSymbols addObject:fixedSymbol];
        
//        UIImage *marker = [UIImage imageNamed:[feature attributeAsStringForKey:@"sentiment"]];
//        AGSPictureMarkerSymbol *pictureSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:marker];
//        [compositeSymbol addSymbol:pictureSymbol];
        
        
        NSInteger score = [feature attributeAsIntForKey:@"score" exists:nil];
        NSString *scoreText = [NSString stringWithFormat:@"%ld", score];
        
        if (self.minScore > score) {
            self.minScore = score;
        }
        if (self.maxScore < score){
            self.maxScore = score;
        }
        
        AGSTextSymbol *textSymbol = [AGSTextSymbol textSymbolWithText:scoreText color:[UIColor blackColor]];
        textSymbol.color = [UIColor whiteColor];
        [compositeSymbol addSymbol:textSymbol];
        [self.textSymbols addObject:textSymbol];
        
//        markerSymbol.color = [UIColor redColor];
        
        AGSPoint* markerPoint = feature.geometry.envelope.center;
        if (xmin > feature.geometry.envelope.center.x){
            xmin = feature.geometry.envelope.center.x;
        }
        if (xmax < feature.geometry.envelope.center.x){
            xmax = feature.geometry.envelope.center.x;
        }
        if (ymin > feature.geometry.envelope.center.y){
            ymin = feature.geometry.envelope.center.y;
        }
        if (ymax < feature.geometry.envelope.center.y){
            ymax = feature.geometry.envelope.center.y;
        }
        
        
        //Create the Graphic, using the symbol and
        //geometry created earlier
        AGSGraphic* myGraphic =
        [AGSGraphic graphicWithGeometry:markerPoint
                                 symbol:compositeSymbol
                             attributes:nil];
        [self.graphics addObject:myGraphic];
        
        //Add the graphic to the Graphics layer
        [graphicLayer addGraphic:myGraphic];
        
    }
    
    self.envelope = [AGSEnvelope envelopeWithXmin:xmin-100 ymin:ymin-100 xmax:xmax+100 ymax:ymax+100 spatialReference:self.mapView.spatialReference];
    [self.mapView zoomToEnvelope:self.envelope animated:YES];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(renderFeatures) userInfo:nil repeats:YES];
    
}

- (void)renderFeatures{
    AGSGraphicsLayer *graphicLayer = (AGSGraphicsLayer *)[self.mapView mapLayerForName:@"GraphicsLayer"];
    

    
    for (NSInteger idx=0; idx<self.graphics.count; idx++) {
        AGSSimpleMarkerSymbol *symbol = [self.simpleSymbols objectAtIndex:idx];
        
        AGSGraphic* feature = [self.features objectAtIndex:idx];
        NSInteger score = [feature attributeAsIntForKey:@"score" exists:nil];
        
        symbol.size = [self sizeForScore:score];
        AGSCompositeSymbol *compositeSymbol = [self.compositeSymbols objectAtIndex:idx];
        [compositeSymbol removeAllSymbols];
        [compositeSymbol addSymbol:symbol];
        
        AGSSimpleMarkerSymbol *fixed = [self.fixedSymbols objectAtIndex:idx];
        [compositeSymbol addSymbol:fixed];
        
        AGSTextSymbol *textSymbol = [self.textSymbols objectAtIndex:idx];
        [compositeSymbol addSymbol:textSymbol];
        
        AGSGraphic *graphic = [self.graphics objectAtIndex:idx];
        graphic.symbol = compositeSymbol;
    }
    [graphicLayer removeAllGraphics];
    [graphicLayer addGraphics:self.graphics];

}

- (CGSize)sizeForScore:(NSInteger)score {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    NSInteger range = self.maxScore - self.minScore;
    CGFloat normalized = (CGFloat)(score - self.minScore) / range * (sin(currentTime * 3.14159) * 0.3 + 1.0);
    
    
    CGFloat radius = 35 + normalized * 25;
    
    return CGSizeMake(radius, radius);
}

//3. Implement the layer delegate method
- (void)mapViewDidLoad:(AGSMapView *) mapView {
    //do something now that the map is loaded
    //for example, show the current location on the map
    NSLog(@"loaded");
    
    [mapView.locationDisplay startDataSource];
    
}

#pragma mark - Callout delegate


- (BOOL)callout:(AGSCallout *)callout willShowForFeature:(id<AGSFeature>)feature layer:(AGSLayer<AGSHitTestable> *)layer mapPoint:(AGSPoint *)mapPoint{
    
    for (AGSGraphic *selectedFeature in self.features) {
        if (selectedFeature.geometry.envelope.center.x == [feature geometry].envelope.center.x && selectedFeature.geometry.envelope.center.y == [feature geometry].envelope.center.y) {
            
            
            NSInteger score = [selectedFeature attributeAsIntForKey:@"score" exists:nil];
            self.selectedScore = [NSNumber numberWithInteger:score];
            self.selectedAuthor = [selectedFeature attributeAsStringForKey:@"author"];
            self.selectedMessage = [selectedFeature attributeAsStringForKey:@"message"];
            self.selectedSentiment = [selectedFeature attributeAsStringForKey:@"sentiment"];
            
            NSLog(@"%@", feature);
            NSLog(@"%@", self.selectedMessage);
            NSLog(@"%@", self.selectedSentiment);
            NSLog(@"%@", self.selectedAuthor);
            NSLog(@"%@", self.selectedScore);
        }
    }
    
    NSLog(@"show callout");
    
    self.labelScore.text = [NSString stringWithFormat:@"Score: %@", self.selectedScore];
    self.labelAuthor.text = self.selectedAuthor;
    [self.bottomViewBar setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Bar", self.selectedSentiment]]];
    
    [self.mapView centerAtPoint:[feature geometry].envelope.center animated:YES];
    


    [self.view layoutIfNeeded];
    self.constraintHeightOfBottomView.constant = 230;
    

    [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    
    
    
    [self.tableView reloadData];

    return NO;
}

#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    cell.backgroundColor = [ColorHelper colorWithSentiment:self.selectedSentiment];
    self.tableView.backgroundColor = cell.backgroundColor;
    cell.textView.text = self.selectedMessage;
    return cell;
}


- (IBAction)handleShowButton:(id)sender {
    [self.mapView zoomToEnvelope:self.envelope animated:YES];

//    [self.mapView zoomToGeometry:self.mapView.locationDisplay.mapLocation withPadding:0 animated:YES];
  
}
- (IBAction)handleLikeButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == 0) {
        [button setImage:[UIImage imageNamed:@"heartgray"] forState:UIControlStateNormal];
        button.tag = 1;
    } else {
        [button setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        button.tag = 0;
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

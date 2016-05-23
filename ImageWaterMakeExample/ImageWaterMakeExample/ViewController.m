//
//  ViewController.m
//  ImageWaterMakeExample
//
//  Created by yyb on 16/5/20.
//  Copyright © 2016年 yyb. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+YYBWatermakeToPic.h"
#import "NSDate+YYBInternetDateTime.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLGeocoder *geocoder;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLocation];
}
- (void)setLocation{
    _geocoder = [[CLGeocoder alloc] init];
    _locationManager=[[CLLocationManager alloc] init];
    _locationManager.delegate=self;
    
    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    _locationManager.distanceFilter=10;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
    }
    [_locationManager startUpdatingLocation];
    
}
- (void)startUI:(CLLocation *)location{
    __weak typeof(self) weakSelf = self;
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error||placemarks.count==0) {
            
            NSLog( @"你输入的地址没找到，可能在月球上");
            
            [NSDate getCurrentTimeFromService:^(NSString *currentTimeStr, NSError *error) {
                
                [weakSelf getServiceTime:currentTimeStr WithAddr:nil Err:error];
                
            }];
            
        }else//编码成功
        {
            
            CLPlacemark   * firstPlacemark=[placemarks firstObject];
            NSString *address =firstPlacemark.addressDictionary[@"FormattedAddressLines"][0];
            [NSDate getCurrentTimeFromService:^(NSString *currentTimeStr, NSError *error) {
                
                [weakSelf getServiceTime:currentTimeStr WithAddr:address Err:error];
                
            }];
            
        }
        
    }];
    
}
-(void)getServiceTime:(NSString *)currentTimeStr WithAddr:(NSString *)address Err:(NSError *)error{
    
    NSString *locationStr  = address;
    NSString *finalStr = currentTimeStr;
    
    if (locationStr) {
        finalStr =   [currentTimeStr stringByAppendingString:[NSString stringWithFormat:@"\n%@",locationStr]];
    }
    //主线程中刷新ui
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *image =[UIImage imageNamed:@"rose"];
        CGRect  rect = CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width*2/3,[UIScreen mainScreen].bounds.size.height*2/3);
        
        UIFont  *font = [ UIFont fontWithName : @"Arial-BoldMT" size : 17 ];
        UIColor *color= [ UIColor redColor ];
    
        UIImage *newImage = [image createShareImage:finalStr image:image andRect:rect andFont:font andColor:color];
        
        self.imageView.image = newImage;
    });
}
#pragma mark ---- CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation=[locations lastObject];
    if (currLocation) {
         [self startUI:currLocation];
        [_locationManager stopUpdatingLocation];
    }
}
/**
 *定位失败，回调此方法
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code]==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code]==kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
@end

//
//  ZMCGuidepageViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/6/22.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCGuidepageViewController.h"
#import "ZMCCustomeTabBarController.h"
#import <CoreLocation/CoreLocation.h>

#define k_Base_Tag  10000
#define k_Rotate_Rate 1
#define VERSION_INFO_CURRENT @"currentversion"

@interface ZMCGuidepageViewController ()<UIScrollViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@property (strong, nonatomic) CLLocationManager* locationManager;
@end

@implementation ZMCGuidepageViewController


- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        CGFloat width = 120;
        CGFloat height = 30;
        CGFloat x = (kScreenWidth - width) * 0.5;
        CGFloat y = kScreenHeight - 30 -20;
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(x, y, width, height)];
        pageControl.pageIndicatorTintColor = RGB(241, 241, 241);
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self.view addSubview:pageControl];
        
        _pageControl = pageControl;
    }
    return _pageControl;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startLocation];
    self.pageControl.numberOfPages = 4;
}

- (void)dealloc{
    [self.pageControl removeFromSuperview];
    self.pageControl = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_locationManager startUpdatingLocation];
    
//    [self startLocationService];
//    self.view.backgroundColor = [UIColor colorWithRed:140.0/255 green:1 blue:1 alpha:1];
    
    NSArray *imageArr = @[@"1",@"2",@"3",@"4"];
    NSArray *textImageArr = nil;
    
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = YES;
    mainScrollView.contentSize = CGSizeMake(kScreenWidth*imageArr.count, kScreenHeight);
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    
//    添加图片
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 330, kScreenWidth, 170*kScreenWidth/1242.0)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [UIImage imageNamed:@"yun"];
    [self.view addSubview:imageView];
    
    
    for (int i=0; i<imageArr.count; i++) {
        UIView *rotateView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight*2)];
        [rotateView setTag:k_Base_Tag+i];
        [mainScrollView addSubview:rotateView];
        if (i!=0) {
            rotateView.alpha = 0;
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [rotateView addSubview:imageView];
        
        UIImageView *textImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 50, kScreenWidth, kScreenWidth *260.0/1242.0)];
        [textImageView setTag:k_Base_Tag*2+i];
        textImageView.image = [UIImage imageNamed:textImageArr[i]];
        [mainScrollView addSubview:textImageView];
        
        //最后页面添加按钮
        if (i == imageArr.count-1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, kScreenHeight-50, 120, 30);
            btn.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 63);
            btn.layer.cornerRadius = 15;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(ClickToRemove) forControlEvents:UIControlEventTouchUpInside];
            [rotateView addSubview:btn];
        }
    }
    
    UIView *firstView = [mainScrollView viewWithTag:k_Base_Tag];
    [mainScrollView bringSubviewToFront:firstView];
    
}


//#pragma mark - 开始定位
//- (void)startLocationService
//{
//    
//    if (![CLLocationManager locationServicesEnabled]) {
//        ALERT_MSG(@"无法进行定位", @"请检查你的设备是否开启定位服务");
//        return;
//    }
//    //如果没有授权则请求用户授权
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
//        [self.locationManager requestWhenInUseAuthorization];
//    }else
//        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
//            //设置定位精度
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//            //定位频率,每隔多少米定位一次
//            CLLocationDistance distance = 50.0;//五十米定位一次
//            self.locationManager.distanceFilter = distance;
//            //启动跟踪定位
//            [self.locationManager startUpdatingLocation];
//        }
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
//    {
//        [_locationManager requestWhenInUseAuthorization];// 前台定位
//        [_locationManager requestAlwaysAuthorization];// 前后台同时定位
//    }
//}
//
//
//- (CLLocationManager *)locationManager
//{
//    if (!_locationManager) {
//        _locationManager = [[CLLocationManager alloc] init];
//        _locationManager.delegate = self;
//        
//    }
//    return _locationManager;
//}
-(void)startLocation{
    
    if (nil == _locationManager)
        
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    //设置定位的精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置移动多少距离后,触发代理.
    _locationManager.distanceFilter = 10.0;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
    {
        [_locationManager requestWhenInUseAuthorization];// 前台定位
        [_locationManager requestAlwaysAuthorization];// 前后台同时定位
    }

}
// 错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    ZMCLog(@"error%@",error);
}
// 6.0 以上调用这个函数
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = locations[0];
    //    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    
    //    CLLocation *newLocation = locations[1];
    //    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    //    NSLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
    
    // 计算两个坐标距离
    //    float distance = [newLocation distanceFromLocation:oldLocation];
    //    NSLog(@"%f",distance);
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       ZMCLog(@"%@",error);
                       
                       for (CLPlacemark *place in placemarks) {
                           
                           ZMCLog(@"name============%@",place.name);//位置名
                           ZMCLog(@"街道======%@",place.thoroughfare);// 街道
                           ZMCLog(@"子街道======%@",place.subThoroughfare);//子街道
                           ZMCLog(@"市======%@",place.locality);//市
                           ZMCLog(@"区======%@",place.subLocality);//区
                           ZMCLog(@"国家======%@",place.country);//国家
                           
                       }
                   }];
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    uint page = (scrollView.contentOffset.x / scrollView.bounds.size.width) + 0.5;
    
    self.pageControl.currentPage = page;
    
    UIView * view1 = [scrollView viewWithTag:k_Base_Tag];
    UIView * view2 = [scrollView viewWithTag:k_Base_Tag+1];
    UIView * view3 = [scrollView viewWithTag:k_Base_Tag+2];
    UIView * view4 = [scrollView viewWithTag:k_Base_Tag+3];
    
    UIImageView * imageView1 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2];
    UIImageView * imageView2 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2+1];
    UIImageView * imageView3 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2+2];
    UIImageView * imageView4 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2+3];
    
    CGFloat xOffset = scrollView.contentOffset.x;
    
    //根据偏移量旋转
    CGFloat rotateAngle = -1 * 1.0/kScreenWidth * xOffset * M_PI_2 * k_Rotate_Rate;
    view1.layer.transform = CATransform3DMakeRotation(rotateAngle, 0, 0, 1);
    view2.layer.transform = CATransform3DMakeRotation(M_PI_2*1+rotateAngle, 0, 0, 1);
    view3.layer.transform = CATransform3DMakeRotation(M_PI_2*2+rotateAngle, 0, 0, 1);
    view4.layer.transform = CATransform3DMakeRotation(M_PI_2*3+rotateAngle, 0, 0, 1);
    
    //根据偏移量位移（保证中心点始终都在屏幕下方中间）
    view1.center = CGPointMake(0.5 * kScreenWidth+xOffset, kScreenHeight);
    view2.center = CGPointMake(0.5 * kScreenWidth+xOffset, kScreenHeight);
    view3.center = CGPointMake(0.5 * kScreenWidth+xOffset, kScreenHeight);
    view4.center = CGPointMake(0.5 * kScreenWidth+xOffset, kScreenHeight);
    
    //当前哪个视图放在最上面
    if (xOffset<kScreenWidth*0.5) {
        [scrollView bringSubviewToFront:view1];
        
    }else if (xOffset>=kScreenWidth*0.5 && xOffset < kScreenWidth*1.5){
        [scrollView bringSubviewToFront:view2];
        
        
    }else if (xOffset >=kScreenWidth*1.5 && xOffset < kScreenWidth*2.5){
        [scrollView bringSubviewToFront:view3];
        
    }else if (xOffset >=kScreenWidth*2.5)
    {
        [scrollView bringSubviewToFront:view4];
        
    }
    
    //调节其透明度
    CGFloat xoffset_More = xOffset*1.5>kScreenWidth?kScreenWidth:xOffset*1.5;
    if (xOffset < kScreenWidth) {
        view1.alpha = (kScreenWidth - xoffset_More)/kScreenWidth;
        imageView1.alpha = (kScreenWidth - xOffset)/kScreenWidth;;
        
    }
    if (xOffset <= kScreenWidth) {
        view2.alpha = xoffset_More / kScreenWidth;
        imageView2.alpha = xOffset / kScreenWidth;
    }
    if (xOffset >kScreenWidth && xOffset <= kScreenWidth*2) {
        view2.alpha = (kScreenWidth*2 - xOffset)/kScreenWidth;
        view3.alpha = (xOffset - kScreenWidth)/ kScreenWidth;
        
        imageView2.alpha = (kScreenWidth*2 - xOffset)/kScreenWidth;
        imageView3.alpha = (xOffset - kScreenWidth)/ kScreenWidth;
    }
    if (xOffset >kScreenWidth*2 ) {
        view3.alpha = (kScreenWidth*3 - xOffset)/kScreenWidth;
        view4.alpha = (xOffset - kScreenWidth*2)/ kScreenWidth;
        
        imageView3.alpha = (kScreenWidth*3 - xOffset)/kScreenWidth;
        imageView4.alpha = (xOffset - kScreenWidth*2)/ kScreenWidth;
    }
    
    //调节背景色
    if (xOffset <kScreenWidth && xOffset>0) {
        self.view.backgroundColor = [UIColor colorWithRed:(234+21.0/kScreenWidth*xOffset)/255.0 green:(252-0.0/kScreenWidth*xOffset)/255.0 blue:(234-35.0/kScreenWidth*xOffset)/255.0 alpha:1];
        
    }else if (xOffset>=kScreenWidth &&xOffset<kScreenWidth*2){
        
        self.view.backgroundColor = [UIColor colorWithRed:(255-43.0/kScreenWidth*(xOffset-kScreenWidth))/255.0 green:(252-4.0/kScreenWidth*(xOffset-kScreenWidth))/255.0 blue:(199+56.0/320*(xOffset-kScreenWidth))/255.0 alpha:1];
        
    }else if (xOffset>=kScreenWidth*2 &&xOffset<kScreenWidth*3){
        
        self.view.backgroundColor = [UIColor colorWithRed:(212+42.0/kScreenWidth*(xOffset-kScreenWidth*2))/255.0 green:(248-11.0/kScreenWidth*(xOffset-kScreenWidth*2))/255.0 blue:(255-18.0/kScreenWidth*(xOffset-kScreenWidth*2))/255.0 alpha:1];
        
    }else if (xOffset>=kScreenWidth*3 &&xOffset<kScreenWidth*4){
        
        self.view.backgroundColor = [UIColor colorWithRed:(254-10.0/kScreenWidth*(xOffset-kScreenWidth*3))/255.0 green:(237-10.0/kScreenWidth*(xOffset-kScreenWidth*3))/255.0 blue:(237-10.0/kScreenWidth*(xOffset-kScreenWidth*3))/255.0 alpha:1];
    }
    
}

-(void)ClickToRemove
{
    ZMCLog(@"点击事件");
//    [self.view removeFromSuperview];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(click)]) {
        [self.delegate click];
    }
    
}
-(BOOL)shouldAutorotate
{
    return YES;
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


+ (BOOL)isShow
{
    // 读取版本信息
    NSString *localVersion = [USER_DEFAULT objectForKey:VERSION_INFO_CURRENT];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
        [ZMCGuidepageViewController saveCurrentVersion];
        return YES;
    }else
    {
        return NO;
    }
}
// 保存版本信息
+ (void)saveCurrentVersion
{
    [USER_DEFAULT setObject:@"YES" forKey:@"isUpdate"];
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [USER_DEFAULT setObject:version forKey:VERSION_INFO_CURRENT];
    [USER_DEFAULT synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
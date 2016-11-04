//
//  LocationViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ZMCNearbyTableViewCell.h"

#import "HomeNetwork.h"
#import "LocationMarketModel.h"
#import "ZMCSearchResultViewController.h"

#import "ZMCLocationHeaderView.h"

#import "LZFoldButton.h"

@interface ZMCLocationViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UISearchBarDelegate,LZFoldButtonDelegate>
{
    NSArray *_nearybyMarkets;
    
    NSArray *_historyNames;
    NSArray *_historyMarkets;
    NSArray *_locationInfoArray;
    
    BOOL _isLocatedSuccess;
    
    UIButton *_maskView;
    
    
    NSMutableArray *_lzButtons;
    
    NSArray *_sectionTitles;
    
    NSArray *_provinces;
    NSArray *_cities;
    NSArray *_countries;
    NSMutableDictionary *_pccInfo;
    
    NSInteger _locationFieldCount;

}
@property (nonatomic, strong) UITableView *LocationTableView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UILabel *headerLab;

@property (nonatomic, weak) ZMCLocationHeaderView *headerView;

@property (nonatomic, weak) LZFoldButton *provinceBtn;
@property (nonatomic, weak) LZFoldButton *cityBtn;
@property (nonatomic, weak) LZFoldButton *countyBtn;

@end

static NSString *cellReuseId = @"cell";
static NSString *systemCellReuseId = @"system";
@implementation ZMCLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _pccInfo = [[NSMutableDictionary alloc] init];
    
    ZMCLog(@"%@%@%@", _provincesStr, _cityStr, _countyStr);
    
    
    if (_provincesStr != nil) {

//        if ([_countyStr isEqualToString:@"吴中区"]) {
//            _countyStr = @"工业园区";
//        }
        _locationInfoArray = @[_provincesStr, _cityStr , _countyStr];
        
    }else{
        _locationInfoArray = @[@"选择省份", @"选择城市", @"选择区县"];
    }
    
    self.navigationItem.title = @"定位";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(cancelLocate) title:@"取消"];
    
    _sectionTitles = @[@"历史菜场",@"附近菜场",@"推荐菜场"];
    
    
    _nearybyMarkets = [self getNameArrayWithModels:_markets];
//    _historyNames = @[@"方洲邻里中心鲜蔬店",@"葑门菜场",@"陆慕菜场",@"葑门菜场"];
    
    // 获取历史菜市场
    [self sendRequestForHistoryMarkets];
    
//TODO:遍历model数组，把model的name属性放到一个新的数组中，然后创建历史菜场按钮
    [HomeNetwork requestHistoryMarketsWithPage:1 andCompleteBlock:^(NSArray *array) {

        
    }];
    
    /**
     *  头部的headview
     */
    self.headerView = [ZMCLocationHeaderView instanceHeaderView];
    [self setHeaderView];

    self.LocationTableView.tableHeaderView = self.headerView;
    self.LocationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.LocationTableView];
    
    // 蒙版
    [self createMaskView];

    
    _lzButtons = [[NSMutableArray alloc] init];
    
    [self requestProvince];
    
    [self.LocationTableView reloadData];
}

- (UITableView *)LocationTableView
{
    if (!_LocationTableView) {
        _LocationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64) style:UITableViewStylePlain];
        _LocationTableView.delegate = self;
        _LocationTableView.dataSource = self;
        _LocationTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _LocationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [_LocationTableView registerNib:[UINib nibWithNibName:@"ZMCNearbyTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
        [_LocationTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCellReuseId];

        _LocationTableView.separatorColor = UIColorFromRGB(0xe8e8e8);
    }
    return _LocationTableView;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

//发送请求获取历史菜场，需要token
- (void)sendRequestForHistoryMarkets
{
    
    [HomeNetwork requestHistoryMarketsWithPage:1 andCompleteBlock:^(NSArray *array) {
        NSMutableArray *nameArray = [[NSMutableArray alloc] init];
        for (LocationMarketModel *model in array) {
            [nameArray addObject:model.name];
        }
        _historyNames = nameArray;
        
        _historyMarkets = array;
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:0];
        [self.LocationTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
}


#pragma mark- 根据model数组得到菜场名字数组
- (NSArray *)getNameArrayWithModels:(NSArray *)models
{
    if (models != nil && models.count != 0) {
        NSMutableArray *array = [NSMutableArray array];
        _isLocatedSuccess = YES;
        for (LocationMarketModel *model in models) {
            [array addObject:model.name];
        }
        return array;
    }
    return nil;
}

#pragma mark- 退出定位界面
- (void)cancelLocate
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)returnMarketArray:(ReturnMarketArrayBlock)block
{
    self.returnMarketArrayBlock = block;
}

#pragma mark- 设置表头，给searchbar和按钮添加方法
- (void)setHeaderView
{
    
    
    self.headerView.searchBar.delegate = self;
    
    
//    _locationInfoArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"infoArray"];
    
    NSString *buttonName;
    if (!_markets) {
        buttonName = @"定位失败,请点击重新加载";
    } else {
        if (_markets.count == 0) {
           buttonName = @"周边没有菜场信息，换个地方试试";
            self.headerView.locateButton.enabled = NO;
        } else {
            LocationMarketModel *market = _markets[0];
            buttonName = market.name;
            self.headerView.locateButton.enabled = NO;
        }
    }
    [self.headerView.locateButton setTitle:buttonName forState:UIControlStateNormal];
    [self.headerView.locateButton addTarget:self action:@selector(clickToLocate) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark- 蒙版view和点击方法
- (void)createMaskView
{
    //蒙版view
    _maskView = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight)];
    _maskView.backgroundColor = [UIColor lightGrayColor];
//    _maskView.alpha = 0.1;
    _maskView.hidden = YES;
    [_maskView addTarget:self action:@selector(clickToDeselect:) forControlEvents:UIControlEventTouchUpInside];
    [self.LocationTableView addSubview:_maskView];
}
- (void)clickToDeselect:(UIButton *)button
{
    for (LZFoldButton *lllz in _lzButtons) {
        [lllz LZCloseTable];
        
    }
    button.hidden = YES;
    [_LocationTableView reloadData];
}


#pragma mark- 请求开通的省份列表
- (void)requestProvince
{
    NSMutableArray *provinceNames = [[NSMutableArray alloc] init];
    [HomeNetwork requestProvinceAndCompleteBlock:^(NSArray *array) {
        if ([array isKindOfClass:[NSNull class]]) {
            _provinces = @[@"暂未开通"];
            [provinceNames addObject:@"暂未开通"];
        }else{
            _provinces = array;
            for (int i = 0; i <_provinces.count; i ++) {
                [provinceNames addObject:_provinces[i][@"name"]];
            }
        }
        
        [self createButtonListWithListArray:provinceNames andIndex:0 number:_provinces.count];
    }];
    
    
    NSMutableArray *cityNames = [[NSMutableArray alloc] init];
    [HomeNetwork requestCityListWithProvince:10 andCompleteBlock:^(NSArray *array) {
        if ([array isKindOfClass:[NSNull class]]) {
            _cities = @[@"暂未开通"];
            [cityNames addObject:@"暂未开通"];
        }else{
            _cities = array;
            for (int i = 0; i < _cities.count; i ++) {
                [cityNames addObject:_cities[i][@"name"]];
            }
        }
        
        [self createButtonListWithListArray:cityNames andIndex:1 number:_cities.count];
        
    }];
    
    
    NSMutableArray *countryNames = [[NSMutableArray alloc] init];
    [HomeNetwork requestCountryListWithCity:106 andCompleteBlock:^(NSArray *array) {
        if ([array isKindOfClass:[NSNull class]]) {
            _countries = @[@"暂未开通"];
            [countryNames addObject:@"暂未开通"];
        }else{
            _countries = array;
            for (int i = 0; i < _countries.count; i ++) {
                [countryNames addObject:_countries[i][@"name"]];
            }
        }
        [self createButtonListWithListArray:countryNames andIndex:2 number:_countries.count];
        
    }];
    
    [_pccInfo setObject:@(10) forKey:@"province"];
    [_pccInfo setObject:@(106) forKey:@"city"];
    [_pccInfo setObject:@(1102) forKey:@"country"];

    [self getInfo];
}

#pragma mark- 创建带有下拉列表的button
- (void)createButtonListWithListArray:(NSArray *)array andIndex:(int)a number:(NSInteger)number
{
    
    LZFoldButton *button = [_LocationTableView viewWithTag:(1111 + a)];
    [button removeFromSuperview];

    CGFloat width = (kScreenWidth - 2)/3.0;
    CGRect frame = CGRectMake(0 + a *(width +1), 40, width, 40);
    LZFoldButton *lz = [[LZFoldButton alloc]initWithFrame:frame dataArray:array];
    lz.backgroundColor = [UIColor whiteColor];
    
    lz.lzTitleFontSize = 15;
    lz.lzButtonType = LZFoldButtonTypeRight;
//    lz.lzHeight = SCREEN_H - NAV_H - 100;
    [lz LZSetTitle:_locationInfoArray[a] forState:UIControlStateNormal];
    [lz LZSetTitleColor:StringMiddleColor forState:UIControlStateNormal];
//    [lz LZSetTitleColor:ThemeGreenColor forState:UIControlStateSelected];
    [lz LZSetImage:[UIImage imageNamed:@"xiala_icon"] forState:UIControlStateNormal];
    lz.tag = a + 1111;
    
    if (a == 0) {
        _provinceBtn = lz;
        if (number < 9) {
            lz.lzHeight = 43 * number + number - 1;
        }else{
            lz.lzHeight = 43 * 9 + 8;
        }
    }else if (a == 1){
        _cityBtn = lz;
        if (number < 9) {
            lz.lzHeight = 43 * number + number - 1;
        }else{
            lz.lzHeight = 43 * 9 + 8;
        }
    }else{
        _countyBtn = lz;
        if (number < 9) {
            lz.lzHeight = 43 * number + number - 1;
        }else{
            lz.lzHeight = 43 * 9 + 8;
        }
    }
    
    lz.lzFontSize = 14;
    lz.lzAlpha = 1;
    lz.lzFontColor = StringMiddleColor;
    
    [_LocationTableView addSubview:lz];
    [_lzButtons addObject:lz];
    
    lz.lzDelegate = self;
    
//    __weak UITableView *weakTable = _LocationTableView;
//    //点击上面的foldbutton
//    lz.aaStatusBlock = ^(BOOL isOpen) {
//        _maskView.hidden = !isOpen;
//        [UIView animateWithDuration:0.5 animations:^{
//            _maskView.alpha =  isOpen == YES? 0.3:0.0;
//        }];
//        
//        weakTable.scrollEnabled = !isOpen;
//        [weakTable reloadData];
//
//        if (isOpen) {
//            [self.headerView.searchBar resignFirstResponder];
//        }
//    
//        ZMCLog(@"300----retain_count=：%ld",CFGetRetainCount((__bridge CFTypeRef)self));
//        ZMCLog(@"300----retain_count=：%ld",CFGetRetainCount((__bridge CFTypeRef)weakTable));
//
//    };
}


#pragma mark - 省市区按钮点击会调用的方法
- (void)AAFoldButton:(LZFoldButton *)foldButton isOpen:(BOOL)isOpen
{
    
    for (LZFoldButton *lllz in _lzButtons) {
        if (lllz.tag != foldButton.tag) {
            ZMCLog(@"%ld---%ld", lllz.tag, foldButton.tag);
            if (foldButton.lzSelected == YES) {
                [lllz LZCloseTable];
            }
        }
    }
    
    _maskView.hidden = !isOpen;
    [UIView animateWithDuration:0.2 animations:^{
        _maskView.alpha = isOpen == YES? 0.5:0.0;
    }];
    
    _LocationTableView.scrollEnabled = !isOpen;
    [_LocationTableView reloadData];
    
    if (isOpen) {
        self.headerView.searchBar.showsCancelButton = NO;
        [self.headerView.searchBar resignFirstResponder];
    }
    
//    ZMCLog(@"BOOL--b-->%s",isOpen?"YES":"NO");
//    ZMCLog(@"%ld", foldButton.tag);

}

- (void)AAFoldButton:(LZFoldButton *)foldButton didSelectIndex:(NSInteger)index
{

    if (foldButton.tag == 1111) {
        
        for (int i = 1; i < _lzButtons.count; i ++) {
            LZFoldButton *button = _lzButtons[i];
            [button removeFromSuperview];
        }
        
        long province_id = [_provinces[index][@"id"] longValue];
        NSMutableArray *cityNames = [[NSMutableArray alloc] init];
        
        [HomeNetwork requestCityListWithProvince:province_id andCompleteBlock:^(NSArray *array) {
            _cities = array;
            
            for (int i = 0; i < _cities.count; i ++) {
                [cityNames addObject:_cities[i][@"name"]];
            }
            
            [self createButtonListWithListArray:cityNames andIndex:1 number:_cities.count];
            [_cityBtn LZSetTitle:@"选择城市" forState:UIControlStateNormal];
            [_cityBtn LZSetImage:[UIImage imageNamed:@"xiala_icon"] forState:UIControlStateNormal];
            [_countyBtn LZSetTitle:@"选择区县" forState:UIControlStateNormal];
        }];
        
        [_pccInfo setObject:@(province_id) forKey:@"province"];
        [_pccInfo setObject:@"" forKey:@"city"];
        [_pccInfo setObject:@"" forKey:@"country"];
        [self getInfo];
        
    }
    if (foldButton.tag == 1112) {
        

        
        long city_id = [_cities[index][@"id"] longValue];
        NSMutableArray *countryNames = [[NSMutableArray alloc] init];
        
        [HomeNetwork requestCountryListWithCity:city_id andCompleteBlock:^(NSArray *array) {
            _countries = array;
            
            for (int i = 0; i < _countries.count; i ++) {
                [countryNames addObject:_countries[i][@"name"]];
                
            }
            [self createButtonListWithListArray:countryNames andIndex:2 number:_countries.count];
            [_countyBtn LZSetTitle:@"选择区县" forState:UIControlStateNormal];
            [_countyBtn LZSetImage:[UIImage imageNamed:@"xiala_icon"] forState:UIControlStateNormal];
        }];
        
        [_pccInfo setObject:@(city_id) forKey:@"city"];
        [_pccInfo setObject:@"" forKey:@"country"];
        [self getInfo];
    }
    if (foldButton.tag == 1113) {
        
        long country_id = [_countries[index][@"id"] longValue];
        [_pccInfo setObject:@(country_id) forKey:@"country"];
        
        [self getInfo];
    }

    [_LocationTableView reloadData];
}

- (void)getInfo {
    
    
    [CommonHttpAPI getMarketSearchWithParameters:[CommonRequestModel getMarketSearchWithAddress:@"" city_id:_pccInfo[@"city"] county_id:_pccInfo[@"country"] province_id:_pccInfo[@"province"]] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        NSArray *array = [LocationMarketModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
        _markets = array;
        
        //        定位成功，请求成功后，刷新表头和表的内容
        _nearybyMarkets = [self getNameArrayWithModels:array];
//        [self setHeaderView];
        
        
        //        [_LocationTableView reloadData];
//        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
//        [self.LocationTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//        self.returnMarketArrayBlock(_markets[0]);
        
        [_LocationTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

#pragma mark- 定位失败，点击重新加载
- (void)clickToLocate
{
    _locationFieldCount = 0;
    if (_isLocatedSuccess) {
        return;
    }
    
    if (![CLLocationManager locationServicesEnabled]) {
        ALERT_MSG(@"无法进行定位", @"请检查你的设备是否开启定位服务");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置定位精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        self.locationManager.distanceFilter=distance;
        //启动跟踪定位
        [self.locationManager startUpdatingLocation];
    }

}


#pragma mark- 表的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _nearybyMarkets.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self getCustomViewHeightWithArray:_historyNames];
    }
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ZMCNearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
        cell.marketNameLabel.text = _nearybyMarkets[indexPath.row];
        cell.marketInfoLabel.text = _isLocatedSuccess ? @"":@"";
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCellReuseId forIndexPath:indexPath];
    
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }

    [self getCustomViewWithArray:_historyNames andView:cell];

    cell.backgroundColor = UIColorFromRGB(0xf4f4f4);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    for (LZFoldButton *button in _lzButtons) {
        if (button.lzSelected == YES) {
            return 0;
        }
    }
    
    if (section == 0) {
        if (_historyNames.count == 0) {
            _headerLab.hidden = YES;
            return 0;
        }
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = StringLightColor;
    if (section == 0) {
        label.text = _sectionTitles[0];
    } else {
        label.text = _isLocatedSuccess ?_sectionTitles[1]:_sectionTitles[2];
    }
    _headerLab = label;
    [view addSubview:label];
    view.backgroundColor = tableView.backgroundColor;
    return view;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self clearSearchBar];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        self.returnMarketArrayBlock(_markets[indexPath.row]);
    }
    
    [self cancelLocate];
}


#pragma mark- 根据arr字符串数组，设置相应的button大小，并添加到view上
- (void)getCustomViewWithArray:(NSArray *)arr andView:(UIView *)view
{
//    frame.origin.x = 0;
//    frame.origin.y = 0;
//    CGRect newFrame = frame;
//    UIView *view = [[UIView alloc] initWithFrame:newFrame];
    
    CGFloat x = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat y = 10;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:StringDarkColor forState:UIControlStateNormal];

        CGFloat length = 14 *[(NSString *)arr[i] length];
        
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        //设置button的frame
        button.frame = CGRectMake(10 + x, y, length + 30, 40);
        //当button的位置超出屏幕边缘时换行
        if(10 + x + length > kScreenWidth){
            x = 0; //换行时将w置为0
            y = y + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + x, y, length + 30, 40);//重设button的frame
        }
        x = button.frame.size.width + button.frame.origin.x;
        
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        [view addSubview:button];
        
    }
}
- (CGFloat)getCustomViewHeightWithArray:(NSArray *)arr
{
    if (arr.count == 0) {
        return 0;
    }
    CGFloat x = 0;
    CGFloat y = 10;
    for (int i = 0; i < arr.count; i++) {
        
        CGFloat length = 14 *[(NSString *)arr[i] length];
        
        if(10 + x + length > kScreenWidth){
            x = 0;
            y = y + 40 + 10;
        }
        x = length + x + 30;
    }
    return y + 40 + 10 ;
}
- (void)handleClick:(UIButton *)button
{
    self.returnMarketArrayBlock(_historyMarkets[button.tag]);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations lastObject];//取出最后一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    
    [self getNearbyMarketsWithCoordinate:coordinate];
    
    //如果不需要实时定位，使用完及时关闭定位服务
    [_locationManager stopUpdatingLocation];
    
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        if (error || placemarks.count==0) {
            ZMCLog(@"查不到位置信息，错误原因%@",error);
        } else {
            CLPlacemark *placemark = placemarks[0];
            
//        _locationInfoArray = 设置省市区
            NSArray *locationInfoArray = @[placemark.administrativeArea,placemark.locality,placemark.subLocality];
            [USER_DEFAULT setObject:locationInfoArray forKey:@"infoArray"];
            [USER_DEFAULT synchronize];
        }

    }];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
    if (_locationFieldCount != 0) {
        return;
    }
//    ALERT_MSG(@"提示", @"糟糕，定位失败，请稍候重试！");
    [_locationManager stopUpdatingLocation];
    _locationFieldCount ++;
}

- (void)getNearbyMarketsWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    
    [HomeNetwork requestNearbyMarketWithCoordinateLatitude:coordinate.latitude andLongitude:coordinate.longitude andCompleteBlock:^(NSArray *array) {

        _markets = array;
        
//        定位成功，请求成功后，刷新表头和表的内容
        _nearybyMarkets = [self getNameArrayWithModels:array];
        [self setHeaderView];

        
//        [_LocationTableView reloadData];
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
        [self.LocationTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];

        if (_markets.count > 0) {
            
            self.returnMarketArrayBlock(_markets[0]);
        }
        
    }];
}

#pragma mark- searchBar 代理方法

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self clearSearchBar];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    

    if (_pccInfo.allKeys.count < 3) {
        ALERT_MSG(@"温馨提示", @"选择完整的省市区搜索更准确(^_^)");
//        [self clearSearchBar];
        return;
        
    }
//    搜索菜场
    ZMCSearchResultViewController *searchVC = [[ZMCSearchResultViewController alloc] init];
    searchVC.placeholder = @"搜索菜场";
    searchVC.pccInfo = _pccInfo;
    searchVC.kind = @"菜场";
    searchVC.searchText = self.headerView.searchBar.text;
    [self.navigationController pushViewController:searchVC animated:YES];
    
    [self clearSearchBar];
}

- (void)clearSearchBar
{
    [self.headerView.searchBar resignFirstResponder];
    self.headerView.searchBar.showsCancelButton = NO;
    
    self.headerView.searchBar.text = @"";
}


#pragma mark - 取消按钮颜色
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    for (id cc in [self.headerView.searchBar.subviews[0] subviews]) {
        if ([cc isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)cc;
            [btn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
        }
    }
}


- (void)dealloc
{
    
}

@end

//
//  ViewController.m
//  AutoLayoutAndSIzeClass
//
//  Created by Horson Wu on 15/7/9.
//  Copyright (c) 2015年 Horson Wu. All rights reserved.
//

#import "ViewController.h"
#import "UIView+autoLayoutView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    /*
     mas_makeConstraints 只负责新增约束 Autolayout不能同时存在两条针对于同一对象的约束 否则会报错
     mas_updateConstraints 针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
     mas_remakeConstraints 则会清除之前的所有约束 仅保留最新的约束
     三种函数善加利用 就可以应对各种情况了
     */
    
    - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
    - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
    - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
#endif
    
    
   

    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:sv];
    __weak __typeof(&*self)ws = self;
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
#if  0
#pragma mark -- 简单的View约束
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor redColor];
    [sv addSubview:sv1];
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    /* 等价于
     make.top.equalTo(sv).with.offset(10);
     make.left.equalTo(sv).with.offset(10);
     make.bottom.equalTo(sv).with.offset(-10);
     make.right.equalTo(sv).with.offset(-10);
     */
    
    /* 也等价于
     make.top.left.bottom.and.right.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
     */
#pragma mark -- 两个View相互限制
    int padding1 = 10;
    UIView *sv2 = [UIView new];
    sv2.backgroundColor = [UIColor blackColor];
    [sv1 addSubview:sv2];
    UIView *sv3 = [UIView new];
    sv3.backgroundColor = [UIColor blueColor];
    [sv1 addSubview:sv3];
    
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sv1.mas_centerY);
        make.left.equalTo(sv1.mas_left).with.offset(padding1);
        make.right.equalTo(sv3.mas_left).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(sv3);
    }];
    
    [sv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sv1.mas_centerY);
        make.left.equalTo(sv2.mas_right).with.offset(padding1);
        make.right.equalTo(sv1.mas_right).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(sv2);
    }];
#endif
 
    
#if 0
#pragma mark -- UIScrollView的自动布局
    
    UIScrollView *scrollView =[UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [sv addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    int count = 10;
    UIView *lastView = nil;
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [container addSubview:subv];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20*i));
            if ( lastView )
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        lastView = subv;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
#endif
    
    
#if 1
#pragma mark -- 横向或者纵向等间隙的排列一组view

    UIView *sv11 = [UIView new];
    UIView *sv12 = [UIView new];
    UIView *sv13 = [UIView new];
    UIView *sv21 = [UIView new];
    UIView *sv31 = [UIView new];
    sv11.backgroundColor = [UIColor redColor];
    sv12.backgroundColor = [UIColor redColor];
    sv13.backgroundColor = [UIColor redColor];
    sv21.backgroundColor = [UIColor redColor];
    sv31.backgroundColor = [UIColor redColor];
    [sv addSubview:sv11];
    [sv addSubview:sv12];
    [sv addSubview:sv13];
    [sv addSubview:sv21];
    [sv addSubview:sv31];
    //给予不同的大小 测试效果
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@[sv12,sv13]);
            make.centerX.equalTo(@[sv21,sv31]);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 20));
        }];
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
    [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 60));
        }];
    [sv distributeSpacingHorizontallyWith:@[sv11,sv12,sv13,sv31]];
    [sv distributeSpacingVerticallyWith:@[sv11,sv21,sv31]];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

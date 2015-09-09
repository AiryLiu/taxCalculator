//
//  MSalary.h
//  taxcalculator
//
//  Created by LiuX on 15/9/6.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSalary : NSObject

@property (nonatomic, assign) double originalSalary;
@property (nonatomic, assign) double baseShB;
@property (nonatomic, assign) double baseGJJ;

@property (nonatomic, assign) double finalSalary;
@property (nonatomic, assign) double totalShB;
@property (nonatomic, assign) double tax;

@property (nonatomic, assign) double personalYangLLB;
@property (nonatomic, assign) double personalYiLLB;
@property (nonatomic, assign) double personalShiYLB;
@property (nonatomic, assign) double personalShengYLB;
@property (nonatomic, assign) double personalGongShLB;
@property (nonatomic, assign) double personalGongJJLB;

@property (nonatomic, assign) double corpYangLLB;
@property (nonatomic, assign) double corpYiLLB;
@property (nonatomic, assign) double corpShiYLB;
@property (nonatomic, assign) double corpShengYLB;
@property (nonatomic, assign) double corpGongShLB;
@property (nonatomic, assign) double corpGongJJLB;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)doCalculate;

@end

@interface MRatio : NSObject

@property (nonatomic, assign) NSInteger areaCode;

@property (nonatomic, assign) double personalYangLLB;
@property (nonatomic, assign) double personalYiLLB;
@property (nonatomic, assign) double personalShiYLB;
@property (nonatomic, assign) double personalShengYLB;
@property (nonatomic, assign) double personalGongShLB;
@property (nonatomic, assign) double personalGongJJLB;

@property (nonatomic, assign) double corpYangLLB;
@property (nonatomic, assign) double corpYiLLB;
@property (nonatomic, assign) double corpShiYLB;
@property (nonatomic, assign) double corpShengYLB;
@property (nonatomic, assign) double corpGongShLB;
@property (nonatomic, assign) double corpGongJJLB;

@property (nonatomic, assign) double taxBaseMoney;
@property (nonatomic, strong) NSArray *taxStepArray;
@property (nonatomic, strong) NSArray *taxRatioArray;
@property (nonatomic, strong) NSArray *taxMinusArray;

+ (instancetype)bjRatio;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

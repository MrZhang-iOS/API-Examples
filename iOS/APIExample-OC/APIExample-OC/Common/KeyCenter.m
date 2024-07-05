//
//  KeyCenter.m
//  APIExample
//
//  Created by zhaoyongqiang on 2023/7/11.
//

#import "KeyCenter.h"

//static NSString * const APPID = @"abc54617574441fbb42ce41f57c044fe";
//static NSString * const Certificate = @"d99a513117264109987ed3340c495e78";
//static NSString * const APPID = @"6594b763a7e84a2d89350d1a7749d99d";
static NSString * const APPID = @"e8f38ee7283e4f6eaed4ecec6fcc5b3a";
static NSString * const Certificate = nil;

@implementation KeyCenter

+ (nullable NSString *)AppId {
    return APPID;
}

+ (nullable NSString *)Certificate {
    return Certificate;
}

@end

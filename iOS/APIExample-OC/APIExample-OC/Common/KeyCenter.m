//
//  KeyCenter.m
//  APIExample
//
//  Created by zhaoyongqiang on 2023/7/11.
//

#import "KeyCenter.h"

static NSString * const APPID = @"abc54617574441fbb42ce41f57c044fe";
static NSString * const Certificate = @"d99a513117264109987ed3340c495e78";

@implementation KeyCenter

+ (nullable NSString *)AppId {
    return APPID;
}

+ (nullable NSString *)Certificate {
    return Certificate;
}

@end

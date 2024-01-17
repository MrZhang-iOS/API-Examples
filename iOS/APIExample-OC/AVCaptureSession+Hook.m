//
//  AVCaptureSession+Hook.m
//  ZegoSimpleDemo
//
//  Created by zhangwei on 2023/12/21.
//

#import "AVCaptureSession+Hook.h"
#import <objc/runtime.h>

@implementation AVCaptureSession (Hook)

//分类的方式重构系统方法时不要直接覆盖系统方法，使用runtime置换掉系统方法，防止与相同分类模块冲突造成异常
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class instanceClass = [self class];
        
        SEL originalInstanceSelector = @selector(startRunning);
        SEL swizzledInstanceSelector = @selector(zw_startRunning);
        
        Method originalInstanceMethod = class_getInstanceMethod(instanceClass, originalInstanceSelector);
        Method swizzledInstanceMethod = class_getInstanceMethod(instanceClass, swizzledInstanceSelector);
        
        if (originalInstanceMethod && swizzledInstanceMethod)
        {
            //class_addMethod添加swizzledMethod的实现IMP到originalSelector中（只是添加，不会覆盖originalSelector的原有实现），
            //当且仅当originalSelector为当前类的父类中的函数（无论实例方法还是类方法）时才能添加成功。
            //进行类方法交换时，参数必须为元类
            //1.类本身（分类算作类本身）有实现需要被替换的方法（无论实例方法还是类方法）时，class_addMethod方法返回NO，
            //这种情况交换两个方法的实现就可以了。
            //2.类本身没有实现需要被替换的方法（无论实例方法还是类方法）时，其父类有实现方法（可继承使用），class_addMethod方法返回YES，
            //这种情况重置原方法的实现到新方法名的映射就可以了。
            //
            //也可以直接使用method_exchangeImplementations方法，绕开class_addMethod。
            BOOL isMethodAdd = class_addMethod(instanceClass, originalInstanceSelector, method_getImplementation(swizzledInstanceMethod), method_getTypeEncoding(swizzledInstanceMethod));
            if (isMethodAdd)
            {
                class_replaceMethod(instanceClass, swizzledInstanceSelector, method_getImplementation(originalInstanceMethod), method_getTypeEncoding(originalInstanceMethod));
            }
            else
            {
                method_exchangeImplementations(originalInstanceMethod, swizzledInstanceMethod);
            }
        }
        else
        {
            NSLog(@"❌❌❌没有找到指定的实例方法，交换失败！");
        }
    });
}

- (void)zw_startRunning {
    CFTimeInterval startTime = CACurrentMediaTime();
    //待执行的任务
    [self zw_startRunning];
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"--startRunning耗时:%f", endTime - startTime);
}
@end

//
//  CTFrameParser.m
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//


#import "CTFrameParser.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"

@interface CTFrameParser ()

@end

@implementation CTFrameParser

////1单个富文本
//+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config
//{
//    NSDictionary *attributes = [NSMutableDictionary new];
//    attributes = [self attributeWithConfig:config];
//
//
//    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
//
////    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"iOS程序在启动时会创建一个主线程，而在一个线程只能执行一件事情，如果在主线程执行某些耗时操作，例如加载网络图片，下载资源文件等会阻塞主线程（导致界面卡死，无法交互），所以就需要使用多线程技术来避免这类情况。iOS中有三种多线程技术 NSThread，NSOperation，GCD，这三种技术是随着IOS发展引入的，抽象层次由低到高，使用也越来越简单。"];
//
//    // 创建 CTFramesetterRef 实例
//    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
//
//    // 获得要绘制的区域的高度
//    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
//    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, restrictSize, nil);
//    CGFloat textHeight = coreTextSize.height;
//
//    // 生成 CTFrameRef 实例
//    CTFrameRef frameRef = [self createFrameWithFrameSetter:frameSetter config:config height:textHeight];
//
//    // 将生成好的 CTFrameRef 实例和计算好的绘制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
//    CoreTextData *data = [[CoreTextData alloc] init];
//    data.ctFrame = frameRef;
//    data.height = textHeight;
//
//    // 释放内存
//    CFRelease(frameRef);
//    CFRelease(frameSetter);
//
//    return data;
//}
//
//
//+ (NSDictionary *)attributeWithConfig:(CTFrameParserConfig *)config
//{
//    CGFloat fontSize = config.fontSize;
//    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//    CGFloat lineSpacing = config.lineSpace;
//    const CFIndex kNumberOfSettings = 3;
//    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
//        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
//        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
//        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
//    };
//
//    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
//
//    UIColor * textColor = config.textColor;
//
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
//    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
//    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
//
//    CFRelease(theParagraphRef);
//    CFRelease(fontRef);
//    return dict;
//
//}
//
//
//+ (CTFrameRef)createFrameWithFrameSetter:(CTFramesetterRef)frameSetter config:(CTFrameParserConfig *)config height:(CGFloat)height
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
//
//    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
//
//    CFRelease(path);
//
//    return frame;
//
//}





////2多个富文本
//// 方法一用于提供对外的接口，调用方法二实现从一个 JSON 的模版文件中读取内容，然后调用方法五生成CoreTextData
//+ (CoreTextData *)parseTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config {
//    NSAttributedString *content = [self loadTemplateFile:dict config:config];
//    return [self parseAttributedContent:content config:config];
//}
//
//// 方法二读取 JSON 文件内容，并且调用方法三获得从NSDictionary到NSAttributedString的转换结果。
//+ (NSAttributedString *)loadTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config {
//
//    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
//
//    NSArray *array = [NSArray arrayWithArray:dict];
//        if ([array isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dict in array) {
//                NSString *type = dict[@"type"];
//                if ([type isEqualToString:@"txt"]) {
//                    NSAttributedString *as =
//                    [self parseAttributedContentFromNSDictionary:dict
//                                                          config:config];
//                    [result appendAttributedString:as];
//                }
//            }
//        }
//    return result;
//}
//
//// 方法三将NSDictionary内容转换为NSAttributedString
//+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict
//                                                        config:(CTFrameParserConfig*)config {
//    NSMutableDictionary *attributes = [self attributesWithConfig:config];
//    // set color
//    UIColor *color = [self colorFromTemplate:dict[@"color"]];
//    if (color) {
//        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
//    }
//    // set font size
//    CGFloat fontSize = [dict[@"size"] floatValue];
//    if (fontSize > 0) {
//        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
//        CFRelease(fontRef);
//    }
//    NSString *content = dict[@"content"];
//    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
//}
//
//// 方法四提供将NSString转为UIColor的功能
//+ (UIColor *)colorFromTemplate:(NSString *)name {
//    if ([name isEqualToString:@"blue"]) {
//        return [UIColor blueColor];
//    } else if ([name isEqualToString:@"red"]) {
//        return [UIColor redColor];
//    } else if ([name isEqualToString:@"black"]) {
//        return [UIColor blackColor];
//    }else if ([name isEqualToString:@"yellow"]) {
//        return [UIColor yellowColor];
//    } else if ([name isEqualToString:@"green"]) {
//        return [UIColor greenColor];
//    }
//    else {
//        return nil;
//    }
//}
//
//// 方法五 接受一个NSAttributedString和一个config参数，将NSAttributedString转换成CoreTextData返回
//+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config {
//    // 创建 CTFramesetterRef 实例
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
//
//    // 获得要缓制的区域的高度
//    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
//    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil);
//    CGFloat textHeight = coreTextSize.height;
//
//    // 生成 CTFrameRef 实例
//    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
//
//    // 将生成好的 CTFrameRef 实例和计算好的缓制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
//    CoreTextData *data = [[CoreTextData alloc] init];
//    data.ctFrame = frame;
//    data.height = textHeight;
//
//    // 释放内存
//    CFRelease(frame);
//    CFRelease(framesetter);
//    return data;
//}
//
//// 方法六是方法五的一个辅助函数，供方法五调用
//+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
//                                  config:(CTFrameParserConfig *)config
//                                  height:(CGFloat)height {
//
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
//
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
//    CFRelease(path);
//    return frame;
//}
//
//
//+ (NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config
//{
//    CGFloat fontSize = config.fontSize;
//    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//    CGFloat lineSpacing = config.lineSpace;
//    const CFIndex kNumberOfSettings = 3;
//    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
//        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
//        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
//        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
//    };
//
//    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
//
//    UIColor * textColor = config.textColor;
//
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
//    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
//    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
//
//    CFRelease(theParagraphRef);
//    CFRelease(fontRef);
//    return dict;
//
//}







////3带图片，并有图片点击
//// 方法一
//+ (CoreTextData *)parseTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config {
//    NSMutableArray *imageArray = [NSMutableArray array];
//    NSAttributedString *content = [self loadTemplateFile:dict config:config imageArray:imageArray];
//    CoreTextData *data = [self parseAttributedContent:content config:config];
//    data.imageArray = imageArray;
//    return data;
//}
//
//// 方法二
//+ (NSAttributedString *)loadTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config imageArray:(NSMutableArray *)imageArray{
//
//    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
//
//    NSArray *array = [NSArray arrayWithArray:dict];
//    if ([array isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *dict in array) {
//            NSString *type = dict[@"type"];
//            if ([type isEqualToString:@"txt"]) {
//                NSAttributedString *as =
//                [self parseAttributedContentFromNSDictionary:dict
//                                                      config:config];
//                [result appendAttributedString:as];
//            }else if ([type isEqualToString:@"img"]){
//                CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
//                imageData.name = dict[@"name"];
//                imageData.position = [result length];
//                [imageArray addObject:imageData];
//                NSAttributedString *as =[self parseImageDataFromNSDictionary:dict config:config];
//                [result appendAttributedString:as];
//
//
//            }
//        }
//    }
//    return result;
//}
//
//// 方法三
//+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict
//                                                        config:(CTFrameParserConfig*)config {
//    NSMutableDictionary *attributes = [self attributesWithConfig:config];
//    // set color
//    UIColor *color = [self colorFromTemplate:dict[@"color"]];
//    if (color) {
//        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
//    }
//    // set font size
//    CGFloat fontSize = [dict[@"size"] floatValue];
//    if (fontSize > 0) {
//        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
//        CFRelease(fontRef);
//    }
//    NSString *content = dict[@"content"];
//    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
//}
//
//// 方法四
//+ (UIColor *)colorFromTemplate:(NSString *)name {
//    if ([name isEqualToString:@"blue"]) {
//        return [UIColor blueColor];
//    } else if ([name isEqualToString:@"red"]) {
//        return [UIColor redColor];
//    } else if ([name isEqualToString:@"black"]) {
//        return [UIColor blackColor];
//    } else {
//        return nil;
//    }
//}
//
//// 方法五
//+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config {
//    // 创建 CTFramesetterRef 实例
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
//
//    // 获得要缓制的区域的高度
//    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
//    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil);
//    CGFloat textHeight = coreTextSize.height;
//
//    // 生成 CTFrameRef 实例
//    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
//
//    // 将生成好的 CTFrameRef 实例和计算好的缓制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
//    CoreTextData *data = [[CoreTextData alloc] init];
//    data.ctFrame = frame;
//    data.height = textHeight;
//
//    // 释放内存
//    CFRelease(frame);
//    CFRelease(framesetter);
//    return data;
//}
//
//// 方法六
//+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
//                                  config:(CTFrameParserConfig *)config
//                                  height:(CGFloat)height {
//
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
//
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
//    CFRelease(path);
//    return frame;
//}
//
//
//+ (NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config
//{
//    CGFloat fontSize = config.fontSize;
//    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//    CGFloat lineSpacing = config.lineSpace;
//    const CFIndex kNumberOfSettings = 3;
//    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
//        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
//        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
//        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
//    };
//
//    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
//
//    UIColor * textColor = config.textColor;
//
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
//    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
//    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
//
//    CFRelease(theParagraphRef);
//    CFRelease(fontRef);
//    return dict;
//
//}
//
//static CGFloat ascentCallback(void *ref){
//    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
//}
//
//static CGFloat descentCallback(void *ref){
//    return 0;
//}
//
//static CGFloat widthCallback(void* ref){
//    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
//}
//
//+ (NSMutableAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig *)config
//{
//    CTRunDelegateCallbacks callbacks;
//    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
//    callbacks.version = kCTRunDelegateVersion1;
//    callbacks.getAscent = ascentCallback;
//    callbacks.getDescent = descentCallback;
//    callbacks.getWidth = widthCallback;
//    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));
//
//    UniChar objectReplace = 0xFFFC;
//    NSString *content = [NSString stringWithCharacters:&objectReplace length:1];
//    NSDictionary *attributes = [self attributesWithConfig:config];
//    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
//    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attributeStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
//
//    CFRelease(delegate);
//
//    return attributeStr;
//}
//




//4带文字链接
// 方法一
+ (CoreTextData *)parseTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config {
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *linkArray = [NSMutableArray array];
    NSAttributedString *content = [self loadTemplateFile:dict config:config imageArray:imageArray linkArray:linkArray];
    CoreTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = imageArray;
    data.linkArray = linkArray;
    return data;
}

// 方法二
+ (NSAttributedString *)loadTemplateFile:(NSArray *)dict config:(CTFrameParserConfig*)config imageArray:(NSMutableArray *)imageArray linkArray:(NSMutableArray *)linkArray{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    NSArray *array = [NSArray arrayWithArray:dict];
    if ([array isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in array) {
            NSString *type = dict[@"type"];
            if ([type isEqualToString:@"txt"]) {
                NSAttributedString *as =
                [self parseAttributedContentFromNSDictionary:dict
                                                      config:config];
                [result appendAttributedString:as];
            }else if ([type isEqualToString:@"img"]){
                CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
                imageData.name = dict[@"name"];
                imageData.position = [result length];
                [imageArray addObject:imageData];
                NSAttributedString *as =[self parseImageDataFromNSDictionary:dict config:config];
                [result appendAttributedString:as];
            }else if([type isEqualToString:@"link"]){
                NSUInteger startPoint = result.length;
                NSAttributedString *as = [self parseAttributedContentFromNSDictionary:dict config:config];
                [result appendAttributedString:as];
                
                NSUInteger length = result.length - startPoint;
                NSRange linkRange = NSMakeRange(startPoint, length);
                CoreTextLinkData *linkData = [[CoreTextLinkData alloc] init];
                linkData.title = dict[@"content"];
                linkData.url = dict[@"url"];
                linkData.range = linkRange;
                [linkArray addObject:linkData];
            }
        }
    }
    return result;
}

// 方法三
+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict
                                                        config:(CTFrameParserConfig*)config {
    NSMutableDictionary *attributes = [self attributesWithConfig:config];
    // set color
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    // set font size
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}

// 方法四
+ (UIColor *)colorFromTemplate:(NSString *)name {
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([name isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else {
        return nil;
    }
}

// 方法五
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config {
    // 创建 CTFramesetterRef 实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    // 获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    // 生成 CTFrameRef 实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    // 将生成好的 CTFrameRef 实例和计算好的缓制高度保存到 CoreTextData 实例中，最后返回 CoreTextData 实例
    CoreTextData *data = [[CoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    // 释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}

// 方法六
+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(CTFrameParserConfig *)config
                                  height:(CGFloat)height {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}


+ (NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config
{
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor * textColor = config.textColor;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
    
}

static CGFloat ascentCallback(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void* ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

+ (NSMutableAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig *)config
{
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));
    
    UniChar objectReplace = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplace length:1];
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attributeStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    
    CFRelease(delegate);
    
    return attributeStr;
}

@end


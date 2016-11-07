//
//  ViewController.m
//  PacketCT
//
//  Created by zhangchu on 16/7/11.
//  Copyright © 2016年 zhangchu. All rights reserved.
//

#import "ViewController.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import "CTDisplayView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CTDisplayView *ctView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ctViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (strong, nonatomic) CoreTextData *ctData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.viewWidth.constant;
    
    NSArray *dict = @[
                      @{ @"color" :@"blue",
                         @"content" : @" 更进一步地，实际工作中，我们更希望通过一个排版文件，来设置需要排字的 ",
                         @"size" : @16,
                         @"type" : @"txt"
                         },
                      @{ @"width" :@"50",
                         @"height" : @"50",
                         @"name" : @"picture12",
                         @"type" : @"img"
                         },
                      @{ @"color" : @"red",
                         @"content" : @" 内容、颜色、字体 ",
                         @"size" : @22,
                         @"type" : @"txt"
                         },
                      @{ @"color" :@"blue",
                         @"content" : @"我是链接蚊子啊",
                         @"url" : @"http://blog.devtang.com",
                         @"type" : @"link"
                         },
                      @{ @"color" : @"black",
                         @"content" : @" 大小等信息。\n",
                         @"size" : @16,
                         @"type" : @"txt"
                         },
                      @{ @"width" :@"20",
                         @"height" : @"108",
                         @"name" : @"picture1",
                         @"type" : @"img"
                         },
                      @{ @"color" : @"default",
                         @"content" : @" 我在开发猿题库应用时，自己定义了一个基于 UBB 的排版模版，但是实现该排版文件的解析器要花费大量的篇幅，考虑到这并不是本章的重点，所以我们以一个较简单的排版文件来讲解其思想。",
                         @"type" : @"txt"
                         },
                      @{ @"color" :@"blue",
                         @"content" : @"我是链接蚊子啊aada",
                         @"url" : @"http://blog.devtang.com",
                         @"size" : @33,
                         @"type" : @"link"
                         }
                      ];
    
    self.ctData = [[CoreTextData alloc] init];
    self.ctData = [CTFrameParser parseTemplateFile:dict config:config];
    self.ctView.data = self.ctData;
    self.ctViewHeight.constant = self.ctData.height;
    self.ctView.userInteractionEnabled = YES;
    self.ctView.backgroundColor = [UIColor yellowColor];
    
    
    //    CoreTextData *data = [CTFrameParser parseContent:@"的说法是减肥了卡萨减肥开始了减肥了卡上就发了卡死机法拉盛减肥了开始减肥了深刻的纠纷的蓝色空间发来撒可减肥垃圾分类" config:config];
    //    self.ctView.data = data;
    //    self.ctViewHeight.constant = data.height;
    //    self.ctView.backgroundColor = [UIColor yellowColor];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MEDragerViewController.m
//  抽屉效果
//
//  Created by maybo on 16/8/2.
//  Copyright © 2016年 maybo. All rights reserved.
//

#import "ViewController.h"

#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height



@interface ViewController ()

@property (nonatomic, weak) UIView *mainV;
@property (nonatomic, weak) UIView *leftV;
@property (nonatomic, weak) UIView *rightV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //搭建界面
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 43, 43)];
    [btn setTitle:@"ccc" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
    [self setUp];
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
    
}
-(void)click{
    NSLog(@"cccccc");
}
#define targetR 257
#define targetL -275
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //获取偏移量
    CGPoint transP = [pan translationInView:self.mainV];
    //self.mainV.transform = CGAffineTransformTranslate(self.mainV.transform, transP.x, transP.y);
    //    CGRect frame = self.mainV.frame;
    //    frame.origin.x += transP.x;
    //    self.mainV.frame = frame;
    self.mainV.frame = [self frameWithOffset:transP.x];
    
    //判断拖动方向
    if (self.mainV.frame.origin.x > 0) {
        //显示右侧
        self.rightV.hidden = YES;
    }else if (self.mainV.frame.origin.x < 0) {
        //显示左侧
        self.rightV.hidden = NO;
    }
    
    CGFloat target = 0;
    //判断手势的状态
    if (pan.state == UIGestureRecognizerStateEnded) {
        //当手指松开时,自动定位
        //1.如果x值大于屏幕宽度一半时,定位到右侧
        if (self.mainV.frame.origin.x > screenW * 0.5) {
            //定位到右侧
            target = targetR;
        }else if (CGRectGetMaxX(self.mainV.frame) < screenW * 0.5) {
            //2.如果最大x值小于屏幕宽度一半时,定位到左侧
            //定位到左侧
            target = targetL;
        }
        
        //自动定位.
        //求偏移量
        CGFloat offset = target - self.mainV.frame.origin.x;
        NSLog(@"offset====%f",offset);
        [UIView animateWithDuration:0.5 animations:^{
            self.mainV.frame = [self frameWithOffset:offset];
        }];
        
    }
    //复位
    [pan setTranslation:CGPointZero inView:self.mainV];
    
}

#define maxY 100
//给定一个偏移量,求MainV的它Frame
- (CGRect)frameWithOffset:(CGFloat)offset {
    
    
    CGRect frame = self.mainV.frame;
    NSLog(@"frame.origin.x=%f",frame.origin.x);
    //计算x值
    frame.origin.x += offset;
    //计算Y值
    //fabs(<#double#>)对给定的能数取绝对值.
    frame.origin.y = fabs(frame.origin.x * maxY / screenW);
    //计算高度(屏幕的高度 - 2 * Y)
    frame.size.height = screenH - (2 * frame.origin.y);
    
    
    return frame;
}

//搭建界面
- (void)setUp {
    //leftV
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor blueColor];
    self.leftV = leftV;
    [self.view addSubview:leftV];
    //rightV
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor greenColor];
    self.rightV = rightV;
    [self.view addSubview:rightV];
    
    //mainV
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [UIColor redColor];
    
    self.mainV = mainV;
    [self.view addSubview:mainV];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

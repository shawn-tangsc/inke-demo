//
//  TSCMainViewController.m
//  Test-inke
//
//  Created by 唐嗣成 on 2017/10/22.
//  Copyright © 2017年 shawnTang. All rights reserved.
//

#import "TSCMainViewController.h"
#import "TSCMainTopView.h"

@interface TSCMainViewController ()<UIScrollViewDelegate>


/*
 有了ARC之后，新的property modifier也被引入到objective-c类饿property
 @Property是声明属性的语法，它可以快速方便的为实例变量创建存取器，并允许我们通过点语法使用存取器。就是为变量创建getter和setter方法
 @property还有一些关键字，它们都是有特殊作用的，比如上述代码中的nonatomic，strong：
 
 @property(nonatomic,strong) NSString *carName;
 @property(nonatomic,strong) NSString *carType;
 
 我把它们分为三类，分别是：原子性，存取器控制，内存管理。
 
@property中的属性详解https://www.jianshu.com/p/48313b257701
 
总结：
 NSString类block用copy，控件类用weak，复杂数据类的用strong，数字类，比如INUIgter，NSinter，CGRect这些用ASSAGIN
 
1.atomic 于 nonatomic ：异步控制---------------------------》原子性
  atomic ：默认是有该属性的，这个属性是为了保证程序在多线程情况，编译器回自动生成一些互斥锁加锁代码，避免该变量的读写不同步
  nonatomic: 如果该对象无需考虑多线程的情况，就加上这个属性，代码不会被锁，可以提高效率。

2.readwrite与reaadonly：真正价值不是提供成员变量访问接口，而是控制成员变量的访问权限------------------------------->存取器控制
 readwrite：这个属性是默认的情况，会自动为你生成存取器。
 readonly：只生成getter不会生成setter方法。
 
3.strong与weak： strong 和retain功能相似，weak与assign相似，只是当对象消失后weak会自动把指针变成nil，这个是xcode中的新标记； --------------》内存管理
 strong:强引用，也是我们通常说的引用，其存亡直接决定了所有指向对象的存亡。如果不存在指向一个对象的引用，并且此对象不再显示在列表中，则此对象会被从内存中释放。
 weak: 弱引用，不决定对象的存亡。即使一个对象被持有无数个弱引用。只要没有强饮用指向他，那么还是会被清除。
 
使用：
 何时使用的问题，如果一个对象在某段时间中反复加载，而你又不希望每次加载都要重新alloc 的话，那就strong，strong 保证对此对象保持一个强引用，对于这个对象，只要有1个strong引用的话，那它就不会释放，当然多个strong同时作用于它也不会释放。
 
 如果一个对象在某段时间只会加载一次，并且加载之后确定不再使用了，那就可以使用weak,这样当其他原因导致引用计数减1（比如 removefromsuperview）的时候，此对象就自动释放了。无需再在delloc 里面再release一次，但你要保证释放之后确实不再使用此对象，否则将导致错误
 
4.assign、copy、retain
 assign:默认类型，setter方法直接赋值，不进行任何retain操作，不改变引用计数。一般用来处理基本数据类型，因为是多个对象引用同一个内存，所以如果是其他类型，会出现某一个释放掉后把内存释放掉了，这样另一个对象再引用的时候会出现crash。
 retain：虽然本质上和assign是一样的，多个对象引用同一块内存，但是比assign多加了一个引用计数器，当一次赋值后，引用计数会+1，释放旧的对象（release），引用计数会-1，当引用计数为0时，内存销毁。这个是指针的复制赋值，copy是内容的复制和赋值。
 copy:是当你不希望多个对象引用同一块内存的时候会用到，他会new一个新对象，与retain处理流程一样，先对旧值release，再copy出新的对象，retainCount为1.为了减少对上下文的依赖而引入的机制。我理解为内容的拷贝，向内存申请一块空间，把原来的对象内容赋给他，令其引用计数为1.对copy属性要特别注意：被定义有copy的属性的对象必须要符合NSCopying协议，必须实现-(id)copyWithZone:(NSZone *)zone 方法。

 
 使用：
 使用assign: 对基础数据类型 （NSInteger，CGFloat）和C数据类型（int, float, double, char, 等等）
 使用copy： 对NSString
 使用retain： 对其他NSObject和其子类
 
5.getter 与setter
 getter：是用来指定get方法的方法名
 setter：是用来指定set访求的方法名
 
 在@property的属性中，如果这个属性是一个BOOL值，通常我们可以用getter来定义一个自己喜欢的名字，例如
 
 @property (nonatomic, assign,getter=isValue) boolean value;
 
 @property (nonatomic, assign,setter=setIsValue) boolean value;
 
 */
@property (nonatomic , strong) NSArray * datalist;

/*
    看来上面的说法，看来我们得深刻的了解一下内存
    https://www.jianshu.com/p/1928b54e1253
    oc中的内存管理中，其实就是引用计数(reference count)的管理！！！！
    内存管理就是在程序需要时程序员分配一段内存空间(引用计数=1)，而当使用完(引用计数=0)之后将它释放。
 
     Objective-C对象的动作             Objective-C对象的方法
     1. 创建一个对象并获取它的所有权      alloc/new/copy/mutableCopy (RC = 1)
     2. 获取对象的所有权                retain (RC + 1)
     3. 放弃对象的所有权                release (RC - 1)
     4. 释放对象                      dealloc (RC = 0 ，此时会调用该方法)
 
    ***Autorelease Pool**
 
    在开发中，我们常常都会使用到局部变量，局部变量一个特点就是当它超过作用域时，就会自动释放。而autorelease pool跟局部变量类似，当执行代码超过autorelease pool块时，所有放在autorelease pool的对象都会自动调用release。
    由于放在autorelease pool的对象并不会马上释放，如果有大量图片数据放在这里的话，将会导致内存不足.
 
    ***ARC管理方法***
    iOS/OS X内存管理方法有两种：手动引用计数(Manual Reference Counting)和自动引用计数(Automatic Reference Counting)。
    从OS X Lion和iOS 5开始，不再需要程序员手动调用retain和release方法来管理Objective-C对象的内存，而是引入一种新的内存管理机制Automatic Reference Counting(ARC)。
    简单来说，它让编译器来代替程序员来自动加入retain和release方法来持有和放弃对象的所有权。
 
     在ARC内存管理机制中，id和其他对象类型变量必须是以下四个ownership qualifiers其中一个来修饰：
 
     __strong(默认，如果不指定其他，编译器就默认加入)
     __weak
     __unsafe_unretained
     __autoreleasing
     所以在管理Objective-C对象内存的时候，你必须选择其中一个，下面会用一些列子来逐个解释它们的含义以及如何选择它们。

 */
@property (nonatomic, strong) TSCMainTopView* topView;




/**
 为什么一般来说从xib中拖出来的控件是weak而不是strong的？https://www.zhihu.com/question/29927614?sort=created
 其实我们可以看到，就算不拖下面的控件直接执行的时候，这个UIScrollView 也已经在view hierarchy上了，这个时候指向的已经都是strong了。所以IBOutlet修饰的就不需要用strong了。
 当然，也没有完全不建议用strong。当那些本来不在你的view hierarchy里(例如，你的view在nib里不是一个subview)，或者你想那个view离开了view hierarchy后仍可以不被销毁的话，应该用strong。
 */
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@end

@implementation TSCMainViewController

#pragma mark ---lazy
-(TSCMainTopView *)topView {
    if(!_topView){
        
        //加载广告视图
        _topView = [[TSCMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.datalist];
        
        
        
        /*
         block定义 返回值(如果是void可省略)^(单数列表..){具体代码}
         block可以访问外部变量，但是仅仅限于读，不可以直接写。如果需要直接对变量进行改变，则需要在变量前面加上__block关键字修饰，这样就可以在block中修改这些变量。
         block在ios开发中被视作对象，因此其生命周期会一直等到持有者的生命周期结束了才会结束，另一方面，由于block捕获变量的机制，使得block的对象也可以被block持有，从而形成循环引用，导致两者都不能被释放，这个时候可能导致内存泄露，两者都无法释放。和普通变量存在的__block一样，系统提供给我们__weak的关键字涌来修饰对象变量。申明这是一个弱引用对象，从而解决了循环应用的问题。
            ps:typeof是一个一元运算，放在一个运算数之前，运算数可以是任意类型。
                可以理解为：我们根据typeof()括号里的变量，自动识别变量类型并返回该类型。
         
            __weak typeof(self) weakSelf = self;
         
            但是：
            上述写法可能会导致问题，因为weakSelf是弱引用，如果self被释放掉了，会导致weakSelf变成nil。
            这个时候还需要在block里面使用weakSelf的地方前针对__weak再做一次__strong
         
            __strong typeof(weakSelf) strongSelf = weakSelf;
         
         __block和__weak使用的时候的区别:
         __block会持有该对象，即使超出了该对象的作用域，该对象还是会存在的，直到block对象从堆上销毁；而__weak仅仅是将该对象赋值给weak对象，当该对象销毁时，weak对象将指向nil；
         __block可以让block修改局部变量，而__weak不能。
         另外，MRC中__block是不会引起retain；但在ARC中__block则会引起retain。所以ARC中应该使用__weak。
         
         @weakify 和@strongify:但是这种写法还是比较麻烦，所以YYKitMacro针对这个情况把它做成了一个宏，http://www.cocoachina.com/ios/20161025/17303.html
            1.@autoreleasepool{}
                注意到@weakify(self)前面的@颜色并不是橙色没有？@并不属于宏的一部分，当然你不能平白无故写个@对吧，所以RAC的weakify宏定义机智地给你补了一句autoreleasepool {} 这样一前一后就变成了啥事都没干的@autoreleasepool {}
            2.__attribute__((objc_ownership(weak)))
                这个就是__weak在编译前被编译器替换的结果，weakify这个宏后面最终替换成__weak，所以编译器再替换就成了__attribute__((objc_ownership(weak)))
         
         

         */
        //__weak typeof(self) weakSelf = self;
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            //__strong typeof(weakSelf) strongSelf = weakSelf;
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
        };
    }
    return _topView;
}

-(NSArray *)datalist{
    if(!_datalist){
        
        _datalist = @[@"关注",@"热门",@"附近"];
    }
    return _datalist;
}

#pragma mark ----initial
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}
#pragma mark ----private function
- (void) initUI {
    //添加左右按钮
    [self setupNav];
    //添加子视图控制器
    [self setupChildViewControllers];

}

- (void) setupNav {

    self.navigationItem.titleView = self.topView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void) setupChildViewControllers {
    NSArray * vcNames = @[@"TSCFocusViewController",@"TSCHotViewControllerNew",@"TSCNearViewController"];
    for (NSInteger i = 0; i<vcNames.count; i++) {
        NSString * vcName = vcNames[i];
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.datalist[i];
        //在执行这句话的时候是不会执行改vc的viewdidload的
        [self addChildViewController:vc];
    }
    //将子控制器的view加到mainVC的scrollview上
    //设置scrollview的contentsize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.datalist.count, 0);
    //默认先展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //进入主控制器加载第一个页面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

//动画结束调用代理
//这里非常的麻烦，要抽时间搞懂！！
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    //索引值联动topView
    [self.topView scrolling:idx];
    //根据索引值返回视图引用
    UIViewController * vc = self.childViewControllers[idx];
    //可以用isViewLoaded方法判断一个UIViewController的view是否已经被加载
    if([vc isViewLoaded]){
        return;
    }
    //设置子控制器的view大小
    //在这里有个初始化的时候自动约束的问题，在刚刚初始化的时候，他会去默认匹配设置375作为自己的宽度，并且会加上一个差值来匹配各个不同的屏幕，这个时候设置vc.view.frame他以为自己还是375，适配plus的时候，他会加上39补足到414，但是这个时候你传值给她414,他还是会加上这个值，从而变成了453，所以在屏幕自适应的时候一定要考虑ios的初始化frame的因素
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    //将子控制器的view加入scrollview上
    [scrollView addSubview:vc.view];
}


//减速结束时调用加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}      // called when scroll view grinds to a halt

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

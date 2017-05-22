#MQLMessageUI

项目介绍：使用Masonry结合UITableView-FDTemplateLayoutCell,纯代码实现聊天文字消息界面的展示; ------ 使用了label的Content Hugging属性来控制消息label与消息背景气泡的位置; ----使用自动布局时相关控件的intrinsicContentSize属性是很有用的;

/**
     Hugging priority 确定view有多大的优先级阻止自己变大。
     
     Compression Resistance priority确定有多大的优先级阻止自己变小。
     
     可以注释下面两行代码来理解:
     ---注释后,消息长度(不满一行, 重点)时,展示消息的label会变长来适应背景图片;
     ---取消注释, 把lable的HuggingPriority设置的比背景视图的大,相当于label阻止自己变大的能力大于背景视图,此时背景视图会变短来适应label
     */
    //detailLabel的HuggingPriority要设置为最高的优先级, 不然cell重用的时候有问题
    [_detailLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_bubbleView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];


#sychronized
//MARK: ===== 使用异步并行线程, 会造成多个线程同时访问dataArray对象, 使用@synchronized加锁,保证线程安全
            
            /*
             调用 sychronized 的每个对象，Objective-C runtime 都会为其分配一个递归锁并存储在哈希表中。
             */
            @synchronized (self) {
                [self.dataArray addObject:model];
                NSLog(@"%@", @"===========");
            }

# ListDemo
基于UICollectionView的封装


简述
基于UICollectionView的列表的实现，看似复杂，但分解之后就是如下的四个部分的文件，而且为了方便重用，做了更为细化的分解。

1. 配置文件
Layout

主要实现list中cell，footer、header、section的布局。即自定义的layout（系统提供flowlayout亦可使用）

增删cell时的动画设置

DataSource

数据源，list展示的数据在此文件中保存（以数组的形式）
实现UICollectionViewDataSource协议,将必须的数据源方法通过block的形式返回，便于在引用处设置
实现插入、删除、reload等方法。引用处只需简单调用即可
Delegate

事件源：将点击、display、size返回等事件以block回调至引用处，方便配置
实现LayoutDelegate协议方法，提供Layout必要的布局数据
LayoutDelegate

通常放在Layout文件中，该协议继承自UICollectionViewDelegate协议
提供Layout必须的或者非必须的资源，如用来获取cell宽高、footer和header的size属性等
2. 界面相关
cellProtocol：

自定义cell时必须实现该协议中的方法
提供cell的数据更新、size（高度或者宽度）计算、cell的点击事件（根据mvvm架构，此处不应该有此功能，但未找到更合适的方案）
若cell中有一些单例的方法，如cell中点击头像，可以具体问题具体分析（可在该cell中添加点击头像方法，不必在协议中添加）
具体方法：- (void)alpCellDidSelected:(id)model target:(id)target indexPath:(NSIndexPath *)indexPath
优化：- (void)alpCellDidSelected:(id)model target:(id)target indexPath:(NSIndexPath *)indexPath info:(id)info
此处添加一个泛型info，可以实现一些特殊信息的传递。未验证可行性
reuseViewProtocol

自定义reuseView时需要实现该协议方法，具体方案同cell
modelProtocol

model文件必须实现该协议。
目前该协议中只有两个宏：```typedef uint64_t (^fetchFirstData)(id objData,ALPHttpError *error,BOOL hasMore);
```typedef void (^fetchNextData)(id objData,ALPHttpError *error,BOOL hasMore);
3. 数据获取
collectionView category：创建一个扩展，该扩展中实现上拉、下拉刷新的控件和事件
创建具体model的扩展，实现数据网络请求
4. 特殊情况
关于header或者footer执行时，在DataSource中不调用数据源委托方法，猜测是apple的bug。解决方案是创建DataSource的扩展，在扩展中复写该方法即可实现调用。
具体结构如下图：

List配置文件.png
使用方法：
参见示例：

github链接

截图：


1.png

2.png
由上述使用的方式可以看到代码量还是存在的，只不过之前委托代理的形式现在替换成了block的方式。

优点是多个列表的情况只需要复制一份，简单的修改cell和model即可；
缺点是时刻要注意block的循环引用问题。

若是在多section的情况下，则需要在block中添加对应的section选项即可，作为标识。并且目前如获取cell的数据源方法我都做成了在引用处返回的形式，这样同时也实现了一个列表支持不同类型cell的功能。

总结：这种方式的封装，其实和调用委托方法节省不了多少代码量，但是在重用性上还是便利很多。所以找到它们的平衡点很重要。

不足之处，还望给予指正，谢谢
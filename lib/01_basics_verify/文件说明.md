### StatelessWidget、StatefulWidget 、State的差异

`StatelessWidget`派生类是很简单直接的，它在`build`方法中通过已有组件来完成构建逻辑，返回widget对象，界面需要什么，就在构造函数中传入什么，相当于于一个胶水，把其他组件黏在一起，作为一个新的组件个体。

`StatefulWidget`和`StatefulWidget`功能类似，只不过`StatefulWidget`自己不承担build组件的责任，将构建任务委托给State的派生类，它会通过`createState`方法创建`State`对象。

`State`派生类中可以维护状态数据的边和重新触发自己的build构建方法，实现界面的更新，State对象有生命周期回调方法，可以通过复写方法进行感知。

##### 需要特别注意的是：

不要将StatefulWidget和State混为一谈，两者是不同的两个类型，可以感知生命周期，维护状态数据变化的是State。StatefulWidget的任务是承载配置信息，和创建Sate对象。


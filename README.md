# TemplateSwiftAPP

### 功能清单

1. API：把每个接口都包装成一个独立的API，完成数据请求的整个交互逻辑。支持同步、异步数据请求，配置端口、路径、参数、请求方式(GET/POST/PUT...等)、数据解析、回调、暂停和取消等操作。`目录：Base module/API/`
2. 模型：存储应用程式数据。支持JSON和Model的相互转换、深复制、自动化编码和解码。`目录：Base module/Model/`
3. 视图：显示模型数据，监听用户交互，需要更新时发送给控制器对象。通过模板方法设计，实现通用的功能，并提供一些子类可扩展的接口。`目录：Base module/Common/View/`
4. 控制器：管理视图和模型的交互逻辑，视图的初始化和释放。支持导航栏标题和图标设置、自定义导航栏、左右标题事件、HUD功能、空页面提示和交互功能、html5页面访问功能、表视图控制器功能、自定义约束、下拉刷新和上拉加载交互功能、表单和分组表视图控制器功能、仿新闻多视图切换控制器功能、导航多视图切换控制器功能。`目录：Base module/Common/VC/`
5. 组件：把很多通用的交互界面定义好完整的接口，使用接口来访问这些功能。比如：登录和注册表单交互、空页面交互、下拉列表交互、多视图标题切换交互、HUD交互...等。`目录：Base module/Kit/`
6. 工具类：基于外观模式为子系统中的各类（或结构与方法）提供一个简明一致的界面，隐藏子系统的复杂性，使子系统更加容易使用。它是为子系统中的一组接口所提供的一个一致的界面。例如：访问文件系统、数据库文件、APP本地和远程配置、网络状态配置、日期管理、谓词...等。`目录：Business module/Service/`
7. 宏定义：定义APP字体和颜色、设备型号、第三方Key...等。`目录：Base module/Macro/`
8. 第三方SDK：推送、分享、统计分析、地图...等功能的访问


> 接口相关

- [x] 登录
- [ ] 注册
- [x] 用户信息
- [x] 上传用户头像

- [x] 主题列表
- [x] 主题详情
- [x] 评论列表
- [x] 喜欢
- [x] 收藏
- [x] 添加评论
- [x] 我发布的主题列表
- [x] 发布主题

- [ ] 主题标签和标签主题

- [ ] 分类列表

- [ ] 管理用户
- [ ] 管理主题
- [ ] 管理评论

### 库使用

```
pod 'Alamofire'          # 网络请求 https://github.com/Alamofire/Alamofire，同 AFNetworking
pod 'SnapKit'            # 布局框架 https://github.com/SnapKit/SnapKit，同 Masonry
    
pod 'Kingfisher'         # 缓存图片 https://github.com/onevcat/Kingfisher，同 SDWebImage
pod 'RxSwift'            # 响应式编程框架 https://github.com/ReactiveX/RxSwift
pod 'SVProgressHUD'      # 提示功能 https://github.com/SVProgressHUD/SVProgressHUD
pod 'MJRefresh'          # 上拉和下拉刷新框架 https://github.com/CoderMJLee/MJRefresh
    
pod 'SQLite.swift'       # SQLite https://github.com/stephencelis/SQLite.swift.git
pod 'IQKeyboardManagerSwift'  # 键盘交互 https://github.com/hackiftekhar/IQKeyboardManager
    
pod 'MarkdownView'       # Markdown 渲染 https://github.com/keitaoouchi/MarkdownView.git
    
pod 'TAssetPicker'       # 资源选择 https://github.com/turkeyaa/TAssetPicker
    
pod 'PageController'     # 多视图切换 https://github.com/hirohisa/PageController.git

```

### 目录结构

![目录结构](Resource/structure.png)

### 实战

##### 这边文章基于Swift语言，基于框架的方式来快速的构建自己的APP，从组件化、模型、界面、控制器封装、接口封装，到设计模式的使用，同时会集成一些常用的第三方库和SDK。同时尽量把各个功能都封装在一个独立的模块中，降低代码重复量，简单并且唯一，通过接口的方式去访问。同时可以更容易添加单元测试。

##### 这个项目中会实现很多APP开发所需要的通用的功能和组件，同时让你很容易地扩展自己的组件、功能和特性，而不会对系统有影响。目的在于提供一套统一的解决方案，你可以专注于业务模块。欢迎指正。

#### 从零开始


`Xcode 9.2` `Swift 4.0`

[初始工程](Resource/TemplateSwiftAPP(初始).zip)，它包含了一个空项目，同时添加了CocoaPods管理，下载完成打开`TemplateSwiftAPP.xcworkspace`可直接编译。或者使用命令`pod update` 更新之后再打开

#### 1. 接口封装

![API](Resource/API.png)

我们的思想是基于REST Api方式，把每个接口都包装成独立的模块。每个**NSURLSession**的请求中，不同的只是参数、请求方式(GET/POST/PUT...)、接口路径、返回的数据。那我们是不是可以把不同的参数通过多态(重写父类的方法)来实现。而请求数据完成，通过block、代理或重写来处理不同的结果。这里的结果一般的是json数据，同时就可以把json转换成model传递给相应的控制器对象。你会发现我们的请求过程会特别的简单、方便。

> 如何实现?

1. 定义**RestApi**，一个抽象类。包含：初始化、执行、取消、结果处理、参数、日志统计...等方法。一些是子类必须要实现的方法(参数、结果处理)
2. 定义**BaseRestApi**，继承RestApi。定义错误码、解码类型、处理返回数据
3. 定义**BaseUploadApi**，继承**BaseRestApi**，上传图片基类，支持一张和多张图片上传
4. 定义**Login_Post**，继承**BaseRestApi**，定义初始化方法、请求参数、处理结果方法
5. 如果是上传图片相关，继承**BaseUploadApi**，定义初始化方法，和传递参数

##### 登录接口实现如下：

* 1. 定义初始化方法

```
init(account: String, password: String) {
        super.init(url: "auth/login", httpMethod: .HttpMethods_Post)
        decodeType = .DecodeJSONTypeString;   // 返回值为：token 字符串
        
        self.account = account
        self.password = password
    }
```

* 2. 传递参数

```
override func prepareRequestData() -> Dictionary<String, Any> {
        return [
            "account": account,
            "password": password
        ]
    }
```

* 3. 解析数据，接口返回的data数据

```
override func parseResponseJsonString(json: Data) -> Bool {
        
        let result = String.init(data: json, encoding: String.Encoding.utf8)
        if result != nil && result!.count > 0 {
            token = result!
            return true
        }
        
        return false
    }
```

> 客户端代码

```
let loginApi = Login_Post.init(account: account, password: password)
loginApi.call(async: true)
            
if loginApi.code == RestApiCode.RestApi_OK {
	self.user = loginApi.user!
	self.showSuccessMessage(hud: "登录成功")
	// TODO: 登录成功，逻辑处理
}
else {
	self.showErrorMessage(hud: "登录失败")
}

```

#### 2. 模型

Swift 4.0之后，苹果推出支持了json->model的转换。通过Codable可以直接将json转成对象

在类**JSONModel**中，实现协议：**NSCoding**，支持自动化编码和解码对象。一般的模型对象需要继承**JSONModel**类。

```
class Topic: JSONModel,Codable {
    
    var topicID: UUID?
    var userID: UUID = UUID.init()
    var categoryId: Int = 0
    var likeNum: Int = 0
    var isGood: Int = 0
    var viewNum: Int = 0
    var collectNum: Int = 0
    var replyNum: Int = 0
    var createTime: TimeInterval = 0
    var author: String = ""
    var title: String = ""
    var content: String = ""
    
    override init() {
        super.init()
    }
    
    override init(dict: [String : Any]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
    
    /// 如果我们需要用不同的名称, 只需要提供我们自己的 CodingKey
    enum CodingKeys: String,CodingKey {
        case topicID = "id"
        case categoryId
        case likeNum
        case isGood
        case viewNum
        case collectNum
        case replyNum
        case author
        case title
        case content
        case createTime
    }
}
```

> 客户端代码

```
override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode([Topic].self, from: json) {
            // 解析成功，赋值给:users对象
            self.dataSource = result
            return true;
        }
        
        return false
    }
```

#### 3. 视图

继承类：`UIView`

#### 4. 控制器



### 技术总结


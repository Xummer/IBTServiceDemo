# ServiceCenter
全局只需要一个单列 `IBTServiceCenter`, 其它都是 `IBTService<IBTService>` 的子类, 通过

```
IBTService *service = [[IBTServiceCenter defaultCenter] getService:[SERVICE_NAME class]]
```

或者用 宏定义 

## HOW TO USE

### 如何新建 Service
子类化 `IBTService` 并实现 protocal `<IBTService>`


### 如何获取单列

```
TestService *tMgr = IBTServiceWithName(TestService);
[tMgr doWhatUWant];
```

### PS
第一次获取时才真正创建, 和单列一样。


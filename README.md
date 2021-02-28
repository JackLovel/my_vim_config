## 版本
```
gvim 8.2.12
win10 
```

## 编辑文件
```
:e <file_path>
```

## 使配置生效
```
:source %  
或者 
:source $MYVIMRC 
```
## vim-go 配置

确保go语言运行环境已安装

- 配置代理国内源
```
$ go env -w GO111MODULE=on
$ go env -w GOPROXY=https://goproxy.cn,direct
```
- vim-go 安装依赖工具
```
:GoInstsallBinaries  
```
- 创建项目
```
$ go mod init main // 生成 go.mod 文件
```

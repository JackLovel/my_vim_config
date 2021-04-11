## 版本 
[新的仓库（国内）](https://gitee.com/wcc210/vim_config) github 上传好慢
```
gvim 8.2.12
win10 
```

## 目录
```
:echo &rtp // 查看vimrc 以及 插件存放的路径 

比如：
C:\Users\gog\vimfiles\autoload (存放plug.vim) // 存放 vim-plug 的路径
C:\Users\gog\vimfiles\plugin // 存放所有的插件的路径
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

## python 
安装运行环境 `python3.9` 

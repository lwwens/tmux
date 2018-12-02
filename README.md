> 参考连接
> 1. [Tmux使用手册](http://louiszhai.github.io/2017/09/30/tmux/)
> 2. [Tmux (简体中文)——Archlinux手册](https://wiki.archlinux.org/index.php/Tmux_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
> 3. [《tmux: Productive Mouse-Free Development》中文翻译](https://www.kancloud.cn/kancloud/tmux/62459)
> 4. [WIKI——Category:色彩系](https://zh.wikipedia.org/wiki/Category:%E8%89%B2%E5%BD%A9%E7%B3%BB)
> 5. [特殊符号 UNICODE编码](https://blog.csdn.net/AQ931752921/article/details/84679978)
> 6. [color颜色十六进制编码大全](https://blog.csdn.net/u014450015/article/details/50220869)
## 会话
#### 1.新建会话
	tmux new -s session_name -n window_name    # -n指定初始化窗口名

#### 2.挂起当前会话
	tmux detach-client
	tmux detach
        
#### 3.进入之前的会话
	tmux attach    # 默认进入第一个会话
	tmux attach -t sessionname    # 选项-t指定进入sessionname会话中最后挂起的那个窗口及面板
	tmux a -t sessionname:3.2    # 选项-t指定进入sessionname会话中的第3个窗口第2个面板

#### 4.关闭会话
	tmux kill-session -t sessionname    # 关闭指定会话
	tmux kill-server    # 关闭tmux服务即所有会话

#### 5.查看会话
	tmux list-session
	tmux ls
	prefix s    # 打开tmux会话列表选择切换

-----
## 快捷指令
*以下指令都是本人的配置。*
#### 1.系统指令
|  指令  | 描述                     |
|:------:|:-------------------------|
|    ?   | 显示快捷键帮助文档       |
|    d   | 断开当前会话             |
|    D   | 选择要断开的会话         |
|    r   | 重新加载tmux配置文件     |
|    s   | 显示会话列表用于切换     |
|    :   | 进入命令行模式           |
|    [   | 进入复制模式，按q退出    |
|    ]   | 粘贴复制模式中复制的文本 |

#### 2.窗口指令
| 指令 | 描述                       |
|:----:|:---------------------------|
|   c  | 新建窗口                   |
|   b  | 关闭当前窗口               |
|  0~9 | 切换到指定窗口             |
|   w  | 打开窗口列表，用于切换窗口 |
|   ,  | 重命名当前窗口             |
|   .  | 修改当前窗口编号，重新排序 |
|   f  | 输入关键字快速定位窗口     |
|   g  | 根据窗口索引快速定位窗口   |

#### 3.面板指令
|    指令    | 描述                                           |
|:----------:|:-----------------------------------------------|
|      v     | 下侧新建面板                                   |
|      ;     | 右侧新建面板                                   |
|      x     | 关闭当前面板                                   |
|      z     | 最大化当前面板                                 |
|   n  | 将当前面板移动到新的窗口打开（原窗口中存在两个及以上面板有效）|
|      q     | 显示面板编号，输入对应的数字可切换到相应的面板 |
|      {     | 向前置换当前面板                               |
|      }     | 向后置换当前面板                               |
|   ctrl+o   | 顺时针旋转当前窗口中的所有面板                 |
|      o     | 选择下一面板                                   |
|    space   | 循环切换                                       |
| ctrl+hjkl | 以5个单元格为单位调整当前面板边缘              |
|      t     | 显示时钟                                       |

#### 4.其他快捷键
	# 绑定/键为在新的panel水平方向打开htop
	bind '/' splitw -h 'exec htop'
	# 绑定m键为在新的panel水平方向打开man
	bind m command-prompt -p man "splitw -h 'exec man %%'"
	# 绑定P键为开启日志功能，如下，面板的输出日志将存储到~/Log/tmux
	bind P pipe-pane -o "cat >> ~/Log/tmux/#W.log" \; display "Toggled logging to ~/Log/tmux/#W.log"
	# 绑定p键为在新的panel水平方向打开mocp
	bind 'p' splitw -v 'exec mocp'         

-----
## 编写自定义配置
#### 1.设置256色终端
	set -g default-terminal "tmux-256color"

#### 2.复制模式
	set-window-option -g mode-keys vi    # 复制模式开启vi风格 
	# tmux 2.4版本之前
	bind -t vi-copy 'v' begin-selection  # v进入复制选择
	bind -t vi-copy 'y' copy-selection   # v进入复制选择        
	# tmux 2.4版本之后
	bind-key -T copy-mode-vi 'v' send -X begin-selection
	bind-key -T copy-mode-vi 'y' send -X copy-selection
#### 3.状态栏
	#S: tmux客户端名称
	#I: tmux窗口序号
	#W: tmux窗口名称
	#P: tmux面板序号
	# 设置状态栏刷新时间间隔
	set -g status-interval 3
	# 设置背景透明
	set -g status-bg default
	set -g message-style "fg=yellow"                   # 黄色
	# 状态左栏（[session名]窗口序号:窗口名.面板号）
	set -g status-left-length 20
	set -g status-left '#[fg=#32CD32][#S]#[fg=yellow]#I:#W.#[fg=#00DCDC]#P'
	# 状态右栏（mocp的状态 月/日 星期几 时:分）
	set -g status-right-length 60
	set -g status-right '#[fg=#8787ff]#(bash /etc/tmux-mocp.sh)#[fg=white] %m/%d %A %H:%M‘        

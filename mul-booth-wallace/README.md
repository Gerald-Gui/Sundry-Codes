# MUL-BOOTH-WALLACE

由verilog编写，基于Booth两位乘与华莱士树的32位补码乘法器。

```
mul-booth-wallace
    ├── README.md           // this file
    ├── src                 // 乘法器源码实现
    │   ├── boothgen.v      // booth两位乘部分积生成模块
    │   ├── csa3to2.v       // 全加器，命名来自Carry-Save Adder
    │   ├── mul_top.v       // 乘法器顶层模块
    │   └── wallace.v       // 16个数相加华莱士树
    └── testbench
        └── mul_tb.v        // 简单的激励测试文件，比对仿真结果中res与ref_res
```

代码里有些部分可以组织得更好，但懒得改了~~，又不是不能用~~。

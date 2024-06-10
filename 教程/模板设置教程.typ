#import "@local/math-314:0.3.0": *

#show heading.where(): it => {
  set text(fill: rgb(60, 113, 183))
  // 目录title 为 heading 且 numbering 为 none
  if it.numbering == none {
    it
  } else if it.level == 1 {
    align(center)[#it]
  } else if it.level == 2 {
    let it-numbering = numbering(it.numbering, ..counter(heading).at(it.location()))
    table(
      columns: 1,
      stroke: none,
      table.cell(
        stroke: (bottom: 1pt + rgb(60, 113, 183)),
        text(size: 1.2em)[#math.section] + it-numbering,
      ),
      h(1em) + it.body + h(2em),
    )
  } else {
    it
  }
}

#show: doc => conf-2(
  doc,
  cover-fun: {
    set page(header: none, margin: auto)
    image("../image/cover.jpg", width: 100%)
    align(center, text(20pt)[*math-314模板文档*])
    counter(page).update(0)
  },
)

// 本文档设置
#let fake-par = {
  v(-1.3em)
  box()
  parbreak()
}
#set raw(lang: "typst")
#import "@preview/codly:0.2.0": *
#show: codly-init.with()
#codly(languages: (
  typst: (name: "typst", icon: none, color: rgb("#CE412B")),
))
#show raw.where(): it => it + fake-par

= 使用方法
把文件放到 typst 定义的 \@local 路径下
```
#import "@local/math-314:0.3.0": *
```
或放到 \@preview 路径下
```
#import "@preview/math-314:0.3.0": *
```
然后加入以下即可使用
```
#show: doc => conf-2(
  doc,
)
```
或使用 conf-1
```
#import "@local/math-314:0.3.0": *
#show: doc => conf-1(
  doc,
)
```
#text(fill: green, weight: "bold")[conf-1] *与* #text(fill: green, weight: "bold")[conf-2] *的不同为*

#text(fill: green, weight: "bold")[conf-1 : ] *不区分奇偶页, 中间智能显示当前页面一级或二级标题, 且页面居中*

#text(fill: green, weight: "bold")[conf-2 : ] *奇数页显示一级标题，偶数页显示二级标题，奇数页面偏右。偶数页页满*

若要自定义细节, 请自行传入参数
```
#show: doc => conf-2(
  doc,
  cover-fun: my-cover-fun,
  math-font: "XITS Math",
  heading-numbering: my-heading-numbering,
  outline-fun: my-outline-fun,
  page-set: my-page-set,
  text-set: my-text-set,
  par-set: my-par-set,
  math-equation-i-figured-level: 1,
)
```
== 注意事项
=== #text(fill: red, weight: "bold")[注意事项1]
#text(fill: red, weight: "bold")[本模板有大量预设，但可能用户对某些设置有其他需求，故几乎所有参数都支持更改

  下面为详细的修改方式，可按需查询]

=== #text(fill: blue, weight: "bold")[注意事项2]
#text(fill: blue, weight: "bold")[因为更改了默认字体为思源宋体(Source Han Serif SC)

  更改了默认数学字体为 "XITS Math"

  若没有对应字体可能显示错误]

=== #text(fill: green, weight: "bold")[注意事项3]
*使用* #text(fill: green, weight: "bold")[conf-2] 时，

*除第一个一级标题外，在每个一级标题前*

*可使用* ```#page-to-odd()```

*或* ```#page-to-odd-blank()```

*来使一级标题换页到奇数页*

```#page-to-odd()``` *过度页带页眉*

```#page-to-odd-blank()``` *过渡页不带页眉*

#text(fill: red, weight: "bold")[不使用也可, 但本强迫症表示所有的一级标题不在奇数页上很难受]

*例*
```
= 第一章

#page-to-odd()
= 第二章
```

=== typst 命令行使用
若已安装 typst 命令行工具，可使用
```sh
typst init @local/math-314:0.3.0 my-project
```
来初始化一模板项目并命名为 my-project
// #pagebreak()
#page-to-odd()
= 默认参数
== 封面
封面可自定义

以下为默认封面
```
#let default-cover-fun = {
  set page(header: none)
  align(center + horizon, text(17pt)[封面])
  counter(page).update(0)
}
```

若不需要封面
可直接传入空
```
#show: doc => conf-2(
  doc,
  cover-fun: {},
)
```

自定义封面时,

若使用了默认页眉，因为页眉有默认值，请如默认值一样，在封面函数内加上 #text(fill:red)[set page(header: none)]

若使用了默认目录，因为目录启用了页面计数，请在末尾加上 #text(fill:red)[counter(page).update(0)]
来保证默认目录页面计数正常

如
```
#let my-cover-fun = {
  set page(header: none)
  [自定义封面]
  counter(page).update(0)
}
#show: doc => conf-2(
  doc,
  cover-fun: my-cover-fun,
)
```

== 标题格式
标题格式可自定义

以下为默认标题格式

```
// 默认标题格式
#let default-heading-numbering = {
  (..nums) => if nums.pos().len() < 2 [
    第#nums.pos().map(str).join(".")章
  ] else [
    #nums.pos().map(str).join(".")
  ]
}
```
== 标题样式
本模板未配置标题样式的默认设置
以下为一简单设置
````
#show heading.where(): it => {
  // 目录title 为 heading 且 numbering 为 none
  if it.numbering == none {
    it
  } else if it.level == 1 {
    align(center)[#it]
  } else if it.level == 2 {
    align(center)[#it]
  } else {
    grid(columns: 2, h(1.8em), it)
  }
}
````

以下为推荐设置也是本文档配置
```
#show heading.where(): it => {
  set text(fill: rgb(60, 113, 183))
  // 目录title 为 heading 且 numbering 为 none
  if it.numbering == none {
    it
  } else if it.level == 1 {
    align(center)[#it]
  } else if it.level == 2 {
    let it-numbering = numbering(it.numbering, ..counter(heading).at(it.location()))
    table(
      columns: 1,
      stroke: none,
      table.cell(
        stroke: (bottom: 1pt + rgb(60, 113, 183)),
        text(size: 1.2em)[#math.section] + it-numbering,
      ),
      h(1em) + it.body + h(2em),
    )
  } else {
    it
  }
}
```
== 目录
目录可自定义

以下为默认目录
```
#let default-outline-fun = {
  set page(
    margin: (right: 10%, left: 10%),
    numbering: "i",
    header: [],
  )
  set text(size: 13pt)
  outline(title: "目录", depth: 2, indent: 1em)
  page-to-odd-blank-first()
}
```

自定义目录时，若使用了默认页眉，默认页眉对奇偶进行了区分，
请如默认值一样，在目录函数最后加上
#text(fill: red)[page-to-odd-blank-first()]
来使正文第一页在奇数页

== 页面设置
以下为默认页面设置

以下为 conf-1
```
#let default-page-set = (
  margin: (right: 8.8%, left: 8.8%, top: 7%, bottom: 3%),
  header-ascent: 48%,
  header: header-fun(),
)
```
以下为 conf-2
```
#let default-page-set-2 = (
  margin: (inside: 11.4%, outside: 6.2%, top: 7%, bottom: 3%),
  header-ascent: 48%,
  header: header-fun-2(),
)
```
两个页眉函数

#text(fill:red)[header-fun()] ： 不区分奇偶页 中间智能显示当前页面一级或二级标题

#text(fill:red)[header-fun-2()] ：奇数页显示一级标题，偶数页显示二级标题

== 文本设置
以下为默认文本设置
```
#let default-text-set = (
  font: "Source Han Serif SC",
  lang: "zh",
  region: "cn",
)
```
== 段落设置
以下为默认段落设置
```
#let default-par-set = (
  leading: 0.55em,
  justify: true,
)
```
== 数学字体
默认为 #text(fill: blue)["XITS Math" ]，请自行修改
```
#import "@local/math-314:0.3.0": *
#show: doc => conf-2(
  doc,
  math-font: "自定义数学字体",
)
```
== 数学方程计数
默认使用 #text(fill: blue)[i-figured] 包对数学方程进行计数
$ a times b $
默认计数到一级标题
```
#show: doc => conf-2(
  doc,
  math-equation-i-figured-level: 1,
)
```
// #pagebreak()
#page-to-odd()
= 模板特色

#text(red)[说实话就是没法给你改的模板参数]
== 数学方程计数
默认开启数学方程计数，若不需要自行到 #text(green)[conf-1.typ] 和 #text(green)[conf-2.typ]

注释掉

```show math.equation: i-figured.show-equation.with(level: math-equation-i-figured-level)```

== 首行缩进
默认开启首行缩进，首行缩进 1.8em, 有需求可以检索所有的 1.8 改成想要的值

== 数学样式函数
自定义了一堆数学样式函数

使用```#import "@local/math-314:0.3.0": *```

已全部导入，以下写法仅为展示名字
```
#import "@local/math-314:0.3.0": dingli-1, dingli-2, dingli-3
#import "@local/math-314:0.3.0": dingyi-1, dingyi-2, dingyi-3
#import "@local/math-314:0.3.0": mingti-1, mingti-2, mingti-3
#import "@local/math-314:0.3.0": zhu-1, zhu-2, zhu-3
#import "@local/math-314:0.3.0": zm-1, zm-2, zm-3
#import "@local/math-314:0.3.0": tuilun-1, tuilun-2, tuilun-3
```
后缀为1的仅一段文本,后缀为2的为文本+淡色背景,后缀为3的为简约的框

定义为绿色, 定理、命题为蓝色, 注、证明为橙色

其中定义、定理、命题带有计数器
=== 简化输入
可以简化名字以方便输入
```
#let dy = dingyi-1
#let dl = dingli-1
#let zhu = zhu-2
#let tl = tuilun-1
...
```
=== 计数器参数
带有计数器的，可像如下可使用 (step: false ) 参数来停止步进

```#dingyi-1(step: false)[ 描述][$ a times b $] ```

=== 修改颜色
对颜色有需求的，可自行到修改 ``` math-314/0.3.0/util/math.typ ```
```
#let dingyi-1 = math-fun-1.with("定义", math-color: 你需要的颜色)
```

=== 增加样式
需要其他样式可自行增加
```
#let xinyanshi-1 = math-fun-1.with("新样式", math-color: 你需要的颜色)
```
带有计数器的，请添加到 counter-list 中
```
#let counter-list = ("定义", "定理", "命题","新样式")
```
=== “定义”函数
```
#dingyi-1[ 描述] $ a times b $
#dingyi-2[ 描述][$ a times b $]
#dingyi-3[-a 描述][$ a times b $]
#dingyi-3(step: false)[-b 描述][$ a times b $]
```
#dingyi-1[ 描述] $ a times b $
#dingyi-2[ 描述][$ a times b $]
#dingyi-3[-a 描述][$ a times b $]
#dingyi-3(step: false)[-b 描述][$ a times b $]

=== “定理”函数
```
#dingli-1[ 描述] $ a times b $
#dingli-2[ 描述][$ a times b $]
#dingli-3[-a 描述][$ a times b $]
#dingli-3(step: false)[-b 描述][$ a times b $]
```
#dingli-1[ 描述] $ a times b $
#dingli-2[ 描述][$ a times b $]
#dingli-3[-a 描述][$ a times b $]
#dingli-3(step: false)[-b 描述][$ a times b $]

=== “命题”函数
```
#mingti-1[ 描述] $ a times b $
#mingti-2[ 描述][$ a times b $]
#mingti-3[-a 描述][$ a times b $]
#mingti-3(step: false)[-b 描述][$ a times b $]
```
#mingti-1[ 描述] $ a times b $
#mingti-2[ 描述][$ a times b $]
#mingti-3[-a 描述][$ a times b $]
#mingti-3(step: false)[-b 描述][$ a times b $]

=== “注”函数
```
#zhu-1[] $ a times b $
#zhu-2[][$ a times b $]
#zhu-3[][$ a times b $]
```
#zhu-1[] $ a times b $
#zhu-2[][$ a times b $]
#zhu-3[][$ a times b $]

=== “证明”函数
```
#zm-1[] $ a times b $
#zm-2[][$ a times b $]
#zm-3[][$ a times b $]
```
#zm-1[] $ a times b $
#zm-2[][$ a times b $]
#zm-3[][$ a times b $]

=== “推论”函数
```
#tuilun-1[] $ a times b $
#tuilun-2[][$ a times b $]
#tuilun-3[][$ a times b $]
```
#tuilun-1[] $ a times b $
#tuilun-2[][$ a times b $]
#tuilun-3[][$ a times b $]

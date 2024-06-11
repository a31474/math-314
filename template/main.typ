#import "@local/math-314:0.3.0": *

// 标题格式
#show: heading-style-color

// 封面
#let my-cover-fun() = {
  set page(header: none)
  align(center + horizon, text(20pt)[这是封面])
  counter(page).update(0)
}

#show: doc => conf-2(
  doc,
  cover-fun: my-cover-fun(),
)

=
==

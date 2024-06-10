#import "./util/heading-L1.typ": last-heading-l1-update, first-heading-l1-update
#import "./util/heading-L2.typ": last-heading-l2-update, first-heading-l2-update
#import "./util/math.typ": counter-reset, math-counter-heading-update
#import "util/util.typ": fake-par
#import "util/default.typ": default-cover-fun, default-heading-numbering, default-text-set, default-par-set
#import "util/default.typ": default-page-set, default-outline-fun

// "模板"函数
#let conf-1(
  doc,
  cover-fun: default-cover-fun(),
  heading-numbering: default-heading-numbering,
  outline-fun: default-outline-fun(),
  page-set: default-page-set,
  text-set: default-text-set,
  par-set: default-par-set,
  math-equation-i-figured-level: 2,
  math-fun-update-level: 2,
) = {
  import "@preview/i-figured:0.2.4"

  // 页面 字体
  set page(..page-set)
  set text(..text-set)
  //段距
  set par(..par-set)
  // 封面
  cover-fun
  // 目录
  outline-fun
  counter(page).update(1)

  // 章节计数
  set heading(numbering: heading-numbering)
  show heading.where(): it => {
    if it.level == 1 {
      last-heading-l1-update(it)
      first-heading-l1-update(it)
    } else if it.level == 2 {
      last-heading-l2-update(it)
      first-heading-l2-update(it)
    }
  } + it + fake-par + i-figured.reset-counters(
    return-orig-heading: false,
    it,
    level: math-equation-i-figured-level,
  ) + math-counter-heading-update(it, update-level: math-fun-update-level)

  // 公式计数
  show math.equation: i-figured.show-equation.with(level: math-equation-i-figured-level)

  // 段首缩进
  set par(first-line-indent: 1.8em)
  show math.equation.where(block: true): it => it + fake-par
  show enum.where(): it => it + fake-par
  set enum(indent: 1.8em)
  set list(indent: 1.8em)
  doc
}
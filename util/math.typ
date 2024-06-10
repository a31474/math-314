//
#import "@preview/showybox:2.0.1": showybox
#import "./util.typ": fake-par

// 预设
#let m-color = (
  deep-blue: rgb(60, 113, 183),
  light-blue: rgb(0, 174, 247),
  orange: rgb(255, 134, 24),
  green: rgb(0, 166, 82),
  thin-green: rgb(242, 251, 246),
  thin-blue: rgb(242, 251, 255),
  thin-orange: rgb(255, 249, 243),
)
#let counter-list = ("定义", "定理", "命题")
#let math-counter-heading = counter("math-counter-heading")
#let math-counter-heading-update(it, update-level: 1) = {
  if it.level == update-level {
    math-counter-heading.update(counter(heading).at(it.location()))
  }
}
#let counter-reset(level, reset-level: 1) = if level == reset-level {
  for name in counter-list {
    counter(name).update(0)
  }
}

// 格式一 无block
#let math-fun-1(type, step: true, math-color: rgb(0, 0, 0), it) = {
  if step {
    counter(type).step()
  }
  set text(fill: math-color, weight: "bold")
  type + {
    context math-counter-heading.display("1.")
  } + counter(type).display() + it
} + h(1.8em)

#let dingyi-1 = math-fun-1.with("定义", math-color: m-color.green)
#let dingli-1 = math-fun-1.with("定理", math-color: m-color.light-blue)
#let mingti-1 = math-fun-1.with("命题", math-color: m-color.light-blue)
#let zhu-1(it) = text(fill: m-color.orange)[*注#it*] + h(1.8em)
#let zm-1(it) = text(fill: m-color.orange)[*证明#it*] + h(1.8em)
#let tuilun-1(it) = text(fill: m-color.light-blue)[*推论#it*] + h(1.8em)

// 格式二 有block 简洁
#let math-fun-2-block = rect.with(
  width: 100%,
  inset: (x: 0pt, y: 5pt),
  outset: (left: 0pt, right: 15pt, top: 3.5pt, bottom: 3pt),
)
#let math-fun-2(
  type,
  counter-use: false,
  step: true,
  color-box: rgb(255, 255, 255),
  color-text: rgb(0, 0, 0),
  it,
  body,
) = {
  let main = h(1.8em) + type + {
    if counter-use {
      if step {
        counter(type).step()
      }
      {
        context math-counter-heading.display("1.")
      } + counter(type).display()
    } else {
      ""
    }
  } + it + h(1.8em)
  math-fun-2-block(fill: color-box, text(fill: color-text, main) + body)
} + fake-par
#let dingyi-2 = math-fun-2.with("定义", counter-use: true, color-box: m-color.thin-green, color-text: m-color.green)
#let dingli-2 = math-fun-2.with("定理", counter-use: true, color-box: m-color.thin-blue, color-text: m-color.light-blue)
#let mingti-2 = math-fun-2.with("命题", counter-use: true, color-box: m-color.thin-blue, color-text: m-color.light-blue)
#let zhu-2 = math-fun-2.with("注", color-box: m-color.thin-orange, color-text: m-color.orange)
#let zm-2 = math-fun-2.with("证明", color-box: m-color.thin-orange, color-text: m-color.orange)
#let tuilun-2 = math-fun-2.with("推论", color-box: m-color.thin-blue, color-text: m-color.light-blue)

// 格式三 有block 复杂
#let math-fun-3(
  type,
  counter-use: false,
  step: true,
  color-body: rgb(255, 255, 255),
  color-frame: rgb(0, 0, 0),
  it,
  body,
) = {
  if step {
    counter(type).step()
  }
  let main = type + {
    if counter-use {
      {
        context math-counter-heading.display("1.")
      } + counter(type).display()
    } else {
      ""
    }
  } + it
  pad(
    // right: -1em,
    x : -1em,
    showybox(
      title-style: (boxed-style: (anchor: (x: left, y: horizon), radius: 0pt)),
      frame: (
        border-color: color-frame,
        title-color: color-frame,
        body-color: color-body,
        radius: 5pt,
        body-inset: (left: 1em, right: 1em, top: 0.65em, bottom: 0.9em),
      ),
      title: text(weight: "bold",main),
    )[#body],
  )
} + fake-par
#let dingyi-3 = math-fun-3.with("定义", counter-use: true, color-body: m-color.thin-green, color-frame: m-color.green)
#let dingli-3 = math-fun-3.with(
  "定理",
  counter-use: true,
  color-body: m-color.thin-blue,
  color-frame: m-color.light-blue,
)
#let mingti-3 = math-fun-3.with(
  "命题",
  counter-use: true,
  color-body: m-color.thin-blue,
  color-frame: m-color.light-blue,
)
#let zhu-3 = math-fun-3.with("注", color-body: m-color.thin-orange, color-frame: m-color.orange)
#let zm-3 = math-fun-3.with("证明", color-body: m-color.thin-orange, color-frame: m-color.orange)
#let tuilun-3 = math-fun-3.with("推论", color-body: m-color.thin-blue, color-frame: m-color.light-blue)
#import "./header.typ": header-fun, header-fun-2

#let page-to-odd-blank-first() = context {
  v(-2em) + hide("占位")
  if calc.odd(here().page()) {
    page(header: none, numbering: none)[]
  }
}

//  默认封面
#let default-cover-fun() = {
  set page(header: none, margin: auto)
  align(center + horizon, text(17pt)[封面])
  counter(page).update(0)
}

//  默认标题格式
#let default-heading-numbering = {
  (..nums) => if nums.pos().len() < 2 [
    第#nums.pos().map(str).join(".")章
  ] else [
    #nums.pos().map(str).join(".")
  ]
}

// 默认目录
#let default-outline-fun() = {
  set page(
    margin: (right: 10%, left: 10%),
    numbering: "i",
    header: none,
  )
  set text(size: 13pt)
  outline(title: "目录", depth: 2, indent: 1em)
}
#let default-outline-fun-2() = {
  set page(
    margin: (right: 10%, left: 10%),
    numbering: "i",
    header: none,
  )
  set text(size: 13pt)
  outline(title: "目录", depth: 2, indent: 1em)
  page-to-odd-blank-first()
}

// 默认页面设置
#let default-page-set = (
  margin: (right: 8.8%, left: 8.8%, top: 7%, bottom: 3%),
  header-ascent: 48%,
  header: header-fun(),
)
#let default-page-set-2 = (
  margin: (inside: 10%, outside: 7%, top: 7%, bottom: 3%),
  header-ascent: 48%,
  header: header-fun-2(),
)

// 默认字体设置
#let default-text-set = (
  font: "Source Han Serif SC",
  lang: "zh",
  region: "cn",
)
// 默认段落设置
#let default-par-set = (
  leading: 0.55em,
  justify: true,
)

#let heading-style-color(doc) = {
  show heading.where(): it => {
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
  doc
}
#import "@local/math-314:0.3.0": *

// 标题格式
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

// 封面
#let my-cover-fun() = {
  set page(header: none)
  align(center+horizon,text(20pt)[这是封面])
  counter(page).update(0)
}

#show: doc => conf-2(
  doc,
  cover-fun:my-cover-fun()
)

= 
== 

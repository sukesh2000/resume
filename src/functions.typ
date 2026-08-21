// Function to define the header of the resume
#let header(name, contacts, tagline: none) = {
  align(center, text(size: 20pt, weight: "bold", fill: rgb("#1F4E79"))[#upper(name)])
  if tagline != none {
    v(4pt, weak: true)
    align(center, text(size: 10.5pt, fill: rgb("#555555"))[#tagline])
  }
  v(6pt, weak: true)
  text(
    fill: rgb("#555555"),
    align(
      center,
      [
        #(
          contacts
            .map(contact => {
              if contact.at("type", default: none) == "email" {
                link("mailto:" + contact.url)[#contact.display]
              } else if contact.at("type", default: none) == "location" {
                [#contact.display]
              } else {
                link(contact.url)[#contact.display]
              }
            })
            .join([ #sym.dot.c ])
        )
      ],
    ),
  )
  v(10pt, weak: true)
}

// Function definition to render the role/company/dates line
#let role(name, company, location, start, end) = {
  grid(columns: (auto, 1fr), [#text(weight: "bold", size: 11pt)[#name] #text(fill: rgb("#555555"))[| #company]], grid.cell(
      align(right, text(fill: rgb("#555555"))[#start -- #end]),
    ))
}

// Function to define the section of the resume
#let section(body) = {
  v(9pt, weak: true)
  text(size: 12pt, weight: "bold", fill: rgb("#1F4E79"))[#upper(body)]
  v(3pt, weak: true)
  line(length: 100%, stroke: 0.75pt + rgb("#1F4E79"))
  v(5pt, weak: true)
}

#let experience(designation, company, location, start, end, pointers) = {
  role(designation, company, location, start, end)
  v(3pt, weak: true)
  set block(spacing: 6pt)
  for (i, pointer) in pointers.enumerate() {
    let project = pointer.at("project", default: none)
    let leadSpacing = if i == 0 { 7pt } else { 4pt }
    if project != none {
      block(above: leadSpacing, below: 3pt)[#text(weight: "bold")[#project]]
      for point in pointer.points {
        let content = if type(point) == dictionary { point.paragraph } else { point }
        block(above: 4pt, inset: (left: 1em))[- #content]
      }
    } else {
      block(above: leadSpacing, inset: (left: 1em))[- #pointer]
    }
  }
  v(7pt, weak: true)
}

// Function to render a flat list of bullet points (e.g. achievements)
#let pointList(items) = {
  set block(spacing: 6pt)
  for item in items {
    block[- #item]
  }
}

// Function to render the skills section with generous line spacing
#let skillsList(skills) = {
  set block(spacing: 6pt)
  for (key, value) in skills {
    block[*#key*: #value]
  }
}

// Function to render the academic entries
#let academic(name, degree, subject, start, end) = {
  grid(columns: (auto, 1fr), [*#name* - #degree in #subject], grid.cell(align(right, [#start\-#end])))
}

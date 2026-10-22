#import "variables.typ": doc, college, skills, details, experiences, projects, achievements, include_ai_initiative, font_size, page_margin, par_leading
#import "functions.typ": header, section, experience, academic, pointList, skillsList

#set document(
  author: doc.author,
  title: doc.title,
  description: [#doc.description],
  keywords: doc.keywords,
)
#set page(margin: page_margin)
#show link: it => text(fill: rgb("#555555"))[#it]
#set text(font: "Carlito", size: font_size, fill: rgb("#1A1A1A"))
#set par(leading: par_leading)

#header(details.name, details.links, tagline: details.tagline)
#section[Summary]
#details.summary

// The "professional experience" section. ChainReact (an internal ThoughtWorks
// AI engineering initiative, not a separate job) is folded in under the
// ThoughtWorks entry, positioned second (right after IDFC Bank, before
// IDeaS), rather than living in a separate standalone Projects section.
#let experiences_with_ai_initiative = if include_ai_initiative {
  let chainreact = projects.at(0)
  let thoughtworks = experiences.at(0)
  let ai_initiative_entry = (project: "ChainReact | AI/Works Initiative (Internal ThoughtWorks AI Engineering Project)", points: chainreact.points)
  let thoughtworks_with_ai_initiative = (
    designation: thoughtworks.designation,
    company: thoughtworks.company,
    location: thoughtworks.location,
    start: thoughtworks.start,
    end: thoughtworks.end,
    achievements: thoughtworks.achievements.slice(0, 1) + (ai_initiative_entry,) + thoughtworks.achievements.slice(1),
  )
  (thoughtworks_with_ai_initiative,) + experiences.slice(1)
} else {
  experiences
}

#section[Professional Experience]
#for exp in experiences_with_ai_initiative {
  experience(
    exp.designation,
    exp.company,
    exp.location,
    exp.start,
    exp.end,
    exp.achievements,
  )
}

#section[Skills]
#skillsList(skills)

#section[Education]
#academic(
  college.name,
  college.degree,
  college.subject,
  college.start,
  college.end,
)

#section[Achievements]
#pointList(achievements)

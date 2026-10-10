#import "variables.typ": doc, college, skills, details, experiences, projects, achievements
#import "functions.typ": header, section, experience, academic, pointList, skillsList

#set document(
  author: doc.author,
  title: doc.title,
  description: [#doc.description],
  keywords: doc.keywords,
)
#set page(margin: 1cm)
#show link: it => text(fill: rgb("#555555"))[#it]
#set text(font: "Carlito", size: 9pt, fill: rgb("#1A1A1A"))
#set par(leading: 0.54em)

#header(details.name, details.links, tagline: details.tagline)
#section[Summary]
#details.summary

// The "professional experience" section. ChainReact (an internal ThoughtWorks
// AI engineering initiative, not a separate job) is folded in under the
// ThoughtWorks entry, positioned second (right after IDFC Bank, before
// IDeaS), rather than living in a separate standalone Projects section.
#let chainreact = projects.at(0)
#let thoughtworks = experiences.at(0)
#let ai_initiative_entry = (project: "ChainReact | AI/Works Initiative (Internal ThoughtWorks AI Engineering Project)", points: chainreact.points)
#let thoughtworks_with_ai_initiative = (
  designation: thoughtworks.designation,
  company: thoughtworks.company,
  location: thoughtworks.location,
  start: thoughtworks.start,
  end: thoughtworks.end,
  achievements: thoughtworks.achievements.slice(0, 1) + (ai_initiative_entry,) + thoughtworks.achievements.slice(1),
)
#let experiences_with_ai_initiative = (thoughtworks_with_ai_initiative,) + experiences.slice(1)

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

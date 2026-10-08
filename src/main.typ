// Import variables and functions
#import "variables.typ": doc, college, skills, details, experiences, projects, achievements
#import "functions.typ": header, section, experience, academic, pointList, skillsList, projectEntry

// Document settings
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

// The top-level heading of the resume
#header(details.name, details.links, tagline: details.tagline)
#section[Summary]
#details.summary

// The "experience" section
#section[Experience]
#for exp in experiences {
  experience(
    exp.designation,
    exp.company,
    exp.location,
    exp.start,
    exp.end,
    exp.achievements,
  )
}

// The "projects" section
#section[Projects]
#for proj in projects {
  projectEntry(proj.name, proj.subtitle, proj.points)
}

// The "skills" section
#section[Skills]
#skillsList(skills)

// The "education" section
#section[Education]
#academic(
  college.name,
  college.degree,
  college.subject,
  college.start,
  college.end,
)

// The "achievements" section
#section[Achievements]
#pointList(achievements)

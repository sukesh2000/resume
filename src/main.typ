// Import variables and functions
#import "variables.typ": doc, college, skills, details, experiences, achievements
#import "functions.typ": header, section, experience, academic, pointList, skillsList

// Document settings
#set document(
  author: doc.author,
  title: doc.title,
  description: [#doc.description],
  keywords: doc.keywords,
)
#set page(margin: 1.1cm)
#show link: it => text(fill: rgb("#555555"))[#it]
#set text(font: "Carlito", size: 9.5pt, fill: rgb("#1A1A1A"))
#set par(leading: 0.74em)

// The top-level heading of the resume
#header(details.name, details.links, tagline: details.tagline)
#section[Summary]
#details.summary

// The "skills" section
#section[Skills]
#skillsList(skills)

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

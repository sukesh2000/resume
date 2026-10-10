// Which stack to present the IDFC Bank "Config Portal" project with. The
// project was genuinely built in both, at different times -- pass
// `--input stack=java` (or `stack=golang`) to `typst compile` to pick which
// one to foreground, e.g. based on what a target job description asks for.
// Defaults to "golang" since that's the project's current primary stack.
#let stack = sys.inputs.at("stack", default: "golang")
#let pick(variants) = variants.at(stack, default: variants.golang)

// Optional per-application overrides, e.g.
// `typst compile --input summary="..." --input extra_skills="Liquibase, LDAP" ...`.
// Both default to the empty string, meaning "use the hand-written defaults below."
#let summary_override = sys.inputs.at("summary", default: "")
#let tagline_override = sys.inputs.at("tagline", default: "")
#let extra_skills = sys.inputs.at("extra_skills", default: "")

// Which resume variant to render -- one of "unified" (default), "backend", or "ai".
// All three variants share the exact same facts, metrics, dates, and ownership
// claims from this one file -- only headline, summary, and skills ordering
// change per variant. Pass `--input variant=backend` or `--input variant=ai`.
// `unified` is the single-upload default for Naukri/Instahyre-style platforms.
#let variant = sys.inputs.at("variant", default: "unified")

#let doc = (
  author: "Sukesh Seth",
  title: "Sukesh's Resume",
  description: "Sukesh's Software Development Engineering (SDE) resume written and built using Typst.",
  keywords: ("resume", "engineering", "typst"),
)

#let college = (
  name: "SRM Institute of Science and Technology",
  degree: "B. Tech.",
  subject: "Electronics and Communications Engineering",
  start: 2018,
  end: 2022,
)

// Skills -- the actual content lives here, once, regardless of variant.
#let skill_categories = (
  "Languages": "Java, Go (Golang), Python",
  "Frameworks": "Spring Boot, Spring Security, Hibernate, Node.js, Gin, GORM",
  "Distributed Systems & Messaging": "Microservices, Distributed Systems, REST APIs, gRPC, Kafka",
  "Databases & Caching": "PostgreSQL, Oracle, Cassandra, MongoDB, Redis, Elasticsearch",
  "AI/LLM Engineering": "LLM Integration (Claude), RAG, Embeddings/Vector Search, LangChain, LangGraph, LlamaIndex, Agentic Workflow Design, Prompt Engineering, Temporal, Local LLM Deployment (Ollama), AI-Assisted Development (Claude, GitHub Copilot, Minimax)",
  "DevOps & Cloud": "Docker, Kubernetes, AWS (EC2, S3, EKS), CI/CD (Jenkins, GoCD)",
  "Testing": "JUnit, Mockito, Jest, Testify/gomock",
  "Version Control": "Git",
  "Problem Solving": "Data Structures & Algorithms, Multithreading, Design Patterns, System Design, Agile (Scrum, XP)",
)

// Only the ORDER of categories changes per variant -- the category names and
// their contents are identical across all three, so there is exactly one
// place to update a skill and no risk of the variants drifting apart.
#let backend_first_order = ("Languages", "Frameworks", "Distributed Systems & Messaging", "Databases & Caching", "DevOps & Cloud", "AI/LLM Engineering", "Testing", "Version Control", "Problem Solving")
#let skill_order = (
  unified: backend_first_order,
  backend: backend_first_order,
  ai: ("AI/LLM Engineering", "Languages", "Frameworks", "Distributed Systems & Messaging", "Databases & Caching", "DevOps & Cloud", "Testing", "Version Control", "Problem Solving"),
)
#let ordered_keys = skill_order.at(variant, default: skill_order.unified)
#let base_skills = ordered_keys.map(key => (key, skill_categories.at(key)))
#let skills = if extra_skills != "" {
  base_skills + (("Additional", extra_skills),)
} else {
  base_skills
}

// Per-variant tagline and summary. Same facts and metrics everywhere -- only
// emphasis and ordering change. `tagline_override`/`summary_override` (set via
// `--input tagline=...`/`--input summary=...`) still win for one-off,
// job-specific tailoring on top of whichever variant is selected.
#let taglines = (
  unified: "Backend Engineer  |  Java · Go · Distributed Systems · AI Engineering",
  backend: "Backend Engineer  |  Java · Go · Distributed Systems · Microservices",
  ai: "AI Engineer  |  LLM Agents · RAG · Agentic Workflows · Java/Go Backend",
)
#let summaries = (
  unified: "Backend engineer with 4+ years at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go for BFSI and enterprise platforms, with deep experience in Kafka, Redis, and production reliability. Complementing this, I design LLM-powered agents using retrieval-augmented generation and agentic workflows to automate real engineering problems. Comfortable across the full lifecycle, from distributed-systems architecture to cloud-native deployment on AWS and Kubernetes.",
  backend: "Backend engineer with 4+ years at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go for BFSI and enterprise platforms, with deep experience in Kafka, Redis, and production reliability. Experienced across the full lifecycle, from distributed-systems architecture and observability to cloud-native deployment on AWS and Kubernetes, with additional hands-on experience building LLM-powered agents.",
  ai: "AI engineer with hands-on experience designing and building LLM-powered agents, applying retrieval-augmented generation and agentic workflows (LangGraph, LangChain) to automate real engineering problems such as microservice contract-drift detection. Grounded in 4+ years of backend engineering at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go, with deep experience in Kafka, Redis, and production reliability at BFSI scale.",
)

#let details = (
  name: "Sukesh Seth",
  tagline: if tagline_override != "" {
    tagline_override
  } else {
    taglines.at(variant, default: taglines.unified)
  },
  summary: if summary_override != "" {
    summary_override
  } else {
    summaries.at(variant, default: summaries.unified)
  },
  links: (
    (url: "tel:+918939352970", display: "+918939352970"),
    (type: "email", url: "contact.sukesh20@gmail.com", display: "contact.sukesh20@gmail.com"),
    (type: "location", display: "Bangalore, India"),
    (url: "https://www.linkedin.com/in/sukeshseth", display: "LinkedIn"),
    (url: "https://sukeshseth.medium.com/", display: "Medium"),
    (url: "https://github.com/sukesh2000", display: "GitHub"),
    (url: "https://leetcode.com/u/sukesh1312/", display: "Leetcode")
  ),
)

#let experiences = (
  (
    designation: "Software Engineer",
    company: "ThoughtWorks Technologies - Bangalore",
    location: "Bangalore",
    start: "July 2022",
    end: "Present",
    achievements: (
      (
        project: "IDFC Bank",
        points: (
          [Contributed to building a #pick((golang: "Go-based", java: "Java, Spring Boot based")) configuration and deployment platform for 98 microservices, replacing manual, fragmented config changes that risked outages. Added Redis caching, versioned configs, Kafka-driven rollouts, and automated Conftest/Pact/Helm validation, *reducing configuration time by 60%, database queries by 85%, and increasing adoption by 65%*.],
          [Led observability and release-safety modernization across a polyglot stack running Go, Java, and Node.js, replacing fragmented tracing and slow policy validation that were raising production risk. Migrated tracing to OpenTelemetry, added a region-aware Kafka client for disaster recovery, and shifted Conftest validation to run per service, *reducing validation time from 40 to 3 minutes, MTTD by 70%, and MTTR by 45%*.],
          [Designed and implemented a #pick((golang: "Go-based", java: "Java-based")) authentication middleware for an MCP server, giving the existing configuration platform secure access from AI-assisted development tools.],
          [Manual DR execution required multiple infrastructure and service-level steps, increasing recovery time. Automated the existing DR runbook through Helm and CI/CD, provisioning Kafka in parallel with Redis, Prometheus, and networking, then orchestrating a controlled StatefulSet cutover, *completing failover in 12 minutes*.],
          [The platform's feature-flag tooling required migration from Unleash v6 to v7 alongside a breaking CommonJS-to-ESM change. Independently led the migration and resolved compatibility issues across dependent services, *completing the upgrade without disruption to 98 services*.],
          [Configuration changes depended on ServiceNow webhook notifications, creating a risk of missed updates when webhooks failed. Implemented a webhook and reconciliation pattern with a periodic job that independently re-polls approval status, ensuring configuration changes are not missed due to dropped webhook events.],
          [Tech Stack: Go, Java, Spring Boot, Oracle, Redis, Kafka, Kubernetes, AWS, Helm, Prometheus, OpenTelemetry, ServiceNow.],
        ),
      ),
      (
        project: "IDeaS",
        points: (
          [The existing forecasting system generated month-wise forecasts, limiting the granularity of pricing analysis. Enhanced the Spring Boot forecasting service to support *day-wise forecasts with 30x finer granularity*, introducing additional calculation dimensions and Kafka-driven adjustments for incoming booking data.],
          [Delayed booking-data processing increased the time between pricing analysis cycles. Introduced Kafka-driven real-time data analysis capabilities, *reducing the time between two price-analysis cycles by 24 hours*.],
          [A monolithic architecture caused DB lock contention and limited parallel processing during peak loads. Contributed to the migration toward microservices using Spring MVC, enabling *parallel cross-service processing and reducing database lock contention*.],
          [Tech Stack: Java, Spring Boot, Spring MVC, MS SQL, Kafka.],
        ),
      ),
    ),
  ),
)

// ChainReact's data; folded into the ThoughtWorks block in main.typ rather
// than rendered as its own section.
#let projects = (
  (
    name: "ChainReact",
    subtitle: "Global ThoughtWorks AI/works Hackathon 2026",
    points: (
      [Built an autonomous LLM agent that detects microservice contract drift using deterministic rules and LLM semantic analysis, replacing manual review that let silent schema and semantic mismatches reach production. Auto-generates human-reviewable fix PRs with human-in-the-loop gates for ambiguous cases, *cutting time-to-detect from days to under 2 minutes and time-to-fix from hours to under 5 minutes, scaling linearly from 4 to 400 services*.],
      [Re-architected the agent's orchestration and detection layers, replacing Temporal workflows with LangGraph/LangChain and direct source parsing with a LlamaIndex-backed RAG pipeline over embedded specs and documentation, *improving analysis accuracy and workflow composability*.],
      [Developed during an internal ThoughtWorks hackathon. The initiative was subsequently adopted into the AI/Works stack.],
      [Tech Stack: Python, FastAPI, Claude/Ollama, LangChain, LangGraph, LlamaIndex, PostgreSQL (pgvector), Next.js, TypeScript, GitHub API.],
    ),
  ),
)

// Achievements outside of work experience
#let achievements = (
  [Solved 1000+ Data Structures & Algorithms problems across multiple competitive programming platforms.],
  [Won 2nd Prize at HackCBS 3.0 among 260+ colleges. Led development of an LSTM-based rap-lyrics generator deployed on AWS EC2 with a Flask backend.],
  [Secured 1st position at SRM Research Day 2021 (Aerospace Dept.) for a paper on an autonomous Modular Morphing Drone that dynamically reshapes itself in response to environmental changes.],
  [Won 1st Prize and the Tezos track at a Python Week Hackathon, leading a team building a blockchain-based web app for secure autopsy report management.],
)

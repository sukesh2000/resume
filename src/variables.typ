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
#let extra_skills = sys.inputs.at("extra_skills", default: "")

// Document metadata
#let doc = (
  author: "Sukesh Seth",
  title: "Sukesh's Resume",
  description: "Sukesh's Software Development Engineering (SDE) resume written and built using Typst.",
  keywords: ("resume", "engineering", "typst"),
)

// College related information
#let college = (
  name: "SRM Institute of Science and Technology",
  degree: "B. Tech.",
  subject: "Electronics and Communications Engineering",
  start: 2018,
  end: 2022,
)

// Skills
#let base_skills = (
  "Languages": "Java, Golang, Python, Node.js, SQL",
  "Frameworks": "Spring Boot, Spring Security, Hibernate, Node.js, Gin, GORM",
  "APIs & Messaging": "REST APIs, gRPC, Kafka",
  "Databases & Caching": "PostgreSQL, Oracle, Cassandra, MongoDB, Redis, Elasticsearch",
  "AI/LLM Engineering": "LLM Integration (Claude), RAG, Embeddings/Vector Search, LangChain, LangGraph, LlamaIndex, Agentic Workflow Design, Prompt Engineering, Temporal, Local LLM Deployment (Ollama)",
  "DevOps & Cloud": "Docker, Kubernetes, Amazon Web Services (AWS), CI/CD",
  "Testing": "JUnit, Mockito, Jest, Testify/gomock",
  "Version Control": "Git",
  "Problem Solving": "Data Structures & Algorithms, Multithreading, Design Patterns, System Design",
)
#let skills = if extra_skills != "" {
  base_skills + ("Additional": extra_skills)
} else {
  base_skills
}

// Header related information
#let details = (
  name: "Sukesh Seth",
  tagline: "AI Backend Engineer  |  Java · Golang · LLM/GenAI · Microservices",
  summary: if summary_override != "" {
    summary_override
  } else {
    "Backend engineer with 4+ years at ThoughtWorks, building distributed systems and microservices in Java and Golang for BFSI and enterprise platforms, with hands-on generative AI experience building and productionizing LLM-powered agents (RAG, LangChain/LangGraph, Claude integration). Deep in Kafka-driven event systems, Redis caching, AWS, Kubernetes/Helm, and cloud-native observability across the full backend lifecycle."
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

// Past work experience and achievements
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
          [Manual and fragmented configuration changes across 98 microservices increased operational effort and outage risk. Contributed to building a #pick((golang: "Golang", java: "Java, Spring Boot")) based configuration platform with Redis caching, versioned configurations, Kafka-driven rollouts, and automated Conftest/Pact/Helm validation, *reducing configuration time by 60%, database queries by 85%, and increasing adoption by 65%*.],
          [Fragmented tracing and slow policy validation created production and release risks across a polyglot stack. Led observability and release-safety improvements by migrating tracing to OpenTelemetry across Golang, Java, and Node.js, introducing a region-aware Kafka client for disaster recovery, and shifting Conftest validation to individual services, *reducing validation time from 40 to 3 minutes, MTTD by 70%, and MTTR by 45%*.],
          [The existing configuration platform needed secure access from AI-assisted development tools. Designed and implemented a #pick((golang: "Golang", java: "Java")) based authentication middleware for an MCP server, enabling secure exposure of configuration-platform capabilities to AI-assisted tools.],
          [Manual DR execution required multiple infrastructure and service-level steps, increasing recovery time. Automated the existing DR runbook through Helm and CI/CD by provisioning Kafka in parallel with Redis, Prometheus, and networking, using no-op stubs until dependencies were ready, and orchestrating controlled deployment and StatefulSet scale-down/up, *completing failover in 12 minutes*.],
          [The platform's feature-flag tooling required migration from Unleash v6 to v7 alongside a breaking CommonJS-to-ESM change. Independently led the migration and resolved compatibility issues across dependent services, *completing the upgrade without disruption to 98 services*.],
          [Configuration changes depended on ServiceNow webhook notifications, creating a risk of missed updates when webhooks failed. Implemented a webhook and reconciliation pattern with a periodic job that independently re-polls approval status, ensuring configuration changes are not missed due to dropped webhook events.],
          [Tech Stack: Golang, Java, Spring Boot, Oracle, Redis, Kafka, Kubernetes, AWS, Helm, Prometheus, OpenTelemetry, ServiceNow.],
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

// Personal / hackathon projects
#let projects = (
  (
    name: "ChainReact",
    subtitle: "Global ThoughtWorks AI/works Hackathon 2026",
    points: (
      [Microservice contract drift (schema/semantic mismatches between services) silently causes outages that static linters miss. Built an autonomous LLM agent combining a deterministic rules engine with LLM semantic analysis to auto-raise human-reviewable fix PRs with human-in-the-loop gates for ambiguous cases, *cutting time-to-detect from days to under 2 minutes and time-to-fix from hours to under 5, scaling linearly from 4 to 400 services*.],
      [Re-architected the agent, replacing Temporal workflows with LangGraph/LangChain orchestration and direct source parsing with a LlamaIndex-backed RAG pipeline over embedded specs/docs, *improving analysis accuracy and workflow composability*.],
      [Tech Stack: Python, FastAPI, Claude/Ollama, LangChain, LangGraph, LlamaIndex, vector DB, PostgreSQL, Next.js, TypeScript, GitHub API.],
    ),
  ),
)

// Achievements outside of work experience
#let achievements = (
  [Solved 900+ Data Structures & Algorithms problems across multiple competitive programming platforms.],
  [Won 2nd Prize at HackCBS 3.0 among 260+ colleges. Led development of an LSTM-based rap-lyrics generator deployed on AWS EC2 with a Flask backend.],
  [Secured 1st position at SRM Research Day 2021 (Aerospace Dept.) for a paper on an autonomous Modular Morphing Drone that dynamically reshapes itself in response to environmental changes.],
  [Won 1st Prize and the Tezos track at a Python Week Hackathon, leading a team building a blockchain-based web app for secure autopsy report management.],
)

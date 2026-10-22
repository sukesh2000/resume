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

// Show the "IDFC Bank Credit Cards" Experience entry. Off by default because it
// no longer fits the standard one-page variants at a readable size, so pass
// `--input include_credit_cards=true` for applications that should carry it.
#let include_credit_cards = sys.inputs.at("include_credit_cards", default: "false") == "true"

// Contact phone, overridable per application via `--input phone=...`.
#let contact_phone = sys.inputs.at("phone", default: "+918939352970")

// Contact email, overridable per application via `--input email=...`.
#let contact_email = sys.inputs.at("email", default: "sukeshseth20@gmail.com")

// Job title to match a specific JD's wording (e.g. "Software Engineer",
// "Backend Engineer", "AI Engineer", "Backend AI Engineer"), applied
// consistently to the tagline, the summary's opening noun, and the
// ThoughtWorks designation, e.g. `--input job_title="Software Engineer"`.
// Defaults to each variant's usual framing when not set.
#let job_title_override = sys.inputs.at("job_title", default: "")

// Comma-separated skills to drop from whichever categories contain them for
// a given application, e.g. `--input exclude_skills="Node.js, MongoDB"`.
#let exclude_skills_raw = sys.inputs.at("exclude_skills", default: "")
#let exclude_skills_list = if exclude_skills_raw != "" {
  exclude_skills_raw.split(",").map(s => s.trim())
} else {
  ()
}
#let filter_skill_value(value) = if exclude_skills_list.len() == 0 {
  value
} else {
  value.split(", ").filter(item => not exclude_skills_list.contains(item.trim())).join(", ")
}

// Comma-separated skill CATEGORY names to drop entirely for a given
// application, e.g. `--input exclude_categories="Frameworks, AI/LLM Engineering"`.
// Use this instead of exclude_skills when a whole category doesn't fit a JD.
#let exclude_categories_raw = sys.inputs.at("exclude_categories", default: "")
#let exclude_categories_list = if exclude_categories_raw != "" {
  exclude_categories_raw.split(",").map(s => s.trim())
} else {
  ()
}

// Whether to include the ChainReact/AI-Works initiative (both the Experience
// bullet and the "AI/LLM Engineering" skills category). Defaults to true.
// Pass `--input include_ai=false` for applications where AI/LLM shouldn't be
// a talking point.
#let include_ai_initiative = sys.inputs.at("include_ai", default: "true") != "false"

// Layout knobs, e.g. for filling the page when content is shorter than usual
// (with include_ai=false) or tightening it back up as content grows. Override
// per one-off compile with `--input font_size=10 --input spacing_scale=1.3`.
#let font_size = float(sys.inputs.at("font_size", default: "9")) * 1pt
#let page_margin = float(sys.inputs.at("margin", default: "0.9")) * 1cm
#let par_leading = float(sys.inputs.at("leading", default: "0.54")) * 1em
#let spacing_scale = float(sys.inputs.at("spacing_scale", default: "0.83"))

// Which resume variant to render -- one of "unified" (default), "backend", or "ai".
// All three variants share the exact same facts, metrics, dates, and ownership
// claims from this one file -- only headline, summary, and skills ordering
// change per variant. Pass `--input variant=backend` or `--input variant=ai`.
// `unified` is the single-upload default for Naukri/Instahyre-style platforms.
#let variant = sys.inputs.at("variant", default: "unified")

// Default job title per variant, used when job_title_override is empty.
#let default_job_titles = (unified: "Backend Engineer", backend: "Backend Engineer", ai: "AI Engineer")
#let job_title = if job_title_override != "" {
  job_title_override
} else {
  default_job_titles.at(variant, default: "Backend Engineer")
}
// Only lowercase the title's last word for sentence-lead use in the summary
// ("Backend Engineer" -> "Backend engineer", "AI Engineer" -> "AI engineer"),
// so acronyms like "AI" stay capitalized.
#let job_title_words = job_title.split(" ")
#let job_title_lower = if job_title_words.len() > 1 {
  job_title_words.slice(0, job_title_words.len() - 1).join(" ") + " " + lower(job_title_words.last())
} else {
  lower(job_title)
}

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
  "Frameworks": "Spring Boot, Hibernate, Gin, GORM",
  "Distributed Systems & Messaging": "Microservices, Distributed Systems, REST APIs, gRPC, Kafka",
  "Databases & Caching": "Oracle, Redis, Elasticsearch",
  "AI/LLM Engineering": "LLM Integration (Claude), RAG, Embeddings/Vector Search, LangChain, LangGraph, LlamaIndex, Agentic Workflow Design, Prompt Engineering, Temporal, Local LLM Deployment (Ollama)",
  "AI-Assisted Development": "GitHub Copilot, Claude, Minimax",
  "DevOps & Cloud": "Docker, Kubernetes, AWS (EC2, S3, EKS), CI/CD (Jenkins, GoCD)",
  "Testing": "JUnit, Mockito, Jest, Testify/gomock",
  "Version Control": "Git",
  "Problem Solving": "Data Structures & Algorithms, Multithreading, Design Patterns, System Design, Agile (Scrum, XP)",
)

// Only the ORDER of categories changes per variant -- the category names and
// their contents are identical across all three, so there is exactly one
// place to update a skill and no risk of the variants drifting apart.
#let backend_first_order = ("Languages", "Frameworks", "Distributed Systems & Messaging", "Databases & Caching", "DevOps & Cloud", "AI/LLM Engineering", "AI-Assisted Development", "Testing", "Version Control", "Problem Solving")
#let skill_order = (
  unified: backend_first_order,
  backend: backend_first_order,
  ai: ("AI/LLM Engineering", "AI-Assisted Development", "Languages", "Frameworks", "Distributed Systems & Messaging", "Databases & Caching", "DevOps & Cloud", "Testing", "Version Control", "Problem Solving"),
)
#let ordered_keys_all = skill_order.at(variant, default: skill_order.unified)
#let ordered_keys = ordered_keys_all.filter(key =>
  (include_ai_initiative or key != "AI/LLM Engineering") and not exclude_categories_list.contains(key)
)
#let base_skills = ordered_keys.map(key => (key, filter_skill_value(skill_categories.at(key))))
// Optional per-application "Core Skills" line shown first, to mirror a JD's
// own wording, e.g. `--input top_skills="Data Structures, Algorithms, Go"`.
#let top_skills = sys.inputs.at("top_skills", default: "")
#let skills_with_extra = if extra_skills != "" {
  base_skills + (("Additional", extra_skills),)
} else {
  base_skills
}
#let skills = if top_skills != "" {
  (("Core Skills", top_skills),) + skills_with_extra
} else {
  skills_with_extra
}

// Per-variant tagline and summary. Same facts and metrics everywhere -- only
// emphasis and ordering change. The leading title comes from `job_title`
// (JD-matched via `--input job_title=...`, else the variant default).
// `tagline_override`/`summary_override` (set via `--input tagline=...`/
// `--input summary=...`) still win for one-off, job-specific tailoring.
#let taglines = (
  unified: job_title + "  |  Java · Go · Distributed Systems · AI Engineering",
  backend: job_title + "  |  Java · Go · Distributed Systems · Microservices",
  ai: job_title + "  |  LLM Agents · RAG · Agentic Workflows · Java/Go Backend",
)
#let summaries = (
  unified: job_title_lower + " with 4+ years at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go for BFSI and enterprise platforms, with deep experience in Kafka, Redis, and production reliability. Complementing this, I design LLM-powered agents using retrieval-augmented generation and agentic workflows to automate real engineering problems. Comfortable across the full lifecycle, from distributed-systems architecture to cloud-native deployment on AWS and Kubernetes.",
  backend: job_title_lower + " with 4+ years at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go for BFSI and enterprise platforms, with deep experience in Kafka, Redis, and production reliability. Experienced across the full lifecycle, from distributed-systems architecture and observability to cloud-native deployment on AWS and Kubernetes, with additional hands-on experience building LLM-powered agents.",
  ai: job_title_lower + " with hands-on experience designing and building LLM-powered agents, applying retrieval-augmented generation and agentic workflows (LangGraph, LangChain) to automate real engineering problems such as microservice contract-drift detection. Grounded in 4+ years of backend engineering at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go, with deep experience in Kafka, Redis, and production reliability at BFSI scale.",
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
    (url: "tel:" + contact_phone, display: contact_phone),
    (type: "email", url: contact_email, display: contact_email),
    (type: "location", display: "Bangalore, India"),
    (url: "https://www.linkedin.com/in/sukeshseth", display: "LinkedIn"),
    (url: "https://sukeshseth.medium.com/", display: "Medium"),
    (url: "https://github.com/sukesh2000", display: "GitHub"),
    (url: "https://leetcode.com/u/sukesh1312/", display: "Leetcode")
  ),
)

#let experiences = (
  (
    designation: if job_title_override != "" { job_title_override } else { "Software Engineer" },
    company: "ThoughtWorks Technologies - Bangalore",
    location: "Bangalore",
    start: "July 2022",
    end: "Present",
    achievements: (
      (
        project: "IDFC Bank",
        points: (
          [Contributed to building a large-scale distributed #pick((golang: "Go-based", java: "Java, Spring Boot based")) configuration and deployment platform for 98 microservices, replacing manual, fragmented config changes that risked outages. Added Redis caching, versioned configs, Kafka-driven rollouts, and automated Conftest/Pact/Helm validation, *reducing configuration time by 60%, database queries by 85% on systems processing 10M+ daily transactions, and increasing adoption by 65%*.],
          [Led observability and release-safety modernization across a polyglot stack running Go, Java, and Node.js, replacing fragmented tracing and slow policy validation that were raising production risk. Migrated tracing to OpenTelemetry, added a region-aware Kafka client for disaster recovery, and shifted Conftest validation to run per service, *reducing validation time from 40 to 3 minutes, MTTD by 70%, and MTTR by 45%*.],
          [Designed and implemented a #pick((golang: "Go-based", java: "Java-based")) authentication middleware for an MCP server, giving the existing configuration platform secure access from AI-assisted development tools.],
          [Manual DR execution required multiple infrastructure and service-level steps, increasing recovery time. Automated the existing DR runbook for the distributed platform through Helm and CI/CD, provisioning Kafka in parallel with Redis, Prometheus, and networking, then orchestrating a controlled StatefulSet cutover, *completing failover in 12 minutes*.],
          [The platform's feature-flag tooling required migration from Unleash v6 to v7 alongside a breaking CommonJS-to-ESM change. Independently led the migration and resolved compatibility issues across dependent services, *completing the upgrade without disruption to 98 services*.],
          [Configuration changes depended on ServiceNow webhook notifications, creating a risk of missed updates when webhooks failed. Implemented a webhook and reconciliation pattern with a periodic job that independently re-polls approval status, ensuring configuration changes are not missed due to dropped webhook events.],
          [Manual Artifactory migration from on-premises to cloud was estimated at 10 repositories and 5 services per day. Used a self-hosted Minimax LLM, deployed by another team, to generate and validate migration scripts, *migrating 250 repositories and their deployed services to the cloud in 4-5 days, roughly 5x faster for repositories and 2.4x faster for services than the manual estimate*.],
          [Tech Stack: Go, Java, Spring Boot, Oracle, Redis, Kafka, Kubernetes, AWS, Helm, Prometheus, OpenTelemetry, ServiceNow, Artifactory.],
        ),
      ),
      (
        project: "IDFC Bank Credit Cards",
        points: (
          [Contributed to integrating RuPay into a credit card issuance platform supporting *3 card networks (Visa, Mastercard, and RuPay)*, handling 10K to 100K issuance requests monthly while preserving existing network flows.],
          [Strengthened issuance correctness and reliability under concurrent requests, retries, and external vendor failures, targeting 10 to 50 RPS peak throughput, p95 latency under 300 ms, p99 under 800 ms, and an issuance success rate above 99% for eligible requests.],
          [Implemented an idempotent issuance saga with durable checkpoints and lease-based recovery, per-BIN PAN allocation with database-enforced uniqueness, and a transactional outbox into Kafka with at-least-once delivery, consumer deduplication, and per-card event sequencing.],
          [Established safeguards against duplicate issuance and PAN allocation, recoverable interrupted workflows, and reliable downstream event processing through idempotent consumers and reconciliation, *while preserving backward compatibility for existing Visa and Mastercard issuance flows*.],
          [Tech Stack: Java, Spring Boot, Oracle, Kafka, Temporal, Unleash, Docker, Kubernetes, AWS, Redis, Prometheus, Grafana, OpenTelemetry.],
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
    ).filter(a => include_credit_cards or a.project != "IDFC Bank Credit Cards"),
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
      [Re-architected the agent's orchestration layer, replacing Temporal workflows with LangGraph/LangChain, and layered a LlamaIndex-backed RAG pipeline over tree-sitter AST-based belief extraction to ground detection in embedded specs and documentation, *improving analysis accuracy and workflow composability*.],
      [Developed during an internal ThoughtWorks hackathon. The initiative was subsequently adopted into the AI/Works stack.],
      [Tech Stack: Python, FastAPI, Claude/Ollama, LangChain, LangGraph, LlamaIndex, PostgreSQL (pgvector), Next.js (React), TypeScript, GitHub API.],
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

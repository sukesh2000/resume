// Which stack to present the IDFC Bank "Config Portal" project with. The
// project was genuinely built in both, at different times -- pass
// `--input stack=java` (or `stack=golang`) to `typst compile` to pick which
// one to foreground, e.g. based on what a target job description asks for.
// Defaults to "golang" since that's the project's current primary stack.
#let stack = sys.inputs.at("stack", default: "golang")
#let pick(variants) = variants.at(stack, default: variants.golang)

// Content profile. "current" (the default) is the standard resume's content set
// as of 2026-11-07: the AI performance-engineering platform block leads the IDFC
// work, the credit-card issuance block follows, the release/config platform comes
// third, and ChainReact and IDeaS are omitted.
//
// "legacy" restores the pre-2026-11-07 defaults (credit cards off, ChainReact on,
// no AI performance block, IDeaS present, config platform first) so every resume
// that has already been sent rebuilds exactly as it was. Pass
// `--input profile=legacy` — the handoff recipes do this.
#let profile = sys.inputs.at("profile", default: "current")

// Optional per-application overrides, e.g.
// `typst compile --input summary="..." --input extra_skills="Liquibase, LDAP" ...`.
// Both default to the empty string, meaning "use the hand-written defaults below."
#let summary_override = sys.inputs.at("summary", default: "")
#let tagline_override = sys.inputs.at("tagline", default: "")
#let extra_skills = sys.inputs.at("extra_skills", default: "")

// Boolean knob whose default follows the content profile. An explicitly passed
// `--input key=true|false` always wins; otherwise the value is the profile's own
// default, which is the inverse of the value the "legacy" profile used.
#let flag(key, legacy: false) = {
  let raw = sys.inputs.at(key, default: "")
  if raw != "" { raw == "true" } else {
    if profile == "legacy" { legacy } else { not legacy }
  }
}

// Show the "IDFC Bank Credit Cards" Experience entry. On by default in the
// current profile; off in "legacy" because it did not fit the standard
// one-page variants at a readable size.
#let include_credit_cards = flag("include_credit_cards", legacy: false)

// Put the credit card entry first in Experience instead of after the config platform block.
// Only has an effect together with `include_credit_cards=true`: `--input cards_first=true`.
#let cards_first = sys.inputs.at("cards_first", default: "false") == "true"
#let cards_to_front(items) = if cards_first {
  items.filter(a => a.project == "IDFC Bank Credit Cards") + items.filter(a => a.project != "IDFC Bank Credit Cards")
} else {
  items
}

// Render ChainReact in its own "Projects" section after Experience instead of inside the
// ThoughtWorks entry: `--input chainreact_as_project=true` (ignored when AI content is off).
#let chainreact_as_project = sys.inputs.at("chainreact_as_project", default: "false") == "true"

// Drop the ChainReact block entirely without also stripping the AI/LLM skills
// categories: `--input include_chainreact=false`. Off in the current profile
// (the AI performance-engineering block now carries the AI story), on in "legacy".
#let include_chainreact = flag("include_chainreact", legacy: true)

// Show the IDFC Bank AI performance-engineering platform block. On in the current
// profile, off in "legacy" so every earlier one-page recipe keeps its fit.
#let include_perf_ai = flag("include_perf_ai", legacy: false)

// Show the IDeaS Experience entry. Off in the current profile, on in "legacy".
#let include_ideas = flag("include_ideas", legacy: true)

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
#let filtered_skill_value(value) = if exclude_skills_list.len() == 0 {
  value
} else {
  value.split(", ").filter(item => not exclude_skills_list.contains(item.trim())).join(", ")
}

// Rewrite text inside skill lines for one application, e.g.
// `--input 'skill_replace=AWS (EC2, S3, EKS)=>AWS (EC2, S3, RDS, Lambda, CloudWatch, EKS)'`.
// Format "old=>new", several pairs separated by "||". Use only for skills the user has confirmed.
#let skill_replace_raw = sys.inputs.at("skill_replace", default: "")
#let skill_replacements = if skill_replace_raw != "" {
  skill_replace_raw.split("||").map(pair => pair.split("=>"))
} else {
  ()
}
#let filter_skill_value(value) = skill_replacements.fold(
  filtered_skill_value(value),
  (acc, pair) => acc.replace(pair.at(0).trim(), pair.at(1).trim()),
)

// Comma-separated Experience block labels to omit for one application, e.g.
// `--input exclude_projects=IDeaS` (labels: IDFC Bank, IDFC Bank Credit Cards, IDeaS).
#let exclude_projects_raw = sys.inputs.at("exclude_projects", default: "")
#let exclude_projects_list = if exclude_projects_raw != "" {
  exclude_projects_raw.split(",").map(s => s.trim())
} else {
  ()
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
//
// The current profile carries three IDFC blocks instead of two, so its leading
// and block spacing are tighter than the original pair. Font size and margins
// are unchanged. "legacy" keeps 0.54 / 0.83 — the values every previously sent
// resume was built with.
#let default_leading = if profile == "legacy" { "0.54" } else { "0.59" }
#let default_spacing = if profile == "legacy" { "0.83" } else { "0.84" }
#let font_size = float(sys.inputs.at("font_size", default: "9")) * 1pt
#let page_margin = float(sys.inputs.at("margin", default: "0.9")) * 1cm
#let par_leading = float(sys.inputs.at("leading", default: default_leading)) * 1em
#let spacing_scale = float(sys.inputs.at("spacing_scale", default: default_spacing))

// Which resume variant to render -- one of "unified" (default), "backend", or "ai".
// All three variants share the exact same facts, metrics, dates, and ownership
// claims from this one file -- only headline, summary, and skills ordering
// change per variant. Pass `--input variant=backend` or `--input variant=ai`.
// `unified` is the single-upload default for Naukri/Instahyre-style platforms.
#let variant = sys.inputs.at("variant", default: "unified")

// Default job title per variant, used when job_title_override is empty.
#let default_job_titles = (unified: "Software Engineer", backend: "Software Engineer", ai: "AI Engineer")
#let job_title = if job_title_override != "" {
  job_title_override
} else {
  default_job_titles.at(variant, default: "Software Engineer")
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

// Two skill terms that belong only to the AI performance-engineering platform,
// so they appear only when that block is rendered. Empty otherwise, keeping
// every other build unchanged.
#let perf_ai_ai_skill = if include_perf_ai { ", Multi-Agent Systems" } else { "" }
#let perf_ai_db_skill = if include_perf_ai { ", Amazon OpenSearch" } else { "" }

// Skills -- the actual content lives here, once, regardless of variant.
// `perf_ai_ai_skill` / `perf_ai_db_skill` append the two platform-only terms, so
// they appear only in builds that actually render that block.
#let skill_categories = (
  "Languages": "Java, Go (Golang), Python",
  "Frameworks": "Spring Boot, FastAPI, Hibernate, Gin, GORM",
  "Distributed Systems & Messaging": "Microservices, Distributed Systems, REST APIs, gRPC, Kafka",
  "Databases & Caching": "Oracle, Redis, Elasticsearch" + perf_ai_db_skill,
  "AI/LLM Engineering": "LLM Integration (Claude), RAG, Embeddings/Vector Search, LangChain, LangGraph, LlamaIndex, Agentic Workflow Design, Prompt Engineering, Temporal" + perf_ai_ai_skill,
  "AI-Assisted Development": "GitHub Copilot, Claude, Minimax",
  // Git is folded in here rather than owning a "Version Control" category, which
  // would otherwise print a line holding a single word.
  "DevOps & Cloud": "Docker, Kubernetes, AWS (EC2, S3, EKS), CI/CD (Jenkins, GoCD), Git",
  "Testing": "JUnit, Mockito, Jest, Testify/gomock",
  "Problem Solving": "Data Structures & Algorithms, Multithreading, Design Patterns, System Design, Agile (Scrum, XP)",
)

// Only the ORDER of categories changes per variant -- the category names and
// their contents are identical across all three, so there is exactly one
// place to update a skill and no risk of the variants drifting apart.
#let backend_first_order = ("Languages", "Frameworks", "Distributed Systems & Messaging", "Databases & Caching", "DevOps & Cloud", "AI/LLM Engineering", "AI-Assisted Development", "Testing", "Problem Solving")
#let skill_order = (
  unified: backend_first_order,
  backend: backend_first_order,
  ai: ("AI/LLM Engineering", "AI-Assisted Development", "Languages", "Frameworks", "Distributed Systems & Messaging", "Databases & Caching", "DevOps & Cloud", "Testing", "Problem Solving"),
)
// Alternate skills layout for JDs whose own vocabulary differs from the default
// category names. Same confirmed skills, regrouped and renamed into ATS-friendly
// categories, e.g. `--input skills_layout=ai_platform`. The "default" layout
// leaves every existing build unchanged.
#let skills_layout = sys.inputs.at("skills_layout", default: "default")
#let skills_alt_categories = (
  "Programming Languages": "Java, Python, Go (Golang), TypeScript",
  "Backend Engineering": "Spring Boot, Spring MVC, REST API Design, FastAPI, Hibernate, Temporal, Multithreading & Concurrency",
  "Generative AI & RAG": "RAG, Embeddings & Vector Search, LangChain, LangGraph, LlamaIndex, Agentic Workflow Design, Prompt Engineering, LLM Integration (Claude)" + perf_ai_ai_skill,
  "Distributed Systems & Messaging": "Microservices, Event-Driven Architecture, Kafka, gRPC, REST APIs",
  "Databases & Caching": "Oracle, Redis, Elasticsearch, PostgreSQL (pgvector)" + perf_ai_db_skill,
  "Cloud, DevOps & CI/CD": "Docker, Kubernetes, AWS (EC2, S3, EKS), Jenkins, GoCD",
  "Frontend Development": "Next.js (React), TypeScript",
  "Testing & Engineering Practices": "JUnit, Mockito, Jest, Testify/gomock, System Design, Design Patterns, Agile (Scrum, XP), Code Review",
)
#let skills_alt_order = ("Programming Languages", "Backend Engineering", "Generative AI & RAG", "Distributed Systems & Messaging", "Databases & Caching", "Cloud, DevOps & CI/CD", "Frontend Development", "Testing & Engineering Practices")
#let use_alt_skills = skills_layout == "ai_platform"
#let ordered_keys_all = if use_alt_skills { skills_alt_order } else { skill_order.at(variant, default: skill_order.unified) }
#let active_skill_categories = if use_alt_skills { skills_alt_categories } else { skill_categories }
#let ai_skill_keys = ("AI/LLM Engineering", "Generative AI & RAG")
#let ordered_keys = ordered_keys_all.filter(key =>
  (include_ai_initiative or not ai_skill_keys.contains(key)) and not exclude_categories_list.contains(key)
)
#let base_skills = ordered_keys.map(key => (key, filter_skill_value(active_skill_categories.at(key))))
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
  unified: job_title + "  |  Java · Python · Go · Distributed Systems · AI Engineering",
  backend: job_title + "  |  Java · Go · Distributed Systems · Microservices",
  ai: job_title + "  |  LLM Agents · RAG · Agentic Workflows · Java/Go Backend",
)
#let summaries = (
  unified: job_title_lower + " with 4+ years at ThoughtWorks, building distributed systems and event-driven microservices in Java, Python and Go for BFSI and enterprise platforms, with deep experience in Kafka, Redis, and production reliability. Complementing this, I design LLM-powered agents using retrieval-augmented generation and agentic workflows to automate real engineering problems. Comfortable across the full lifecycle, from distributed-systems architecture to cloud-native deployment on AWS and Kubernetes.",
  backend: job_title_lower + " with 4+ years at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go for BFSI and enterprise platforms, with deep experience in Kafka, Redis, and production reliability. Experienced across the full lifecycle, from distributed-systems architecture and observability to cloud-native deployment on AWS and Kubernetes, with additional hands-on experience building LLM-powered agents.",
  ai: job_title_lower + " with hands-on experience designing and building LLM-powered agents, applying retrieval-augmented generation and agentic workflows (LangGraph, LangChain) to automate real engineering problems such as " + (if profile == "legacy" { "microservice contract-drift detection" } else { "multi-agent software performance engineering" }) + ". Grounded in 4+ years of backend engineering at ThoughtWorks, building distributed systems and event-driven microservices in Java and Go, with deep experience in Kafka, Redis, and production reliability at BFSI scale.",
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

// IDFC Bank's AI performance-engineering platform. Rendered as its own block
// under the ThoughtWorks/IDFC entry when `include_perf_ai=true`. Ownership here
// is deliberately scoped to implementation and orchestration of the multi-agent
// system, not to the platform architecture as a whole.
#let perf_ai_entry = (
  project: "IDFC Bank - AI Performance Engineering Platform",
  points: (
    [Implemented and orchestrated a production-grade multi-agent platform automating software performance engineering. Seven specialized agents, coordinated by a central LangGraph orchestrator, cover profiling ingestion, bottleneck detection, code investigation, root-cause analysis, optimization, validation and reporting.],
    [Built the stateful orchestration layer using LangGraph StateGraph, enabling shared workflow state, conditional routing, inter-agent context passing, parallel execution and checkpoint-based recovery of long-running investigations. Integrated LlamaIndex RAG pipelines with Amazon OpenSearch Service, indexing source-code context, performance anti-patterns and historical findings to enable evidence-based agent reasoning.],
    [Implemented a persistent session store using AWS DynamoDB to retain agent interactions, workflow states and execution history, enabling session continuity and historical analysis. Integrated LangSmith for agent tracing and evaluation, monitoring execution flows, identifying failures and assessing output quality.],
    [Integrated LLM-driven analysis of profiling data, flame graphs and execution traces to identify CPU hotspots, memory pressure and lock contention. Validated optimizations using existing test suites, deterministic canary-versus-baseline telemetry and human-reviewed pull requests.],
    [Tech Stack: Python, FastAPI, LangGraph, LlamaIndex, Amazon OpenSearch Service, AWS DynamoDB, LangSmith, RAG, Multi-Agent Systems, Next.js (React), CI/CD.],
  ),
)
#let perf_ai_entries = if include_perf_ai { (perf_ai_entry,) } else { () }

// The three IDFC engagement blocks, kept separate so their ORDER can follow the
// content profile. Current: AI performance-engineering platform first, then the
// credit-card issuance work, then the release/config platform. Legacy keeps the
// pre-2026-11-07 order for resumes that have already been sent.
#let platform_entry = (
  // The bare "IDFC Bank" label made sense when it was the only IDFC block; with
  // three blocks in the current profile it needs to say which platform it is.
  // "legacy" keeps the original label so old builds stay identical.
  project: if profile == "legacy" { "IDFC Bank" } else { "IDFC Bank - Release Engineering Platform" },
  points: (
    [Contributed to building a large-scale distributed #pick((golang: "Go-based", java: "Java, Spring Boot based")) configuration and deployment platform for 98 microservices, replacing manual, fragmented config changes that risked outages. Added Redis caching, versioned configs, Kafka-driven rollouts, and automated Conftest/Pact/Helm validation, *reducing configuration time by 60%, database queries by 85% on systems processing 10M+ daily transactions, and increasing adoption by 65%*.],
    // The three bullets below are kept only for the "legacy" content profile, so the
    // resumes already sent to employers still rebuild with them. The current profile
    // drops them: they made the block cramped, and the OpenTelemetry / MTTD / MTTR
    // story is already carried by the JD-tailored summaries.
    ..(if profile == "legacy" { ([
      Led observability and release-safety modernization across a polyglot stack running Go, Java, and Node.js, replacing fragmented tracing and slow policy validation that were raising production risk. Migrated tracing to OpenTelemetry, added a region-aware Kafka client for disaster recovery, and shifted Conftest validation to run per service, *reducing validation time from 40 to 3 minutes, MTTD by 70%, and MTTR by 45%*.
    ],) } else { () }),
    [Designed and implemented the #pick((golang: "Go-based", java: "Java-based")) authentication middleware in front of an MCP (Model Context Protocol) server, so AI-assisted development tools reach the configuration platform only through an authenticated path. The tool layer translates agent requests into platform API calls, and every resulting change still passes the human approval gate before it is applied.],
    ..(if profile == "legacy" { ([
      Manual DR execution required multiple infrastructure and service-level steps, increasing recovery time. Automated the existing DR runbook for the distributed platform through Helm and CI/CD, provisioning Kafka in parallel with Redis, Prometheus, and networking, then orchestrating a controlled StatefulSet cutover, *completing failover in 12 minutes*.
    ], [
      The platform's feature-flag tooling required migration from Unleash v6 to v7 alongside a breaking CommonJS-to-ESM change. Independently led the migration and resolved compatibility issues across dependent services, *completing the upgrade without disruption to 98 services*.
    ]) } else { () }),
    [Configuration changes depended on ServiceNow webhook notifications, creating a risk of missed updates when webhooks failed. Implemented a webhook and reconciliation pattern with a periodic job that independently re-polls approval status, ensuring configuration changes are not missed due to dropped webhook events.],
    [Manual migration of on-premises artifact repositories to the cloud was estimated at 10 repositories and 5 services per day. Used a self-hosted Minimax LLM, deployed by another team, to generate and validate migration scripts, *migrating 250 repositories and their deployed services to the cloud in 4-5 days, roughly 5x faster for repositories and 2.4x faster for services than the manual estimate*.],
    [Tech Stack: Go, Java, Spring Boot, Oracle, Redis, Kafka, Kubernetes, AWS, Helm, Prometheus, OpenTelemetry, ServiceNow.],
  ),
)

#let cards_entry = (
  project: "IDFC Bank Credit Cards",
  points: (
    [Contributed to integrating RuPay into a credit card issuance platform supporting *3 card networks (Visa, Mastercard, and RuPay)*, handling 10K to 100K issuance requests monthly while preserving existing network flows.],
    [Owned the issuance-correctness and retry-recovery path for the new network integration, load-testing it to 10 to 50 RPS peak throughput at p95 latency under 300 ms and p99 under 800 ms, sustaining an issuance success rate above 99% for eligible requests.],
    [Implemented an idempotent issuance saga with durable checkpoints and lease-based recovery, per-BIN PAN allocation with database-enforced uniqueness, and a transactional outbox into Kafka with at-least-once delivery, consumer deduplication, and per-card event sequencing.],
    [Established safeguards against duplicate issuance and PAN allocation, recoverable interrupted workflows, and reliable downstream event processing through idempotent consumers and reconciliation, *while preserving backward compatibility for existing Visa and Mastercard issuance flows*.],
    [Tech Stack: Java, Spring Boot, Oracle, Kafka, Temporal, Unleash, Docker, Kubernetes, AWS, Redis, Prometheus, Grafana, OpenTelemetry.],
  ),
)

#let ideas_entry = (
  project: "IDeaS",
  points: (
    [The existing forecasting system generated month-wise forecasts, limiting the granularity of pricing analysis. Enhanced the Spring Boot forecasting service to support *day-wise forecasts with 30x finer granularity*, introducing additional calculation dimensions and Kafka-driven adjustments for incoming booking data.],
    [Delayed booking-data processing increased the time between pricing analysis cycles. Introduced Kafka-driven real-time data analysis capabilities, *reducing the time between two price-analysis cycles by 24 hours*.],
    [A monolithic architecture caused DB lock contention and limited parallel processing during peak loads. Contributed to the migration toward microservices using Spring MVC, enabling *parallel cross-service processing and reducing database lock contention*.],
    [Tech Stack: Java, Spring Boot, Spring MVC, MS SQL, Kafka.],
  ),
)

#let idfc_all = if profile == "legacy" {
  (platform_entry,) + perf_ai_entries + (cards_entry, ideas_entry)
} else {
  perf_ai_entries + (cards_entry, platform_entry, ideas_entry)
}

#let idfc_entries = (
  idfc_all
    .filter(a => include_credit_cards or a.project != "IDFC Bank Credit Cards")
    .filter(a => include_ideas or a.project != "IDeaS")
    .filter(a => not exclude_projects_list.contains(a.project))
)

#let experiences = (
  (
    designation: if job_title_override != "" { job_title_override } else { "Software Engineer" },
    company: "ThoughtWorks Technologies - Bangalore",
    location: "Bangalore",
    start: "July 2022",
    end: "Present",
    achievements: cards_to_front(idfc_entries),
  ),
)


// ChainReact's data; folded into the ThoughtWorks block in main.typ rather
// than rendered as its own section.
#let projects = (
  (
    name: "ChainReact",
    subtitle: "Global ThoughtWorks AI/works Hackathon 2026",
    points: (
      [Designed and built an autonomous LLM agent that detects microservice contract drift, replacing manual review that let silent schema and semantic mismatches reach production. Runs deterministic rules over a tree-sitter AST extraction of each service's API beliefs, then escalates ambiguous cases to LLM semantic analysis grounded by a LlamaIndex RAG pipeline over embedded specs and documentation, using embeddings and vector search instead of raw prompt stuffing.],
      [Re-architected the agent's orchestration layer from Temporal into LangGraph/LangChain, so detection, RAG grounding, and fix generation compose and retry as independent workflow steps. Auto-generates human-reviewable fix PRs through the GitHub API, routing low-confidence findings to human-in-the-loop approval so fixes land inside the existing code-review process rather than bypassing it, *cutting time-to-detect from days to under 2 minutes and time-to-fix from hours to under 5 minutes, scaling linearly from 4 to 400 services*.],
      [Developed during an internal ThoughtWorks AI/works hackathon. The initiative was subsequently adopted into the AI/Works stack.],
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

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
#let skills = (
  "Languages": "Java, Golang, SQL",
  "Frameworks": "Spring Boot, Spring Security, Hibernate, Node.js, Gin, GORM",
  "APIs & Messaging": "REST APIs, gRPC, Kafka",
  "Databases & Caching": "PostgreSQL, Oracle, Redis, Elasticsearch",
  "DevOps & Cloud": "Docker, Kubernetes, AWS, CI/CD",
  "Testing": "JUnit, Mockito, Jest, Testify/gomock",
  "Version Control": "Git",
  "Problem Solving": "Data Structures & Algorithms, System Design",
)

// Header related information
#let details = (
  name: "Sukesh Seth",
  tagline: "Software Engineer  |  Java · Golang · Spring Boot · Gin · Microservices",
  summary: [Software engineer with 4+ years at ThoughtWorks, owning distributed systems and microservices end-to-end for BFSI and enterprise platforms, from architecture through production reliability. Works primarily in Java, Golang and Node.js, with depth in Kafka-driven event systems, Redis caching, Kubernetes/Helm deployments and cloud-native observability. Comfortable working across the full backend lifecycle -- from development and testing to debugging and monitoring.],
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
          [Config and deployment platform: manual, fragmented config changes across 98 microservices were slowing releases and risking avoidable outages.],
          [As a founding senior contributor on a 5-engineer team, helped design and deliver a centralized deployment-variable and configuration-management platform (Golang, Oracle) to fix this.],
          [Personally drove implementation of Redis-backed caching for authorization lookups, versioned config records with full change history, Kafka-driven automated rollout of config-change events and an automated release pipeline (conftest, Pact, Helm) governed by a ServiceNow approval workflow.],
          [Designed and built a Golang auth middleware for an MCP server, exposing the config platform to AI-assisted tools.],
          [Delivered 60% less manual config time, 85% fewer DB permission-check queries on systems processing 10M+ daily transactions and 65% platform adoption growth within one quarter.],
          [Observability and release safety: fragmented tracing and slow policy validation were increasing production risk across a polyglot microservices stack.],
          [Owned the modernization of observability and release-safety practices for the platform.],
          [Migrated tracing and metrics from OpenCensus to OpenTelemetry across Go, Java and Node.js, introduced a region-aware Kafka client mode for the Kafka-less DR region, left-shifted conftest validation to per-service checks across 98 services biweekly and hardened secrets handling with audit logging.],
          [Automated disaster-recovery failover by integrating an existing runbook into our Helm tooling with a CI/CD pipeline, provisioning Kafka in parallel (bridged by no-op stubs until ready) alongside Redis, Prometheus and networking, then switching services active with controlled scale-down/up of deployments and StatefulSets in 12 minutes.],
          [Cut policy-validation runtime from 40 minutes to 3 minutes, reduced MTTD by 70% and MTTR by 45%, with zero severity-1 outages since rollout.],
        ),
      ),
      (
        project: "IDeaS",
        points: (
          [Transformed forecasting feature from month-wise to day-wise forecasts (30x finer granularity) using Spring Boot and MS SQL, adding new calculation dimensions and Kafka-driven adjustments for incoming booking data.],
          [Introduced real-time data analysis capabilities using Kafka, reducing price analysis time between two cycles by 24 hours.],
          [Played a key role in monolith-to-microservices migration using Spring MVC, enabling parallel cross-service processing and easing DB lock contention observed under peak load.],
        ),
      ),
    ),
  ),
  (
    designation: "Software Development Intern",
    company: "HighRadius Corporation - Remote",
    location: "Remote",
    start: "July 2021",
    end: "May 2022",
    achievements: (
      [Built a LightGBM model (80% accuracy) to predict invoice payment delays, paired with a ReactJS dashboard for invoice details.],
      [Engineered the backend with Spring, Hibernate and MySQL, helping the business flag high-risk accounts early.],
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

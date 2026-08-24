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
  summary: [Software engineer with 4+ years at ThoughtWorks, owning distributed systems and microservices end-to-end for BFSI and enterprise platforms. Works primarily in Java, Golang and Node.js, with depth in Kafka-driven event systems, Redis caching, Kubernetes/Helm deployments, and cloud-native observability across the full backend lifecycle.],
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
          [Manual and fragmented configuration changes across 98 microservices increased operational effort and outage risk. Contributed to building a Java, Spring boot based configuration platform with Redis caching, versioned configurations, Kafka-driven rollouts, and automated Conftest/Pact/Helm validation, *reducing configuration time by 60%, database queries by 85%, and increasing adoption by 65%*.],
          [Fragmented tracing and slow policy validation created production and release risks across a polyglot stack. Led observability and release-safety improvements by migrating tracing to OpenTelemetry across Golang, Java, and Node.js, introducing a region-aware Kafka client for disaster recovery, and shifting Conftest validation to individual services, *reducing validation time from 40 to 3 minutes, MTTD by 70%, and MTTR by 45%*.],
          [The existing configuration platform needed secure access from AI-assisted development tools. Designed and implemented a Java based authentication middleware for an MCP server, enabling secure exposure of configuration-platform capabilities to AI-assisted tools.],
          [Manual DR execution required multiple infrastructure and service-level steps, increasing recovery time. Automated the existing DR runbook through Helm and CI/CD by provisioning Kafka in parallel with Redis, Prometheus, and networking, using no-op stubs until dependencies were ready, and orchestrating controlled deployment and StatefulSet scale-down/up, *completing failover in 12 minutes*.],
          [The platform's feature-flag tooling required migration from Unleash v6 to v7 alongside a breaking CommonJS-to-ESM change. Independently led the migration and resolved compatibility issues across dependent services, *completing the upgrade without disruption to 98 services*.],
          [Configuration changes depended on ServiceNow webhook notifications, creating a risk of missed updates when webhooks failed. Implemented a webhook and reconciliation pattern with a periodic job that independently re-polls approval status, ensuring configuration changes are not missed due to dropped webhook events.],
          [Tech Stack: Golang, Java, Spring Boot, Oracle, Redis, Kafka, Kubernetes, Helm, Prometheus, OpenTelemetry, ServiceNow.],
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
  (
    designation: "Software Development Intern",
    company: "HighRadius Corporation - Remote",
    location: "Remote",
    start: "July 2021",
    end: "May 2022",
    achievements: (
      (
        project: "Invoice Payment Risk Prediction",
        points: (
          [Businesses needed an early way to identify invoices likely to experience payment delays. Built a LightGBM-based prediction model with *80% accuracy* and developed a ReactJS dashboard for invoice details, with a Spring/Hibernate/MySQL backend, enabling earlier identification of high-risk accounts.],
          [Tech Stack: Python, LightGBM, ReactJS, Java, Spring, Hibernate, MySQL.],
        ),
      ),
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

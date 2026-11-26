# Resume

My resume, written in [Typst](https://typst.app) so the content lives in one
place and each application can be tailored from the same source.

## Build the resume

```console
typst compile src/main.typ build/sukeshResume.pdf
```

To recompile on every save:

```console
typst watch src/main.typ build/sukeshResume.pdf
```

Requirements: [Typst](https://github.com/typst/typst#installation) (0.15.x) and
the **Carlito** font.

If you have [Task](https://taskfile.dev) installed, `task build` and `task`
(build + watch) do the same thing.

## Where things are

| File | What it holds |
| --- | --- |
| `src/variables.typ` | All resume content — contact details, summary, experience, skills, education. **Edit this one for content.** |
| `src/main.typ` | Section order and what gets rendered. |
| `src/functions.typ` | Layout and styling. |

## Tailoring for a job

Everything is driven by `--input` flags, so the source never has to change:

```console
typst compile src/main.typ build/sukeshResume_acme.pdf \
  --input job_title="Senior Software Engineer" \
  --input tagline="Senior Software Engineer  |  Java · Spring Boot" \
  --input summary="..." \
  --input stack=java \
  --input spacing_scale=0.84
```

The flags used most often:

| Flag | Purpose |
| --- | --- |
| `job_title` | Job title used in the tagline and the ThoughtWorks role line. |
| `tagline`, `summary` | Replace the header tagline and summary for this build. |
| `variant` | `unified` (default), `backend` or `ai` — changes emphasis across the whole resume. |
| `stack` | `golang` (default) or `java` — which stack the IDFC platform is described with. |
| `spacing_scale`, `leading` | Tighter or looser vertical spacing, to keep the resume on one page. |
| `top_skills`, `extra_skills`, `exclude_skills` | Add or drop a Core Skills line and individual skill terms. |
| `exclude_categories`, `exclude_projects` | Drop whole skill categories or experience blocks. |
| `email`, `phone` | Per-application contact overrides. |

### Keeping it to one page

Three Experience blocks plus skills is a tight fit. If a build spills onto a
second page, reduce `spacing_scale` from its default `0.84`, stepping down by
`0.02` at a time. The standard resume builds at one page.

## Notes

- `build/` is a symlink to a folder outside the repo, and `*.pdf` is gitignored
  — PDFs are never committed.
- Generated PDFs are always named `build/sukeshResume.pdf` (or
  `build/sukeshResume_<tag>.pdf` for a tailored build).

## Credits and licence

Based on [Jarmos's Typst resume template](https://github.com/Jarmos-san/resume),
which in turn draws on the
[r/EngineeringResumes template](https://docs.google.com/document/d/1MBvhATv8y-ESORopRoLSZ3f3HjkM_Qa_f8fIHAEqgnI).

Licensed under [CC BY-NC 4.0](./LICENSE).

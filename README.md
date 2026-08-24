# Jarmos's Resume Template

This template repository contains the [Typst](https://typst.app) source code
used to build [my resume](https://github.com/Jarmos-san/resume). I prefer using
Typst over LaTeX due to its intuitive, Markdown-like syntax and the "coding
mode".

## Get Started

To get started with composing your resume using the same tools as I did in this
repository, follow these guidelines:

1. Fork the repository and clone it locally to your system.
2. Ensure Typst is installed and accessible (follow
   [the official installation guidelines](https://github.com/typst/typst?tab=readme-ov-file#installation)).
3. Run the relevant commands as a sanity check to identify whether tools are
   setup properly:

   ```console
   mkdir build
   typst compile ./src/main.typ ./build/sukeshResume.pdf
   ```

4. To compile and watch for changes at the same time, you can invoke the
   following command:

   ```console
   mkdir build
   typst watch ./src/main.typ ./build/sukeshResume.pdf
   ```

If you followed the steps properly until now and can verify the contents of the
PDF are as expected then you should proceed ahead to edit the source code with
your information.

1. Open the `./src/variables.typ` file which contains a bunch of variables
   related to your personal information such as your name, contact details, the
   alma mater, previous work experience and so on.

2. Once you have edited the file and replaced the contents with information
   about yourself, run the commands above to compile the resume's PDF.

3. With the PDF rendered, review it for correctness and then continue applying
   to the jobs of your choice!

For some guidance/tips and tricks to draft a good technical resume, check out my
write-up in the DevelopersIndia wiki -
[How to Create an Ideal Software Engineering Resume](https://wiki.developersindia.in/community-guides/how-to-create-an-ideal-software-engineering-resume).

## Attribution and Credits

Work on the resume would not have been possible without the help of the
following resources (and everyone else involved in the process):

- The
  [r/EngineeringResumes Resume Template](https://docs.google.com/document/d/1MBvhATv8y-ESORopRoLSZ3f3HjkM_Qa_f8fIHAEqgnI)
- The [r/developersIndia](https://www.reddit.com/r/developersIndia) subreddit
  for introducing me to Typst.

## Licensing and Distribution

The contents of this repository are licensed under the terms and conditions
(T&Cs) of CC BY-NC 4.0 and you are allowed to modify, copy and distribute the
contents under similar T&Cs. For more information on the licensing T&Cs, refer
to the [LICENSE](./LICENSE) document.

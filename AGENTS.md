# Agentic Development Guidelines

This repository contains the source code for a Curriculum Vitae (CV) built using LaTeX and the `awesome-cv` class. These guidelines are intended for AI agents and developers to ensure consistency and correctness when modifying the CV.

## 1. Build, Test & Validation

### Core Build System
The project uses `make` to orchestrate the build process using `lualatex`.

*   **Build CV:** `make` (or `make cv.pdf`)
    *   *Under the hood:* Runs `lualatex cv.tex`.
    *   *Output:* Generates `cv.pdf`.
*   **Clean Artifacts:** `make clean`
    *   *Removes:* `cv.aux`, `cv.log`, `cv.pdf`, `cv.out`.
    *   *Usage:* Run this before a build if you suspect cached artifacts are causing issues.

### Containerized Environment
A `Dockerfile` is provided to ensure a consistent `texlive` environment, avoiding local dependency mismatches.

*   **Build Image:** `docker build -t cv .`
*   **Run Build in Container:** `docker run --rm -v "$(pwd):/var/cv" cv`
    *   This mounts the current directory, runs `make`, and leaves the artifact in your local folder.

### "Testing" & Validation Strategy
Since this is a document project, "testing" consists of ensuring the build completes without errors and the visual output is correct.

*   **Compilation Verification:**
    1.  Run `make`.
    2.  Check the exit code (0 means success).
    3.  If it fails, grep `cv.log` for lines starting with `!`.
*   **Single File Validation:**
    *   LaTeX cannot compile partial files (like `cv/experience.tex`) in isolation.
    *   To verify changes in a specific file:
        1.  Ensure it is included in `cv.tex` (e.g., `\input{cv/experience.tex}`).
        2.  Run the full build: `make`.
        3.  Check `cv.log` for specific errors related to that file.
*   **Visual Check:**
    *   There are no automated visual regression tests.
    *   Agents should output the text content they changed so the user can verify it against the PDF if necessary.

## 2. Code Style & Conventions

### Structure & File Organization
*   **Root:** `cv.tex` is the main entry point. It sets up the document class, personal data (name, email), and structure.
*   **Content Directory (`cv/`):** All content sections must reside here.
    *   `cv/experience.tex`: Work history.
    *   `cv/education.tex`: Academic background.
    *   `cv/skills.tex`: Technical and soft skills.
    *   `cv/projects.tex`: Side projects or open source work.
*   **Styles:** Custom styling is defined in `cv.cls`, which inherits from `awesome-cv/awesome-cv.cls`.
    *   Modify this file *only* if you need to change global fonts, colors, or section headers.

### LaTeX Coding Standards
*   **Imports:** Use `\input{cv/<filename>.tex}` to include sections in the main document.
    *   *Do not* use `\include` (it adds page breaks).
*   **Indentation:** Use **2 spaces** for indentation within environments.
*   **Line Breaks:** Keep source lines reasonably short (< 100 chars) where possible to avoid horizontal scrolling, but do not hard wrap paragraphs if it interferes with LaTeX flow.
*   **Comments:**
    *   Use `%` for comments.
    *   Comment out unused sections (like `\input{cv/honors.tex}`) rather than deleting them if they might be needed later.
    *   Do not leave commented-out blocks of old code unless explicitly requested for versioning.

### Naming Conventions
*   **Files:** All filenames should be lowercase kebab-case, e.g., `technical-skills.tex`, `work-experience.tex`.
*   **Custom Commands:** Defined in `cv.cls`. Follow `\camelCase` naming (e.g., `\entrytitlestyle`).

### Common Environments & Macros
*   **Entries (`cventry`):** Used for Experience and Education.
    ```latex
    \begin{cventry}
      {Job Title} % Job title
      {Company Name} % Organization
      {Location} % Location
      {Jan. 2020 - Present} % Date(s)
      {
        \begin{cvitems} % Description(s) of tasks/responsibilities
          \item {Accomplished X using Y technology.}
          \item {Led a team of Z engineers.}
        \end{cvitems}
      }
    \end{cventry}
    ```
*   **Skills (`cvskills`):** Used for listing skills.
    ```latex
    \begin{cvskills}
      \cvskill
        {Languages} % Category
        {Python, C++, JavaScript} % Skills
    \end{cvskills}
    ```
*   **Text Styling:**
    *   Use `\textbf{}` for bold (maps to `awesome` color by default in this class).
    *   Use `\textit{}` for italics.
    *   Use `\color{awesome}` for the accent color.

### Error Handling & Debugging
*   **Special Characters:** LaTeX requires escaping for specific characters. Faiure to do so is the #1 cause of build errors.
    *   `&` -> `\&` (Common in "R&D" or "AT&T")
    *   `%` -> `\%` (Common in "improved performance by 20%")
    *   `$` -> `\$` (Common in amounts)
    *   `_` -> `\_` (Common in variable names or URLs)
*   **Undefined Control Sequence:** If `make` fails with this error, you likely used a command not defined in `cv.cls` or the standard packages. Check for typos in macro names.

## 3. Workflow Examples

### Adding a New Job Experience
1.  Open `cv/experience.tex`.
2.  Locate the top of the `cventries` environment.
3.  Insert a new `\cventry` block.
4.  Ensure dates follow the existing format (usually `Mon. Year` or `Month Year`).
5.  Use `cvitems` for bullet points.
6.  Run `make` to verify syntax.

### Modifying the Accent Color
1.  Open `cv.cls`.
2.  Locate `\definecolor{color}{HTML}{...}` (around line 13).
3.  Change the HTML hex code.
4.  Run `make` to recompile with the new color palette.

### Troubleshooting a Build Failure
1.  Run `make`.
2.  If it fails, read the output. LaTeX errors usually look like:
    ```
    ! Misplaced alignment tab character &.
    l.45 ...mpany R&D department
    ```
3.  The `l.45` indicates the line number in the *source file* (or the intermediate `.aux` file).
4.  Fix the escaping issue (change `R&D` to `R\&D`).
5.  Run `make clean` then `make` again.

## 4. Maintenance

*   **Dependencies:** The project depends on a full TeX Live distribution. Avoid adding packages that are not standard in `texlive-full` unless absolutely necessary.
*   **Class Updates:** If modifying `cv.cls`, ensure backwards compatibility with existing content files.
*   **Generated Files:** Never commit `.pdf`, `.log`, `.aux`, or `.out` files. Only commit source `.tex`, `.cls`, and config files.

# CV
:page_facing_up: CV based on Awesome CV LaTeX template

This repository contains a customizable CV/resume built using the [Awesome-CV](https://github.com/posquit0/Awesome-CV) LaTeX template, structured similarly to [OJFord/curriculum-vitae](https://github.com/OJFord/curriculum-vitae).

## Structure

- `cv.tex` - Main LaTeX document that includes all sections
- `cv.cls` - Custom class file with style modifications
- `awesome-cv/` - Git submodule containing the Awesome-CV template
- `cv/` - Directory containing individual section files:
  - `education.tex` - Education history
  - `skills.tex` - Technical and soft skills
  - `experience.tex` - Work experience
  - `awards.tex` - Awards and honors

## Getting Started

When cloning this repository, make sure to initialize the submodules:

```bash
git clone --recurse-submodules https://github.com/lourencobt/CV.git
```

Or if you've already cloned the repository:

```bash
git submodule update --init --recursive
```

## Customization

1. Edit `cv.tex` to update your personal information (name, title, contact details, etc.)
2. Modify the section files in the `cv/` directory with your own content
3. Adjust styling in `cv.cls` if needed

## Building

### Using Make (requires LaTeX)

```bash
make
```

### Using Docker

```bash
docker build -t cv-builder .
docker run --rm -v $(pwd):/var/cv cv-builder
```

### Clean Build Artifacts

```bash
make clean
```

## GitHub Actions

The repository includes a GitHub Actions workflow that automatically:
- Builds the CV on every push
- Uploads the PDF as an artifact
- Creates releases with the CV PDF on pushes to main/master branch

## Requirements

- LuaLaTeX or XeLaTeX
- Awesome-CV template dependencies (Roboto fonts, Source Sans Pro, FontAwesome6)

## License

Your CV content is your own. The Awesome-CV template is licensed under the LaTeX Project Public License.

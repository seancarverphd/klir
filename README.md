# klir

**KLI in R (Kullback-Leibler Interactive)**  
Computes the number of samples needed for confidence in model selection.

**Author:** Sean Carver, PhD (Applied Mathematics, Cornell; Professorial Lecturer, American University)  
**License:** GPL-3.0

---

## Project Summary

This package implements a simulation-based method for determining how many data samples are needed to correctly select a true model over an alternative, with a specified level of confidence (e.g., 95%). The method uses Kullback-Leibler divergence as its theoretical foundation and bootstrapped log-likelihood ratios to determine the required sample size via quantile regression.

The methodology was presented at the **Joint Statistical Meetings (JSM), August 2017**. The repository includes the conference proceedings paper, the JSM talk slides, a tutorial, and the full R implementation.

---

## JSM 2017 Conference Paper

**"Number of Samples Needed For Model Selection With Confidence"**  
Sean G. Carver, Ph.D.  
*Joint Statistical Meetings Proceedings, 2017*

- [Download PDF](CarverJSM2017.pdf)
- [Google Scholar entry](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=khxzFsAAAAAJ&citation_for_view=khxzFsAAAAAJ:9yKSN-GCB0IC)

---

## Skills and Tools Demonstrated

- **Statistical methodology:** Kullback-Leibler divergence, bootstrapped log-likelihood ratios, quantile regression for sample size determination, sequential hypothesis testing
- **Reproducible research:** Conference paper in knitr/LaTeX (`.Rnw`, Sweave), talk slides in knitr/R Markdown (`.Rmd`), rendered to PDF via `make`
- **Build automation:** Makefile for fully reproducible compilation of paper and slides from source
- **Visualization:** Word clouds of baseball Markov chain states and transitions as motivating application
- **Simulation:** Monte Carlo simulation of model selection procedures (`simulation.R`)
- **Languages / tools:** R, knitr, R Markdown, LaTeX, Sweave, Make, BibTeX

---

## Key Findings

- Proposes a practical alternative to raw KL divergence: the **number of samples needed** to reject an alternative model with a specified confidence level
- Method proceeds by: (1) simulating samples from the true model, (2) computing log-likelihood ratios, (3) bootstrapping their sum, (4) using quantile regression to find the sample size where the desired quantile crosses zero
- Validated on t-distributions of varying degrees of freedom
- Applied to baseball Markov chains: "How many innings are needed to falsify a model of the Yankees when simulating a model of the Orioles?"

---

## Repository Structure

```
klir/
├── kli.R              # Core KLI computation
├── simulation.R       # Monte Carlo simulation
├── JSMtalk.Rmd        # JSM 2017 conference talk (ioslides)
├── JSMpaper.Rnw       # JSM 2017 proceedings paper (knitr/LaTeX)
├── CarverJSM2017.pdf  # Compiled conference paper (PDF)
├── tutorial.Rmd       # Tutorial for the method
├── Makefile           # Build automation
├── refs.bib           # Bibliography
├── eg.R               # Example usage
├── reps.R             # Repetitions helper
├── wcloud.R           # Word cloud visualization
├── StateWordCloud.png       # State word cloud figure
├── TransitionWordCloud.png  # Transition word cloud figure
├── State0Transitions.png    # State transition diagram
└── README.md
```

---

## How to Build

```bash
# Compile paper and talk slides from source:
make

# Or run the core method directly:
source("kli.R")
```

Requires R with packages: `knitr`, `quantreg`, and dependencies listed in `JSMpaper.Rnw`.

---

## Data

Baseball data required for the motivating application is sourced from [https://github.com/maxtoki/baseball_R/](https://github.com/maxtoki/baseball_R/).  
Place `fields.csv` and `all20011.csv` in a `data/` directory before running.

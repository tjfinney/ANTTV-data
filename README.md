## ANTTV.data

This is one of a set of repositories relating to analysis of New Testament textual variation:

[ANTTV.book](https://github.com/tjfinney/ANTTV.book)
: A book on analysis of New Testament textual variation.

[ANTTV.code](https://github.com/tjfinney/ANTTV.code)
: Computer programs written in *R* (*a free software environment for statistical computing and graphics*) to analyse data relating to New Testament Textual variation.

[ANTTV.data](https://github.com/tjfinney/ANTTV.data)
: Data relating to New Testament textual variation.

[How to discover textual groups](https://www.digitalstudies.org/article/id/7324/) provides an introduction to the analysis techniques.

## Data sets

The data sets are comprised of data matrices and distance matrices compiled from numerous sources such as critical editions, monographs, dissertations, and online data repositories. Data matrices are comprised of rows for textual witnesses (e.g. Greek manuscripts, lectionaries, early versions, patristic citations) and columns for readings (represented by numeric or alphabetic codes) at variation sites (i.e. places where the witnesses have varying textual states). Distance matrices are derived from published tables of percentage agreements by converting each percentage agreement to a distance using this formula:

Distance = 1 - (percentage agreement / 100)

## Sources

Please see table 2 of [Views of New Testament Textual Space](https://www.tfinney.net/Views/index.xhtml) for information on the sources of these data sets.

## Mirrors

A number of the data sets are mirrored at the following Zenodo repositories:

* [Data matrices](https://zenodo.org/record/4064629)
* [Distance matrices](https://zenodo.org/record/4064631)

## Getting started

1. Install [R](https://cran.r-project.org/doc/FAQ/R-FAQ.html#How-can-R-be-installed_003f) on your computer
2. [Optional] To make life far easier, install the [RStudio IDE](https://posit.co/download/rstudio-desktop/) on your computer
3. Install the `ANTTV.code` package
4. Use the programs in the package to analyse the data.

## Installation


## Doing analysis

To do analysis on these data sets, first install [R](https://cran.r-project.org/doc/FAQ/R-FAQ.html#How-can-R-be-installed_003f) on your computer. (The [RStudio IDE](https://posit.co/downloads/) provides a great environment for working with *R*.) Once *R* is installed, install the *devtools* package then install the *ANTTV.code* package from [GitHub](https://github.com/) by entering the following commands at the *R* prompt:

``` r
install.packages("devtools")
devtools::install_github("tjfinney/ANTTV.code")
```

Once the `ANTTV.code` package is installed, a data set can be loaded and analysed as follows:

``` r
library(ANTTV.code)
read_data_frame("data/Acts.UBS5.csv") |> do_reduction() |> do_dist() |> do_NJ()
```

Output can be saved as outlined in the *Saving results* section of the [ANTTV.code Readme](https://github.com/tjfinney/ANTTV.code#saving-results). For example:

``` r
read_data_frame("data/Acts.UBS5.csv") |> do_reduction() |> do_dist() |> do_PAM(fn="output/PAM/Acts.UBS5.txt", write=TRUE)
```

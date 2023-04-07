# Introduction

*ANTTV data* is one of three repositories relating to analysis of New Testament textual variation:

[ANTTV book](https://github.com/tjfinney/ANTTV-book)
: A book on analysis of New Testament textual variation.

[ANTTV code](https://github.com/tjfinney/ANTTV-code)
: Computer programs to analyse data relating to New Testament Textual variation. These programs are written in *R* (*a free software environment for statistical computing and graphics*).

[ANTTV data](https://github.com/tjfinney/ANTTV-data)
: Data relating to New Testament textual variation.

Please see [How to Discover Textual Groups](https://www.digitalstudies.org/articles/10.16995/dscn.291/) for an introduction to the analysis techniques.

# Data sets

The data sets are comprised of data matrices and distance matrices compiled from numerous sources such as critical editions, monographs, dissertations, and online data repositories. Data matrices are comprised of rows for textual witnesses (e.g. Greek manuscripts, lectionaries, early versions, patristic citations) and columns for readings (represented by numeric or alphabetic codes) at variation sites (i.e. places where the witnesses have varying textual states). Distance matrices are derived from published tables of percentage agreements by converting each percentage agreement to a distance using this formula:

Distance = 1 - (percentage agreement / 100)

# Sources

Please see table 2 of [Views of New Testament Textual Space](https://www.tfinney.net/Views/index.xhtml) for information on the sources of these data sets.

# Mirrors

A number of the data sets are mirrored at the following Zenodo repositories:

* [Data matrices](https://zenodo.org/record/4064629)
* [Distance matrices](https://zenodo.org/record/4064631)

# Doing analysis

To do analysis on these data sets, open an *R* session and install the `devtools` and `ANTTV.code` packages. (The [RStudio IDE](https://posit.co/downloads/) provides a great environment for working with *R*.)

``` r
install.packages("devtools")
devtools::install_github("tjfinney/ANTTV-code")
```

Once the `ANTTV.code` package is installed, a data set can be loaded and analysed:

``` r
library(ANTTV.code)
read_data_frame("data/Acts.UBS5.csv") |> do_reduction() |> do_dist() |> do_NJ()
```



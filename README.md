ECR Poster LateX Document Class
===============================

Introduction
------------

This LateX document class provides a basic framework with which to create
Edinburgh Centre for Robotics (ECR) branded posters with. It makes use of
the TikZPoster (see [CTAN][0]) at its base and builds on top of it.

More information about the ECR is available on their [website][1].

Usage
-----

This is a drop-in document class that you can use right away. It makes use of
the TikZPoster document class, and so depends on the TikZPoster package - make
sure this and all its dependencies are installed (more info at [CTAN][0]).

1. Add the `ecrposter.cls` file to your work directory
1. In your new LaTeX document, set your document class to `ecrposter`. The
   options supported by the document class are identical to that used by
   TikZPoster, so have a look at their [documentation][0] for possible
   options.<br/> *The default options are:* `17pt`, `a1paper`, and `landscape`
1. Populate the title information by executing the `\title`, `\author`, and
   `\institute` macros
1. Within the `\begin{document} ...` environment call the `\maketitle` macro to
   generate the title
1. Populate the document with your content :D

Contributors
------------

- [Hans-Nikolai Viessmann](https://github.com/hv15)
- [@wxmerkt](https://github.com/wxmerkt)

*More to follow...*

License
-------

Though this document class is accessible to the public, the logos of the
Edinburgh Center for Robotics (ECR), Heriot-Watt University, The University of
Edinburgh, and The Engineering and Physical Sciences Research Council
(EPSRC) are their property and must only be used in accordance with their
regulations.

**The licensing of this document class is yet to be determined, copyright is
held by the ECR.**

Extras
------

### SVG to PDF

Evidently, this is not trivial as most of the tools that exist to do this
(InkScape, Adobe Illustrator, etc.) will tend to rasterise parts of the SVG
in the process of converting it. This can contribute to an increase in file
size as well, and more importantly, a decrease in quality.

One solution that we've found to solve this is to use the [cairo][2] and 
[libzsvg][3] libraries to do the conversion - they avoid the aforementioned
problems (mostly). The tool to do this is either [svg2pdf][4] or
[svgconvert][5]. You'll need to compile the tool yourself, ensuring that all
dependencies are met.

### Detecting rasterised content in PDF files

Depending on what tool suite is used to generate a PDF file, it may opt to
generate bitmaps/lossy versions of any vector graphics. This leads to bad
visual scaling of the PDF. There are several ways of determining whether a
PDF contains rasterised content or not.

1. Visually check the PDF by zooming in and out of parts of the document to see
   if anything is pixelated or not.
1. Search the PDF file for the `/image` token: `grep -c -i "/image"
   PDF-FILE.pdf`.
1. Use a tool like `pdfimages` to list/extract any bitmaps from the PDF:
   `pdfimages -list PDF-FILE.pdf`

[0]: https://www.ctan.org/pkg/tikzposter "CTAN: TikZPoster LateX package"
[1]: http://www.edinburgh-robotics.org/ "Edinburgh Centre for Robotics website"
[2]: http://cairographics.org/ "Cairo Graphics library"
[3]: https://wiki.gnome.org/action/show/Projects/LibRsvg "librsvg library"
[4]: http://cgit.freedesktop.org/~cworth/svg2pdf/ "svg2pdf tool"
[5]: http://blog.mathieu-leplatre.info/static-build-of-cairo-and-librsvg.html "svgconvert tool"

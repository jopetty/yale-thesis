# yale-thesis
A LaTeX Class for typesetting a doctoral dissertation for the Yale University Graduate School of Arts and Sciences

## Goals
This class was made to be:
* Conformant to the Yale GSAS formatting guidelines.
* A `LaTeX3` programming exercise. This class is programmed using `expl`.

## Usage
### Version Control
It is _highly_ recommended that you use a version control system, such as GitHub, while writing your thesis --- this lets you track and revert changes and means that you have a backup online. If you already use GitHub, fork this repository to your own account. If you don't want to use GitHub, clone this repository.

### Directory Structure
Once you have a copy of this respository, your directory should look something like this:
```
$ tree
.
├── LICENSE
├── README.md
├── content
│   └── 0-abstract.tex
├── example
│   ├── content
│   │   └── 0-abstract.tex
│   ├── draft.pdf
│   ├── draft.tex
│   ├── main.pdf
│   └── main.tex
├── main.tex
└── yale-thesis.cls

4 directory, 10 files
```

You can ignore the `example/` directory --- this just contains example documents to demonstrate what thesis and draft thesis look like. 

The `content/` directory is where you will put all of your thesis chapters and the abstract, which is already included in the file `content/0-abstract.tex`. It's recommended to use a similar formatting scheme for the rest of your chapters: `content/#-name`, where `#` is the chapter number and `name`, the chapter name. This ensures that all the files will be presented in the order in which they appear in your document, making it much easier to find and edit specific chapters. Putting each chapter in its own file makes it easier to edit, revise, and revert changes you make as writing progresses.

### Adding chapters
To add chapters to your thesis, open `main.tex` and, below the line reading `%% Include your chapters here`, place the following line:
```tex
%% main.tex
...

%% Include your chapters here
\include{content/#-name.tex}

...
```
Do this for each chapter in your thesis.

### External Resources
If you have extra resources to include in your thesis --- images, code, figures, etc. --- you can optionally create a new directory named `resources/` and use it to store all the extra files so they don't clutter the main directory. Then, use the command
```tex
\input{resources/file.ext}
```
to place `file.ext` into your document.

### Compilation
`yale-thesis` has been tested with `pdflatex` and `xelatex`. `pdflatex` is likely the best TeX engine to use, unless you require unicode compatability, are writing multiple languages, or want to use custom fonts.

While you are still editing your thesis, it may be helpful to mark the output document with the current draft that you are working on, so that you can quickly reference different printed or PDF versions of your thesis. To do so, pass the `draft` option to the `yale-thesis` class as shown below in `main.tex` (note that this is the default behavior):
```tex
%% main.tex
\documentclass[draft]{yale-thesis}

...
```
To remove the draft heading, remove the `draft` option from `main.tex`.

## Specifications
A summary of the [Guide to Formatting the Doctoral Dissertation](http://gsas.yale.edu/sites/default/files/formatdissertation.pdf) by the Yale University GSAS.

### Typing
All text must be double spaced on one side of the page. Footnotes, bibliographic references, and long quotations may be double single spaces, but double spacing must be used between successive entries.

### Margins
There must be a 1.5-inch margin on the binding edge (usually the left side) and a 1-inch margin on the three remaining edges. These margins apply to full-page photographs and pages containing charts, tables, illustrations, the abstract, title page, and all pages of text.

### Page Numbers
Page numbers must be located at least 0.5 inches from any edge. Page numbers can be centered at the top or bottom, or placed in the upper right-hand corner. It is customary not to have a page number at the top of a page containing a chapter heading; instead, it may be placed in the lower right-hand corner, centered at the bottom of the page, or omitted entirely.

### Print Size
The document should be typeset with 10-12pt font.

### Citation Style
Yale does not require any specific citation style to be used for references and bibliographic entries. Students should choose a style that is in accordance with their discipline and the reccomendations of their thesis committee or department.

### Abstract
An abstract not exceeding 750 words is required. It should immediately precede the title page, and be formatted as follows:
```TeX
%% Centering
[Abstract]
[Full title of dissertation]
[Author's full name]
[Year of PhD Award]
```

### Title Page
Prepare the title page according to the sample below. The title of the dissertation should be as concise as possible, consistent with giving an accurate description of the thesis. Students may wish to embed key words in the title so that it will be retrievable on computerized listings. Formulas, Greek letters, mathematical symbols and the like should be expressed in English words in the title, which should be typed in mixed case consistent with normal usage. Titles should not be typed in all capital letters. Where a subtitle is used, it must be separated by a colon from the main title; simply placing the subtitle on a separate line is not sufficient.

### Copyright Notice
A copyright notice should be typed about 3 inches below the top margin on a separate page immediately following the title page. The notice must include the copyright symbol ©, the year in which copyright is established, and the full legal name of the author.

### Front and Back Matter
A table of contents listing at least the major headings should be included for any dissertation that is divided into chapters or other sections, and should immediately follow the copyright page. Where illustrations, figures, or tables are included in the dissertation, a list that includes the page numbers on which they are found should follow the table of contents. Other front matter may include, where appropriate, acknowledgements of help from persons or institutions; a dedication if one is desired; and a glossary of terms. (The order of these pages is at the discretion of the author.) Back matter may consist of one or more appendices and a bibliography. All front and back matter should be listed in the table of contents.

### Tables
Tables may be numbered serially throughout the dissertation, or by chapter. A table that is small may be set into a text page in its logical location; large tables are generally presented on a separate following page. Since most dissertations will be read in microform, wherever possible tables should be placed as near to the interpretive text as possible. Where there are many tables, however, or where tables are longer than one or two pages, they may be presented in an appendix following the text of the dissertation. In any case, pages which contain only tables must have page numbers.

### Illustrations
Illustrations are normally placed on separate pages, with the figure number and legend typed either beneath the illustration or on the preceding page. Figures and their legend pages should be numbered in with the text of the dissertation.If necessary, illustrative material may be photographically reduced to meet the margin requirements. In such instances, space should be left for page and figure numbers to be typed on the page, together with the legend if one is to be typed beneath the illustration.

# Baylor Dissertation/Thesis Template

## Template Description
This repository contains the LaTeX class (thesis.cls) and template .tex files that generate the basic structure of a dissertation/thesis in a format that conforms with the Baylor University formatting guidelines with the IEEE style guide. The LaTeX class thesis.cls is based on the Baylor CS department template available from the GitHub repository `BaylorCS/baylor-cs-thesis`. 
--------------------------------------------------------------------------------------------------------------------------------------
## Changelog

- Added "Attributions" page
  - includes enumerated 'attributionsList' and itemized 'authorList' for attribution & author contributions \item's
  - includes 'attribution' environment (simply 'singlespace' alias currently) for each 'attributionList' \item
- Added optional command to insert unsigned version of title/signature page PDF instead of generating w/ TeX
- Changed \<sub,subsub>section to explicitly include optional ToC title ([#7] of @startsection)
  - optional ToC title was not functional for \subsection & \subsubsection, so these were modified
  - \section w/ no arguments provided desired behavior, but changed it to match \subsection & \subsubsection
  - best if ToCtitle/title need consistent formatting, else no args preferred. 1 mandatory arg should be avoided -> eliminates optional #7 arg
- Changed Level 5 heading from \parindent to flushleft (0pt), as Grad School instructed
- Added thesisAppendixPage as prehook to 'appendices' environment
- Added automatic Appendix vs. Appendices handling (as per guidelines)
  - Records Appendix chapter count in .aux, so requires 2 compiles to take effect (added 2 useful .aux writing commands to assist).
  - Appendix page displays Appendix or Appendices depending on numAppendices
  - ToC entries adjusted for singular Appendix case (i.e. numAppendices=1):
    - Arabic 'A' dropped from Chapter heading, ToC title, & subsequent Appendix/ToC numbering
    - "APPENDIX" removed from \chapter ToC title
    - \section and lower levels all moved 1 ToC level down
    - renewed \<sub,subsub>section commands w/ explicit optional+normal parameter helpful for removing undesired spacing w/o non-functional /cft commands
- Added enforcement of no page break mid citation, regardless of # of lines (as instructed by Baylor)
- Adjusted figure/table spacing to match guidelines more closely
- Modified 'subappendices' environment so Chapter level appendices match format guidelines
  - Available if really needed, but highly discouraged by Baylor. If used, be prepared to defend use and possibly compromise on formatting.
- Replaced 'center' environments with \begingroup\centering...\par\endgroup when 'center' prevented exact heading position w/ \vspace* (e.g. Abstract)
- Added storage of \chapter & \section titles (\curr<Chap,Sec>Title) for later access to this text
- Added a number of package requirements and various useful control sequence and math operator definitions.
- Modified the \Xname defs (X=abstract/appendix/etc.) to normal capitalization and created \XToCtitle & \Xheading that apply formatting to \Xname's
  - not strictly necessary, but allows usage of previously capitalized \Xname vars within document, e.g. "see \attributionname\ for list of publications"
  - provides separation of ToC titles & headings for independent control, allowing formatting/spacing hooks to be added to one or the other.
  - improves TeX logic/readability & more flexible to future changes
- Replaced braced groups with \begingroup ...\endgroup. No direct impact, but...
  - helps differentiate groups from braced parameter arguments and more clearly indicates explicit grouping


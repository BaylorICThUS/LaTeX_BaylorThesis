%*******************************************************************************************************************************%
%===============================================================================================================================%
%--------------------------------------------------------- thesis.cls ----------------------------------------------------------%
%===============================================================================================================================%
%*******************************************************************************************************************************%
% Baylor University Thesis/Dissertation LaTeX Template
%
% Last Updated in December, 2023
%-------------------------------------------------------------------------------------------------------------------------------%
% Contributors
%-------------------------------------------------------------------------------------------------------------------------------%
% Some code derived from an early template
% created by Jeff Donahoo (2000), with additional
% inspiration from a template by David Jack (2011);
% rewritten and simplified by Jonathan Drake (2013).
% additional stuff by Alvin Jude (2014)
%-------------------------------------------------------------------------------------------------------------------------------%
% cloned 'BaylorCS/baylor-cs-thesis' repo and ammended by Blake Schultze (2021)
% updated by Blake Schultze (2023)
%===============================================================================================================================%
%---------------------------------------------------------- Changelog ----------------------------------------------------------%
%===============================================================================================================================%
% Added \comment{} - simplifies multiline comments
% Fixed spaces after floats: images & tables
% -- NOTE:
%    This only works when floats are at to of page. There is no guarantee that inline images and tables
%    Will actually work. If anybody needs this, will need to be fixed
% final version changelog:
% Dedication: Moved to 3 inches from the top, removed title ("DEDICATION") from the top of the page
% Double spacing AFTER level 3 (\subsection) when text follows.
% Add period after level 5 (followed by 2 spaces)
% Added APPENDICES separator page
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021
%-------------------------------------------------------------------------------------------------------------------------------%
% + Added "Attributions" page
%   - includes enumerated 'attributionsList' and itemized 'authorList' for attribution & author contributions \item's
%   - includes 'attribution' environment (simply 'singlespace' alias currently) for each 'attributionList' \item
% + Added optional command to insert unsigned version of title/signature page PDF instead of generating w/ TeX
% + Changed \<sub,subsub>section to explicitly include optional ToC title ([#7] of @startsection)
%   - optional ToC title was not functional for \subsection & \subsubsection, so these were modified
%   - \section w/ no arguments provided desired behavior, but changed it to match \subsection & \subsubsection
%   - best if ToCtitle/title need consistent formatting, else no args preferred. 1 mandatory arg should be avoided -> eliminates optional #7 arg
% + Changed Level 5 heading from \parindent to flushleft (0pt), as Grad School instructed
% + Added thesisAppendixPage as prehook to 'appendices' environment
% + Added automatic Appendix vs. Appendices handling (as per guidelines)
%   - Records Appendix chapter count in .aux, so requires 2 compiles to take effect (added 2 useful .aux writing commands to assist).
%   - Appendix page displays Appendix or Appendices depending on numAppendices
%   - ToC entries adjusted for singular Appendix case (i.e. numAppendices=1):
%       --- Arabic 'A' dropped from Chapter heading, ToC title, & subsequent Appendix/ToC numbering
%       --- "APPENDIX" removed from \chapter ToC title
%       --- \section and lower levels all moved 1 ToC level down
%       --- renewed \<sub,subsub>section commands w/ explicit optional+normal parameter helpful for removing undesired spacing w/o non-functional /cft commands
% + Added enforcement of no page break mid citation, regardless of # of lines (as instructed by Baylor)
% + Adjusted figure/table spacing to match guidelines more closely
% + Modified 'subappendices' environment to match Chapter level appendices with format guidelines
%   - Available if necessary, but highly discouraged by Baylor. If used, be prepared to defend use and possibly compromise on formatting.
% + Replaced 'center' environments with \begingroup\centering...\endgroup when 'center' prevented exact heading position w/ \vspace* (e.g. Abstract)
% + Added storage of \chapter & \Section titles (\curr<Chap,Sec>Titles for later access to this text
% + Added a number of package requirements and various useful control sequence and math operator definitions.
% + Modified the \Xname defs to normal capitalization and created \XToCtitle & \Xheading that \MakeUppercase the \Xname's, where X=abstract/appendix/etc.
%   - Not strictly necessary, but provides flexibility for future changes and improves logic/readability
% + Replaced braced groups with \begingroup ...\endgroup. No impact, just easier to see/read explicit grouping
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023
%-------------------------------------------------------------------------------------------------------------------------------%
%
%
%
%
%===============================================================================================================================%
% TODO:
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021
%-------------------------------------------------------------------------------------------------------------------------------%
% + Replace in/ex/em spacing with \baselineskip in most vertical spacing contexts.
%   - Double/triple space is \baselineskip/1.5\baselineskip within \doublespacing and 2\bqaselineskip/3\baselineship within \singlespacing.
%   - em is pretty close to \baselineskip in \singlespacing, so the difference is often unnoticeable unless it's measured.
%   - even when the difference is small, most spacing can be generated with logical factors of \baselineskip (i.e. 0.5, 1.0, 1.5...), which makes the spacing
%     easier to understand and modify if necessary
% + Replace 'center' environments with \begingroup\centering...\par\pendgroup in places where vertical spacing needs to be controlled precisely.
% + Remove need for fancyhdr so tocloft can be used to its full potential, rather than under its current restrictions
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023
%-------------------------------------------------------------------------------------------------------------------------------%
% NOTES: (1) there is far too much repeated code, which would be much easier to manage if encapsulated in macros. This would also make
% the code much shorter and more readable. The priority in 2021/2023 was making it work, but this needs to be cleaned up ASAP
% (2) the hard coded lengths in the many V/H spacing commands should be parameterized, wherever reasonable, so such spacing can be
% managed from individual length parameters rather changing them everywhere by hand each time a spacing change needs to be made
% (3) Adding parameter list descriptions for important macros, particularly Report class derived sectioning commands, would be
% an invaluable asset for managing this .cls file. When macro parameters are decoded, this knowledge expires long before the next
% maintenance. As an example: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}*[<altheading>]{<heading>}
%
%-------------------------------------------------------------------------------------------------------------------------------%
%===============================================================================================================================%
\ProvidesClass{thesis}[2014/06/01]

\newif\if@makeDraftThesis                                                       % draft:	draft heading, no graphics loaded, etc.
\newif\if@makeShortThesis                                                       % short:	front matter omitted
\newif\if@isDissertation
\@makeDraftThesisfalse
\@makeShortThesisfalse
\@isDissertationtrue                                                            % Yes, this is dissertation
%\@isDissertationfalse                                                          % No, this is a thesis/other
\DeclareOption{draft}{\@makeDraftThesistrue}
\DeclareOption{short}{\@makeShortThesistrue}
\DeclareOption{dissertation}{\@isDissertationtrue}
\ProcessOptions
\LoadClass[12pt,letterpaper]{report}                                            % Load the parent class: report
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\comment}[1]{}                                                      % ALVIN: Simplifies adding comments
%-------------------------------------------------------------------------------------------------------------------------------%
% General document configuration
%-------------------------------------------------------------------------------------------------------------------------------%
\AtBeginDocument
{
    % \voffset = 1in, so all top lengths -> 0.0in
    \setlength{\topmargin}{0.0in}
    \setlength{\headheight}{0.0in}
    \setlength{\headsep}{0.0in}
    \setlength{\topskip}{0.0in}
	% Blake, 2021: Page num intended to be 0.25in below text, but varies by roman/Arabic numbering.
    % Better to be set individually, some combo of 1ex/em & \baselineskip spacing, but current val is acceptably close globally
    \setlength{\footskip}{0.37in}                                               % Best global compromise.
    \setlength{\textheight}{9.0in}                                              % Yields 1in bottom margin
    \setlength{\textwidth}{6.0in}                                               % Yields 1.25in right margin + marginparwidth
    \setlength{\oddsidemargin}{0.25in}                                          % 0.25in added to 1in leftmargin yielding 1.25in
    \setlength{\evensidemargin}{0.25in}                                         % 0.25in added to 1in leftmargin yielding 1.25in
    \setlength{\parindent}{0.5in}                                               % used in triplespace
    \setlength{\labelsep}{0.5em}
    \setlength{\labelwidth}{1.5em}
	
	\onecolumn
	\raggedbottom
	\doublespacing
	\pagenumbering{arabic}

	\setcounter{tocdepth}{2}
	\setcounter{secnumdepth}{3}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake added, 2021: Provides driver-independent tint/shade/etc. additions to 'color' package.
% Called here to prevent subsequent option clashes
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage[% [optional] package options & additional color packs
    svgnames,table,dvipsnames,usenames,x11names,fixpdftex,hyperref
]{xcolor}
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{setspace}                                                       % We need both double and single spacing
%-------------------------------------------------------------------------------------------------------------------------------%
% TABLE FORMATING STUFF
% This is confusing because the caption is at the top.
%%%%%%% THERE HAS TO BE A BETTER WAY JIM
% aboveskip = distance between caption and float
% belowskip = distace between caption and text
% Set the caption label separator and spacing for all floats
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{caption}
\captionsetup{labelsep=colon,font=singlespacing}
\captionsetup[table]{belowskip=-0.0em, aboveskip=1em, justification=centering}
%\captionsetup[figure]{belowskip=2em, aboveskip=2em}                            % Previous (replaced) fig skip values
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021:  Was > triple spaced between figure and caption (called legend in Guidelines)
% Spacing between a Figure & a Table, w/ no intervening text, is doubled up, which helps
% discern between them but isn't addressed in the guidelines and was not asked to change it.
%-------------------------------------------------------------------------------------------------------------------------------%
\captionsetup[figure]{belowskip=-1em, aboveskip=1em}                            % Blake, 2021: new fig skip values
%-------------------------------------------------------------------------------------------------------------------------------%
% because we set this which determines the distance between the table
% and the preeceeding / proceeding text, we HAVE to set the belowskip in the thing above to 0
% this is also applicable for the images and pictures. Fortunately the configuration
% for both are the same. If they're not, then we're in big barney
%-------------------------------------------------------------------------------------------------------------------------------%
\setlength{\intextsep}{2em}                                                     % Vertical space for floats in the middle of the page
\setlength{\textfloatsep}{3.0em}                                                % Vertical space for floats at the top of the page
\setlength{\abovecaptionskip}{2em}
%\setlength{\belowcaptionskip}{-0.01em}
%===============================================================================================================================%
%------------------------------------------------- Additional useful packages --------------------------------------------------%
%===============================================================================================================================
\RequirePackage[titletoc]{appendix}                                             % Fix the ToC style for appendices
\RequirePackage{graphicx}                                                       %\RequirePackage[pdftex]{graphicx}
\RequirePackage{amsmath}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Switched to IEEEtran bibstyle for IEEE style guide. Retaining "chicago" package requirement
% yields parenthetical, rather than bracketed, citation numbers, so package is eliminated.
%\RequirePackage{chicago}
%-------------------------------------------------------------------------------------------------------------------------------%
% ALVIN: Needs this
\RequirePackage{multirow}
\RequirePackage{hhline}
\RequirePackage{url}
\RequirePackage{newclude}                                                       % for newclude bibtex
\RequirePackage{breakcites}                                                     % ensures multiple citations may break at line end
\RequirePackage[titles]{tocloft}                                                % ToC/LoF/LoT formatting controls
%-------------------------------------------------------------------------------------------------------------------------------%
% NOTE: \@m=1000, \@M=10000, \@MM=20000
%-------------------------------------------------------------------------------------------------------------------------------%
\brokenpenalty=\@M                                                              % Eliminates page breaks at hyphens
\clubpenalty=\@M                                                                % Eliminates orphan lines
\widowpenalty=\@M                                                               % Eliminates widowed lines
%===============================================================================================================================%
%---------------------------------- Frontmatter/backmatter: component names, titles, headings ----------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake: Added Dec 2023
% Conditionals for controlling whether the front/back matter names () are passed directly titles of (1) page/chapter
% headings and (2) their corresponding ToC entries are printed directly from their
% names (\X..Xname} or with \MakeUppercase (true) to (1) their ToC entry title
% and (2) to their page heading title
%-------------------------------------------------------------------------------------------------------------------------------%
% Front/back matter "page heading" control
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@UppercaseHeadings                                                     % Uppercase page heading names?
\@UppercaseHeadingstrue
%\@UppercaseHeadingsfalse
\if@UppercaseHeadings
    \global\let\ToCheadingFontStyle\MakeUppercase
\else
    \global\let\ToCheadingFontStyle\relax
\fi
\newcommand\setUppercaseHeadings{\@UppercaseHeadingstrue}
\newcommand\setCapitalizedHeadings{\@UppercaseHeadingsfalse}
%-------------------------------------------------------------------------------------------------------------------------------%
% Front/back matter "ToC entry label" control
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@UppercaseToCtitles                                                    % Uppercase ToC entry names?
\@UppercaseToCtitlestrue
%\@UppercaseToCtitlesfalse
\if@UppercaseToCtitles
    \global\let\ToCtitleFontStyle\MakeUppercase
\else
    \global\let\ToCtitleFontStyle\relax
\fi
\newcommand\setUppercaseToCtitles{\@UppercaseToCtitlestrue}
\newcommand\setCapitalizedToCtitles{\@UppercaseToCtitlesfalse}
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the names of front/back matter "pages" & "\chapter"s
%-------------------------------------------------------------------------------------------------------------------------------%
%\renewcommand*{\abstractname}{Abstract}
\newcommand*{\ToCname}{Table of Contents}
\newcommand*{\LoFname}{List of Figures}
\newcommand*{\LoTname}{List of Tables}
\newcommand*{\acknowledgename}{Acknowledgments}
\newcommand*{\dedicationname}{Dedication}
\newcommand*{\attributionname}{Attributions}                                    % Blake added, 2021
\newcommand*{\appendicesname}{Appendix}
\newcommand*{\appendicespluralname}{Appendices}                                 % Plural when more than one appendix chapter
\newcommand*{\bibliographyname}{Bibliography}
\renewcommand*{\chaptername}{Chapter}
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the (capitalized) headings of front/back matter "pages" & "\chapter"s
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\abstractHeading}{\ToCheadingFontStyle{\abstractname}}
\newcommand*{\ToCHeading}{\ToCheadingFontStyle{\ToCname}}
\newcommand*{\LoFHeading}{\ToCheadingFontStyle{\LoFname}}
\newcommand*{\LoTHeading}{\ToCheadingFontStyle{\LoTname}}
\newcommand*{\acknowledgeHeading}{\ToCheadingFontStyle{\acknowledgename}}
\newcommand*{\dedicationHeading}{\ToCheadingFontStyle{\dedicationname}}
\newcommand*{\attributionHeading}{\ToCheadingFontStyle{\attributionname}}
\newcommand*{\appendixHeading}{\ToCheadingFontStyle{\appendicesname}}
\newcommand*{\appendicesHeading}{\ToCheadingFontStyle{\appendicespluralname}}   % Plural when more than one appendix chapter
\newcommand*{\bibliographyHeading}{\ToCheadingFontStyle{\bibliographyname}}
\newcommand*{\chapterHeading}{\ToCheadingFontStyle{\chaptername}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Set the (capitalized) ToC titles of front/back matter "pages" & "\chapter"s
% included just in case they ever need to be made distinct from one another
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\abstractToCtitle}{\ToCtitleFontStyle{\abstractname}}
\newcommand*{\cftToCtitle}{\ToCtitleFontStyle{\ToCname}}
\newcommand*{\cftLoFtitle}{\ToCtitleFontStyle{\LoFname}}
\newcommand*{\cftLoTtitle}{\ToCtitleFontStyle{\LoTname}}
\newcommand*{\acknowledgeToCtitle}{\ToCtitleFontStyle{\acknowledgename}}
\newcommand*{\dedicationToCtitle}{\ToCtitleFontStyle{\dedicationname}}
\newcommand*{\attributionToCtitle}{\ToCtitleFontStyle{\attributionname}}
\newcommand*{\appendixToCtitle}{\ToCtitleFontStyle{\appendicesname}}
\newcommand*{\appendicesToCtitle}{\ToCtitleFontStyle{\appendicespluralname}}    % Plural when more than one appendix chapter
\newcommand*{\bibliographyToCtitle}{\ToCtitleFontStyle{\bibliographyname}}
\newcommand*{\chapterToCtitle}{\ToCtitleFontStyle{\chaptername}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Convert to form expected by other packages
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\appendixname}{\normalsize\normalfont\appendixHeading}
\renewcommand*{\bibname}{\normalsize\normalfont\bibliographyHeading}
%===============================================================================================================================%
%------------------------------- Document sectioning commands: label numbering style formatting --------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Set number format of Level 1-4 counter values printed in headings/labels
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\thechapter}{\arabic{chapter}}
\renewcommand*{\thesection}{\thechapter.\arabic{section}}
\renewcommand*{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand*{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Macro that converts a given number to a corresponding number name
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: renamed \arabicText as \ArabicText and converted UPPERCASE number
% names to Capitalized number names. \ArabicText was then used to define \arabicText
% (lowercase) and \ARABICText (UPPERCASE) variations using \MakeLowercase and
% \MakeUppercase, respectively.
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\ArabicText}[1]%
{% number to Capitalized number name
    %\                                                                          % Blake, 2023: removed "Force a space"
    \ifnum0<0#1                                                                 % Test for chapter number vs appendix letter
		\ifcase#1
			Zero \or One \or Two \or Three \or Four \or
			Five \or Six \or Seven \or Eight \or Nine \or Ten \or
			Eleven \or Twelve \or Thirteen \or Fourteen \or
			Fifteen \or Sixteen \or Seventeen \or Eighteen \or
			Nineteen \or Twenty
		\fi%
	\else%
        #1%                                                                     % Pass-through
	\fi%
}
\newcommand{\arabicText}[1]{\MakeLowercase{\ArabicText{#1}}}                    % number to lowercase number name
\newcommand{\ARABICText}[1]{\MakeUppercase{\ArabicText{#1}}}                    % number to UPPERCASE number name
%===============================================================================================================================%
%------------------------------------- Itemized and Enumerated list labels and formatting --------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Enumerated list labels
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\theenumi}{\arabic{enumi}}
\renewcommand*{\theenumii}{\alph{enumii}}
\renewcommand*{\theenumiii}{\roman{enumiii}}
\renewcommand*{\theenumiv}{\alph{enumiv}}
\renewcommand*{\labelenumi}{(\theenumi)}
\renewcommand*{\labelenumii}{(\theenumii)}
\renewcommand*{\labelenumiii}{(\theenumiii)}
\renewcommand*{\labelenumiv}{(\theenumiii.\theenumiv)}
%-------------------------------------------------------------------------------------------------------------------------------%
% Itemized list labels
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\labelitemi}{\textbullet}
\renewcommand*{\labelitemii}{\textasteriskcentered}
\renewcommand*{\labelitemiii}{\normalfont \bfseries \textendash}
\renewcommand*{\labelitemiv}{\textperiodcentered}
%-------------------------------------------------------------------------------------------------------------------------------%
% Margins for lists
%-------------------------------------------------------------------------------------------------------------------------------%
\setlength{\leftmargini}{3.5em}
\setlength{\leftmarginiii}{2.2em}
\setlength{\leftmarginiv}{2.2em}
\setlength{\leftmarginv}{2.2em}
\setlength{\leftmarginvi}{2.2em}
\setlength{\leftmargin}{\leftmargini}
\setlength{\labelwidth}{1.5em}
%*******************************************************************************************************************************%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%----------------------- Document sectioning commands: labeling/formatting controls & (re)defined macros -----------------------%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%*******************************************************************************************************************************%
%===============================================================================================================================%
%------------------------------------------------- Chapter command & headings --------------------------------------------------%
%===============================================================================================================================%
\renewcommand\chapter
{% Chapter command
    \if@openright\cleardoublepage\else\clearpage\fi                             % first page on right
	\thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter
}
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter[#1]#2
{% Chapter heading	
    \setcounter{footnoteA}{0}                                                   % the footnotes should start with 1 in each chapter	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
        %\ifnum \c@section >
        \ifnum \value{section} <\@ne
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
            \addcontentsline{toc}{chapter}{\protect\rm\chapterToCtitle\ \ARABICText{\thechapter}\vspace{-0.5\baselineskip-6pt}}%
        %\else
        \fi
        %
%**************************** MANUAL ToC H-SPACING HACK ************************************************************************************
		\addcontentsline{toc}{chapter}{\protect{\hspace{0.35in}\rm#1}}%
		%\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
	% I expect if they notice this additional LoF/LoT spacing between entries from different chapters, they will request it be removed.
    \addtocontents{lof}{\protect\addvspace{8\p@}}                               % 8pt spacing
    \addtocontents{lot}{\protect\addvspace{8\p@}}                               % 8pt spacing
	\begingroup
		\centering
		\vspace*{0.43in}
		\MakeUppercase{\@chapapp{}}%
        \hspace{-0.25em}                                                        % for the chapter text to look pretty.
		\space\ARABICText{\thechapter}
		\vspace{-1ex}
		\singlespacing{#2}\\
		\vspace{0.13in}
	\endgroup
	\@afterheading
}
%===============================================================================================================================%
%------------------------------------------------- Section command & headings --------------------------------------------------%
%===============================================================================================================================%
\def\@sect#1#2#3#4#5#6[#7]#8%
{% Section heading
    \ifnum #2>\c@secnumdepth
        \let\@svsec\@empty
    \else
        \refstepcounter{#1}%
        \protected@edef\@svsec{\@seccntformat{#1}\relax}%
    \fi
    \@tempskipa #5\relax
    \ifdim \@tempskipa>\z@
        \begingroup
            #6{%
            \@hangfrom{\hskip #3\relax\@svsec}%
              \interlinepenalty \@M #8\@@par}%
        \endgroup
        \csname #1mark\endcsname{#7}%
        \addcontentsline{toc}{#1}{%
            \ifnum #2>\c@secnumdepth \else
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
                %\protect\numberline{\csname the#1\endcsname}%
                \protect\numberline{}%\csname the#1\endcsname
            \fi
            #7%
        }%
    \else
        \def\@svsechd{%                                                          %= Save Section Head macro
            #6{\hskip #3\relax
            \@svsec #8}%
            \csname #1mark\endcsname{#7}%
            \addcontentsline{toc}{#1}{%
                \ifnum #2>\c@secnumdepth \else
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
                    \protect\numberline{}%\csname the#1\endcsname
                \fi
                #7%
            }%
        }%
    \fi
    \@xsect{#5}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Reverted the \section command to 2 parameters, where optional [#1] provides a "short title" option for its ToC entry
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand{\section}[2][]
{% Section command
	\ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
    %NOTE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}*[<altheading>]{<heading>}
	\@startsection{section}{1}{0pt}{1em}{0.001ex}%skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
	{\centering\normalfont\slshape\normalsize}[\ToCentry]{#2}
}
%===============================================================================================================================%
%------------------------------------------------ Subsection command & headings ------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% IF there is content text immediately after level 3,
%   THEN distance between Level 3 and Content text = doublespace.
% IF there is level 4 header immediately after level 3,
%   THEN distance between Level 3 and Level 4 = triplespace.
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Reverted the \subsection command to 2 parameters, where optional [#1] provides a "short title" optiono for its ToC entry
\renewcommand{\subsection}[2][]
{% Subsection command
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
	%NOTE: \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}*[<altheading>]{<heading>}
	\@startsection{subsection}{2}{0pt}{0.001ex}{0.001ex}
	{\vspace{1em}\normalfont\slshape\normalsize}[\hspace{-0.5in}\ToCentry]{#2}
}
%===============================================================================================================================%
%------------------------------------------------ Subsection command & headings ------------------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Changed "Level 5" heading from \parindent to 0\p@ as requested by Grad School
% Blake, 2021: Reverted the \subsubsection command to 2 parameters, where optional [#1] provides a "short title" optiono for its ToC entry
%\renewcommand{\subsubsection}[1]
%{%
%    \vspace{1em}
%	\@startsection{subsubsection}{3}{0\p@}{0.001em}{-1em}%
%	{\normalfont\slshape\normalsize}{#1\hspace{-3ex}}{.} %adds a period/fullstop/dot after the title
%}
\renewcommand{\subsubsection}[2][]
{% Subsubsection command
    \vspace{1em}
	\ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
	\@startsection{subsubsection}{3}{0\p@}{0.001em}{-1em}%
	{\normalfont\slshape\normalsize}[\ToCentry]{#2\hspace{-3ex}}{.} %adds a period/fullstop/dot after the title
}
%===============================================================================================================================%
%--------------------------------------- List Control: Itemize/Enumerate list commands -----------------------------------------%
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
%% standardize itemize and enumerate spacing
%-------------------------------------------------------------------------------------------------------------------------------%
\let\oldenumerate\enumerate
\renewcommand{\enumerate}{
  \oldenumerate
  \setlength{\itemsep}{1em}
  \setlength{\parskip}{-1em}
  \setlength{\parsep}{0pt}	
}
%-------------------------------------------------------------------------------------------------------------------------------%
%% standardize itemize and enumerate spacing
%-------------------------------------------------------------------------------------------------------------------------------%
\let\olditemize\itemize
\renewcommand{\itemize}{
  \olditemize
  \setlength{\parsep}{-\baselineskip}	
  \setlength{\itemsep}{1em}
  \setlength{\parskip}{-1em}

}
%-------------------------------------------------------------------------------------------------------------------------------%
% removes extra space after the list (itemize). So it will be double space instead of triple
%-------------------------------------------------------------------------------------------------------------------------------%
\let\@oldlistI\@listI
\renewcommand{\@listI}{
	\@oldlistI
	\topsep=0pt
}
%*******************************************************************************************************************************%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%------------------------------------ Prologue (Frontmatter) page construction definitions -------------------------------------%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%*******************************************************************************************************************************%
% Internal boolean variables
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: These are unnecessary and can be removed.
% If kept, should use \gdef or \newcommand & \renewcommand here and the filling of stash, not mixed \gdef & \newcommand.
%\newcommand{\th@dedicationStash}{\relax}
%\newcommand{\th@acknowledgementsStash}{\relax}
%-------------------------------------------------------------------------------------------------------------------------------%
\gdef\th@dedicationStash{\relax}
\gdef\th@acknowledgementsStash{\relax}
\gdef\th@attributionsStash{\relax}
%-------------------------------------------------------------------------------------------------------------------------------%
\newif\if@makeLoF
\newif\if@makeLoT
\newif\if@makeCopyrightPage
\newif\if@makeDedication
\newif\if@makeAcknowledgements
\newif\if@makeAttributions                                                      % Blake added, 2021
\newif\if@makeReaderThree
\newif\if@makeReaderFour
\newif\if@makeReaderFive
%-------------------------------------------------------------------------------------------------------------------------------%
% Initial values for boolean variables
%-------------------------------------------------------------------------------------------------------------------------------%
\@makeLoFfalse
\@makeLoTfalse
\@makeCopyrightPagetrue
\@makeDedicationfalse
\@makeAcknowledgementsfalse
\@makeAttributionsfalse                                                         % Blake added, 2021
\@makeReaderThreefalse
\@makeReaderFourfalse
\@makeReaderFivefalse
%-------------------------------------------------------------------------------------------------------------------------------%
% User conditional controls
%-------------------------------------------------------------------------------------------------------------------------------%
%\excludeAbstractPage
%\excludeAcknowlegmentsPage
%\excludeDedicationPage
%\excludeAttributionsPage
%===============================================================================================================================%
% The Prologue (frontmatter) pages: grouping/ordering, pagination, and style/formatting controls
%===============================================================================================================================%
\newcommand{\thesisPrologue}
{
	% Where to start counting pages (Baylor's first pages are unpaginated, but counted!)
	\pagenumbering{roman}
	\pagestyle{empty}
	
    % Unpaginated preliminary pages
	\thesisAbstractpage
    \thesisTitlePage
	\thesisCopyrightPage
	
	% Where to start paginating (thus making ToC page "iv" or so)
	\pagestyle{plain}
	
	% Paginated preliminary pages
	\thesisToCpage
	\thesisLoFpage
	\thesisLoTpage
	\thesisAcknowledgementpage
	\thesisDedicationpage
    \thesisAttributionspage                                                     % Blake added, 2021
    % Blake, 2023: Hack to get "single spacing" before 1st Chapter ToC entry
    % Same hack used on each of the preceding pages
    \addtocontents{toc}{\protect\vspace{-\baselineskip}}
		
}
%===============================================================================================================================%
% Abstract page contruction (attempts to match BUGS 2013 guidelines)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Replaced "center" environment with grouped (temp) \centering justification clause,
% otherwise interferes with \vspace* generating heading at the 2.5" mark
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAbstractpage}
{
	\doublespacing
    \thispagestyle{empty}
	\if@makeDraftThesis
		\begin{center}
			\Huge Draft \\
			\Large \today \normalsize
		\end{center}
		\vspace{-8em}
	\fi
	\begingroup
        \centering
        \vspace*{1.3in}%
        \abstractHeading\\
		\thesisTitle\\
		\thesisAuthorName, \thesisSeeking\\
        \thesisMentorTitle: \thesisMentor\\[1em]%                               % Blake added, 2021: creates so called "triple space"
    \endgroup
    \par
    \thesisAbstract
	\clearpage
}
%===============================================================================================================================%
% Title/Signature page contruction (attempts to match BUGS 2013 guidelines)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Special footer for the signature page
% Blake, 2023: There was a conflict between fancyhdr and tocloft, unknown whether more recent package updates fixed this, but
% fancyhdr is only used here so, given the importance of the tocloft package, consider achieving the desired results w/o fancyhdr
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{fancyhdr}
\fancypagestyle{masters_title_page}
{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\cfoot{\footnotesize \textit{Page bearing signatures is kept on file in the Graduate School.}}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Option to insert title/signature page from PDF file; otherwise, page is TeX generated
% Blake, 2021: Added this capability.
% Initially is unsigned PDF form directly from Grad School, but can also be used to insert the signed PDF form
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{pdfpages}                                                       % Provides clean PDF insertion capability (Blake added, 2021)
\newif\if@insertSignaturePage\@insertSignaturePagefalse
\newcommand*\signaturePageAddr{}
\newcommand*\insertSignaturePage[1]{
    \@insertSignaturePagetrue
    \renewcommand*\signaturePageAddr{#1}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Internal macro for drawing signature lines
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisSignature}[2]
{
		\normalsize
		\vspace{0.05in}
		\\
		\vrule width #2 height 0.2mm
        \\
        \vspace{-0.15in}
		#1
}
%-------------------------------------------------------------------------------------------------------------------------------%
%****************************************************** UNDER CONTRUCTION ******************************************************%
% Blake, 2021: In progress with title page.
%-------------------------------------------------------------------------------------------------------------------------------%
%\newcommand*{\thesisSignature}[2]
%{
%		\normalsize
%		%\vspace{0.05in}
%		%\\
%		\vrule width #2 height 0.1mm\\[0.1mm-2ex]
%        %[-0.5\baselineskip]
%        %\vspace{0.5em}
%		#1
%}
%-------------------------------------------------------------------------------------------------------------------------------%
% Title/signature page contruction
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*{\thesisTitlePage}
{
    \if@insertSignaturePage%
        \includepdf{\signaturePageAddr}
    \else
    	\thispagestyle{masters_title_page}
    	\doublespacing
    	
    	\begin{center}
    	   \vspace*{0.1in}
    		\thesisTitle \\
    		by \\
    		\thesisAuthorName, \thesisHolding \\
    		A Thesis \\
    		Approved by the \thesisDepartment
    		\thesisSignature{\thesisDepartmentChair, Chairperson}{97mm}
    	\\
    	\vspace{0.1in}
    	\singlespacing
        Submitted to the Graduate Faculty of\\
    	Baylor University in Partial Fulfillment of the \\
    	Requirements for the Degree \\
    	of \\
    	\thesisDegree
    	
    	\vspace{0.25in}
    	\vfill
    	\doublespacing
    	\begingroup
    		\addtolength{\leftskip}{-2.25in}
         	Approved by the Thesis Committee
         	\thesisSignature{\thesisMentor, Chairperson}{80mm}
         	\thesisSignature{\thesisReaderOne}{80mm}
         	\thesisSignature{\thesisReaderTwo}{80mm}
    		\if@makeReaderThree \thesisSignature{\thesisReaderThree}{80mm} \fi
    		\if@makeReaderFour \thesisSignature{\thesisReaderFour}{80mm} \fi
    		\if@makeReaderFive \thesisSignature{\thesisReaderFive}{80mm} \fi
    		\\
    	\endgroup
    	
    	\vspace{0.25in}
    	\vfill
    	
    	\begingroup
    		\addtolength{\leftskip}{2.6in}
    		Accepted by the Graduate School \\
    		\vspace{-0.075in}
    		\thesisConfDate
    		\thesisSignature{\thesisDean, Dean}{80mm} \\
    	\endgroup
    	
        \end{center}
    \fi
        \clearpage
}
%-------------------------------------------------------------------------------------------------------------------------------%
%****************************************************** UNDER CONTRUCTION ******************************************************%
% Blake 2021, in progress: correcting margins and positioning/spacing of lines.
% Attempting to match Grad School provided "4 Line Signature Page", though it extends
% into the 1" top and bottom margins and has inconsistent spacing.
%-------------------------------------------------------------------------------------------------------------------------------%
%\newcommand*{\thesisTitlePage}
%{
%    \if@insertSignaturePage%
%        %\include{\signaturePageAddr}
%        %\include{./Forms/SignaturesPage.pdf}
%        \includepdf{\signaturePageAddr}
%    \else
%    	\thispagestyle{masters_title_page}
%    	\doublespacing	
%        {
%            \vspace*{0.5ex -\baselineskip}
%            \centering
%        %\begin{center}
%    	%\vspace*{0.1in}
%    		\thesisTitle \\[0.5\baselineskip-1.5ex]
%    		by \\[0.5\baselineskip-1.5ex-0.3mm]
%    		%by \\[0.5\baselineskip-0.5em - 0.2mm]
%    		\thesisAuthorName, \thesisHolding \\[-1.5ex - 0.2mm + 0.5\baselineskip]
%    		A Dissertation \\[-1.em + 0.3mm + 0.5\baselineskip]
%    		Approved by the \thesisDepartment\\[-0.5em +0.2mm + 0.5\baselineskip]
%    		\thesisSignature{\thesisDepartmentChair, Chairperson}{4.0in}\\[0.5\baselineskip - 0.2mm]
%    	%\vspace{0.1in}
%        	\singlespacing
%            	Submitted to the Graduate Faculty of\\
%        	Baylor University in Partial Fulfillment of the \\
%        	Requirements for the Degree \\
%        	of \\[-0.5ex + 0.2mm + 0.5\baselineskip]
%        	\thesisDegree\\[\baselineskip]
%        }
%    	\vspace{2\baselineskip}
%    	%\vfill
%    	\doublespacing
%    	%\hspace{0.25in}
%    	%\setlength\leftskip{0.5in}
%        {   %
%            	\centering
%                %\addtolength{\leftskip}{-2.5in}
%                Approved by the Dissertation Committee\\
%         		\thesisSignature{\thesisMentor, Chairperson}{80mm}\\
%         		\thesisSignature{\thesisReaderOne}{80mm}\\
%         		\thesisSignature{\thesisReaderTwo}{80mm}\\
%    		\if@makeReaderThree \thesisSignature{\thesisReaderThree}{80mm}\\ \fi
%    		\if@makeReaderFour \thesisSignature{\thesisReaderFour}{80mm}\\ \fi
%    		\if@makeReaderFive \thesisSignature{\thesisReaderFive}{80mm}\\ \fi
%    		%\\
%    	}
%    	
%    	\vspace{0.25in}
%    	\vfill	
%    	%\addtolength{\leftskip}{-1.0in}
%        %\setlength\leftskip{-1.25in}
%        {
%    		%\centering
%    		\begin{flushleft}
%                \centering
%                Accepted by the Graduate School \\
%        		\vspace{-0.075in}
%        		\thesisConfDate
%        		\thesisSignature{\thesisDean, Dean}{80mm} \\
%            \end{flushleft}
%    	}	
%    	%\end{center}
%    \fi
%    \clearpage
%}
%===============================================================================================================================%
% Copyright page contruction (attempts to match BUGS 2013 guidelines)
%===============================================================================================================================%
%\newlength\Copyright@topskip
%\setlength\Copyright@topskip{8.19in}
\def\Copyright@topskip{8.19in}
\newcommand*{\thesisCopyrightPage}
{
    \if@makeCopyrightPage
        \thispagestyle{empty}
		\vspace*{\Copyright@topskip}
		\begin{center}
            Copyright \copyright{} \the\year\ by  \thesisAuthorName\\
            All rights reserved
		\end{center}
		\clearpage
	\fi
}
%===============================================================================================================================%
% Acknowledgments page construction (optional)
%===============================================================================================================================%
\newcommand{\thesisAcknowledgementpage}
{
    \if@makeAcknowledgements
        \thispagestyle{plain}
        %\addtocontents{toc}{\protect\vspace{-0.25in}}                          % Blake, 2021
        \addtocontents{toc}{\protect\vspace{-\baselineskip}}                   % Blake, 2023: Hack to eliminate triple spacing, replaced -0.25in with -2\baselineskip
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\acknowledgeToCtitle}
		\begin{center}\vspace*{0.3in}\normalfont\normalsize\acknowledgeHeading\end{center}
		\hspace{\parindent}
		\th@acknowledgementsStash
		\clearpage
	\fi
}
%===============================================================================================================================%
% Dedication page construction (optional)
%===============================================================================================================================%
\newcommand{\thesisDedicationpage}
{
	\if@makeDedication		
		\thispagestyle{plain}
		%\addtocontents{toc}{\protect\vspace{-0.25in}}                          % Blake, 2021
        \addtocontents{toc}{\protect\vspace{-\baselineskip}}                   % Blake, 2023: Hack to eliminate triple spacing, replaced -0.25in with -2\baselineskip
        \phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\dedicationToCtitle}
		\begin{center}\vspace*{0.25in}\normalfont\normalsize\dedicationHeading{}\end{center} % SHOWS the dedication title on the page
		%\begin{center}\vspace*{0.25in}\normalfont\normalsize{}\end{center} % DOES NOT show the dedication title on the actual page
		\vspace{0.75in} % badhack to make sure dedication starts at 3inches from the top
		\begin{center}\th@dedicationStash\end{center}
		\clearpage
	\fi
}
%===============================================================================================================================%
% Attributions page (optional) - Blake added, 2021
%===============================================================================================================================%
\newcommand{\thesisAttributionspage}
{
	\if@makeAttributions
		\thispagestyle{plain}
        %\addtocontents{toc}{\protect\vspace{-0.25in}}                          % Blake, 2021
        \addtocontents{toc}{\protect\vspace{-\baselineskip}}                    % Blake, 2023: Hack to eliminate triple spacing, replaced -0.25in with -2\baselineskip
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\attributionToCtitle}
		\begingroup
            \vspace*{0.3in}
            \centering\normalfont\normalsize\attributionHeading\par
        \endgroup
        \vspace{-0.5\baselineskip}
        \hspace{\parindent}
        \th@attributionsStash
		\clearpage
	\fi
    \addtocontents{toc}{\protect\vspace{\baselineskip}}                         % Blake, 2023: Hack to eliminate triple spacing, replaced -0.25in with -2\baselineskip
}
%===============================================================================================================================%
% Table of Contents (ToC) page construction
%===============================================================================================================================%
% Uses the 'tocloft' package
% NOTE: overflowing chapter titles MUST be single-spaced
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftparskip{0.5\baselineskip}                                      % Vertical skip between headings
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftpartleader{\normalfont\cftdotfill{\cftchapdotsep}}             % then remove the bolds.
\renewcommand\cftchapleader{\normalfont\cftdotfill{\cftchapdotsep}}             % then remove the bolds.
\renewcommand\cftpartpagefont{\normalfont}
\renewcommand\cftchappagefont{\normalfont}                                      % this defaults to bold, overwrite that.
\renewcommand\cftchapdotsep{\cftsecdotsep}                                      % first define the chap dots to be equal to the section dots
%-------------------------------------------------------------------------------------------------------------------------------%
%\setlength\cftbeforechapskip{0.5\baselineskip}
\setlength{\cftbeforechapskip}{1.0em \@plus\p@}                                 % Blake, 2023: Default value
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: IDK where ~1.25pt space is being added to Level 1-4 sectioning commands, but its removed here
%-------------------------------------------------------------------------------------------------------------------------------%
%\renewcommand\cftpartafterpnum{\vspace{1em}}
%\renewcommand\cftchapafterpnum{\vspace{1em}}                                   % Blake, 2023: Replaced
%\renewcommand\cftsecafterpnum{\vspace{1em}}                                    % Blake, 2023: Replaced
%\renewcommand\cftsubsecafterpnum{\vspace{1em}}                                 % Blake, 2023: Replaced
%\renewcommand\cftsubsubsecafterpnum{\vspace{1em}}                              % Blake, 2023: Replaced
\renewcommand\cftchapafterpnum{\vspace{-1.25pt}}
\renewcommand\cftsecafterpnum{\vspace{-1.25pt}}
\renewcommand\cftsubsecafterpnum{\vspace{-1.25pt}}
\renewcommand\cftsubsubsecafterpnum{\vspace{-1.25pt}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: Added "Figure " before figure #s in the LoF, then adjusted numberline spacing/location
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cftfigpresnum{\figurename\ }                                      % Add "Figure " before figure #s in LoF entries
\newlength\len@cftfigpresnum                                                    % Width of content preceding 'snum', i.e. \cftfigpresnum
\settowidth\len@cftfigpresnum{\cftfigfont\cftfigpresnum}                        % Set to the width of \cftfigpresnum
%\addtolength\len@cftfigpresnum{\cftfignumwidth}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: Added "Table " before table #s in the LoT, then adjusted numberline spacing/location
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand\cfttabpresnum{\tablename\ }                                       % Add "Table " before table #s in LoT entries
\newlength\len@cfttabpresnum                                                    % Width of content preceding 'snum', i.e. \cfttabpresnum
\settowidth\len@cfttabpresnum{\cfttabfont\cfttabpresnum}                        % Set to the width of \cfttabpresnum
%\addtolength\len@cfttabpresnum{\cfttabnumwidth}
%-------------------------------------------------------------------------------------------------------------------------------%
%USAGE: \cftsetindents{<type>}{<indent>}{<snumwidth>}
%-------------------------------------------------------------------------------------------------------------------------------%
\cftsetindents{figure}{0in}{\len@cftfigpresnum+0.25in}                          % Simplest way to adjust for the addition of the word "Figure " to LoF entries
%\cftsetindents{figure}{-\len@cftfigpresnum+0.5in}{\len@cftfigpresnum+0.25in}   % More complicated but more logical and also works to adjust for the added word "Figure "
\cftsetindents{table}{0in}{\len@cfttabpresnum+0.25in}                           % Simplest way to adjust for the addition of the word "Table " to LoT entries
%\cftsetindents{table}{-\len@cfttabpresnum+0.5in}{\len@cfttabpresnum+0.25in}    % More complicated but more logical and also works to adjust for the added word "Table "
\cftsetindents{chapter}{0in}{0in}
\cftsetindents{section}{0.5in}{0in}
\cftsetindents{subsection}{1.25in}{0in}
\cftsetindents{subsubsection}{1.0in}{0in}
%-------------------------------------------------------------------------------------------------------------------------------%
% Table of Contents (ToC) page
%-------------------------------------------------------------------------------------------------------------------------------%
%\setlength\cftbeforetoctitleskip{0.28in}                                       % Vertical skip before Table of Contents title
%\setlength\cftaftertoctitleskip{0in}                                           % Vertical skip after Table of Contents title
%\renewcommand{\cftaftertoctitle}{}                                             % Control sequences executed after ToC title
\newcommand{\thesisToCpage}
{%
	\renewcommand*{\contentsname}{%
        \vspace*{-0.27in}%
        \centering%
        \normalsize\normalfont\ToCHeading%
        \vspace{-0.25in}%
    }
	%\renewcommand*{\contentsname}{\centering\normalsize\normalfont\ToCHeading\\}
    %\renewcommand\cftparskip{-1.25\baselineskip}                               % Vertical skip between headings
    \begin{singlespace}
	\tableofcontents
	\end{singlespace}
	\clearpage
}
%===============================================================================================================================%
% List of X (LoX) page constructions: X = Figures (LoF), Tables (LoT)
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% List of Figures (LoF) page (optional)
%-------------------------------------------------------------------------------------------------------------------------------%
%\setlength{\cftbeforeloftitleskip}{0.25in}
%\setlength{\cftafterloftitleskip}{0in}
%\renewcommand{\cftafterloftitle}{}
%-------------------------------------------------------------------------------------------------------------------------------%
%\setlength{\cftfignumwidth}{2.85em}                                            % Blake added, 2021: Provide space for X.X.XX LoF numbering
%\setlength{\cftfignumwidth}{\len@cftfigpresnum+0.25in}                         % Blake, 2023: Removed in favor of \setindents
%\renewcommand{\cftfigaftersnum}{}
%\renewcommand{\cftfigaftersnumb}{\relax\hspace{-\len@cftfigpresnum}}
%\renewcommand\cftfigafterpnum{\vspace{1em}}                                    % <ALT>{\vspace{-6pt}}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisLoFpage}
{
	\if@makeLoF
        \renewcommand*{\addvspace}[1]{}                                         % Blake, 2023: Removes extra space separating LoF entries from different chapters
        %\addtocontents{toc}{\protect\vspace{-0.25in}}                          % Blake, 2021: ADDS 0.25" space before LoF entry in ToC
        \addtocontents{toc}{\protect\vspace{-\baselineskip}}                   % Blake, 2023: Hack to eliminate triple spacing, replaced -0.25in with -2\baselineskip
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\cftLoFtitle}
		\renewcommand*{\listfigurename}{\vspace*{-0.27in}\centering\normalsize\normalfont\LoFHeading\vspace{-0.25in}}
		\begin{singlespace}
		\listoffigures
		\end{singlespace}
		\clearpage
	\fi
}
%-------------------------------------------------------------------------------------------------------------------------------%
% List of Tables (LoT) page (optional)
%-------------------------------------------------------------------------------------------------------------------------------%
%\setlength{\cftbeforelottitleskip}{-0.25in}
%\setlength{\cftafterlottitleskip}{0in}
%\renewcommand{\cftafterlottitle}{}
%-------------------------------------------------------------------------------------------------------------------------------%
%\setlength{\cfttabnumwidth}{2.85em}                                            % Blake added, 2021: Provide space for X.X.XX LoT numbering
%\renewcommand\cfttabafterpnum{\vspace{1em}}% <ALT>{\vspace{-6pt}}
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisLoTpage}{
	\if@makeLoT
		\renewcommand*{\addvspace}[1]{}                                         % Blake, 2023: Removes extra space separating LoF entries from different chapters
        %\addtocontents{toc}{\protect\vspace{-0.25in}}                          % Blake, 2021: ADDS 0.25" space before LoF entry in ToC
        \addtocontents{toc}{\protect\vspace{-\baselineskip}}                   % Blake, 2023: Hack to eliminate triple spacing, replaced -0.25in with -2\baselineskip
        \phantomsection                                                         % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\cftLoTtitle}
		\renewcommand*{\listtablename}{\vspace*{-0.27in}\centering\normalsize\normalfont\LoTHeading\vspace{-0.25in}}
		\begin{singlespace}
		\listoftables
		\end{singlespace}
		\clearpage
	\fi
}
%===============================================================================================================================%
% Appendix/Appendices title page and content page(s) contruction
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: Added for automatic Appendix vs. Appendices handling according to format guidelines.
% Replaces \@chapter in the case there is only 1 Appendix chapter. Removes "A" from \numberline and heading ( via \ARABICText{\thechapter} removal)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter@multiple@appendices[#1]#2
{%
    \setcounter{footnoteA}{0}                                                   % the footnotes should start with 1 in each chapter
	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
        \ifnum \value{section} <\@ne
            \addcontentsline{toc}{chapter}{%
                \protect\rm\ARABICText{\thechapter}%                            % Blake, 2023: 1st \chapter ToC line in Appendix
                \vspace{-0.5\baselineskip-6pt}%
            }%
        \fi
		%\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}% Blake, 2023: REPLACED- removed chapter numbering from ToC entry
        \addcontentsline{toc}{chapter}{\protect{\hspace{0.25in}\rm#1}}%         % Blake, 2023: Indent 2nd \ToC line; \hspace spacing hack
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	% I expect if they notice this additional LoF/LoT spacing between entries from different chapters, they will request it be removed.
    \addtocontents{lof}{\protect\addvspace{8\p@}}                               % 8pt spacing
    \addtocontents{lot}{\protect\addvspace{8\p@}}                               % 8pt spacing
	\begingroup
		\centering
		\vspace*{0.43in}
        %\MakeUppercase{\old@appendixname}%                                     % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
        \MakeUppercase{\appendixHeading}%                                       % Restore "APPENDIX"/"Appendix" in Appendix chapter headings
        \hspace{-0.25em}                                                        % for the chapter text to look pretty.
        \space\ARABICText{\thechapter}                                          % if \thechapter is a number, print its name, otherwise pass through \thechapter unchanged
		\vspace{-1ex}
		\singlespacing{#2}\\
		\vspace{0.13in}
	\endgroup
	\@afterheading
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Added for automatic Appendix vs. Appendices handling according to format guidelines.
% Replaces \@chapter in the case there is only 1 Appendix chapter. Removes "A" from \numberline and heading ( via \ARABICText{\thechapter} removal)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter@singular@appendix[#1]#2
{%
	% the footnotes should start with 1 in each chapter
	\setcounter{footnoteA}{0}
	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%
        \ifnum \value{section} <\@ne
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC H-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
            \addcontentsline{toc}{chapter}{%
                \protect\rm\ARABICText{\thechapter}\vspace{-0.5\baselineskip-6pt}%
            }%
        \fi
		%\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC H-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
        \addcontentsline{toc}{chapter}{\protect{\hspace{0.25in}\rm#1}}%         % Blake, 2023: Removed chapter numbering from ToC labels
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	% I expect if they notice this additional LoF/LoT spacing between entries from different chapters, they will request it be removed.
    \addtocontents{lof}{\protect\addvspace{8\p@}}                               % 8pt spacing
    \addtocontents{lot}{\protect\addvspace{8\p@}}                               % 8pt spacing
	\begingroup
		\centering
		\vspace*{0.43in}
		\MakeUppercase{\@chapapp{}}%
        \hspace{-0.25em}                                                        % for the chapter text to look pretty.
		%\ARABICText{\thechapter}
		\vspace{-1ex}
		\singlespacing{#2}\\
		\vspace{0.13in}
	\endgroup
	\@afterheading
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: Replaced explicit redefinitions of \section, \subsection, \subsubsection within the numAppendices=1 branch of
% \thesisAppendixPage with \let\Xsection\Xsection@singular@appendix statements using the following variant sectioning commands
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\section@singular@appendix}[2][]                                    % move down 1 level, use optional \section parameter to fix ToC num/title gap by -3ex
{%
    \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
    \@startsection{subsection}{1}{0pt}{1em}{0.001ex}                            % skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
	{\centering\normalfont\slshape\normalsize}[\hspace{-3ex}\ToCentry]{##2}
}
\newcommand{\subsection@singular@appendix}[2][]                                 % move down 1 level
{%
7    \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
	\@startsection{subsubsection}{2}{0pt}{0.001ex}{0.001ex}
	{\vspace{1em}\normalfont\slshape\normalsize}[\hspace{-3ex}\ToCentry]{##2}
}
\newcommand{\subsubsection@singular@appendix}[2][]                              % move down 1 level
{%
    \vspace{1em}
    \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
	\@startsection{paragraph}{3}{0\p@}{0.001em}{-1em}%
	{\normalfont\slshape\normalsize}[\ToCentry\hspace{-3ex}]{##2\hspace{-3ex}}{.} % adds a period/fullstop/dot after the title
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2023: Added \@redotocentry@pp variant to control the ToC labels of sectioning commands in the Appendix independent
% from sectioning commands in the main body of the document. *denotes lines that differ from (i.e. were added to) \@redotocentry@pp
% NOTE: this (& the original) command redefines \addcontentsline in the Appendix context to automatically include
% \appendixname\space, so the \addcontentsline commands only dictate what is ADDED to \appendixname\space.
% TODO: A more flexible solution, one that isn't simply a "hack" to conform to the Grad Department guidelines, should be found.
%-------------------------------------------------------------------------------------------------------------------------------%
\global\let\old@appendixname\appendixname                                       % Save the \appendixname so it can be restored elsewhere
\newcommand{\NEW@redotocentry@pp}[1]{%
    \let\oldacl@pp=\addcontentsline
    \def\addcontentsline##1##2##3%
    {%
        \def\@pptempa{##1}\def\@pptempb{toc}%
        \ifx\@pptempa\@pptempb                                                  % if( ##1 = toc )
            \def\@pptempa{##2}\def\@pptempb{#1}%
            \ifx\@pptempa\@pptempb                                              % if( ##2 = #1 )
                \oldacl@pp{##1}{##2}{\appendixname\space##3}%                   % Prepends \appendixname\space to ToC entry for all Appendix
                \renewcommand\appendixname{}%                                   %*Remove APPENDIX/Appendix from ToC labels below Chapter level
            \else
                \global\let\appendixname\old@appendixname%                      %*Restore APPENDIX/Appendix as ToC labels for next Chapter level
                \oldacl@pp{##1}{##2}{##3}%
            \fi
        \else
            \oldacl@pp{##1}{##2}{##3}%
        \fi
    }
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Appendix/Appendices page (depending on whether there is 1 "Appendix" or 2+ "Appendices"
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Added for automatic Appendix vs. Appendices handling according to format guidelines. Also fixes vertical centering.
% If singular Appendix detected (via .aux, so change detected on 2nd compile, then 3rd compile for .toc changes to take effect):
% - Changes "APPENDICES" to "APPENDIX" on appendix page
% - Adjusts sectioning commands to remove "A" from heading/ToC, move ToC entries down 1 level, and remove "APPENDIX" from \chapter title entry in ToC.
% - Renews \section and uses optional ToC title parameter to effectively set \cftsecnumwidth.
%   --- This is a hack since \cft lengths have no effect with fancyhdr + tocloft option 'titles'
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAppendixPage}{

        \thispagestyle{plain}
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC H-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
		\addtocontents{toc}{\protect\vspace{-0.25in}}
        \phantomsection                                                         % Anchor the bookmark to this position
        %\renewcommand\chapterToCtitle{}                                        % Blake, 2023:
        %\appendixtitletocoff                                                   % remove "APPENDIX" from ToC chapter title
        \global\let\@redotocentry@pp\NEW@redotocentry@pp
        \ifnumcomp{\value{numAppendices}}{=}{1}                                 % If there is only 1 Appendix chapter
        {
            %\appendixtitletocoff                                               % remove "APPENDIX" from ToC chapter title
            \glet\old@chapter\@chapter                                          % save \@chapter JIC
            \glet\@chapter\@chapter@singular@appendix
            \glet\thisAppendixHeading\appendixHeading                           % set heading to Appendix
            \renewcommand{\thesection}{\arabic{section}}                        % remove "A" from section numbers
            \renewcommand{\thesubsection}{\arabic{subsection}}                  % remove "A" from subsection numbers
            % Blake, 2023: Save \Xsection definitions in \old@Xsection macros, then redefine \Xsection for use in singular Appendix
            \global\let\old@section\section                                     % save the definition of \section before redefining it
            \global\let\old@subsection\subsection                               % save the definition of \subsection before redefining it
            \global\let\old@subsubsection\subsubsection                         % save the definition of \subsubsection before redefining it
            \let\section\section@singular@appendix                              % redefine \section for use in singular Appendix
            \let\subsection\subsection@singular@appendix                        % redefine \subsection for use in singular Appendix
            \let\subsubsection\subsubsection@singular@appendix                  % redefine \subsubsection for use in singular Appendix
%            \renewcommand{\section}[2][]                                        % move down 1 level, use optional \section parameter to fix ToC num/title gap by -3ex
%            {%
%                \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
%            	\@startsection{subsection}{1}{0pt}{1em}{0.001ex}               %skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
%            	{\centering\normalfont\slshape\normalsize}[\hspace{-3ex}\ToCentry]{##2}
%            }
%            \renewcommand{\subsection}[2][]                                     % move down 1 level
%            {
%                \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
%            	\@startsection{subsubsection}{2}{0pt}{0.001ex}{0.001ex}
%            	{\vspace{1em}\normalfont\slshape\normalsize}[\hspace{-3ex}\ToCentry]{##2}
%            }
%            \renewcommand{\subsubsection}[2][]                                  % move down 1 level
%            {%
%                \vspace{1em}
%                \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
%            	\@startsection{paragraph}{3}{0\p@}{0.001em}{-1em}%
%            	{\normalfont\slshape\normalsize}[\ToCentry\hspace{-3ex}]{##2\hspace{-3ex}}{.} % adds a period/fullstop/dot after the title
%            }
            \addcontentsline{toc}{part}{\normalsize\normalfont\appendixToCtitle}% set ToC title to Appendix
%**************************** MANUAL ToC V-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC H-SPACING HACK ************************************************************************************
%**************************** MANUAL ToC ENTRY LABELING HACK ************************************************************************************
            \addtocontents{toc}{\protect\vspace{-\baselineskip}}                % reduce to \section sized skip
        }
        {
            %\appendixtitletocoff                                               % remove "APPENDIX" from ToC chapter title
            \glet\old@chapter\@chapter                                          % save \@chapter JIC
            \glet\@chapter\@chapter@multiple@appendices
            \glet\thisAppendixHeading\appendicesHeading                         % set appendix page heading to APPENDICES/Appendices
            \addcontentsline{toc}{part}{\normalsize\normalfont\appendicesToCtitle}% set ToC title to Appendices

        }
        \vspace*{\fill}
		\begingroup
            \centering\normalfont\normalsize\thisAppendixHeading\\
        \endgroup
        \vspace*{\fill}
		\clearpage
}
%===============================================================================================================================%
% Redefine \thebibliography at the beginning of the main \document body
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Intercept the bibliography body
% Blake, 2021: Prevent page breaks mid-citation. There are other ways to do this, e.g. modify .bst file, bib environment, etc. This is easiest
% & works for citations of any # of lines, which Grad School requested in technical review.
%-------------------------------------------------------------------------------------------------------------------------------%
\AtBeginDocument
{
    \def\thebibliography#1
	{
		\clearpage
		\addcontentsline{toc}{chapter}{\bibname}
		\vspace*{0.42in}
		\centering\normalfont\normalsize\bibname
		\vspace{2ex}
		\intactCitations                                                      % prevents page breaks mid-citation
        \singlespacing
		\list{[\arabic{enumi}]}
		{
	 		\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
	 		\advance\leftmargin\labelsep
	 		\advance\leftmargin\bibindent
			\itemindent -\bibindent
			\listparindent \itemindent
			\usecounter{enumi}
		}
		\def\newblock{\hskip .11em plus .33em minus -.07em}
		\sloppy
	 	\sfcode`\.=1000\relax
	}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Intercept the main document (basically the main function here)
%-------------------------------------------------------------------------------------------------------------------------------%
\let\interceptedDocument\document
\renewcommand*{\document}
{
	\interceptedDocument
	
	% Front matter
	\if@makeShortThesis
		\thesisAbstractpage
	\else
		\thesisPrologue
	\fi
	
	% Document body follows
    \doublespacing
	\pagenumbering{arabic}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Expected parameters
%-------------------------------------------------------------------------------------------------------------------------------%
\renewcommand*{\title}[1]{\gdef\thesisTitle{#1}}
\newcommand*{\degree}[1]{\gdef\thesisDegree{#1}}
\newcommand*{\supervisor}[1]{\gdef\thesisMentor{#1}}
\newcommand*{\supervisorTitle}[1]{\gdef\thesisMentorTitle{#1}}
\newcommand*{\seeking}[1]{\gdef\thesisSeeking{#1}}
\newcommand*{\holding}[1]{\gdef\thesisHolding{#1}}
\newcommand*{\readerOne}[1]{\gdef\thesisReaderOne{#1}}
\newcommand*{\readerTwo}[1]{\gdef\thesisReaderTwo{#1}}
\newcommand*{\department}[1]{\gdef\thesisDepartment{#1}}
\newcommand*{\departmentChair}[1]{\gdef\thesisDepartmentChair{#1}}
\newcommand*{\graduateDean}[1]{\gdef\thesisDean{#1}}
\renewcommand*{\date}[1]{\gdef\thesisConfDate{#1}}
\renewcommand*{\author}[1]{\gdef\thesisAuthorName{#1}}
\renewcommand{\abstract}[1]{\gdef\thesisAbstract{#1}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Optional parameters
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\acknowledgements}[1]{\@makeAcknowledgementstrue\gdef\th@acknowledgementsStash{#1}}
\newcommand{\dedication}[1]{\@makeDedicationtrue\gdef\th@dedicationStash{#1}}
\newcommand{\attributions}[1]{\@makeAttributionstrue\gdef\th@attributionsStash{#1}}% Blake added, 2021
\newcommand*{\readerThree}[1]{\@makeReaderThreetrue\gdef\thesisReaderThree{#1}}
\newcommand*{\readerFour}[1]{\@makeReaderFourtrue\gdef\thesisReaderFour{#1}}
\newcommand*{\readerFive}[1]{\@makeReaderFivetrue\gdef\thesisReaderFive{#1}}
\newcommand*{\makeCopyrightPage}{\@makeCopyrightPagetrue}
\newcommand*{\makeListOfFigures}{\@makeLoFtrue}
\newcommand*{\makeListOfTables}{\@makeLoTtrue}
%\newcommand*{\stack}{}                                                         % Alvin's Note: Stacking is obsolete. Handled by the subsections respective headers
%-------------------------------------------------------------------------------------------------------------------------------%
% Handy table spacing macros: \abovespace, \belowspace
%% Alvin's Note: Obsolete. Do not use
%\def\abovestrut#1{}
%\def\belowstrut#1{}
%\def\abovespace{}
%\def\aroundspace{}
%\def\belowspace{}
%-------------------------------------------------------------------------------------------------------------------------------%
% Rysavy: footnotes must have the same indent as paragraph
\RequirePackage{manyfoot}
\RequirePackage[bottom]{footmisc}                                               % Blake added 2021: ensures bottom page footnotes in main body text
% the footnote indent should be 0.5in, which is parindent
\SetFootnoteHook{\singlespace\hspace{\dimexpr 0.5in-3ex \relax}}
\DeclareNewFootnote{A}
% the footnotes need to start with 1 at the beginning of each chapter
\renewcommand{\footnote}[1]{\footnoteA{#1}}
%\def\footnoterule{\vspace*{0.1em}\kern-3\p@
%  \hrule \@width 2in \kern 2.6\p@} % the \hrule is .4pt high
%\renewcommand{\footnoterule}{%
%  \kern -3pt
%  \hrule width \textwidth height 1pt
%  \kern 2pt
%}
% if you start a chapter without a section, you need this to have the paragraph indented
\RequirePackage{indentfirst}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake added, 2021
\RequirePackage{xstring}                        % Adds macros to manipulate/parse strings of characters/tokens (needs e-TEX)
\RequirePackage{xparse}                         % Provides \<New,Renew,Provide,Declare><Document,ExpandableDocument><Command,Environment> w/ extensive parameter options
\RequirePackage{siunitx}                        % Provides SI unit symbols/commands
\RequirePackage{xfrac}                          % Provides \sfrac: solidus alternative to virgule \nicefrac & \tfrac
\RequirePackage{cancel}                         % Provides \cancel, \cancelto: cancel "slash" math terms or w/ arrow to value (e.g. 0 or inf)
\RequirePackage{calc}                           % Provides internal TeX calculation capabilities & commands
\RequirePackage{mathtools}                      % Provides many improvements/additions to 'amsmath'
\RequirePackage{etoolbox}
%\RequirePackage{fixltx2e}
%\RequirePackage{dblfloatfix}
\RequirePackage{algpseudocode}                  % Adds many algorithm writing styles and utilities for user definined styles
\RequirePackage{algorithmicx}                   % Adds many algorithm writing styles and utilities for user definined styles
\RequirePackage{algorithm}                      % Adds titledauto numbered environment enclosing 'algorithmic' environment content
%\algsetup{linenodelimiter=)}
\RequirePackage{enumitem}                       % Provides more options/control of enumerate environment numbering/lettering
\RequirePackage{scalerel}                       %  relative scale/stretch delimiters
\RequirePackage{stackengine}                    % Add ability to stack text, math, symbols/glyphs, images, etc
%\RequirePackage{isodate}
\RequirePackage{datetime2}
\RequirePackage{mfirstuc}                       % Provides \capitalisewords to capitlize 1st letter of text, incl. modifiable list of words to ignore (e.g. of, or, etc.)
\RequirePackage[normalem]{ulem}                 % Provides text underlining/strikethrough commands and customizations
\RequirePackage{txfonts}
\RequirePackage{amsfonts}
\RequirePackage{bbm}
%\RequirePackage{bickham}
%\RequirePackage{pifont}                         % access to dingbat symbols
%\RequirePackage{pxfonts}
%\RequirePackage{bibentry}
%    \nobibliography*    % Read in .bbl file entries for in text \bibentry citations, but also create back matter Bibliography
%\RequirePackage[printwatermark]{xwatermark}
%\RequirePackage{draftwatermark}
%\SetWatermarkText{PREPRINT}
%\SetWatermarkScale{0.65}
%\SetWatermarkLightness{0.925}
%\RequirePackage{cite}
\RequirePackage{comment}
\RequirePackage{pgf}                            % Implementation of "portable graphics format"=basic layer underlying "Tikz"
\RequirePackage{tikz}                           % Provides extensive set of graphics/drawing commands
%-------------------------------------------------------------------------------------------------------------------------------%
%\makeatletter
%-------------------------------------------------------------------------------------------------------------------------------%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Register Variable & List Definitions/Configurations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%-------------------------------------------------------------------------------------------------------------------------------%
%\selectlanguage{UKenglish}
\newcounter{savedsection}
\newcounter{numAppendices}
\newlength\lsideWidth
%\setlength\textheight{9.0in}
%\setlength{\cftchapnumwidth}{2.85em}
%\renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{2.3em}}
%\renewcommand{\cftfigleader}{\normalfont\cftdotfill{\cftfigdotsep}}
%\renewcommand\@tocrmarg{2.75em}
%\renewcommand\@pnumwidth{1.85em}
%-------------------------------------------------------------------------------------------------------------------------------%
\newlist{attributionList}{enumerate}{2}                         % For inserting publication atteributions on Attributions page
\setlist[attributionList]{label=(\arabic*),ref={\arabic*},leftmargin=0.25in, topsep=0pt, partopsep=0pt, parsep=0pt, itemsep=0pt}
\newlist{authorList}{itemize}{1}                                % For inserting author contributions to each attribution
\setlist[authorList]{label=\textbullet, leftmargin={\labelwidth-\labelsep},topsep=0pt,itemsep=0pt, itemindent=0pt}
\newlist{notationList}{itemize}{1}                              % Generates more closely spaced lists for notation/glossary lists
\setlist[notationList]{label=\textbullet, itemsep=-6pt}
%-------------------------------------------------------------------------------------------------------------------------------%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Math Control Sequence & Symbol/Operator Definitions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%-------------------------------------------------------------------------------------------------------------------------------%
\global\let\biconditional\Leftrightarrow
\global\let\xp\expandafter
%-------------------------------------------------------------------------------------------------------------------------------%
\def\glet{\global\let}
\def\intactCitations{\interlinepenalty=\@M}                                     % Prevent page breaks mid citation
\def\ToCtitleBreaks{\interlinepenalty=0}                                        % Allow page breaks mic ToC title entry	
\def\setDocumentILP{\interlinepenalty=\@M}	
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\superscript}[1]{\ensuremath{^{\textrm{#1}}}}
\newcommand{\subscript}[1]{\ensuremath{_{\textrm{#1}}}}
\newcommand*{\defeq}{\mathrel{\vcenter{\baselineskip0.5ex \lineskiplimit0pt
                     \hbox{\scriptsize.}\hbox{\scriptsize.}}}%
                     =}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\vect}[1]{\vbox{\m@th \ialign {##\crcr\vectfill\crcr\noalign{\kern-2.95\p@ \nointerlineskip}$#1$\crcr}}\kern-2.1pt}
\newcommand{\setdef}[2]{\left\{\,#1\setor #2\,\right\}}                 % Defines set { #1 | #2 }
\newcommand{\setpad}{\;}                                                % Defines set definition open/close/mid padding space
\newcommand{\seqopen}{\left\lbrace}                                     % Defines sequence definition open (left) bracing
\newcommand{\seqclose}{\right\rbrace}                                   % Defines sequence definition close (right) bracing
\newcommand{\setopen}{\left\lbrace\setpad}                              % Defines set definition open (left) bracing + padding
\newcommand{\setclose}{\right\rbrace\setpad}                            % Defines set definition close (right) bracing + padding
\newcommand{\setwhere}{\setpad\middle\vert\setpad}                      % Defines set definition where/such that vert separator + padding
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\alignedbox}[3][white]{
    % #1 = color (optional, defaults to yellow)
    % #2 = before alignment
    % #3 = after alignment
    &
    \begingroup
    \settowidth\lsideWidth{$\displaystyle #2$}
    \addtolength\lsideWidth{\fboxsep+\fboxrule}
    \hspace{-\lsideWidth}
    \fcolorbox{black}{#1}{$\displaystyle #2 #3$}
    \endgroup
}
%-------------------------------------------------------------------------------------------------------------------------------%
\DeclareMathOperator{\degreesF}{\si{\degree} \mathsf{F}}                % degrees Fahrenheit symbol
\DeclareMathOperator{\degrees}{\si{\degree}}                            % degrees symbol
\DeclareMathOperator*{\diag}{diag}                                      % diagonal matrix label 'diag'
\DeclareMathOperator*{\rand}{rand}                                      % diagonal matrix label 'diag'
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand\Dotfill{\leavevmode\cleaders\hb@xt@ .33em{\hss .\hss }\hfill\kern\z@}
%\newcommand\attrref{}
\newcommand{\fsection}[3]{\section{#1}\label{#2}\input{#3}}
\newcommand{\fsubsection}[3]{\subsection{#1}\label{#2}\input{#3}}
\newcommand{\fsubsubsection}[3]{\subsubsection{#1}\label{#2}\input{#3}}
\newcommand{\subsubsubsection}[1]{\par\noindent\newline\textbf{#1}\hspace*{\fill}\\}
%*******************************************************************************************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%------------------------- 'subappendices' environment: command insertions into environment definition -------------------------%
%-------------------------------------------------------------------------------------------------------------------------------%
%*******************************************************************************************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
\newenvironment{attribution}{
    \begin{singlespace}
}{
    \end{singlespace}
}
%%-------------------------------------------------------------------------------------------------------------------------------%
%% In process
%%-------------------------------------------------------------------------------------------------------------------------------%
%\newcommand\addAttribution[3][]{
%    \begin{attributionList}
%    \item\begin{attribution}
%    %Schultze, B. E., M. Witt, Y. Censor, K. E. Schubert, and R. W. Schulte (2015). Performance of hull-detection algorithms for proton computed tomography reconstruction. In S. Reich and A. Zaslavski (Eds.), \textit{Infinite Products of Operators and Their Applications}, Volume 636 of \textit{Contemporary Mathematics}, pp. 211–224. American Mathematical Society.
%     B. E. Schultze, M. Witt, Y. Censor, K. E. Schubert, and R. W. Schulte, “Performance of hull-detection algorithms for proton computed tomography reconstruction,” in \textit{Infinite Products of Operators and Their Applications}, ser. Contemporary Mathematics, S. Reich and A. Zaslavski, Eds., vol. 636. American Mathematical Society, 2015, pp. 211–224.
%    \end{attribution}%
%    \ifx#1\@empty\else\label{#1}\fi%
%
%}
%===============================================================================================================================%
% Redefine \Xmark sectioning commands to store the current X title for retrieval: X=chapter/section/subsection/ubsubsection
%===============================================================================================================================%
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake added, 2021
% Blake, 2023: expanded to include subsection and subsubsection
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand*\currChapTitle{}                                                    % Stores current chapter title
\newcommand*\currSecTitle{}                                                     % Stores current section title
\newcommand*\currSubsecTitle{}                                                  % Stores current subsection title
\newcommand*\currSubsubsecTitle{}                                                  % Stores current subsubsection title
%-------------------------------------------------------------------------------------------------------------------------------%
\let\old@chaptermark=\chaptermark
\renewcommand*\chaptermark[1]{%
  \renewcommand*\currChapTitle{#1}%
  \old@chaptermark{#1}%
}
%-------------------------------------------------------------------------------------------------------------------------------%
\let\old@sectionmark=\sectionmark
\renewcommand*\sectionmark[1]{%
  \renewcommand*\currSecTitle{#1}%
  \old@sectionmark{#1}%
}
%-------------------------------------------------------------------------------------------------------------------------------%
\let\old@subsectionmark=\subsectionmark
\renewcommand*\subsectionmark[1]{%
  \renewcommand*\currSubsecTitle{#1}%
  \old@subsectionmark{#1}%
}
%-------------------------------------------------------------------------------------------------------------------------------%
\let\old@subsubsectionmark=\subsubsectionmark
\renewcommand*\subsubsectionmark[1]{%
  \renewcommand*\currSubsubsecTitle{#1}%
  \old@subsubsectionmark{#1}%
}
%===============================================================================================================================%
% Appendix and Subappendix construction: environments, formatting, and pages
%===============================================================================================================================%
\BeforeBeginEnvironment{appendices}{\thesisAppendixPage}
\AtEndEnvironment{appendices}{\auxwrite@regset{numAppendices}{\the\value{chapter}}}
%-------------------------------------------------------------------------------------------------------------------------------%
% Subappendix wrapper
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\subappendix}[2]{%
     \ifstrempty{#1}{
        \def\subappendixTitle{\currChapTitle:~\capitalisewords{Supplemental Information}}
    }{
        \def\subappendixTitle{\capitalisewords{#1}}
    }
    \begin{subappendices}%
        #2
    \end{subappendices}
    % Temp workaround for "subappendices" environment usage independent from \subappendix w/o issue
    \gundef{\subappendixTitle}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\BeforeBeginEnvironment{subappendices}{%
    \setcounter{savedsection}{\value{section}}
    \setcounter{section}{0}
}
\AtBeginEnvironment{subappendices}{%
    \renewcommand{\thechapter}{\arabic{chapter}}
    \renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
    \renewcommand{\thesubsection}{\arabic{chapter}.\Alph{section}.\arabic{subsection}}
	\renewcommand{\thesubsubsection}{\arabic{chapter}.\Alph{section}.\arabic{subsection}.\Roman{subsubsection}}
	{
		\centering
		\vspace*{0.43in}
		{\appendixname}
        \hspace{-0.25em} % for the chapter text to look pretty.
		\ARABICText{\thechapter}
	}
    \@afterheading
    {
    	\centering\normalfont
		\vspace{-1ex}
		\@ifundefined{subappendixTitle}{
            \currChapTitle\singlespacing{\currChapTitle:~\capitalisewords{Supplemental Information}}\\
        }{
            \singlespacing{\subappendixTitle}\\
		}
        \vspace{0.13in}
	}
    \addcontentsline{toc}{section}{\appendicesToCtitle}
    %\addcontentsline{toc}{section}{\appendicesHeading~\ARABICText{\thechapter}\numberline{\nowtitle:~\capitalisewords{Supplemental Information}}}
    \counterwithin{figure}{section}
    \counterwithin{table}{section}
}
%===============================================================================================================================%
% Helper commands simplifying the writing of macro/counter values to .aux file
%-------------------------------------------------------------------------------------------------------------------------------%
% Info written to aux file can be read back on next compile, making info from later in the document available at the beginning
% of the document after the next compile. e.g. count of appendix chapters to control whether there is an Appendix or Appendices
%===============================================================================================================================%
\DeclareDocumentCommand\auxwrite@macro{O{xdef} m m}
{
        \protected@write\@auxout{}%
        {%
                \xp\xp\xp\string%
                \xp\csname\xp#1\xp\endcsname%\newcommand%
                \xp\string%
                \xp#2%
                \xp{#3}%
        }%
}
%-------------------------------------------------------------------------------------------------------------------------------%
\DeclareDocumentCommand\auxwrite@regset{O{setcounter} m m}
%\newcommand\auxwrite@regset[3][setcounter]%
{%
        \protected@write\@auxout{}%
        {%
                \xp\xp\xp\string%
                \xp\csname #1\endcsname%
                \xp{\xp\string#2}%
                \xp{#3}%
        }%
}
%-------------------------------------------------------------------------------------------------------------------------------%
%*******************************************************************************************************************************%
%************************************************ END: Dissertation-Preamble.tex ***********************************************%
%*******************************************************************************************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%

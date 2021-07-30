% %%%%%%%%%%%%%%%%%%%%%%%%%
%
% Baylor University Master's Thesis LaTeX Template
%
% Last Updated in June 2014
%
% %%%%%%%%%%%%%%%%%%%%%%%%%
%
% Some code derived from an early template
% created by Jeff Donahoo (2000), with additional
% inspiration from a template by David Jack (2011);
% rewritten and simplified by Jonathan Drake (2013).
% additional stuff by Alvin Jude (2014)
%
% %%%%%%%%%%%%%%%%%%%%%%%%%

% ================== Changelog ================================
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
% =============================================================

\ProvidesClass{thesis}[2014/06/01]


% draft	draft heading, no graphics loaded, etc.
% short	front matter omitted
\newif\if@makeDraftThesis
\newif\if@makeShortThesis
\newif\if@isDissertation
\@makeDraftThesisfalse
\@makeShortThesisfalse
%\@isDissertationtrue
\@isDissertationfalse
\DeclareOption{draft}{\@makeDraftThesistrue}
\DeclareOption{short}{\@makeShortThesistrue}
\DeclareOption{dissertation}{\@isDissertationtrue}
\ProcessOptions

% Load the parent class: report
\LoadClass[12pt,letterpaper]{report}
% ALVIN: Simplifies adding comments
\newcommand{\comment}[1]{}

% General document configuration
\AtBeginDocument
{
	\setlength{\topmargin}{0.0in}
	\setlength{\headheight}{0.0in}
	\setlength{\headsep}{0.0in}
	\setlength{\topskip}{0.0in}
	\setlength{\footskip}{0.4in}
	\setlength{\textheight}{9.0in} % 1in margins
	\setlength{\textwidth}{6.0in} % 1.25in margins
	\setlength{\oddsidemargin}{0.25in} % 1.25in margin relative to 1in default
	\setlength{\evensidemargin}{0.25in} % 1.25in margin relative to 1in default
	\setlength{\parindent}{0.5in} % used in triplespace
	\setlength{\labelsep}{0.5em}
	\setlength{\labelwidth}{1.5em}
	
	\onecolumn
	\raggedbottom
	\doublespacing
	\pagenumbering{arabic}

	\setcounter{tocdepth}{2}
	\setcounter{secnumdepth}{3}
	
}

% We need both double and single spacing
\RequirePackage{setspace}

% -----------------------------------------------
% TABLE FORMATING STUFF
% This is confusing because the caption is at the top.
%%%%%%% THERE HAS TO BE A BETTER WAY JIM
% aboveskip = distance between caption and float
% belowskip = distace between caption and text
% Set the caption label separator and spacing for all floats
\RequirePackage{caption}
\captionsetup{labelsep=colon,font=singlespacing}
\captionsetup[table]{belowskip=-0.0em, aboveskip=1em, justification=centering}
%\captionsetup[figure]{belowskip=2em, aboveskip=2em}

% Blake, 2021:  Was > triple spaced between figure and caption (called legend in Guidelines)
% Spacing between a Figure & a Table, w/ no intervening text, is doubled up, which helps
% discern between them but isn't addressed in the guidelines and may be asked to change it.
\captionsetup[figure]{belowskip=-1em, aboveskip=1em}

% because we set this which determines the distance between the table
% and the preeceeding / proceeding text, we HAVE to set the belowskip in the thing above to 0
% this is also applicable for the images and pictures. Fortunately the configuration
% for both are the same. If they're not, then we're in big barney
\setlength{\intextsep}{2em} % Vertical space for floats in the middle of the page
\setlength{\textfloatsep}{3.0em} % Vertical space for floats at the top of the page
% -----------------------------------------------
\setlength{\abovecaptionskip}{2em}
%\setlength{\belowcaptionskip}{-0.01em}

% Fix the ToC style for appendices
\RequirePackage[titletoc]{appendix}

% Optional additional packages
\RequirePackage{graphicx}                       %\RequirePackage[pdftex]{graphicx}
\RequirePackage{amsmath}
% Blake, 2021: Switched to IEEEtran bibstyle. Retaining "chicago" package inclusion
% yields parenthetical, rather than bracketed, citation numbers.
%\RequirePackage{chicago}
% ALVIN: Needs this
\RequirePackage{multirow}
\RequirePackage{hhline}
\RequirePackage{url} % for newclude bibtex
\RequirePackage{newclude}
\RequirePackage{breakcites}
\RequirePackage[titles]{tocloft}

\brokenpenalty=10000	% Eliminates page breaks at hyphens
\clubpenalty=10000 		% Eliminates orphan lines
\widowpenalty=10000 	% Eliminates widowed lines
	

% Set the names of prologue pages
\newcommand*{\ToCname}{Table of Contents}
\newcommand*{\LoFname}{List of Figures}
\newcommand*{\LoTname}{List of Tables}
\newcommand*{\acknowledgename}{Acknowledgments}
\newcommand*{\dedicationname}{Dedication}
\newcommand*{\attributionname}{Attributions}                                % Blake added, 2021
\newcommand*{\appendicesname}{Appendix}
\newcommand*{\appendicestitle}{Appendices} % Plural because more than one
\renewcommand*{\chaptername}{Chapter}
\newcommand*{\bibliographyname}{Bibliography}
%\renewcommand*{\abstractname}{Abstract}

% Set the headings of prologue pages
\newcommand*{\ToCheading}{\MakeUppercase{\ToCname}}
\newcommand*{\LoFheading}{\MakeUppercase{\LoFname}}
\newcommand*{\LoTheading}{\MakeUppercase{\LoTname}}
\newcommand*{\acknowledgeheading}{\MakeUppercase{\acknowledgename}}
\newcommand*{\dedicationheading}{\MakeUppercase{\dedicationname}}
\newcommand*{\attributionheading}{\MakeUppercase{\attributionname}}                                % Blake added, 2021
\newcommand*{\appendicesheading}{\MakeUppercase{\appendicesname}}
\newcommand*{\appendicestitleheading}{\MakeUppercase{\appendicestitle}} % Plural because more than one
\newcommand*{\chapterheading}{\MakeUppercase{\chaptername}}
\newcommand*{\bibliographyheading}{\MakeUppercase{\bibliographyname}}
\newcommand*{\abstractheading}{\MakeUppercase{\abstractname}}

% Convert to form expected by other packages
\renewcommand*{\appendixname}{\normalsize\normalfont\appendicesheading}
\renewcommand*{\bibname}{\normalsize\normalfont\bibliographyheading}

% Heading format
\renewcommand*{\thechapter}{\arabic{chapter}}
\renewcommand*{\thesection}{\thechapter.\arabic{section}}
\renewcommand*{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand*{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

% Enumerated list labels
\renewcommand*{\theenumi}{\arabic{enumi}}
\renewcommand*{\theenumii}{\alph{enumii}}
\renewcommand*{\theenumiii}{\roman{enumiii}}
\renewcommand*{\theenumiv}{\alph{enumiv}}
\renewcommand*{\labelenumi}{(\theenumi)}
\renewcommand*{\labelenumii}{(\theenumii)}
\renewcommand*{\labelenumiii}{(\theenumiii)}
\renewcommand*{\labelenumiv}{(\theenumiii.\theenumiv)}

% Itemized list labels
\renewcommand*{\labelitemi}{\textbullet}
\renewcommand*{\labelitemii}{\textasteriskcentered}
\renewcommand*{\labelitemiii}{\normalfont \bfseries \textendash}
\renewcommand*{\labelitemiv}{\textperiodcentered}

% Margins for lists
\setlength{\leftmargini}{3.5em}
\setlength{\leftmarginiii}{2.2em}
\setlength{\leftmarginiv}{2.2em}
\setlength{\leftmarginv}{2.2em}
\setlength{\leftmarginvi}{2.2em}
\setlength{\leftmargin}{\leftmargini}
\setlength{\labelwidth}{1.5em}


	
% Macro that converts the given number to a corresponding number name
\newcommand{\arabicText}[1]
{
	\ % Force a space
	\ifnum0<0#1 % Test for chapter number vs appendix letter
		\ifcase#1
			ZERO \or ONE \or TWO \or THREE \or FOUR \or
			FIVE \or SIX \or SEVEN \or EIGHT \or NINE \or TEN \or
			ELEVEN \or TWELVE \or THIRTEEN \or FOURTEEN \or
			FIFTEEN \or SIXTEEN \or SEVENTEEN \or EIGHTEEN \or
			NINETEEN \or TWENTY
		\fi
	\else
		#1 % Pass-through
	\fi
}



% Chapter command
\renewcommand\chapter
{
	\if@openright\cleardoublepage\else\clearpage\fi % first page on right
	\thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter
}

% Chapter heading
\def\@chapter[#1]#2
{
	% the footnotes should start with 1 in each chapter
	\setcounter{footnoteA}{0}
	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%

		\addcontentsline{toc}{chapter}{\protect\numberline{\rm\thechapter}\rm#1}
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{8\p@}} % 8pt spacing
	\addtocontents{lot}{\protect\addvspace{8\p@}} % 8pt spacing
	{
		\centering
		\vspace*{0.43in}
		\MakeUppercase{\@chapapp{}}%
		\hspace{-0.25em} % for the chapter text to look pretty.
		\arabicText{\thechapter}
		\vspace{-1ex}
		\singlespacing{#2}\\
		\vspace{0.13in}
	}
	\@afterheading
}

% Section headings
% \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}*[<altheading>]{<heading>}
\renewcommand{\section}
{%
	\@startsection{section}{1}{0pt}{1em}{0.001ex}%skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
	{\centering\normalfont\slshape\normalsize}
}
% IF there is content text immediately after level 3,
%   THEN distance between Level 3 and Content text = doublespace.
% IF there is level 4 header immediately after level 3,
%   THEN distance between Level 3 and Level 4 = triplespace.
	
\renewcommand{\subsection}[1]
{
	\@startsection{subsection}{2}{0pt}{0.001ex}{0.001ex}
	{\vspace{1em}\normalfont\slshape\normalsize}{#1}
}

\renewcommand{\subsubsection}[1]
{%
        \vspace{1em}
	\@startsection{subsubsection}{3}{\parindent}{0.001em}{-1em}%
	{\normalfont\slshape\normalsize}{#1\hspace{-3ex}}{.} %adds a period/fullstop/dot after the title
}

%% standardize itemize and enumerate spacing
\let\oldenumerate\enumerate
\renewcommand{\enumerate}{
  \oldenumerate
  \setlength{\itemsep}{1em}
  \setlength{\parskip}{-1em}
  \setlength{\parsep}{0pt}	
}
%% standardize itemize and enumerate spacing
\let\olditemize\itemize
\renewcommand{\itemize}{
  \olditemize
  \setlength{\parsep}{-\baselineskip}	
  \setlength{\itemsep}{1em}
  \setlength{\parskip}{-1em}

}

% removes extra space after the list (itemize). So it will be double space instead of triple
\let\@oldlistI\@listI
\renewcommand{\@listI}{
	\@oldlistI
	\topsep=0pt
}

% Internal boolean variables
\newcommand{\th@dedicationStash}{\relax}
\newcommand{\th@acknowledgementsStash}{\relax}
\newif\if@makeLoF
\newif\if@makeLoT
\newif\if@makeDedication
\newif\if@makeAcknowledgements
\newif\if@makeAttributions                  % Blake added, 2021
\newif\if@makeCopyright
\newif\if@makeReaderThree
\newif\if@makeReaderFour
\newif\if@makeReaderFive

% Initial values for boolean variables
\@makeLoFfalse
\@makeLoTfalse
\@makeCopyrighttrue
\@makeDedicationfalse
\@makeAcknowledgementsfalse
\@makeAttributionsfalse                     % Blake added, 2021
\@makeReaderThreefalse
\@makeReaderFourfalse
\@makeReaderFivefalse

% Internal macro for drawing signature lines
\newcommand*{\thesisSignature}[2]
{
		\normalsize
		%\vspace{0.05in}
		%\\
		\vrule width #2 height 0.1mm\\[0.1mm-2ex]
        %[-0.5\baselineskip]
        %\vspace{0.5em}
		#1
}

% Special footer for the signature page
\RequirePackage{fancyhdr}
\fancypagestyle{masters_title_page}
{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\cfoot{\footnotesize \textit{Page bearing signatures is kept on file in the Graduate School.}}
}

%-------------------------------------------------------------------------------------------------------------------------------%
% Blake added, 2021
\RequirePackage{pdfpages}

% Adds option to import title/signature page directly from Grad School provided PDF form
\newif\if@insertSignaturePage
\@insertSignaturePagefalse
\newcommand*\signaturePageAddr{}
\newcommand*\insertSignaturePage[1]{
    \@insertSignaturePagetrue
    \renewcommand*\signaturePageAddr{#1}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Signature page (attempts to match BUGS 2013 guidelines)
% Blake 2021, in progress: correcting margins and positioning/spacing of lines.
% Attempting to match Grad School provided "4 Line Signature Page", though it extends
% into the 1" top and bottom margins
\newcommand*{\thesisTitlePage}
{
    \if@insertSignaturePage%
        %\include{\signaturePageAddr}
        %\include{./Forms/SignaturesPage.pdf}
        \includepdf{\signaturePageAddr}
    \else
    	\thispagestyle{masters_title_page}
    	\doublespacing	
        {
            \vspace*{0.5ex -\baselineskip}
            \centering
        %\begin{center}
    	%\vspace*{0.1in}
    		\thesisTitle \\[0.5\baselineskip-1.5ex]
    		by \\[0.5\baselineskip-1.5ex-0.3mm]
    		%by \\[0.5\baselineskip-0.5em - 0.2mm]
    		\thesisAuthorName, \thesisHolding \\[-1.5ex - 0.2mm + 0.5\baselineskip]
    		A Dissertation \\[-1.em + 0.3mm + 0.5\baselineskip]
    		Approved by the \thesisDepartment\\[-0.5em +0.2mm + 0.5\baselineskip]
    		\thesisSignature{\thesisDepartmentChair, Chairperson}{4.0in}\\[0.5\baselineskip - 0.2mm]
    	%\vspace{0.1in}
        	\singlespacing
            	Submitted to the Graduate Faculty of\\
        	Baylor University in Partial Fulfillment of the \\
        	Requirements for the Degree \\
        	of \\[-0.5ex + 0.2mm + 0.5\baselineskip]
        	\thesisDegree\\[\baselineskip]
        }
    	\vspace{2\baselineskip}
    	%\vfill
    	\doublespacing
    	%\hspace{0.25in}
    	%\setlength\leftskip{0.5in}
        {   %
            	\centering
                %\addtolength{\leftskip}{-2.5in}
                Approved by the Dissertation Committee\\
         		\thesisSignature{\thesisMentor, Chairperson}{80mm}\\
         		\thesisSignature{\thesisReaderOne}{80mm}\\
         		\thesisSignature{\thesisReaderTwo}{80mm}\\
    		\if@makeReaderThree \thesisSignature{\thesisReaderThree}{80mm}\\ \fi
    		\if@makeReaderFour \thesisSignature{\thesisReaderFour}{80mm}\\ \fi
    		\if@makeReaderFive \thesisSignature{\thesisReaderFive}{80mm}\\ \fi
    		%\\
    	}
    	
    	\vspace{0.25in}
    	\vfill	
    	%\addtolength{\leftskip}{-1.0in}
        %\setlength\leftskip{-1.25in}
        {
    		%\centering
    		\begin{flushleft}
                \centering
                Accepted by the Graduate School \\
        		\vspace{-0.075in}
        		\thesisConfDate
        		\thesisSignature{\thesisDean, Dean}{80mm} \\
            \end{flushleft}
    	}	
    	%\end{center}
    \fi
    \clearpage
}

% Copyright page (attempts to match BUGS 2013 guidelines)
\newcommand*{\thesisCopyrightPage}
{
	\if@makeCopyright
		\thispagestyle{empty}
		\vspace*{8.19in}
		\begin{center}
		Copyright \copyright{} \the\year\ by  \thesisAuthorName \\
		All rights reserved
		\end{center}
		\clearpage
	\fi
}

% Abstract page (attempts to match BUGS 2013 guidelines)
% Blake, 2021: Replaced "center" environment with braced \centering clause,
% otherwise interferes with \vspace* generating heading at the 2.5" mark
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
	{
        \centering
        \vspace*{1.3in}%
        \abstractheading\\
		\thesisTitle\\
		\thesisAuthorName, \thesisSeeking\\
        \thesisMentorTitle: \thesisMentor\\[1em]% Blake added, 2021: creates so called "triple space"
    }
    \par
    \thesisAbstract
	\clearpage
}


% Table of contents page
% Massive change just because overflowing chapter titles have to be single-spaced
% uses the tocloft package
%\renewcommand\cftchapleader{\cftdotfill{\cftchapdotsep}}
\renewcommand\cftchapdotsep{\cftsecdotsep} % first define the chap dots to be equal to the section dots
\renewcommand\cftchapleader{\normalfont\cftdotfill{\cftchapdotsep}} % then remove the bolds.
\renewcommand\cftchappagefont{\normalfont} % this defaults to bold, overwrite that.
\renewcommand\cftpartleader{\normalfont\cftdotfill{\cftchapdotsep}} % then remove the bolds.
\renewcommand\cftpartpagefont{\normalfont}
\renewcommand\cftpartafterpnum{\vspace{1em}}
\renewcommand\cftchapafterpnum{\vspace{1em}}
\renewcommand\cftsecafterpnum{\vspace{1em}}
\renewcommand\cftsubsecafterpnum{\vspace{1em}}
\renewcommand\cftsubsubsecafterpnum{\vspace{1em}}
\renewcommand\cftfigafterpnum{\vspace{1em}}
\renewcommand\cfttabafterpnum{\vspace{1em}}
\setlength{\cftfignumwidth}{2.85em}
\setlength{\cfttabnumwidth}{2.85em}
%\renewcommand*{\l@section}{\@dottedtocline{1}{1.5em}{2.3em}}
%\renewcommand{\cftfigleader}{\normalfont\cftdotfill{\cftfigdotsep}}
\newcommand{\thesisToCpage}
{

	\renewcommand*{\contentsname}{\vspace*{-0.27in}\centering\normalsize\normalfont\ToCheading\vspace{-0.25in}}
	\begin{singlespace}
	\tableofcontents
	\end{singlespace}

	\clearpage
}

% List of figures page (optional)
% Blake, 2021: vspace*{-0.27in -> -0.77in} to create heading at 1" mark
\newcommand{\thesisLoFpage}
{
	\if@makeLoF
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\LoFheading}
		\renewcommand*{\listfigurename}{\vspace*{-0.27in}\centering\normalsize\normalfont\LoFheading\vspace{-0.25in}}
		\begin{singlespace}
		\listoffigures
		\end{singlespace}
		\clearpage
	\fi
}

% List of tables page (optional)
% Blake, 2021: vspace*{-0.27in -> -0.77in} to create heading at 1" mark
\newcommand{\thesisLoTpage}{
	\if@makeLoT
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\LoTheading}
		\renewcommand*{\listtablename}{\vspace*{-0.27in}\centering\normalsize\normalfont\LoTheading\vspace{-0.25in}}
		\begin{singlespace}
		\listoftables
		\end{singlespace}
		\clearpage
	\fi
}

% Acknowledgments page (optional)
\newcommand{\thesisAcknowledgementpage}
{
	\if@makeAcknowledgements
		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\acknowledgeheading}
		\begin{center}\vspace*{0.3in}\normalfont\normalsize\acknowledgeheading\end{center}
		\hspace{\parindent}
		\th@acknowledgementsStash
		\clearpage
	\fi
}

% Dedication page (optional)
\newcommand{\thesisDedicationpage}
{
	\if@makeDedication		
		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\dedicationheading}
		%\begin{center}\vspace*{0.25in}\normalfont\normalsize{}\end{center} % SHOWS the dedication title on the page
		\begin{center}\vspace*{0.25in}\normalfont\normalsize{}\end{center} % DOES NOT show the dedication title on the actual page
		\vspace{0.75in} % badhack to make sure dedication starts at 3inches from the top
		\begin{center}\th@dedicationStash\end{center}
		\clearpage
	\fi
}

% Attributions page (optional)
\newcommand{\thesisAttributionspage}
{
	\if@makeAttributions
		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\attributionheading}
		\begin{center}\vspace*{0.3in}\normalfont\normalsize\attributionheading\nolinebreak\end{center}
		\vspace{-1\baselineskip}
        \hspace{\parindent}
        \th@attributionsStash
		\clearpage
	\fi
}
\newcommand{\thesisAppendixPage}{

		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\appendicestitleheading}
		%\begin{center}\vspace*{0.25in}\normalfont\normalsize{}\end{center} % SHOWS the dedication title on the page
		\vspace*{\fill}
		\begin{center}\vspace*{-2.75in}\normalfont\normalsize{}\end{center} % DOES NOT show the dedication title on the actual page
		\begin{center}\appendicestitleheading\end{center}
		\vspace*{\fill}
		\clearpage
}

% The thesis prologue (front matter)
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
    \thesisAttributionspage                                 % Blake added, 2021
}

% Intercept the bibliography body
\AtBeginDocument
{
	\def\thebibliography#1
	{
		\clearpage
		\addcontentsline{toc}{chapter}{\bibname}
		\vspace*{0.42in}
		\centering\normalfont\normalsize\bibname
		\vspace{2ex}
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

% Intercept the main document (basically the main function here)
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

% Expected parameters
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

% Optional parameters
\newcommand{\acknowledgements}[1]{\@makeAcknowledgementstrue \gdef\th@acknowledgementsStash{#1}}
\newcommand{\dedication}[1]{\@makeDedicationtrue \gdef\th@dedicationStash{#1}}
\newcommand{\attributions}[1]{\@makeAttributionstrue \gdef\th@attributionsStash{#1}}               % Blake added, 2021
\newcommand*{\readerThree}[1]{\@makeReaderThreetrue \gdef\thesisReaderThree{#1}}
\newcommand*{\readerFour}[1]{\@makeReaderFourtrue \gdef\thesisReaderFour{#1}}
\newcommand*{\readerFive}[1]{\@makeReaderFivetrue \gdef\thesisReaderFive{#1}}
\newcommand*{\makeListOfFigures}{\@makeLoFtrue}
\newcommand*{\makeListOfTables}{\@makeLoTtrue}

% Handy table spacing macros: \abovespace, \belowspace
%% Alvin's Note: Obsolete. Do not use
\def\abovestrut#1{}
\def\belowstrut#1{}
\def\abovespace{}
\def\aroundspace{}
\def\belowspace{}
\def\amanda{}

% Alvin's Note: Stacking is obsolete. Handled by the subsections respective headers
\newcommand*{\stack}{}

% Rysavy: footnotes must have the same indent as paragraph
\RequirePackage{manyfoot}
\RequirePackage[bottom]{footmisc}
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
\RequirePackage{xcolor}                         % Provides
\RequirePackage{siunitx}                        % Provides SI unit symbols/commands
\RequirePackage{xfrac}                          % Provides \sfrac: solidus alternative to virgule \nicefrac & \tfrac
\RequirePackage{cancel}                         % Provides \cancel, \cancelto: cancel "slash" math terms or w/ arrow to value (e.g. 0 or inf)
\RequirePackage{calc}                           % Provides internal TeX calculation capabilities & commands
\RequirePackage{mathtools}                      %
%\RequirePackage{cite}\
\RequirePackage{etoolbox}
%\RequirePackage{fixltx2e}
%\RequirePackage[printwatermark]{xwatermark}
%\RequirePackage{dblfloatfix}
\RequirePackage{algpseudocode}                   % Adds many algorithm writing styles and utilities for user definined styles
%\RequirePackage{algorithm2e}                   % Adds many algorithm writing styles and utilities for user definined styles
%\RequirePackage{algorithmic}                   % Adds many algorithm writing styles and utilities for user definined styles
\RequirePackage{algorithmicx}                   % Adds many algorithm writing styles and utilities for user definined styles
\RequirePackage{algorithm}
%\algsetup{linenodelimiter=)}
\RequirePackage{enumitem}
\RequirePackage{multirow}
\RequirePackage{stackengine,scalerel}
%\RequirePackage{isodate}
\RequirePackage{datetime2}
\RequirePackage{mfirstuc}
\RequirePackage[normalem]{ulem}
\RequirePackage{txfonts}
\RequirePackage{amsfonts}
\RequirePackage{bbm}
%\RequirePackage{bickham}
%\RequirePackage{pifont}                         % access to dingbat symbols
%\RequirePackage{pxfonts}
\RequirePackage{appendix}                       %[title]
%\RequirePackage[round]{natbib}
%\RequirePackage{bibentry}
%    \nobibliography*    % Read in .bbl file entries for in text \bibentry citations, but also create back matter Bibliography
%\RequirePackage{draftwatermark}
%\SetWatermarkText{PREPRINT}
%\SetWatermarkScale{0.65}
%\SetWatermarkLightness{0.925}
%\RequirePackage{cite}
\RequirePackage{comment}
\RequirePackage{pgf}
\RequirePackage{tikz}
%-------------------------------------------------------------------------------------------------------------------------------%
%\makeatletter
%-------------------------------------------------------------------------------------------------------------------------------%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Register Variable & List Definitions/COnfigurations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%-------------------------------------------------------------------------------------------------------------------------------%
%\selectlanguage{UKenglish}
\newcounter{savedsection}
\newlength\lsideWidth
\setlength\textheight{9.0in}
%-------------------------------------------------------------------------------------------------------------------------------%
\newlist{attributionList}{enumerate}{2}
\setlist[attributionList]{label=(\arabic*),ref={\arabic*},leftmargin=0.25in, topsep=0pt, partopsep=0pt, parsep=0pt, itemsep=0pt}
\newlist{authorList}{itemize}{1}
\setlist[authorList]{label=\textbullet, leftmargin={\labelwidth-\labelsep},topsep=0pt,itemsep=0pt, itemindent=0pt}
\newlist{notationList}{itemize}{1}
\setlist[notationList]{label=\textbullet, itemsep=-6pt}
%-------------------------------------------------------------------------------------------------------------------------------%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Math Control Sequence & Symbol/Operator Definitions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%-------------------------------------------------------------------------------------------------------------------------------%
\global\let\biconditional\Leftrightarrow
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
\newcommand*\currChapTitle{}
\newcommand*\currSecTitle{}
%-------------------------------------------------------------------------------------------------------------------------------%
\let\oldchaptermark=\chaptermark
\renewcommand*\chaptermark[1]{%
  \renewcommand*\currChapTitle{#1}%
  \oldchaptermark{#1}}
%-------------------------------------------------------------------------------------------------------------------------------%
\let\oldsectionmark=\sectionmark
\renewcommand*\sectionmark[1]{%
  \renewcommand*\currSecTitle{#1}%
  \oldsectionmark{#1}}
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
%%-------------------------------------------------------------------------------------------------------------------------------%
%\newcommand*\currChapTitle{}
%\newcommand*\currSecTitle{}
%%-------------------------------------------------------------------------------------------------------------------------------%
%\let\oldchaptermark=\chaptermark
%\renewcommand*\chaptermark[1]{%
%  \renewcommand*\currChapTitle{#1}%
%  \oldchaptermark{#1}}
%%-------------------------------------------------------------------------------------------------------------------------------%
%\let\oldsectionmark=\sectionmark
%\renewcommand*\sectionmark[1]{%
%  \renewcommand*\currSecTitle{#1}%
%  \oldsectionmark{#1}}
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
    \gundef{\subappendixTitle} % Temp workaround for "subappendices" environment use independently from \subappendix w/o issue
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
		\arabicText{\thechapter}
	}
    \@afterheading
    {
    	\centering\normalfont
		\vspace{-1ex}
		\@ifundefined{subappendixTitle}{
            \singlespacing{\currChapTitle:~\capitalisewords{Supplemental Information}}\\
        }{
            \singlespacing{\subappendixTitle}\\
		}
        \vspace{0.13in}
	}
    \addcontentsline{toc}{section}{\appendicestitleheading}
    %\addcontentsline{toc}{section}{\appendiceheading~\arabicText{\thechapter}\numberline{\nowtitle:~\capitalisewords{Supplemental Information}}}
    \counterwithin{figure}{section}
    \counterwithin{table}{section}
}
%-------------------------------------------------------------------------------------------------------------------------------%
%*******************************************************************************************************************************%
%************************************************ END: Dissertation-Preamble.tex ***********************************************%
%*******************************************************************************************************************************%
%-------------------------------------------------------------------------------------------------------------------------------%
%\makeatother

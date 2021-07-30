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
%-------------------------------------------------------------%
% Blake, 2021
%-------------------------------------------------------------%
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
% + Added storage of \chapter & \Section titles (\curr<Chap,Sec>Titlesfor later access to this text
% + Added a number of package requirements and various useful control sequence and math operator definitions.
% + Modified the \Xname defs to normal capitalization and created \XToCtitle & \Xheading that \MakeUppercase the \Xname's, where X=abstract/appendix/etc.
%   - Not strictly necessary, but provides flexibility for future changes and improves logic/readability
% + Replaced braced groups with \begingroup ...\endgroup. No impact, just easier to see/read explicit grouping
%-------------------------------------------------------------%
% TODO:
% + Replace in/ex/em spacing with \baselineskip in most vertical spacing contexts.
%   - Double/triple space is \baselineskip/1.5\baselineskip within \doublespacing and 2\bqaselineskip/3\baselineship within \singlespacing.
%   - em is pretty close to \baselineskip in \singlespacing, so the difference is often unnoticeable unless it's measured.
%   - even when the difference is small, most spacing can be generated with logical factors of \baselineskip (i.e. 0.5, 1.0, 1.5...), which makes the spacing
%     easier to understand and modify if necessary
% + Replace 'center' environments with \begingroup\centering...\par\pendgroup in places where vertical spacing needs to be controlled precisely.
% + Remove need for fancyhdr so tocloft can be used to its full potential, rather than under its current restrictions
% =============================================================

\ProvidesClass{thesis}[2014/06/01]


% draft	draft heading, no graphics loaded, etc.
% short	front matter omitted
\newif\if@makeDraftThesis
\newif\if@makeShortThesis
\newif\if@isDissertation
\@makeDraftThesisfalse
\@makeShortThesisfalse
\@isDissertationtrue                                                            % Yes, this is dissertation
%\@isDissertationfalse                                                          % No, this is a thesis/other
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
    % \voffset = 1in, so all top lengths -> 0.0in
	\setlength{\topmargin}{0.0in}
	\setlength{\headheight}{0.0in}
	\setlength{\headsep}{0.0in}
	\setlength{\topskip}{0.0in}
	% Page num intended to be 0.25in below text, but varies by roman/Arabic numbering.
    % Better to be set individually, some combo of 1ex/em & \baselineskip spacing, but current val is acceptably close globally
    \setlength{\footskip}{0.37in}                                              % Best global compromise.
	\setlength{\textheight}{9.0in}                                             % Yields 1in bottom margin
	\setlength{\textwidth}{6.0in}                                              % Yields 1.25in right margin + marginparwidth
	\setlength{\oddsidemargin}{0.25in}                                         % 0.25in added to 1in leftmargin yielding 1.25in
	\setlength{\evensidemargin}{0.25in}                                        % 0.25in added to 1in leftmargin yielding 1.25in
	\setlength{\parindent}{0.5in}                                              % used in triplespace
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
\RequirePackage%
[
        svgnames,
        table,
        dvipsnames,
        usenames,
        x11names,
        fixpdftex,
        hyperref
]{xcolor}
%-------------------------------------------------------------------------------------------------------------------------------%

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
% discern between them but isn't addressed in the guidelines and was not asked to change it.
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
\RequirePackage{graphicx}                                                       %\RequirePackage[pdftex]{graphicx}
\RequirePackage{amsmath}
% Blake, 2021: Switched to IEEEtran bibstyle for IEEE style guide. Retaining "chicago" package requirement
% yields parenthetical, rather than bracketed, citation numbers, so package is eliminated.
%\RequirePackage{chicago}
% ALVIN: Needs this
\RequirePackage{multirow}
\RequirePackage{hhline}
\RequirePackage{url}                                                            % for newclude bibtex
\RequirePackage{newclude}
\RequirePackage{breakcites}
\RequirePackage[titles]{tocloft}

% \@m=1000, \@M=10000, \@MM=20000
\brokenpenalty=\@M	     % Eliminates page breaks at hyphens
\clubpenalty=\@M 		 % Eliminates orphan lines
\widowpenalty=\@M 	     % Eliminates widowed lines

% Set the names of front/back matter pages & chapters
%\renewcommand*{\abstractname}{Abstract}
\newcommand*{\ToCname}{Table of Contents}
\newcommand*{\LoFname}{List of Figures}
\newcommand*{\LoTname}{List of Tables}
\newcommand*{\acknowledgename}{Acknowledgments}
\newcommand*{\dedicationname}{Dedication}
\newcommand*{\attributionname}{Attributions}                                    % Blake added, 2021
\newcommand*{\appendicesname}{Appendix}
\newcommand*{\appendicespluralname}{Appendices}                                 % Plural because more than one
\renewcommand*{\chaptername}{Chapter}
\newcommand*{\bibliographyname}{Bibliography}

% Set the (capitalized) headings of front/back matter pages & chapters
\newcommand*{\abstractHeading}{\MakeUppercase{\abstractname}}
\newcommand*{\ToCHeading}{\MakeUppercase{\ToCname}}
\newcommand*{\LoFHeading}{\MakeUppercase{\LoFname}}
\newcommand*{\LoTHeading}{\MakeUppercase{\LoTname}}
\newcommand*{\acknowledgeHeading}{\MakeUppercase{\acknowledgename}}
\newcommand*{\dedicationHeading}{\MakeUppercase{\dedicationname}}
\newcommand*{\attributionHeading}{\MakeUppercase{\attributionname}}
\newcommand*{\appendixHeading}{\MakeUppercase{\appendicesname}}
\newcommand*{\appendicesHeading}{\MakeUppercase{\appendicespluralname}}         % Plural because more than one
\newcommand*{\chapterHeading}{\MakeUppercase{\chaptername}}
\newcommand*{\bibliographyHeading}{\MakeUppercase{\bibliographyname}}

% Set the (capitalized) ToC titles of front/back matter pages & chapters
% included just in case they ever become distinct
\newcommand*{\abstractToCtitle}{\MakeUppercase{\abstractname}}
\newcommand*{\cftToCtitle}{\MakeUppercase{\ToCname}}
\newcommand*{\cftLoFtitle}{\MakeUppercase{\LoFname}}
\newcommand*{\cftLoTtitle}{\MakeUppercase{\LoTname}}
\newcommand*{\acknowledgeToCtitle}{\MakeUppercase{\acknowledgename}}
\newcommand*{\dedicationToCtitle}{\MakeUppercase{\dedicationname}}
\newcommand*{\attributionToCtitle}{\MakeUppercase{\attributionname}}
\newcommand*{\appendixToCtitle}{\MakeUppercase{\appendicesname}}
\newcommand*{\appendicesToCtitle}{\MakeUppercase{\appendicespluralname}}                     % Plural because more than one
\newcommand*{\chapterToCtitle}{\MakeUppercase{\chaptername}}
\newcommand*{\bibliographyToCtitle}{\MakeUppercase{\bibliographyname}}

% Convert to form expected by other packages
\renewcommand*{\appendixname}{\normalsize\normalfont\appendixHeading}
\renewcommand*{\bibname}{\normalsize\normalfont\bibliographyHeading}

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
	% I expect if they notice this additional LoF/LoT spacing between entries from different chapters, they will request it be removed.
    \addtocontents{lof}{\protect\addvspace{8\p@}} % 8pt spacing
	\addtocontents{lot}{\protect\addvspace{8\p@}} % 8pt spacing
	\begingroup
		\centering
		\vspace*{0.43in}
		\MakeUppercase{\@chapapp{}}%
		\hspace{-0.25em} % for the chapter text to look pretty.
		\arabicText{\thechapter}
		\vspace{-1ex}
		\singlespacing{#2}\\
		\vspace{0.13in}
	\endgroup
	\@afterheading
}

% Section headings
% \@startsection{<name>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>}*[<altheading>]{<heading>}
\renewcommand{\section}[2][]
{%
	\ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
	\@startsection{section}{1}{0pt}{1em}{0.001ex}%skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
	{\centering\normalfont\slshape\normalsize}[\ToCentry]{#2}
}
% IF there is content text immediately after level 3,
%   THEN distance between Level 3 and Content text = doublespace.
% IF there is level 4 header immediately after level 3,
%   THEN distance between Level 3 and Level 4 = triplespace.
	
\renewcommand{\subsection}[2][]
{
    \ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
	\@startsection{subsection}{2}{0pt}{0.001ex}{0.001ex}
	{\vspace{1em}\normalfont\slshape\normalsize}[\ToCentry]{#2}
}

% Blake, 2021: Changed "Level 5" heading from \parindent to 0\p@ as requested by Grad School
%\renewcommand{\subsubsection}[1]
%{%
%    \vspace{1em}
%	\@startsection{subsubsection}{3}{0\p@}{0.001em}{-1em}%
%	{\normalfont\slshape\normalsize}{#1\hspace{-3ex}}{.} %adds a period/fullstop/dot after the title
%}
\renewcommand{\subsubsection}[2][]
{%
    \vspace{1em}
	\ifstrempty{#1}{\def\ToCentry{#2}}{\def\ToCentry{#1}}
	\@startsection{subsubsection}{3}{0\p@}{0.001em}{-1em}%
	{\normalfont\slshape\normalsize}[\ToCentry]{#2\hspace{-3ex}}{.} %adds a period/fullstop/dot after the title
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
% Blake, 2021: These are unnecessary and can be removed.
% If kept, should use \gdef or \newcommand & \renewcommand here and the filling of stash, not mixed \gdef & \newcommand.
%\newcommand{\th@dedicationStash}{\relax}
%\newcommand{\th@acknowledgementsStash}{\relax}
\gdef\th@dedicationStash{\relax}
\gdef\th@acknowledgementsStash{\relax}
\gdef\th@attributionsStash{\relax}

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
\@makeAttributionsfalse                                                         % Blake added, 2021
\@makeReaderThreefalse
\@makeReaderFourfalse
\@makeReaderFivefalse

% Internal macro for drawing signature lines
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
% Blake, 2021: In progress with title page. Generates
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
%-------------------------------------------------------------------------------------------------------------------------------%
\RequirePackage{pdfpages}   % Provides clean PDF insertion capability

% Adds option to import title/signature page directly from Grad School provided PDF form
\newif\if@insertSignaturePage\@insertSignaturePagefalse
\newcommand*\signaturePageAddr{}
\newcommand*\insertSignaturePage[1]{
    \@insertSignaturePagetrue
    \renewcommand*\signaturePageAddr{#1}
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Signature page (attempts to match BUGS 2013 guidelines)
% Blake, 2021: Added conditional inclusion of unsigned title/signature PDF, otherwise it's TeX generated
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
% Blake 2021, in progress: correcting margins and positioning/spacing of lines.
% Attempting to match Grad School provided "4 Line Signature Page", though it extends
% into the 1" top and bottom margins and has inconsistent spacing.
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
%-------------------------------------------------------------------------------------------------------------------------------%

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

%-------------------------------------------------------------------------------------------------------------------------------%
% Abstract page (attempts to match BUGS 2013 guidelines)
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
        \thesisMentorTitle: \thesisMentor\\[1em]% Blake added, 2021: creates so called "triple space"
    \endgroup
    \par
    \thesisAbstract
	\clearpage
}
%-------------------------------------------------------------------------------------------------------------------------------%


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
\setlength{\cftfignumwidth}{2.85em}                 % Blake added, 2021: Provide space for X.X.XX LoF numbering
\setlength{\cfttabnumwidth}{2.85em}                 % Blake added, 2021: Provide space for X.X.XX LoT numbering



% If fancyhdr is removed and tocloft option 'titles' is turned off, these will have effect and can set ToC spacing more effectively.
%\renewcommand\cftparskip{0mm}                                                  % Vertical skip between headings
%\setlength\cftbeforetoctitleskip{0.28in}                                       % Vertical skip before Table of Contents title
%\setlength\cftaftertoctitleskip{0in}                                           % Vertical skip after Table of Contents title
%\renewcommand{\cftaftertoctitle}{}                                             % Control sequences executed after ToC title

\newcommand{\thesisToCpage}
{

	\renewcommand*{\contentsname}{\vspace*{-0.27in}\centering\normalsize\normalfont\ToCHeading\vspace{-0.25in}}
	%\renewcommand*{\contentsname}{\centering\normalsize\normalfont\ToCHeading\\}
	\begin{singlespace}
	\tableofcontents
	\end{singlespace}

	\clearpage
}

% List of figures page (optional)
%\setlength{\cftbeforeloftitleskip}{0.25in}
%\setlength{\cftafterloftitleskip}{0in}
%\renewcommand{\cftafterloftitle}{}
\newcommand{\thesisLoFpage}
{
	\if@makeLoF
		\addtocontents{toc}{\protect\vspace{-0.25in}}     % ADDS 0.25" space before LoF entry in ToC
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\cftLoFtitle}
		\renewcommand*{\listfigurename}{\vspace*{-0.27in}\centering\normalsize\normalfont\LoFHeading\vspace{-0.25in}}
		\begin{singlespace}
		\listoffigures
		\end{singlespace}
		\clearpage
	\fi
}

% List of tables page (optional)
%\setlength{\cftbeforelottitleskip}{-0.25in}
%\setlength{\cftafterlottitleskip}{0in}
%\renewcommand{\cftafterlottitle}{}
\newcommand{\thesisLoTpage}{
	\if@makeLoT
		\addtocontents{toc}{\protect\vspace{-0.25in}}     % REMOVES the 0.25" space before LoF entry in ToC
		\phantomsection  % Anchor the bookmark to this position
		\addcontentsline{toc}{part}{\normalsize\normalfont\cftLoTtitle}
		\renewcommand*{\listtablename}{\vspace*{-0.27in}\centering\normalsize\normalfont\LoTHeading\vspace{-0.25in}}
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
		\addcontentsline{toc}{part}{\normalsize\normalfont\acknowledgeToCtitle}
		\begin{center}\vspace*{0.3in}\normalfont\normalsize\acknowledgeHeading\end{center}
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
		\addcontentsline{toc}{part}{\normalsize\normalfont\dedicationToCtitle}
		\begin{center}\vspace*{0.25in}\normalfont\normalsize\dedicationHeading{}\end{center} % SHOWS the dedication title on the page
		%\begin{center}\vspace*{0.25in}\normalfont\normalsize{}\end{center} % DOES NOT show the dedication title on the actual page
		\vspace{0.75in} % badhack to make sure dedication starts at 3inches from the top
		\begin{center}\th@dedicationStash\end{center}
		\clearpage
	\fi
}

%-------------------------------------------------------------------------------------------------------------------------------%
% Attributions page (optional) - Blake added, 2021
%-------------------------------------------------------------------------------------------------------------------------------%
\newcommand{\thesisAttributionspage}
{
	\if@makeAttributions
		\thispagestyle{plain}
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
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
}
%-------------------------------------------------------------------------------------------------------------------------------%
% Blake, 2021: Added for automatic Appendix vs. Appendices handling according to format guidelines.
% Replaces \@chapter in the case there is only 1 Appendix chapter. Removes "A" from \numberline and heading ( via \arabicText{\thechapter} removal)
%-------------------------------------------------------------------------------------------------------------------------------%
\def\@chapter@singular@appendix[#1]#2
{
	% the footnotes should start with 1 in each chapter
	\setcounter{footnoteA}{0}
	
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{**************************}
		\typeout{Chapter \thechapter}%

		\addcontentsline{toc}{chapter}{\protect\numberline{}\rm#1}
	\else
		\addcontentsline{toc}{chapter}{\singlespacing{#2}}%
	\fi
	\chaptermark{#1}%
	% I expect if they notice this additional LoF/LoT spacing between entries from different chapters, they will request it be removed.
    \addtocontents{lof}{\protect\addvspace{8\p@}} % 8pt spacing
	\addtocontents{lot}{\protect\addvspace{8\p@}} % 8pt spacing
	\begingroup
		\centering
		\vspace*{0.43in}
		\MakeUppercase{\@chapapp{}}%
		\hspace{-0.25em} % for the chapter text to look pretty.
		%\arabicText{\thechapter}
		\vspace{-1ex}
		\singlespacing{#2}\\
		\vspace{0.13in}
	\endgroup
	\@afterheading
}
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
		\addtocontents{toc}{\protect\vspace{-0.25in}}
		\phantomsection  % Anchor the bookmark to this position
        \ifnumcomp{\value{numAppendices}}{=}{1}
        {
            \appendixtitletocoff                                % remove "APPENDIX" from ToC chapter title
            \glet\thisAppendixHeading\appendixHeading           % set heading to Appendix
            \glet\old@chapter\@chapter                          % save \@chapter JIC
            \glet\@chapter\@chapter@singular@appendix
            \renewcommand{\thesection}{\arabic{section}}        % remove "A" from section numbers
            \renewcommand{\thesubsection}{\arabic{subsection}}  % remove "A" from subsection numbers
            \renewcommand{\section}[2][]                          % move down 1 level, use optional \section parameter to fix ToC num/title gap by -3ex
            {%
                \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
            	\@startsection{subsection}{1}{0pt}{1em}{0.001ex}%skip: 2 space before, 1 space after. adjusted to 0.001 so that it's virually none
            	{\centering\normalfont\slshape\normalsize}[\hspace{-3ex}\ToCentry]{##2}
            }
            \renewcommand{\subsection}[2][]                       % move down 1 level
            {
                \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
            	\@startsection{subsubsection}{2}{0pt}{0.001ex}{0.001ex}
            	{\vspace{1em}\normalfont\slshape\normalsize}[\hspace{-3ex}\ToCentry]{##2}
            }
            \renewcommand{\subsubsection}[2][]                    % move down 1 level
            {%
                \vspace{1em}
                \ifstrempty{##1}{\def\ToCentry{##2}}{\def\ToCentry{##1}}
            	\@startsection{paragraph}{3}{0\p@}{0.001em}{-1em}%
            	{\normalfont\slshape\normalsize}[\ToCentry\hspace{-3ex}]{##2\hspace{-3ex}}{.} %adds a period/fullstop/dot after the title
            }
            \addcontentsline{toc}{part}{\normalsize\normalfont\appendixToCtitle}    % set ToC title to Appendix
            \addtocontents{toc}{\protect\vspace{-\baselineskip}}                    % reduce to \section sized skip
        }
        {
            \glet\thisAppendixHeading\appendicesHeading                             % set heading to Appendices
            \addcontentsline{toc}{part}{\normalsize\normalfont\appendicesToCtitle}  % set ToC title to Appendices
        }
		\vspace*{\fill}
		\begingroup
            \centering\normalfont\normalsize\thisAppendixHeading\\
        \endgroup
        \vspace*{\fill}
		\clearpage
}
%-------------------------------------------------------------------------------------------------------------------------------%

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
    \thesisAttributionspage                                                     % Blake added, 2021
}

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
\newcommand{\attributions}[1]{\@makeAttributionstrue \gdef\th@attributionsStash{#1}}        % Blake added, 2021
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
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Register Variable & List Definitions/COnfigurations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
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
\def\intactCitations{\interlinepenalty=\@M}	
\def\ToCtitleBreaks{\interlinepenalty=0}	
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
            \currChapTitle\singlespacing{\currChapTitle:~\capitalisewords{Supplemental Information}}\\
        }{
            \singlespacing{\subappendixTitle}\\
		}
        \vspace{0.13in}
	}
    \addcontentsline{toc}{section}{\appendicesToCtitle}
    %\addcontentsline{toc}{section}{\appendicesHeading~\arabicText{\thechapter}\numberline{\nowtitle:~\capitalisewords{Supplemental Information}}}
    \counterwithin{figure}{section}
    \counterwithin{table}{section}
}
%-------------------------------------------------------------------------------------------------------------------------------%
\BeforeBeginEnvironment{appendices}{\thesisAppendixPage}
\AtEndEnvironment{appendices}{\auxwrite@regset{numAppendices}{\the\value{chapter}}}
%-------------------------------------------------------------------------------------------------------------------------------%
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

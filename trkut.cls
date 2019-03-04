%%% Originally written by Sandra Schumann in 2012
%%% Modified by Kaarel Kivisalu in 2018
%%% kaarel.kivisalu@real.edu.ee (kaarel.kivisalu@gmail.com pärast 06.2020)

% Mitu juhendajat
% Automaatne nummerdamine ilma käsuta
%------------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{trkut}[2018-12-02 TRK UT class]

\LoadClass[oneside, 12pt, headings=small, numbers=noendperiod]{scrreprt}% Numbrite vahel ja lõpus on punkt, chapter font large, 12pt.

\RequirePackage{etoolbox}% Scriptimismacrod
\RequirePackage{polyglossia}% Eesti keele tugi
\setdefaultlanguage{estonian}
\RequirePackage{csquotes}% Eesti jutumärgid käsuga \enquote{}
% Need peaksid olema eesti keele jaoks olemas, overleaf ei tunnista millegipärast
\DeclareQuoteStyle{estonian}%
  {\quotedblbase}
  {\textquotedblleft}
  [0.05em]
  {\quotedblbase}
  {\textquotedblleft}
\RequirePackage{graphicx}% Joonised
\RequirePackage[colorlinks,citecolor=black,filecolor=black,linkcolor=black,urlcolor=black]{hyperref}% Sisukorras ja viidetel on lingid
\RequirePackage{amsmath}
\RequirePackage{siunitx}

%---------------------------------------------
%	ÄÄRISED
%---------------------------------------------

\RequirePackage[layout=a4paper, top=2.5cm, bottom=2.5cm, left=3cm, right=2cm, includeall=false]{geometry}
\geometry{%
	layout=a4paper,
	top=2.5cm,
	bottom=2.5cm,
	left=3cm,
	right=2cm,
	includeall=false
}

%----------------------------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------------------------

\doublehyphendemerits=10000%    No consecutive line hyphens
\brokenpenalty=10000%           No broken words across columns/pages
\widowpenalty=9999%             Almost no widows at bottom of page
\clubpenalty=9999%              Almost no orphans at top of page
\interfootnotelinepenalty=9999% Almost never break footnotes

%---------------------------------------------
%	NUMMERDAMINE
%---------------------------------------------

%% Leheküljenumbrid algavad sisukorra teiselt leheküljelt
\renewcommand\thepage{}
\newtoggle{nummerdamelehti}
\togglefalse{nummerdamelehti}

% Käsk nummerdamise alustamiseks
\newcommand{\nummerdame}{%
	\iftoggle{nummerdamelehti}{}{%
		\renewcommand\thepage{\arabic{page}}%
		\toggletrue{nummerdamelehti}%
		\thispagestyle{empty}%
	}
}

%---------------------------------------------
%	SISUKORD
%---------------------------------------------

\KOMAoptions{toc=chapterentrydotfill}%      Peatükkide taga on punktiirjoon
\addtokomafont{chapterentry}{\mdseries}%    Peatükid ei ole boldis
%\renewcommand*{\@pnumwidth}{1em}%          Punktiirjoone ja leheküljenumbrite vahe
\setcounter{tocdepth}{99}%                  Näitame kõikide - ka väga madala taseme - jaotuste pealkirju
\setcounter{secnumdepth}{99}%               Numbreid ka neile

%---------------------------------------------
%	TABELID, JOONISED, VÕRRANDID
%---------------------------------------------

\RequirePackage{enumitem}
\setlist{nosep, before={\parskip=0pt}}

% Left-align all captions. Always.
\RequirePackage{caption}
\captionsetup{justification=justified,singlelinecheck=false}

% Joonis vahetult seda kirjeldava teksti juures ehk sama alapeatüki sees
\RequirePackage[section]{placeins}

% Captions to "Caption" style instead of "Source".
\newcommand{\trkcaptionsetup}{\captionsetup{labelformat=simple, labelsep=period, labelfont=bf, font=bf}}
\trkcaptionsetup % And this is also the default
% Captions to "Source" mode. Only used internally by \allikas
\newcommand{\captionstosource}{\captionsetup{labelformat=simple, labelsep=period, font=normalfont}}
% Add source to a figure or table.
\newcommand{\allikas}[1]{\vspace{-1em}\captionstosource\caption*{Allikas: #1}\trkcaptionsetup}

% Töö kõik tabelid tuleb nummerdada läbiva numeratsiooniga (ja kui juba tabelid, siis muu ka vist)
\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{equation}{chapter}
\counterwithout{footnote}{chapter}

%---------------------------------------------
%	PAIGUTUS JA FORMAAT
%---------------------------------------------

\RequirePackage{microtype}% Teeb paigutuse paremaks

% Overleaf'ist tingitud microtype warningu eemaldamine, see peaks olema eemaldatud microtype ver 2.7
% https://tex.stackexchange.com/questions/373594/microtype-producing-dozens-of-unknown-slot-number-warnings
\def\MT@is@composite#1#2\relax{%
  \ifx\\#2\\\else
    \expandafter\def\expandafter\MT@char\expandafter{\csname\expandafter
                    \string\csname\MT@encoding\endcsname
                    \MT@detokenize@n{#1}-\MT@detokenize@n{#2}\endcsname}%
    % 3 lines added:
    \ifx\UnicodeEncodingName\@undefined\else
      \expandafter\expandafter\expandafter\MT@is@uni@comp\MT@char\iffontchar\else\fi\relax
    \fi
    \expandafter\expandafter\expandafter\MT@is@letter\MT@char\relax\relax
    \ifnum\MT@char@ < \z@
      \ifMT@xunicode
        \edef\MT@char{\MT@exp@two@c\MT@strip@prefix\meaning\MT@char>\relax}%
          \expandafter\MT@exp@two@c\expandafter\MT@is@charx\expandafter
            \MT@char\MT@charxstring\relax\relax\relax\relax\relax
      \fi
    \fi
  \fi
}
% new:
\def\MT@is@uni@comp#1\iffontchar#2\else#3\fi\relax{%
  \ifx\\#2\\\else\edef\MT@char{\iffontchar#2\fi}\fi
}

% Kas lisadel on ülemine ääris 2,5 cm või 5 cm?
% Lisade pealkirjad stiilis "Lisa 2 Teise lisa pealkiri"
% Vaata https://tex.stackexchange.com/questions/163890
\let\oldaddchap\addchap
\g@addto@macro\appendix{%
	\renewcommand*{\thechapter}{%
		{\arabic{chapter}}
	}
	\renewcommand*{\chapterformat}{%
		{\chapapp\nobreakspace\thechapter\autodot\enskip}%
	}
	\renewcommand*{\chaptermarkformat}{%
		{\chapapp\nobreakspace\thechapter\autodot\enskip}%
	}
	\let\oldaddcontentsline\addcontentsline
	\newcommand\hackedaddcontentsline[3]{\oldaddcontentsline{#1}{#2}{\chapapp\nobreakspace#3}}
	\let\oldchapter\chapter
	\renewcommand*\chapter[1]{%
		\let\addcontentsline\hackedaddcontentsline%
		\oldchapter{#1}%
		\let\addcontentsline\oldaddcontentsline%
	}
	\renewcommand*{\chapterheadstartvskip}{\vspace{0pt}}
}

% Font size
% \tiny			6pt
% \scriptsize	8pt
% \footnotesize	10pt
% \small		11pt
% \normalsize	12pt
% \large		14pt
% \Large		17pt
% \LARGE		20pt
% \huge			25pt
% \Huge			25pt

\renewcommand{\baselinestretch}{1.5}%   Reavahe on 1,5
\setlength{\parindent}{0pt}%            Taandridasid pole
\setlength{\parskip}{1em}%              Lõiguvahe on 1 em
\setlength{\topskip}{0pt}%              Ülaääre ja teksti vahel pole vaba ruumi

% Pealkirjade vahed 
\RedeclareSectionCommand[%
beforeskip=2.5 cm]{chapter}
\renewcommand*{\chapterheadendvskip}{\vspace{0em}}
\RedeclareSectionCommand[
beforeskip=1pt,
afterskip=1sp,
tocindent=2em]{section}
\RedeclareSectionCommand[
beforeskip=1pt,
afterskip=1sp,
tocindent=4em]{subsection}
\RedeclareSectionCommand[
beforeskip=1pt,
afterskip=1sp,
tocindent=6em]{subsubsection}
\RedeclareSectionCommand[
beforeskip=1pt,
afterskip=1sp,
tocindent=8em]{paragraph}
\RedeclareSectionCommand[
beforeskip=1pt,
afterskip=1sp,
indent=0pt,% Miks on see siin, aga mitte teistel pealkirjadel
tocindent=10em]{subparagraph}

% Pealkirjad boldis ja tekstiga sama fondiga
\setkomafont{disposition}{\rmfamily\bfseries}

%---------------------------------------------
%	TIITELLEHT
%---------------------------------------------
\newtoggle{mitujuhendajat}
\togglefalse{mitujuhendajat}

\RequirePackage{xparse}
\NewDocumentCommand{\autor}{m}{\newcommand{\@autor}{#1}\renewcommand{\@author}{#1}}
\NewDocumentCommand{\pealkiri}{m}{\newcommand{\@pealkiri}{#1}\renewcommand{\@title}{#1}}
\NewDocumentCommand{\juhendaja}{m}{\newcommand{\@juhendaja}{#1}}
\NewDocumentCommand{\klass}{m}{\newcommand{\@klass}{#1}}
\NewDocumentCommand{\koht}{m}{\newcommand{\@koht}{#1}}
\NewDocumentCommand{\asutus}{m}{\newcommand{\@asutus}{#1}}
\NewDocumentCommand{\paber}{m}{\newcommand{\@paber}{#1}}

% Vaikeväärtused
\paber{Uurimist\"o\"o}
\asutus{Tallinna Reaalkool}
\koht{Tallinn}

% Tiitellehe genereerimine
\renewcommand{\maketitle}{%
	\newpage
	\thispagestyle{empty}
	\large	
	\begin{center}
        \@asutus
	\end{center}
	\vspace{8cm}
	\begin{center}
		{\LARGE\textbf{\@title}}
		
		\@paber
	\end{center}
	\vspace{2cm}
	\begin{flushright}
	\@author \\
	\@klass \\
	\iftoggle{mitujuhendajat}{%
		Juhendajad: \@juhendaja
	}{%
		Juhendaja: \@juhendaja
	}
	\end{flushright}
	\vfill
	\centerline{\@koht{} \the\year}
	\clearpage
	\normalsize
}

%--------------------------------------------------
%	KINNITUSLEHT
%--------------------------------------------------

\newcommand{\kinnitusleht}{%
	\newpage
	\addcontentsline{toc}{chapter}{Kinnitusleht}
	\setlength{\topskip}{2.5 cm}
	\setlength{\vskip}{0 cm}
	\Large{\textbf{Kinnitusleht}}
    \normalsize
    
    Kinnitan, et 
    \begin{itemize}
        \item koostasin uurimistöö iseseisvalt. Kõigile töös kasutatud teiste autorite töödele ja
        andme\-allikatele on viidatud;
        \item olen teadlik, et uurimistööd ei edastata teistele tulu teenimise eesmärgil ega jagata
        tead\-likult plagieerimiseks.
    \end{itemize}
    
    \vspace{1em}
    \dotfill
    
    kuupäev / nimi / allkiri 
    
    \vspace{1.5cm}
    \noindent Tunnistan uurimistöö kaitsmisvalmiks. 
    
    \iftoggle{mitujuhendajat}{%
		Juhendajad  
		
		\vspace{1em}
        \dotfill 
    
        kuupäev / nimi / allkiri

        \dotfill 
    
        kuupäev / nimi / allkiri
	}{%
		Juhendaja
		
		\vspace{1em}
        \dotfill 
    
        kuupäev / nimi / allkiri
	}
    \vfill
    \setlength{\topskip}{0 cm}
}

%---------------------------------------------
%
%---------------------------------------------

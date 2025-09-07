% BK5.cls
% Corporate document class for BK5
% ------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BK5}[2025/07/14 v1.0 BK5 corporate document class]

% ----------------------------------------------------------------
% Base class
% ----------------------------------------------------------------
\LoadClass[journal,twoside,web]{ieeecolor}

% ----------------------------------------------------------------
% Packages
% ----------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage[a4paper,
left=2.0cm,
right=2.0cm,
top=3.5cm,
bottom=3.5cm]{geometry}
\RequirePackage{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\RequirePackage{etoolbox}
\RequirePackage{tikz}
\RequirePackage{eso-pic}
\RequirePackage{ifthen}
\RequirePackage{atbegshi}
\makeatletter

\graphicspath{{Images/}}

% ----------------------------------------------------------------
% Corporate colours (approximate brand palette)
% ----------------------------------------------------------------
\input{defines.sty}


\newcounter{pagecount}
\AtBeginShipout{%
	\stepcounter{pagecount} % Tel de pagina's
	\ifnum\value{pagecount}>1 % Pas toe vanaf pagina 2
	\AtBeginShipoutUpperLeft{%
		\begin{tikzpicture}[remember picture, overlay]
			\fill[bk-dark] (current page.north west) ++(2.7cm,0) -- (current page.north west) -- ++(0,-5.5cm) -- cycle;
		\end{tikzpicture}
	}
	\fi
}

% ----------------------------------------------------------------
% Fonts
% ----------------------------------------------------------------
\ifboolexpr{ bool {xetex} or bool {luatex} }{%
	\RequirePackage{fontspec}
	\setmainfont{Helvetica Neue}[%
	UprightFont = * Regular,
	BoldFont = * Bold,
	ItalicFont = * Italic,
	BoldItalicFont = * Bold Italic,
	Scale = MatchLowercase]
	\setsansfont{Helvetica Neue}[Scale = MatchLowercase]
}{%
	% pdfLaTeX fallback
	\RequirePackage{helvet}
	\renewcommand{\familydefault}{\sfdefault}
}

% ----------------------------------------------------------------
% Header / Footer
% ----------------------------------------------------------------
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancyhf{}
% Header
\fancyhead[L]{\textbf{\BK@project}}
\fancyhead[C]{}
\fancyhead[R]{\today}

% Voettekst-instellingen
\fancyfoot[L]{\@author}
\fancyfoot[C]{Page \thepage}
\fancyfoot[R]{\includegraphics[width=3cm]{SaxionLogo}}

% Remove header/footer rules
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% ----------------------------------------------------------------
% Specific commands
% ----------------------------------------------------------------
\newcommand{\BKproject}[1]{\def\BK@project{#1}}
\newcommand{\BKthesisSubTitle}[1]{\def\BK@thesisSubTitle{#1}}
\newcommand{\BKuniversity}[1]{\def\BK@university{#1}}
\newcommand{\BKaddress}[1]{\def\BK@address{#1}}
\newcommand{\BKcompany}[1]{\def\BK@company{#1}}
\newcommand{\BKCompanyCoach}[1]{\def\BK@CompanyCoach{#1}}
\newcommand{\BKContact}[1]{\def\BK@Contact{#1}}

% Standard AI note can be overwritten using /renewcommand in the file that uses this class
\newcommand{\BKAINote}[1]{Dit verslag is taalkundig ondersteund met AI; de inhoud blijft onze eigen verantwoordelijkheid.}

% ----------------------------------------------------------------
% Title page
% ----------------------------------------------------------------
\renewcommand{\maketitle}{%
	\begin{titlepage}
		\vspace*{-3cm}
		\begin{center}
			\begin{minipage}{0.35\textwidth}
				\raggedleft
				\includegraphics[width=0.8\linewidth]{SaxionLogo}
			\end{minipage}%
			\hspace{0.5cm}%
			\rule[-0.85cm]{0.5pt}{2cm} % Verticale lijn van 0.5pt dik en 3cm hoog
			\hspace{0.5cm}%
			\begin{minipage}{0.35\textwidth}
				\raggedright
				\includegraphics[width=0.8\linewidth]{BK5Logo}
			\end{minipage}
		\end{center}
		
		\vspace{2cm}
		\noindent
		{\Huge\bfseries \BK@project \par}
		\vspace{0.2cm}
		
		\ifdefined\BK@thesisSubTitle
		\noindent \textit{- \BK@thesisSubTitle} \\[0.5em]
		\rule[0.3cm]{\linewidth}{2pt}
		\fi
		
		\vspace{3cm}
		
		\noindent
		{\Large \@author \par}
		\small \textit{Supervisor \BK@CompanyCoach}
		\vspace{3cm}
		
		\noindent
		\makebox[0pt][r]{%
			\begin{minipage}{0.3cm}
				\rule{0.5pt}{3cm} % Thin vertical line
			\end{minipage}%
		}%
		\begin{minipage}{0.8\linewidth}
			\par\noindent
			\ifdefined\BK@university
			\textbf{University} \BK@university \par
			\fi
			\textbf{Faculty} School of Business, Building \& Technology (BBT) \par
			\ifdefined\BK@company
			\textbf{Company} \BK@company \par
			\fi
			\ifdefined\BK@address
			\textbf{Address} \BK@address \par
			\fi
			\ifdefined\BK@Contact
			\textbf{Contact} \BK@Contact \par
			\fi
			\textbf{Date} \@date
			
		\end{minipage}
		
		\vspace{4.4cm}
		
		
		\footnotesize\textit{%
			\ifdefined\BKAINote
			\BKAINote
			\else
			Dit verslag is taalkundig ondersteund met AI; de inhoud blijft mijn eigen verantwoordelijkheid.
			\fi
		}
		
	\end{titlepage}
}

\AddToShipoutPicture*{%
	\AtPageLowerLeft{%
		\includegraphics[width=\paperwidth]{Footer}%
	}
}

% Option: table of contents depth
\setcounter{tocdepth}{2}

% ----------------------------------------------------------------
% End of class
% ----------------------------------------------------------------
\endinput
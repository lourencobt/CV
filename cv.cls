\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}

\LoadClass{awesome-cv/awesome-cv}

%
% Modifications
%

\usepackage{lato}

% change default colour
\definecolor{color}{HTML}{0a8181}
\colorlet{awesome}{color}

% Awesome section color
\def\@sectioncolor#1{%
  \ifbool{acvSectionColorHighlight}{{\color{awesome}#1}}{#1}%
}

% disable section colour
\setbool{acvSectionColorHighlight}{true}

% change font sizes
\renewcommand*{\headerfirstnamestyle}[1]{{\fontsize{32pt}{1em}\lato\bfseries\color{text} #1}}
\renewcommand*{\headerlastnamestyle}[1]{{\fontsize{32pt}{1em}\lato\bfseries\color{text} #1}}
\renewcommand*{\headerpositionstyle}[1]{{\fontsize{7.6pt}{1em}\bodyfont\scshape\color{awesome} #1}}
\renewcommand*{\sectionstyle}[1]{{\fontsize{16pt}{1em}\lato\fontseries{eb}\selectfont\color{text}\@sectioncolor{#1}}}

% change bold color
\renewcommand*{\bfseries}{\fontseries{b}\selectfont\color{awesome}}

% change hrule color
\def\vhrulefill#1{\leavevmode\color{awesome}\leaders\hrule\@height#1\hfill \kern\z@}

% customize cvhonors environment
\renewenvironment{cvhonors}{
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2mm}
  \begin{center}
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} C{2.0cm} L{\textwidth - 5.5cm} R{3.5cm}}
}{
    \end{tabular*}
  \end{center}
}

\renewcommand*{\cvhonor}[4]{
  \honordatestyle{#4} & \honorpositionstyle{#1}, \honortitlestyle{#2} & \honorlocationstyle{#3} \\
}

% % another layout for cventry
% \renewcommand*{\cventry}[5]{
%   \vspace{-2.0mm}
%   \setlength\tabcolsep{0pt}
%   \setlength{\extrarowheight}{0pt}
%   \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{4.5cm} L{\textwidth - 4.5cm}}
%     \entrydatestyle{#4} & \entrytitlestyle{#2} \\
%     \entrylocationstyle{#3} & \entrypositionstyle{#1} \\
%     & \descriptionstyle{#5}
%   \end{tabular*}
% }

% Define an environment for cvskill
\renewenvironment{cvskills}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2.0mm}
  \begin{center}
    \setlength\tabcolsep{1ex}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} l L{\textwidth * \real{0.9}}}
}{%
    \end{tabular*}
  \end{center}
}
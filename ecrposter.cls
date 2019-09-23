% This document class makes use of images and logos that are owned by a
% third-party. These must be used in accordance with their regulations.
% 
% The copyright of this LaTeX Document Class is held by The Edinburgh Centre
% for Robotics, this document may not be distributed without their permission.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecrposter}[2016/04/20%
	Document class for typesetting posters with ECR branding]

% ---------------------------------------------------------------------------- %
% Main Setup
%% we define the default options to pass to TikZPoster class
\PassOptionsToClass{17pt,landscape,a1paper}{tikzposter}
%% we specify that all options from our class get passed to TikZPoster class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tikzposter}}
%% we process all options
\ProcessOptions\relax
%% we load the 
\LoadClass{tikzposter}[2014/01/15]

% ---------------------------------------------------------------------------- %
% Load Packages
\RequirePackage[T1]{fontenc}
\RequirePackage{fix-cm}
\RequirePackage[scaled]{helvet}
\RequirePackage{sansmath}
\RequirePackage{inconsolata}
\RequirePackage[export]{adjustbox}

% ---------------------------------------------------------------------------- %
% Font Configurations
%% ensure that we are using sans font throughout
\renewcommand{\familydefault}{\sfdefault}
%% ensure that maths equations are typeset with sans fonts
\sansmath

% ---------------------------------------------------------------------------- %
% General Configurations

% ---------------------------------------------------------------------------- %
% Declarations
%% lengths and other dimensions
\newlength{\footerheight}
\newlength{\offcentre}
%%% As with all things, precision's shadow is chaos %%%
%% better spacing between blocks
\newcommand{\qspace}{\vspace{0.25\baselineskip}}
\newcommand{\haspace}{\vspace{0.5\baselineskip}}
%% add support for a subtitle
\newcommand{\@subtitle}{~}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
%% we do some nastiness and undefine some TikZPoster stuff
\let\titlegraphic\@undefined

% ---------------------------------------------------------------------------- %
% Assignments and related invocations
%% assign lengths and other dimensions
\setlength{\footerheight}{0.09\textheight}
\newcommand{\titleboxwidth}{0.7\linewidth}

% ---------------------------------------------------------------------------- %
% TikZPoster related setup
%% color style
\definecolorstyle{ECRcolors} {%
	\definecolor{colorOne}{RGB}{219,225,233} % Gray
	\definecolor{colorTwo}{RGB}{53,74,106} % Dark Sky Blue
	\definecolor{colorThree}{RGB}{53,74,106} % Dark Sky Blue
	\definecolor{innerColorOne}{RGB}{227, 164, 166} % Off Red
	\definecolor{innerColorTwo}{RGB}{138, 113, 153} % Off Blue
	}{%
	% Background Colours
	\colorlet{backgroundcolor}{colorOne}
	\colorlet{framecolor}{black}
	% Title Colours
	\colorlet{titlefgcolor}{black}
	\colorlet{titlebgcolor}{white}
	\colorlet{titlebottomcolor}{colorTwo}
	% Block Colours
	\colorlet{blocktitlebgcolor}{colorThree}
	\colorlet{blocktitlefgcolor}{white}
	\colorlet{blockbodybgcolor}{white}
	\colorlet{blockbodyfgcolor}{black}
	% Innerblock Colours
	\colorlet{innerblocktitlebgcolor}{innerColorTwo}
	\colorlet{innerblocktitlefgcolor}{black}
	\colorlet{innerblockbodybgcolor}{innerColorTwo}
	\colorlet{innerblockbodyfgcolor}{black}
	% Note colours
	\colorlet{notefgcolor}{white}
	\colorlet{notebgcolor}{colorTwo}
	\colorlet{noteframecolor}{colorTwo}
}

%% title style
\definetitlestyle{ECRtitle}{width=\linewidth, titlegraphictotitledistance=0mm, innersep=15mm, titletotopverticalspace=0mm, titletoblockverticalspace=20mm}{%
	\begin{scope}[line width=\titlelinewidth]
		\fill[fill=titlebgcolor] (\titleposleft,\titleposbottom) rectangle (\titleposright,\titlepostop);
		\draw[color=titlebottomcolor] (\titleposleft,\titleposbottom) -- (\titleposright,\titleposbottom);
	\end{scope}
}

%% block style
\defineblockstyle{ECRblocks}{%
	titlewidthscale=1, bodywidthscale=1,titlecenter,
	titleoffsetx=0pt, titleoffsety=0pt, bodyoffsetx=0mm, bodyoffsety=0mm,
	bodyverticalshift=0mm, roundedcorners=0, linewidth=2pt,
	titleinnersep=6mm, bodyinnersep=1cm
}{%
	\fill[blockbodybgcolor,rounded corners=\blockroundedcorners] (blockbody.south west) rectangle (blockbody.north east);
	\ifBlockHasTitle
	\fill[blocktitlebgcolor,rounded corners=\blockroundedcorners] (blocktitle.south west) rectangle (blocktitle.north east);
	\fi
}

%% innerblock style
\defineinnerblockstyle{ECRinnerblocks}{%
	titlewidthscale=1, bodywidthscale=1,titleleft,
	titleoffsetx=0pt, titleoffsety=0pt, bodyoffsetx=0mm, bodyoffsety=0mm,
	bodyverticalshift=0mm, roundedcorners=0, linewidth=2pt,
	titleinnersep=5mm, bodyinnersep=3mm
}{%
	\draw[innerblockbodybgcolor,rounded corners=\innerblockroundedcorners] (innerblockbody.south west) rectangle (innerblockbody.north east);
	\ifInnerblockHasTitle
	\draw[innerblocktitlebgcolor, fill=innerblocktitlebgcolor,rounded corners=\innerblockroundedcorners] (innerblocktitle.south west) rectangle (innerblocktitle.north east);
	\fi
}

%% define TikZPoster theme
\definelayouttheme{ECR}{%
	\usecolorstyle{ECRcolors}
	\usetitlestyle{ECRtitle}
	\useblockstyle{ECRblocks}
	\useinnerblockstyle{ECRinnerblocks}
}
%% and then we set it as the default theme
\usetheme{ECR}

%% new environment for tables
\newenvironment{tikztable}[1][]{%
\def\rememberparameter{#1}
\addvspace{\medskipamount}
\begin{center}
\small
}{%
\ifx\rememberparameter\@empty
 % Nothing
\else
\\[10pt]
\captionof{table}{\rememberparameter}
\fi
\end{center}
\addvspace{\medskipamount}
}

% ---------------------------------------------------------------------------- %
% Document Layout
% title layout
\settitle{%
    %% <---- A little bit of LaTeX magic ---->
    %% In order to achieve the overlap of the Logos and Title texts, we used the
    %% \\[LEN] linebreak notation where LEN is some arbitrary vertical distance.
    %% LEN can be negative, meaning we can move everything after the linebreak
    %% above the linebreak - in essence achieving an overlap. The problem with
    %% this though is that it isn't trivial to find a LEN ratio that allows for
    %% adaption to arbitrary changes to the layout. THe result is that one has to
    %% keep fiddling with the number for each layout - which is non-sensical.
    %% The solution you see below resolves all the issue through a bit of TeX/LaTeX
    %% box magic.
    %% TeX/LaTeX use boxes to organise content within a document. The vertical and
    %% horizontal sizes of these boxes is taken into account to ensure that the
    %% content `flows' well. Additionally the size gives the box its own space and
    %% as such is meant to prevent overlapping of content. The macros to make boxes
    %% though can given a size parameter which allows one to altar the size of the box
    %% irrespective to its content. If the size is smaller then the content, other
    %% boxes with be moved in to take up the `free' space - leading to an overlap. We
    %% can use this here to achieve an overlap.
    %% We create a box with no width which is the first box within the group - which
    %% means we flush to the left (or to the right depending on text-comprehension).
    %% Furthermore we can specify that the content is aligned relative to the size of
    %% the box - in our case this means we align to the far left side of the group -
    %% the page/poster in this instance. Here now comes the trick - we can define the
    %% size of the content by creating another box within the first box which has
    %% a size - in this instance the page/poster width. If we align box 1 to the left,
    %% box 2 is aligned to the left as well, but because box 2 has a size, the content
    %% aligns with box 2. Doing so means we have created a box with no shape, which means
    %% other boxes can overlap it - but it contains a box with a shape, meaning that the
    %% content aligns to the inner most box.
    \makebox[0pt][l]{%
        \noindent%
        \begin{minipage}{\linewidth}
            \centering
            \color{titlefgcolor}{%
                {\bfseries \huge \parbox{\titleboxwidth}{\centering \@title}}\vspace*{0.5em}\linebreak
                {\Large \parbox{\titleboxwidth}{\centering \@subtitle}}\par
            }
            \vspace*{1.5em}
            {\Large \@author \par}
            \vspace*{0.5em}
            {\large \@institute}
        \end{minipage}
    }%
    \noindent%
    \begin{minipage}{\linewidth}
        \includegraphics[valign=c,height=0.052\textheight]{logos/ECR_Logo.pdf}
        \hfill
        \includegraphics[valign=c,height=0.032\textheight]{logos/HW_Logo_positive.pdf}
		\hspace{2em}
        \includegraphics[valign=c,height=0.045\textheight]{logos/University_of_Edinburgh_Logo.pdf}
    \end{minipage}
}

%% footer layout
\newcommand{\makefooter}{%
	\begin{scope}
		\node[fill=white,minimum height=\footerheight, minimum width=\linewidth,anchor=south] at (0, -0.5\textheight) {\parbox{\TP@titlewidth-\TP@titleinnersep}{%
			\vspace{0.5\baselineskip}
			\hspace{0.5\TP@titleinnersep}
			\begin{minipage}[t]{0.14\linewidth}
				\vspace*{0pt}
				\includegraphics[valign=c,height=0.02\textheight]{logos/EPSRC_Logo.pdf}
			\end{minipage}%
			\begin{minipage}[t]{0.45\linewidth}
				\vspace*{0pt}
				\vbox{%
					{\small \bfseries Acknowledgements}\\
					{\small This research is supported by the Engineering and Physical Sciences Research Council (EPSRC), as part of the CDT in Robotics and Autonomous Systems at Heriot-Watt University and The University of Edinburgh.}
				}
			\end{minipage}%
			\hfill%
			\begin{minipage}[t]{0.3\linewidth}
				\vspace*{0pt}
				\vbox{%
					{\small \bfseries Contact Details}\\
					{\small Email: \texttt{some-email@[hw/ed].ac.uk}}\\
					{\small Web: \texttt{www.edinburgh-robotics.org}}\\
					{\small Twitter: \texttt{@EDINrobotics}}
				}
			\end{minipage}
		}};
		
		\draw[color=titlebottomcolor,line width=4mm,anchor=south] ($(-0.5\textwidth,-0.5\textheight+\footerheight)$) -- ($(0.5\textwidth,-0.5\textheight+\footerheight)$);
	\end{scope}
}

%% because of how TikZPoster class is setup, we need to override their 
%% AtEndDocument hook
\global\let\@enddocumenthook\@empty
%% and then we declare our own
\AtEndDocument{%
	\makefooter
	\end{tikzpicture}
	\end{center}
}

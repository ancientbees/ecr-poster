% This document class makes use of images and logos that are owned by a
% third-party. These must be used in accordance with their regulations.
% 
% The copyright of this LaTeX Document Class is held by The Edinburgh Centre
% for Robotics, this document may not be distributed without their permission.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ecrposter}[2015/10/13%
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
\RequirePackage{helvet}
\RequirePackage{sansmath}

% ---------------------------------------------------------------------------- %
% Font Configurations
%% ensure that we are using sans font throughout
\renewcommand{\familydefault}{\sfdefault}
%% ensure that maths exquations are typeset with sans fonts
\sansmath

% ---------------------------------------------------------------------------- %
% General Configurations

% ---------------------------------------------------------------------------- %
% Declarations
%% lengths and other dimensions
\newlength{\footerheight}
\newlength{\offcentre}
%% more concise column spacing
\newcommand{\third}{0.333333} % As with all things, precision's shadow is chaos
%% better spacing between blocks
\newcommand{\qspace}{\vspace{0.25\baselineskip}}
\newcommand{\haspace}{\vspace{0.5\baselineskip}}
%% we do some nastiness and undefine some TikZPoster stuff
\let\titlegraphic\@undefined

% ---------------------------------------------------------------------------- %
% Assignments and related invocations
%% assign lengths and other dimensions
\setlength{\footerheight}{5.5cm}
\setlength{\offcentre}{-14em}
\newcommand{\titleboxwidth}{0.7\linewidth}

% ---------------------------------------------------------------------------- %
% TikZPoster related setup
%% color style
\definecolorstyle{ECRcolors} {
	\definecolor{colorOne}{RGB}{219,225,233} % Gray
	\definecolor{colorTwo}{RGB}{53,74,106} % Dark Sky Blue
	\definecolor{colorThree}{RGB}{53,74,106} % Dark Sky Blue
	\definecolor{innerColorOne}{RGB}{227, 164, 166} % Off Red
	\definecolor{innerColorTwo}{RGB}{138, 113, 153} % Off Blue
	}{
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
\definetitlestyle{ECRtitle}{width=\linewidth, titlegraphictotitledistance=-75mm, innersep=15mm,titletotopverticalspace=0mm, titletoblockverticalspace=20mm}{
	\begin{scope}[line width=\titlelinewidth]
		\fill[fill=titlebgcolor] (\titleposleft,\titleposbottom) rectangle (\titleposright,\titlepostop);
		\draw[color=titlebottomcolor] (\titleposleft,\titleposbottom) -- (\titleposright,\titleposbottom);
	\end{scope}
}

%% block style
\defineblockstyle{ECRblocks}{
	titlewidthscale=1, bodywidthscale=1,titlecenter,
	titleoffsetx=0pt, titleoffsety=0pt, bodyoffsetx=0mm, bodyoffsety=0mm,
	bodyverticalshift=0mm, roundedcorners=0, linewidth=2pt,
	titleinnersep=6mm, bodyinnersep=1cm
}{
	\fill[blockbodybgcolor,rounded corners=\blockroundedcorners] (blockbody.south west) rectangle (blockbody.north east);
	\ifBlockHasTitle
	\fill[blocktitlebgcolor,rounded corners=\blockroundedcorners] (blocktitle.south west) rectangle (blocktitle.north east);
	\fi
}

%% innerblock style
\defineinnerblockstyle{ECRinnerblocks}{
	titlewidthscale=1, bodywidthscale=1,titleleft,
	titleoffsetx=0pt, titleoffsety=0pt, bodyoffsetx=0mm, bodyoffsety=0mm,
	bodyverticalshift=0mm, roundedcorners=0, linewidth=2pt,
	titleinnersep=5mm, bodyinnersep=3mm
}{
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
\newenvironment{tikztable}[1][]{
\def\rememberparameter{#1}
\addvspace{\medskipamount}
\begin{center}
\small
}{
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
	\centering
	\vbox{%
		$\vcenter{\hbox{\includegraphics[height=10em]{logos/ECR_Logo.pdf}}}$
		\hfill
		$\vcenter{\hbox{\includegraphics[height=8em]{logos/HW_Logo.pdf}}}$
		\hspace{2em}
		$\vcenter{\hbox{\includegraphics[height=8em]{logos/University_of_Edinburgh_logo.pdf}}}$ \\
		[\TP@titlegraphictotitledistance]
		\hspace*{\offcentre}
		\color{titlefgcolor}{\bfseries \huge \parbox{\titleboxwidth}{\vspace{2em}\centering \@title} \par}
		\vspace*{2em}
		\hspace*{\offcentre}
		{\Large \@author \par}
		\vspace*{0.5em}
		\hspace*{\offcentre}
		{\large \@institute}
	}
}

%% footer layout
\newcommand{\makefooter}{%
	\begin{scope}
		\node[fill=white,minimum height=\footerheight, minimum width=\linewidth,anchor=south] at (0, -0.5\textheight) {\parbox{\TP@titlewidth-\TP@titleinnersep}{
			\vspace{0.5\baselineskip}
			\hspace{0.5\TP@titleinnersep}
			\begin{minipage}[t]{0.14\linewidth}
				\vspace*{0pt}
				\includegraphics[height=4.5em]{logos/EPSRC_Logo.pdf}
			\end{minipage}%
			\begin{minipage}[t]{0.45\linewidth}
				\vspace*{0pt}
				\vbox{
					{\small \bfseries Acknowledgements}\\
					{\small This research is supported by the Engineering and Physical Sciences Research Council (EPSRC), as part of the CDT in Robotics and Autonomous Systems at Heriot-Watt University and The University of Edinburgh.}
				}
			\end{minipage}%
			\hfill%
			\begin{minipage}[t]{0.3\linewidth}
				\vspace*{0pt}
				\vbox{
					{\small \bfseries Contact Details}\\
					{\small Email: \texttt{some-email@[hw/ed].ac.uk}}\\
					{\small Web: \texttt{www.edinburgh-robotics.org}}\\
					{\small Twitter: \texttt{@EDINrobotics}}
				}
			\end{minipage}
		}};
		
		\draw[color=titlebottomcolor,line width=5mm,anchor=south] ($(-0.5\textwidth,-0.5\textheight+\footerheight)$) -- ($(0.5\textwidth,-0.5\textheight+\footerheight)$);
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

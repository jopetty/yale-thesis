%% yale-thesis.cls

\RequirePackage{expl3, xparse}

\ExplSyntaxOn

%% Define Class Metadata
\tl_const:Nn \c__ythesis_class_name_tl		{yale-thesis}
\tl_const:Nn \c__ythesis_class_version_tl	{0.0.1}
\tl_const:Nn \c__ythesis_class_date_tl		{2017/08/03}
\tl_const:Nn \c__ythesis_class_description_tl	{A~LaTeX3~class~for~typesetting~doctoral~dissertations~for~Yale~University}
\tl_const:Nn \c__ythesis_university_name_tl	{Yale~University}
\tl_const:Nn \c__ythesis_parent_class_tl	{report}

\ProvidesExplClass{\c__ythesis_class_name_tl} 		% class name
		  {\c__ythesis_class_date_tl}		% date
		  {\c__ythesis_class_version_tl}	% verison
		  {\c__ythesis_class_description_tl}	% description

%% Define Class Commands
\seq_new:N  \g_ythesis_year_seq % Sequence to store the match from regex
\tl_new:N   \g_ythesis_year_tl  % Token list to store the year
\tl_new:N   \g_ythesis_date_tl  % Token list to store the full date

% Expand commands passed to \date{}, like \today
\cs_generate_variant:Nn \regex_extract_all:nnN { nx }

% Redefine \author, \title, and \date for consistency and to be able to
% re-use their values 
\RenewDocumentCommand\author{ m }	{\tl_const:Nn \g_ythesis_author_tl {#1}}
\RenewDocumentCommand\title{ m }	{\tl_const:Nn \g_ythesis_title_tl {#1}}
\NewDocumentCommand\advisor{ m }	{\tl_const:Nn \g_ythesis_advisor_tl {#1}}
\RenewDocumentCommand\date{ m }     
{
    \tl_gset:Nx \g_ythesis_date_tl {#1}
    \regex_extract_all:nxN {(\d{4})} {\g_ythesis_date_tl} \g_ythesis_year_seq
    \tl_gset:Nn \g_ythesis_year_tl {\seq_item:Nn \g_ythesis_year_seq {1}}
}

% Draft option switch
\bool_new:N		\g_ythesis_isdraft_bool
\bool_gset_false:N	\g_ythesis_isdraft_bool

% Page numbering
\tl_new:N	\g_page_numbering_tl

% Font size (default should be 12pt)
\str_new:N	\g_ythesis_fontsize_str
\str_gset:Nn	\g_ythesis_fontsize_str {12pt}

%% Option Parsing

\DeclareOption{draft}{ % Set the draft option switch
\bool_gset_true:N \g_ythesis_isdraft_bool
\PassOptionsToClass{draft}{\c__ythesis_parent_class_tl}
}

\DeclareOption{11pt}{
	\str_gset:Nn	\g_ythesis_fontsize_str {11pt}
}
\DeclareOption{10pt}{
	\str_gset:Nn	\g_ythesis_fontsize_str {10pt}
}

\DeclareOption*{ % Pass all remaining options to base class
	\PassOptionsToClass{\CurrentOption}{\c__ythesis_parent_class_tl}
}
\ProcessOptions\relax

\LoadClass[letterpaper, \g_ythesis_fontsize_str]{\c__ythesis_parent_class_tl}

%% Margins
\RequirePackage{geometry}
\geometry{top=1in, bottom=1in, left=1.5in, right=1in, headheight=15pt}

%% Title Page & Abstract
\RenewDocumentEnvironment{abstract} {} {
	\begin{titlepage}
	\begin{singlespace}
	\begin{center}
		Abstract
		\par\vspace{1em}
		\g_ythesis_title_tl
		\par\vspace{1em}
		\g_ythesis_author_tl
		\par\vspace{1em}
		\g_ythesis_date_tl
		\par\vspace{1em}
	\end{center}
	\end{singlespace}
} {
	\end{titlepage}
}

\RenewDocumentCommand\maketitle{ } {
	\begin{titlepage}
		\begin{singlespace}
			\begin{center}
				\g_ythesis_title_tl
				\par\vfill
				A~Dissertation\\
				Presented~to~the~Faculty~of~the~Graduate~School\\
				of\\
				Yale~University\\
				in~Candidacy~for~the~Degree~of\\
				Doctor~of~Philosophy
				\par\vfill
				by\\
				\g_ythesis_author_tl
				\par\vspace{1.5em}
				Dissertation~Director:~\g_ythesis_advisor_tl
				\par\vspace{1.5em}
				\g_ythesis_date_tl
			\end{center}
		\end{singlespace}
	\end{titlepage}

	%% Copyright page
	\begin{titlepage}
		\vspace*{1.3in}
		\begin{singlespace}
			\begin{center}
				% \g_ythesis__dateyear_tl \\
				Copyright~\textcopyright{}~\g_ythesis_year_tl{}~by~\g_ythesis_author_tl\\
				All~rights~reserved.
			\end{center}
		\end{singlespace}
	\end{titlepage}
}

%% Remaining Packages
\RequirePackage{kantlipsum}	% Filler Text
\RequirePackage{microtype}	% Typography refinement
\RequirePackage{setspace} 	\doublespacing

%% Draft
\bool_if:NT \g_ythesis_isdraft_bool {
	\RequirePackage{fancyhdr}
	
	% Add draft header to titlepage(s)
	\fancypagestyle{empty}{
		\fancyhf{}
		\fancyhead[R]{\texttt{DRAFT~of~\today}}
	}
	
	% Add draft header to pages @ the start of chapters
	\fancypagestyle{plain}{
		\fancyhf{}
		\fancyhead[R]{\texttt{DRAFT~of~\today}}
		\fancyfoot[C]{\thepage}
	}
	
	\pagestyle{fancy}
	\renewcommand{\headrulewidth}{0pt}
	\fancyhf{}
	\fancyhead[R]{\texttt{DRAFT~of~\today}}
	\fancyfoot[C]{\thepage}
}

\AtBeginDocument{
	\begin{abstract}
		\input{content/0-abstract.tex}
	\end{abstract}

	\maketitle

	\tableofcontents
}

\ExplSyntaxOff

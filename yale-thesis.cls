%% yale-thesis.cls

\RequirePackage{expl3, xparse}

\ExplSyntaxOn

%% Define Class Metadata
\tl_const:Nn \c__yale_class_name_tl		{yale-thesis}
\tl_const:Nn \c__yale_class_version_tl		{0.0.1}
\tl_const:Nn \c__yale_class_date_tl		{2017/08/03}
\tl_const:Nn \c__yale_class_description_tl	{A~LaTeX3~class~for~typesetting~doctoral~dissertations~for~Yale~University}
\tl_const:Nn \c__yale_university_name_tl	{Yale~University}
\tl_const:Nn \c__yale_parent_class_tl		{report}

\ProvidesExplClass{\c__yale_class_name_tl} 		% class name
		  {\c__yale_class_date_tl}		% date
		  {\c__yale_class_version_tl}		% verison
		  {\c__yale_class_description_tl}	% description

%% Define Class Commands
\seq_new:N	\g_date_year_seq % sequence to hold regex-extracted year from date

% Redefine \author, \title, and \date for consistency and to be able to
% re-use their values 
\RenewDocumentCommand\author{ m }	{\tl_const:Nn \g_author_tl {#1}}
\RenewDocumentCommand\title{ m }	{\tl_const:Nn \g_title_tl {#1}}
\RenewDocumentCommand\date{ m }		{\tl_const:Nn \g_date_tl {#1} \regex_extract_all:nnN {(\d{4})} {#1} \g_date_year_seq}
\NewDocumentCommand\advisor{ m }	{\tl_const:Nn \g_advisor_tl {#1}}

\bool_new:N		\g_isdraft_bool
\bool_gset_false:N	\g_isdraft_bool


%% Option Parsing
\DeclareOption{draft}{
\bool_gset_true:N \g_isdraft_bool
\PassOptionsToClass{draft}{\c__yale_parent_class_tl}
}

\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{\c__yale_parent_class_tl}
}
\ProcessOptions\relax

\LoadClass[letterpaper]{\c__yale_parent_class_tl}

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
		\g_title_tl
		\par\vspace{1em}
		\g_author_tl
		\par\vspace{1em}
		\g_date_tl
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
				\g_title_tl
				\par\vfill
				A~Dissertation\\
				Presented~to~the~Faculty~of~the~Graduate~School\\
				of\\
				Yale~University\\
				in~Candidacy~for~the~Degree~of\\
				Doctor~of~Philosophy
				\par\vfill
				by\\
				\g_author_tl
				\par\vspace{1.5em}
				Dissertation~Director:~\g_advisor_tl
				\par\vspace{1.5em}
				\g_date_tl
			\end{center}
		\end{singlespace}
	\end{titlepage}

	%% Copyright page
	\begin{titlepage}
		\vspace*{1.3in}
		\begin{singlespace}
			\begin{center}
				Copyright~\textcopyright{}~{\seq_item:Nn \g_date_year_seq {1}}~by~\g_author_tl\\
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
\bool_if:NT \g_isdraft_bool {
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

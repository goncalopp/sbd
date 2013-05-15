drop table cursos cascade;
create table cursos(cod_curso numeric(3) not null, 
		nome varchar(35) not null,
		primary key (cod_curso));


drop table departamentos cascade;
create table departamentos (cod_departamento numeric(3) not null,
		nome varchar(40) not null,
		primary key (cod_departamento));

drop table alunos cascade;
create table alunos (num_aluno numeric(6) not null,
		nome varchar(30) not null,
		local varchar(25),
		data_nsc date,
		sexo char(1) not null CHECK ( sexo IN ( 'F' , 'M' )  ), 
		cod_curso numeric(3) not null,
		primary key (num_aluno),
		unique (num_aluno, cod_curso),
		foreign key (cod_curso) references cursos);

drop table cadeiras cascade;
create table cadeiras(cod_cadeira numeric(5) not null,
		nome varchar(40) not null,
		creditos numeric(2) not null,
		cod_departamento numeric(3) not null,
		primary key (cod_cadeira),
		foreign key (cod_departamento) references departamentos);

drop table curso_cadeira cascade;
create table curso_cadeira( cod_curso numeric(3) not null, 
		cod_cadeira numeric(5) not null,
		semestre numeric(2) not null,
		primary key (cod_curso, cod_cadeira),
		foreign key (cod_curso) references cursos,
		foreign key (cod_cadeira) references cadeiras);

drop table inscricoes cascade;
create table inscricoes(num_aluno numeric(6) not null,
		cod_curso numeric(3) not null,
		cod_cadeira numeric(5) not null, 
		data_inscricao date not null,
		data_avaliacao date,
		nota numeric(2),
		primary key (num_aluno, cod_curso, cod_cadeira, data_inscricao),
		foreign key (num_aluno, cod_curso) references alunos(num_aluno, cod_curso),
		foreign key (cod_curso, cod_cadeira) references curso_cadeira);

drop table categorias cascade;
create table categorias(cod_categoria numeric(3) not null,
		nome varchar(30) not null,
		vencimento numeric(8) not null,
		primary key (cod_categoria));

drop table docentes cascade;
create table docentes(cod_docente numeric(5) not null,
		nome varchar(30) not null,
		cod_departamento numeric(3) not null,
		cod_categoria numeric(3) not null,
		primary key (cod_docente),
		foreign key (cod_departamento) references departamentos,
		foreign key (cod_categoria) references categorias);

drop table precedencias cascade;
create table precedencias(cod_curso numeric(3) not null,
		cod_cadeira numeric(5) not null,
		cod_cadeira_p numeric(5) not null,
		primary key (cod_curso, cod_cadeira, cod_cadeira_p),
		foreign key (cod_curso, cod_cadeira) references 
				curso_cadeira(cod_curso,cod_cadeira),
		foreign key (cod_curso, cod_cadeira_p) references 
				curso_cadeira(cod_curso,cod_cadeira));

drop table historico_categorias cascade;
create table historico_categorias(cod_docente numeric(5) not null,
		cod_categoria numeric(3) not null,
		data date not null,
		primary key (cod_docente, cod_categoria),
		foreign key (cod_docente) references docentes(cod_docente),
		foreign key (cod_categoria) references categorias(cod_categoria));

drop sequence seq_aluno;
create sequence seq_aluno increment by 1 start with 1;

drop sequence seq_docente;
create sequence seq_docente increment by 1 start with 1;

drop sequence seq_curso;
create sequence seq_curso increment by 1 start with 1;

drop sequence seq_cadeira;
create sequence seq_cadeira increment by 1 start with 1;

drop sequence seq_departamento;
create sequence seq_departamento increment by 1 start with 1;

drop sequence seq_categoria;
create sequence seq_categoria increment by 1 start with 1;

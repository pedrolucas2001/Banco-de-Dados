/*Na aula de hoje, crie as seguintes tabelas: 
Medico (idMedico - deve ser uma coluna auto incremental - , nome, CRM, UF - a combinação do CRM e UF deve ser única)
Consulta (data, hora, valor, idMedico_fk, idPaciente_fk, diagnostico )
Paciente (idPaciente - deve ser uma coluna auto incremental - , nome, cpf)
Obs: campo em negrito e sublinhado = PK, coluna só em negrito = FK.*/

create database treino4;
use treino4;

create table Medico (
idMedico int auto_increment,
nome varchar(50),
crm varchar(15),
uf char(2),
constraint medico_pk primary key (idMedico),
unique(crm,uf)
);


create table Paciente (
idPaciente int auto_increment,
nome varchar(50),
cpf bigint,
constraint paciente_pk primary key (idPaciente)
);

create table consulta (
idConsulta int auto_increment,
dtConsulta date,
hora time,
valor decimal(6,2),
diagnostico varchar(100),
idMedico_fk int,
idPaciente_fk int,
constraint consulta_pk primary key(idConsulta),
constraint consulta_medico foreign key (idMedico_fk)
	references Medico(idMedico) on update set null on delete set null,
constraint consulta_paciente foreign key (idPaciente_fk)
	references Paciente(idPaciente) on update set null on delete set null
);
drop table consulta;

/*Em seguida, realize as seguintes ações:
Insira pelo menos 3 registros para  médico, 10 para consulta e 6 para paciente;*/

insert into medico (nome,crm,uf) values 
	("Mateus","CRM-123456","DF"),
    ("Joaquim","CRM-456123","SP"),
    ("Cláudia","CRM-987654","RJ");
insert into paciente (nome,cpf) values 
	("Pedro",07350468164),
    ("Lucas",06548975687),
    ("Maria",25632178954),
    ("João",07956865498),
    ("Enzo",06786546864),
    ("Lara",05569898774);
insert into consulta (dtConsulta,hora,valor,diagnostico,idMedico_fk,idPaciente_fk) values 
	("2022-11-19","15:30",99.99,"Covid-19",1,3),
    ("2022-11-20","18:30",199.99,"Asma",2,1),
    ("2022-11-18","07:30",150,"Dengue",3,2),
    ("2022-11-01","15:30",59.99,"Covid-19",2,4),
    ("2022-10-15","08:00",290,"Alzheimer",3,6),
    ("2022-10-16","16:30",550,"Pedra nos rins",1,5),
    ("2022-11-19","16:30",160,"Gripe",1,3),
    ("2022-11-19","17:30",200,"Febre",1,3),
    ("2022-09-21","07:30",469.99,"Chikungunya",1,3),
	("2022-09-21","07:30",469.99,"Chikungunya",1,6),
	("2022-08-21","09:30",469.99,"Chikungunya",1,5);

-- Exclua um registro de paciente;

delete from paciente 
where idPaciente = 2;

-- Altere algum registro de médico e o diagnóstico de alguma consulta;

update medico
set nome = "Franscisco"
where idMedico = 1;

update consulta
set diagnostico = "Câncer"
where idConsulta = 10;

-- Realize uma consulta que traga o total de consultas realizadas por medico;

select * from consulta;
select medico.nome, count(idConsulta) qtdConsultas 
	from medico inner join consulta 
		on idMedico=idMedico_fk group by medico.nome;

-- Crie uma View que que retorne o nome do médico e seu CRM, a data da consulta, o nome do paciente e o diagnóstico;

create view vw_consultaGeral as
select medico.nome Medico,crm,dtConsulta,paciente.nome Paciente,diagnostico 
	from  medico inner join consulta inner join paciente
		on idMedico=idMedico_fk and idPaciente=idPaciente_fk 
			group by idConsulta;

-- Acrescente a coluna sexo na tabela Paciente;

alter table paciente
add column sexo char(1);

-- Acrescente valores na coluna que acabou de ser criada;

update paciente
set sexo = "M"
where idPaciente in(1,4,5);

update paciente
set sexo = "F"
where idPaciente in(3,6);

-- Retorne a quantidade de pacientes por sexo;

select sexo,count(idPaciente) qtd from paciente group by sexo;


-- Retorne o valor gasto por cliente;

select * from consulta;
select paciente.nome, sum(valor) GastoTotal 
	from paciente inner join consulta
		on idPaciente=idPaciente_fk group by paciente.nome;

-- Retorne todos os pacientes que seu nome termine com a letra 'a';

select nome from paciente where nome like "%a"; 

-- Exclua a tabela paciente;

drop table paciente;

-- Exclua o banco de dados Criado.
drop database treino4;




























cidade
#Criação do usuário e Banco de Dados

CRIACAO USUARIO 'rayssa'@'localhost' IDENTIFIED BY 'computacao@raiz';

#Permissão para os usuários
GRANT CREATE, ALTER, INSERT, SELECT on *.* TO 'rayssa'@'localhost';
FLUSH PRIVILEGES;

#Criação do Banco De Dados
CRIAR BANCO DE DADOS uvv;

#Conectar o usuario
system mysql -u rayssa -p;

#Agora escolha o Banco de Dados
use uvv;

CREATE TABLE regioes (
                id_regiao INT NOT NULL,
                nome VARCHAR(25) NOT NULL,
                PRIMARY KEY (id_regiao)
);

ALTER TABLE regioes COMMENT 'Tabela com n�mero e o nome das regi�es.';

ALTER TABLE regioes MODIFY COLUMN id_regiao INTEGER COMMENT 'Representa a Chave Prim�ria das regi�es';

ALTER TABLE regioes MODIFY COLUMN nome VARCHAR(25) COMMENT 'Indica o nome das Regi�es.';


CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INT,
                PRIMARY KEY (id_pais)
);

ALTER TABLE paises COMMENT 'Tabela com informa��es dos pa�ses.';

ALTER TABLE paises MODIFY COLUMN id_pais CHAR(2) COMMENT 'Representa a Chave Prim�ria da tabela p�ises';

ALTER TABLE paises MODIFY COLUMN nome VARCHAR(50) COMMENT 'Indica o nome do pa�s';

ALTER TABLE paises MODIFY COLUMN id_regiao INTEGER COMMENT 'Representa a FK para a tabela regi�es.';


CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

CREATE TABLE localizacoes (
                id_localizacao INT NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2),
                PRIMARY KEY (id_localizacao)
);

ALTER TABLE localizacoes COMMENT 'localiza��o dos escrit�rios que trabalham os empregados.';

ALTER TABLE localizacoes MODIFY COLUMN id_localizacao INTEGER COMMENT 'Representa a Chave Prim�ria da tabela';

ALTER TABLE localizacoes MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endere�o com Logradouro e n� de um escrit�rio da empresa';

ALTER TABLE localizacoes MODIFY COLUMN cep VARCHAR(12) COMMENT 'CEP do endere�o do escrit�rio ou facilidade da empresa.';

ALTER TABLE localizacoes MODIFY COLUMN cidade VARCHAR(50) COMMENT 'Cidade';

ALTER TABLE localizacoes MODIFY COLUMN uf VARCHAR(25) COMMENT 'Estado (sigla ou de forma extensa.';

ALTER TABLE localizacoes MODIFY COLUMN id_pais CHAR(2) COMMENT 'Representa a Chave Estrangeira para a tabela pa�ses';


CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo DECIMAL(8,2),
                salario_maximo DECIMAL(8,2),
                PRIMARY KEY (id_cargo)
);

ALTER TABLE cargos COMMENT 'Tabela respons�vel por armazenar os cargos que existem no per�odo atual da empresa e o sal�rio m�nimo e m�ximo de cada cargo.';

ALTER TABLE cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'Representa a PK da tabela';

ALTER TABLE cargos MODIFY COLUMN cargo VARCHAR(35) COMMENT 'Indica o nome do Cargo.';

ALTER TABLE cargos MODIFY COLUMN salario_minimo DECIMAL(8, 2) COMMENT 'Indica o menor sal�rio da empresa.';

ALTER TABLE cargos MODIFY COLUMN salario_maximo DECIMAL(8, 2) COMMENT 'O maior sal�rio da empresa.';


CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

CREATE TABLE departamentos (
                id_departamento INT NOT NULL,
                nome VARCHAR(50),
                id_localizacao INT NOT NULL,
                id_gerente INT,
                PRIMARY KEY (id_departamento)
);

ALTER TABLE departamentos COMMENT 'Tabela Departamentos da empresa';

ALTER TABLE departamentos MODIFY COLUMN id_departamento INTEGER COMMENT 'Representa a chave prim�ria do departamento';

ALTER TABLE departamentos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome dos departamentos';

ALTER TABLE departamentos MODIFY COLUMN id_localizacao INTEGER COMMENT 'Representa a Chave Prim�ria da tabela';

ALTER TABLE departamentos MODIFY COLUMN id_gerente INTEGER COMMENT 'Chave estrangeira para a tabela de localiza��es.';


CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome );

CREATE TABLE empregados (
                id_empregados INT NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario DECIMAL(8,2),
                comissao DECIMAL(4,2),
                id_departamento INT,
                id_supervisor INT NOT NULL,
                PRIMARY KEY (id_empregados)
);

ALTER TABLE empregados COMMENT 'Informa��es dos empregados';

ALTER TABLE empregados MODIFY COLUMN id_empregados INTEGER COMMENT 'Representa Chave Prim�ria do empregado';

ALTER TABLE empregados MODIFY COLUMN nome VARCHAR(75) COMMENT 'Nome e Sobrenome do colaborador';

ALTER TABLE empregados MODIFY COLUMN email VARCHAR(35) COMMENT 'E-mail do empregado sem o @';

ALTER TABLE empregados MODIFY COLUMN telefone VARCHAR(20) COMMENT 'telefone com espa�o para o c�digo referente a pa�s e estado.';

ALTER TABLE empregados MODIFY COLUMN data_contratacao DATE COMMENT 'Come�ou a trabalhar em seu atual cargo.';

ALTER TABLE empregados MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'FK no relac.tab. cargos. Atual cargo do colaborador';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(8, 2) COMMENT 'Valor do sal�rio p/ m�s do colaborador, em seu cargo atual.';

ALTER TABLE empregados MODIFY COLUMN comissao DECIMAL(4, 2) COMMENT 'Comiss�o do departamento de vendas recebe';

ALTER TABLE empregados MODIFY COLUMN id_departamento INTEGER COMMENT 'FK tab. de depart.,indica o atual do colaborador.';

ALTER TABLE empregados MODIFY COLUMN id_supervisor INTEGER COMMENT 'Um auto-relacionamento 
';


CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

CREATE TABLE hsitorico_cargos (
                id_empregados INT NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INT,
                PRIMARY KEY (id_empregados, data_inicial)
);

ALTER TABLE hsitorico_cargos COMMENT '"carreira" de um empregado dentro da empresa. 
';

ALTER TABLE hsitorico_cargos MODIFY COLUMN id_empregados INTEGER COMMENT 'Representa Chave Prim�ria do empregado';

ALTER TABLE hsitorico_cargos MODIFY COLUMN data_inicial DATE COMMENT 'Data Inicial no atual cargo, <data_final';

ALTER TABLE hsitorico_cargos MODIFY COLUMN data_final DATE COMMENT 'Data Final(�ltimo dia trabalhado no cargo) >data_inicial.';

ALTER TABLE hsitorico_cargos MODIFY COLUMN id_cargo VARCHAR(10) COMMENT 'FK p/ tabela "cargos". Cargo trab. no passado.';

ALTER TABLE hsitorico_cargos MODIFY COLUMN id_departamento INTEGER COMMENT 'FK tab. depart. Empregado trabalhou algum dia.';


--Início das insert 

INSERT INTO regioes VALUES 
        ( 1
        , 'Europe' 
        );

INSERT INTO regioes VALUES 
        ( 2
        , 'Americas' 
        );

INSERT INTO regioes VALUES 
        ( 3
        , 'Asia' 
        );

INSERT INTO regioes VALUES 
        ( 4
        , 'Middle East and Africa' 
        );


INSERT INTO paises VALUES 
        ( 'IT'
        , 'Italy'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'JP'
        , 'Japan'
	, 3 
        );

INSERT INTO paises VALUES 
        ( 'US'
        , 'United States of America'
        , 2 
        );

INSERT INTO paises VALUES 
        ( 'CA'
        , 'Canada'
        , 2 
        );

INSERT INTO paises VALUES 
        ( 'CN'
        , 'China'
        , 3 
        );

INSERT INTO paises VALUES 
        ( 'IN'
        , 'India'
        , 3 
        );

INSERT INTO paises VALUES 
        ( 'AU'
        , 'Australia'
        , 3 
        );

INSERT INTO paises VALUES 
        ( 'ZW'
        , 'Zimbabwe'
        , 4 
        );

INSERT INTO paises VALUES 
        ( 'SG'
        , 'Singapore'
        , 3 
        );

INSERT INTO paises VALUES 
        ( 'UK'
        , 'United Kingdom'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'FR'
        , 'France'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'DE'
        , 'Germany'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'ZM'
        , 'Zambia'
        , 4 
        );

INSERT INTO paises VALUES 
        ( 'EG'
        , 'Egypt'
        , 4 
        );

INSERT INTO paises VALUES 
        ( 'BR'
        , 'Brazil'
        , 2 
        );

INSERT INTO paises VALUES 
        ( 'CH'
        , 'Switzerland'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'NL'
        , 'Netherlands'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'MX'
        , 'Mexico'
        , 2 
        );

INSERT INTO paises VALUES 
        ( 'KW'
        , 'Kuwait'
        , 4 
        );

INSERT INTO paises VALUES 
        ( 'IL'
        , 'Israel'
        , 4 
        );

INSERT INTO paises VALUES 
        ( 'DK'
        , 'Denmark'
        , 1 
        );

INSERT INTO paises VALUES 
        ( 'ML'
        , 'Malaysia'
        , 3 
        );

INSERT INTO paises VALUES 
        ( 'NG'
        , 'Nigeria'
        , 4 
        );

INSERT INTO paises VALUES 
        ( 'AR'
        , 'Argentina'
        , 2 
        );

INSERT INTO paises VALUES 
        ( 'BE'
        , 'Belgium'
        , 1 
        );

INSERT INTO localizacoes VALUES 
        ( 1000 
        , '1297 Via Cola di Rie'
        , '00989'
        , 'Roma'
        , NULL
        , 'IT'
        );

INSERT INTO localizacoes VALUES 
        ( 1100 
        , '93091 Calle della Testa'
        , '10934'
        , 'Venice'
        , NULL
        , 'IT'
        );

INSERT INTO localizacoes VALUES 
        ( 1200 
        , '2017 Shinjuku-ku'
        , '1689'
        , 'Tokyo'
        , 'Tokyo Prefecture'
        , 'JP'
        );

INSERT INTO localizacoes VALUES 
        ( 1300 
        , '9450 Kamiya-cho'
        , '6823'
        , 'Hiroshima'
        , NULL
        , 'JP'
        );

INSERT INTO localizacoes VALUES 
        ( 1400 
        , '2014 Jabberwocky Rd'
        , '26192'
        , 'Southlake'
        , 'Texas'
        , 'US'
        );

INSERT INTO localizacoes VALUES 
        ( 1500 
        , '2011 Interiors Blvd'
        , '99236'
        , 'South San Francisco'
        , 'California'
        , 'US'
        );

INSERT INTO localizacoes VALUES 
        ( 1600 
        , '2007 Zagora St'
        , '50090'
        , 'South Brunswick'
        , 'New Jersey'
        , 'US'
        );

INSERT INTO localizacoes VALUES 
        ( 1700 
        , '2004 Charade Rd'
        , '98199'
        , 'Seattle'
        , 'Washington'
        , 'US'
        );

INSERT INTO localizacoes VALUES 
        ( 1800 
        , '147 Spadina Ave'
        , 'M5V 2L7'
        , 'Toronto'
        , 'Ontario'
        , 'CA'
        );

INSERT INTO localizacoes VALUES 
        ( 1900 
        , '6092 Boxwood St'
        , 'YSW 9T2'
        , 'Whitehorse'
        , 'Yukon'
        , 'CA'
        );

INSERT INTO localizacoes VALUES 
        ( 2000 
        , '40-5-12 Laogianggen'
        , '190518'
        , 'Beijing'
        , NULL
        , 'CN'
        );

INSERT INTO localizacoes VALUES 
        ( 2100 
        , '1298 Vileparle (E)'
        , '490231'
        , 'Bombay'
        , 'Maharashtra'
        , 'IN'
        );

INSERT INTO localizacoes VALUES 
        ( 2200 
        , '12-98 Victoria Street'
        , '2901'
        , 'Sydney'
        , 'New South Wales'
        , 'AU'
        );

INSERT INTO localizacoes VALUES 
        ( 2300 
        , '198 Clementi North'
        , '540198'
        , 'Singapore'
        , NULL
        , 'SG'
        );

INSERT INTO localizacoes VALUES 
        ( 2400 
        , '8204 Arthur St'
        , NULL
        , 'London'
        , NULL
        , 'UK'
        );

INSERT INTO localizacoes VALUES 
        ( 2500 
        , 'Magdalen Centre, The Oxford Science Park'
        , 'OX9 9ZB'
        , 'Oxford'
        , 'Oxford'
        , 'UK'
        );

INSERT INTO localizacoes VALUES 
        ( 2600 
        , '9702 Chester Road'
        , '09629850293'
        , 'Stretford'
        , 'Manchester'
        , 'UK'
        );

INSERT INTO localizacoes VALUES 
        ( 2700 
        , 'Schwanthalerstr. 7031'
        , '80925'
        , 'Munich'
        , 'Bavaria'
        , 'DE'
        );

INSERT INTO localizacoes VALUES 
        ( 2800 
        , 'Rua Frei Caneca 1360 '
        , '01307-002'
        , 'Sao Paulo'
        , 'Sao Paulo'
        , 'BR'
        );

INSERT INTO localizacoes VALUES 
        ( 2900 
        , '20 Rue des Corps-Saints'
        , '1730'
        , 'Geneva'
        , 'Geneve'
        , 'CH'
        );

INSERT INTO localizacoes VALUES 
        ( 3000 
        , 'Murtenstrasse 921'
        , '3095'
        , 'Bern'
        , 'BE'
        , 'CH'
        );

INSERT INTO localizacoes VALUES 
        ( 3100 
        , 'Pieter Breughelstraat 837'
        , '3029SK'
        , 'Utrecht'
        , 'Utrecht'
        , 'NL'
        );

INSERT INTO localizacoes VALUES 
        ( 3200 
        , 'Mariano Escobedo 9991'
        , '11932'
        , 'Mexico City'
        , 'Distrito Federal,'
        , 'MX'
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 10
        , 'Administration'
        , 200
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 20
        , 'Marketing'
        , 201
        , 1800
        );
                                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 30
        , 'Purchasing'
        , 114
        , 1700
	);
                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 40
        , 'Human Resources'
        , 203
        , 2400
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 50
        , 'Shipping'
        , 121
        , 1500
        );
                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 60 
        , 'IT'
        , 103
        , 1400
        );
                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 70 
        , 'Public Relations'
        , 204
        , 2700
        );
                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 80 
        , 'Sales'
        , 145
        , 2500
        );
                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 90 
        , 'Executive'
        , 100
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 100 
        , 'Finance'
        , 108
        , 1700
        );
                
INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 110 
        , 'Accounting'
        , 205
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 120 
        , 'Treasury'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 130 
        , 'Corporate Tax'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 140 
        , 'Control And Credit'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 150 
        , 'Shareholder Services'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 160 
        , 'Benefits'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 170 
        , 'Manufacturing'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 180 
        , 'Construction'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 190 
        , 'Contracting'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 200 
        , 'Operations'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 210 
        , 'IT Support'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 220 
        , 'NOC'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 230 
        , 'IT Helpdesk'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 240 
        , 'Government Sales'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 250 
        , 'Retail Sales'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 260 
        , 'Recruiting'
        , NULL
        , 1700
        );

INSERT INTO departamentos(id_departamento, nome, id_gerente, id_localizacao) VALUES 
        ( 270 
        , 'Payroll'
        , NULL
        , 1700
        );

INSERT INTO cargos VALUES 
        ( 'AD_PRES'
        , 'President'
        , 20080
        , 40000
        );
INSERT INTO cargos VALUES 
        ( 'AD_VP'
        , 'Administration Vice President'
        , 15000
        , 30000
        );

INSERT INTO cargos VALUES 
        ( 'AD_ASST'
        , 'Administration Assistant'
        , 3000
        , 6000
        );

INSERT INTO cargos VALUES 
        ( 'FI_MGR'
        , 'Finance Manager'
        , 8200
        , 16000
        );

INSERT INTO cargos VALUES 
        ( 'FI_ACCOUNT'
        , 'Accountant'
        , 4200
        , 9000
        );

INSERT INTO cargos VALUES 
        ( 'AC_MGR'
        , 'Accounting Manager'
        , 8200
        , 16000
        );

INSERT INTO cargos VALUES 
        ( 'AC_ACCOUNT'
        , 'Public Accountant'
        , 4200
        , 9000
        );
INSERT INTO cargos VALUES 
        ( 'SA_MAN'
        , 'Sales Manager'
        , 10000
        , 20080
        );

INSERT INTO cargos VALUES 
        ( 'SA_REP'
        , 'Sales Representative'
        , 6000
        , 12008
        );

INSERT INTO cargos VALUES 
        ( 'PU_MAN'
        , 'Purchasing Manager'
        , 8000
        , 15000
        );

INSERT INTO cargos VALUES 
        ( 'PU_CLERK'
        , 'Purchasing Clerk'
        , 2500
        , 5500
        );

INSERT INTO cargos VALUES 
        ( 'ST_MAN'
        , 'Stock Manager'
        , 5500
        , 8500
        );
INSERT INTO cargos VALUES 
        ( 'ST_CLERK'
        , 'Stock Clerk'
        , 2008
        , 5000
        );

INSERT INTO cargos VALUES 
        ( 'SH_CLERK'
        , 'Shipping Clerk'
        , 2500
        , 5500
        );

INSERT INTO cargos VALUES 
        ( 'IT_PROG'
        , 'Programmer'
        , 4000
        , 10000
        );

INSERT INTO cargos VALUES 
        ( 'MK_MAN'
        , 'Marketing Manager'
        , 9000
        , 15000
        );

INSERT INTO cargos VALUES 
        ( 'MK_REP'
        , 'Marketing Representative'
        , 4000
        , 9000
        );

INSERT INTO cargos VALUES 
        ( 'HR_REP'
        , 'Human Resources Representative'
        , 4000
        , 9000
        );

INSERT INTO cargos VALUES 
        ( 'PR_REP'
        , 'Public Relations Representative'
        , 4500
        , 10500
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 100
        , 'Steven King'
        , 'SKING'
        , '515.123.4567'
        , STR_TO_DATE('17-06-2003', '%d-%m-%Y')
        , 'AD_PRES'
        , 24000
        , NULL
        , NULL
        , 90
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 101
        , 'Neena Kochhar'
        , 'NKOCHHAR'
        , '515.123.4568'
        , STR_TO_DATE('21-09-2005', '%d-%m-%Y')
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 102
        , 'Lex De Haan'
        , 'LDEHAAN'
        , '515.123.4569'
        , STR_TO_DATE('13-01-2001', '%d-%m-%Y')
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 103
        , 'Alexander Hunold'
        , 'AHUNOLD'
        , '590.423.4567'
        , STR_TO_DATE('03-01-2006', '%d-%m-%Y')
        , 'IT_PROG'
        , 9000
        , NULL
        , 102
        , 60
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 104
        , 'Bruce Ernst'
        , 'BERNST'
        , '590.423.4568'
        , STR_TO_DATE('21-05-2007', '%d-%m-%Y')
        , 'IT_PROG'
        , 6000
        , NULL
        , 103
        , 60
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 105
        , 'David Austin'
        , 'DAUSTIN'
        , '590.423.4569'
        , STR_TO_DATE('25-06-2005', '%d-%m-%Y')
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 106
        , 'Valli Pataballa'
        , 'VPATABAL'
        , '590.423.4560'
        , STR_TO_DATE('05-02-2006', '%d-%m-%Y')
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 107
        , 'Diana Lorentz'
        , 'DLORENTZ'
        , '590.423.5567'
        , STR_TO_DATE('07-02-2007', '%d-%m-%Y')
        , 'IT_PROG'
        , 4200
        , NULL
        , 103
        , 60
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 108
        , 'Nancy Greenberg'
        , 'NGREENBE'
        , '515.124.4569'
        , STR_TO_DATE('17-08-2002', '%d-%m-%Y')
        , 'FI_MGR'
        , 12008
        , NULL
        , 101
        , 100
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 109
        , 'Daniel Faviet'
        , 'DFAVIET'
        , '515.124.4169'
        , STR_TO_DATE('16-08-2002', '%d-%m-%Y')
        , 'FI_ACCOUNT'
        , 9000
        , NULL
        , 108
        , 100
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 110
        , 'John Chen'
        , 'JCHEN'
        , '515.124.4269'
        , STR_TO_DATE('28-09-2005', '%d-%m-%Y')
        , 'FI_ACCOUNT'
        , 8200
        , NULL
        , 108
        , 100
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 111
        , 'Ismael Sciarra'
        , 'ISCIARRA'
        , '515.124.4369'
        , STR_TO_DATE('30-09-2005', '%d-%m-%Y')
        , 'FI_ACCOUNT'
        , 7700
        , NULL
        , 108
        , 100
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 112
        , 'Jose Manuel Urman'
        , 'JMURMAN'
        , '515.124.4469'
        , STR_TO_DATE('07-03-2006', '%d-%m-%Y')
        , 'FI_ACCOUNT'
        , 7800
        , NULL
        , 108
        , 100
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 113
        , 'Luis Popp'
        , 'LPOPP'
        , '515.124.4567'
        , STR_TO_DATE('07-12-2007', '%d-%m-%Y')
        , 'FI_ACCOUNT'
        , 6900
        , NULL
        , 108
        , 100
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 114
        , 'Den Raphaely'
        , 'DRAPHEAL'
        , '515.127.4561'
        , STR_TO_DATE('07-12-2002', '%d-%m-%Y')
        , 'PU_MAN'
        , 11000
        , NULL
        , 100
        , 30
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 115
        , 'Alexander Khoo'
        , 'AKHOO'
        , '515.127.4562'
        , STR_TO_DATE('18-05-2003', '%d-%m-%Y')
        , 'PU_CLERK'
        , 3100
        , NULL
        , 114
        , 30
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 116
        , 'Shelli Baida'
        , 'SBAIDA'
        , '515.127.4563'
        , STR_TO_DATE('24-12-2005', '%d-%m-%Y')
        , 'PU_CLERK'
        , 2900
        , NULL
        , 114
        , 30
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 117
        , 'Sigal Tobias'
        , 'STOBIAS'
        , '515.127.4564'
        , STR_TO_DATE('24-07-2005', '%d-%m-%Y')
        , 'PU_CLERK'
        , 2800
        , NULL
        , 114
        , 30
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 118
        , 'Guy Himuro'
        , 'GHIMURO'
        , '515.127.4565'
        , STR_TO_DATE('15-11-2006', '%d-%m-%Y')
        , 'PU_CLERK'
        , 2600
        , NULL
        , 114
        , 30
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 119
        , 'Karen Colmenares'
        , 'KCOLMENA'
        , '515.127.4566'
        , STR_TO_DATE('10-08-2007', '%d-%m-%Y')
        , 'PU_CLERK'
        , 2500
        , NULL
        , 114
        , 30
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 120
        , 'Matthew Weiss'
        , 'MWEISS'
        , '650.123.1234'
        , STR_TO_DATE('18-07-2004', '%d-%m-%Y')
        , 'ST_MAN'
        , 8000
        , NULL
        , 100
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 121
        , 'Adam Fripp'
        , 'AFRIPP'
        , '650.123.2234'
        , STR_TO_DATE('10-04-2005', '%d-%m-%Y')
        , 'ST_MAN'
        , 8200
        , NULL
        , 100
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 122
        , 'Payam Kaufling'
        , 'PKAUFLIN'
        , '650.123.3234'
        , STR_TO_DATE('01-05-2003', '%d-%m-%Y')
        , 'ST_MAN'
        , 7900
        , NULL
        , 100
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 123
        , 'Shanta Vollman'
        , 'SVOLLMAN'
        , '650.123.4234'
        , STR_TO_DATE('10-10-2005', '%d-%m-%Y')
        , 'ST_MAN'
        , 6500
        , NULL
        , 100
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 124
        , 'Kevin Mourgos'
        , 'KMOURGOS'
        , '650.123.5234'
        , STR_TO_DATE('16-11-2007', '%d-%m-%Y')
        , 'ST_MAN'
        , 5800
        , NULL
        , 100
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 125
        , 'Julia Nayer'
        , 'JNAYER'
        , '650.124.1214'
        , STR_TO_DATE('16-07-2005', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 126
        , 'Irene Mikkilineni'
        , 'IMIKKILI'
        , '650.124.1224'
        , STR_TO_DATE('28-09-2006', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2700
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 127
        , 'James Landry'
        , 'JLANDRY'
        , '650.124.1334'
        , STR_TO_DATE('14-01-2007', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2400
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 128
        , 'Steven Markle'
        , 'SMARKLE'
        , '650.124.1434'
        , STR_TO_DATE('08-03-2008', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2200
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 129
        , 'Laura Bissot'
        , 'LBISSOT'
        , '650.124.5234'
        , STR_TO_DATE('20-08-2005', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3300
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 130
        , 'Mozhe Atkinson'
        , 'MATKINSO'
        , '650.124.6234'
        , STR_TO_DATE('30-10-2005', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2800
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 131
        , 'James Marlow'
        , 'JAMRLOW'
        , '650.124.7234'
        , STR_TO_DATE('16-02-2005', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 132
        , 'TJ Olson'
        , 'TJOLSON'
        , '650.124.8234'
        , STR_TO_DATE('10-04-2007', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2100
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 133
        , 'Jason Mallin'
        , 'JMALLIN'
        , '650.127.1934'
        , STR_TO_DATE('14-06-2004', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3300
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 134
        , 'Michael Rogers'
        , 'MROGERS'
        , '650.127.1834'
        , STR_TO_DATE('26-08-2006', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 135
        , 'Ki Gee'
        , 'KGEE'
        , '650.127.1734'
        , STR_TO_DATE('12-12-2007', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2400
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 136
        , 'Hazel Philtanker'
        , 'HPHILTAN'
        , '650.127.1634'
        , STR_TO_DATE('06-02-2008', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2200
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 137
        , 'Renske Ladwig'
        , 'RLADWIG'
        , '650.121.1234'
        , STR_TO_DATE('14-07-2003', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3600
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 138
        , 'Stephen Stiles'
        , 'SSTILES'
        , '650.121.2034'
        , STR_TO_DATE('26-10-2005', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 139
        , 'John Seo'
        , 'JSEO'
        , '650.121.2019'
        , STR_TO_DATE('12-02-2006', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2700
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 140
        , 'Joshua Patel'
        , 'JPATEL'
        , '650.121.1834'
        , STR_TO_DATE('06-04-2006', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 141
        , 'Trenna Rajs'
        , 'TRAJS'
        , '650.121.8009'
        , STR_TO_DATE('17-10-2003', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3500
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 142
        , 'Curtis Davies'
        , 'CDAVIES'
        , '650.121.2994'
        , STR_TO_DATE('29-01-2005', '%d-%m-%Y')
        , 'ST_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 143
        , 'Randall Matos'
        , 'RMATOS'
        , '650.121.2874'
        , STR_TO_DATE('15-03-2006', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 144
        , 'Peter Vargas'
        , 'PVARGAS'
        , '650.121.2004'
        , STR_TO_DATE('09-07-2006', '%d-%m-%Y')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 145
        , 'John Russell'
        , 'JRUSSEL'
        , '011.44.1344.429268'
        , STR_TO_DATE('01-10-2004', '%d-%m-%Y')
        , 'SA_MAN'
        , 14000
        , .4
        , 100
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 146
        , 'Karen Partners'
        , 'KPARTNER'
        , '011.44.1344.467268'
        , STR_TO_DATE('05-01-2005', '%d-%m-%Y')
        , 'SA_MAN'
        , 13500
        , .3
        , 100
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 147
        , 'Alberto Errazuriz'
        , 'AERRAZUR'
        , '011.44.1344.429278'
        , STR_TO_DATE('10-03-2005', '%d-%m-%Y')
        , 'SA_MAN'
        , 12000
        , .3
        , 100
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 148
        , 'Gerald Cambrault'
        , 'GCAMBRAU'
        , '011.44.1344.619268'
        , STR_TO_DATE('15-10-2007', '%d-%m-%Y')
        , 'SA_MAN'
        , 11000
        , .3
        , 100
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 149
        , 'Eleni Zlotkey'
        , 'EZLOTKEY'
        , '011.44.1344.429018'
        , STR_TO_DATE('29-01-2008', '%d-%m-%Y')
        , 'SA_MAN'
        , 10500
        , .2
        , 100
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 150
        , 'Peter Tucker'
        , 'PTUCKER'
        , '011.44.1344.129268'
        , STR_TO_DATE('30-01-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 10000
        , .3
        , 145
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 151
        , 'David Bernstein'
        , 'DBERNSTE'
        , '011.44.1344.345268'
        , STR_TO_DATE('24-03-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 9500
        , .25
        , 145
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 152
        , 'Peter Hall'
        , 'PHALL'
        , '011.44.1344.478968'
        , STR_TO_DATE('20-08-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 9000
        , .25
        , 145
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 153
        , 'Christopher Olsen'
        , 'COLSEN'
        , '011.44.1344.498718'
        , STR_TO_DATE('30-03-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 8000
        , .2
        , 145
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 154
        , 'Nanette Cambrault'
        , 'NCAMBRAU'
        , '011.44.1344.987668'
        , STR_TO_DATE('09-12-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 7500
        , .2
        , 145
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 155
        , 'Oliver Tuvault'
        , 'OTUVAULT'
        , '011.44.1344.486508'
        , STR_TO_DATE('23-11-2007', '%d-%m-%Y')
        , 'SA_REP'
        , 7000
        , .15
        , 145
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 156
        , 'Janette King'
        , 'JKING'
        , '011.44.1345.429268'
        , STR_TO_DATE('30-01-2004', '%d-%m-%Y')
        , 'SA_REP'
        , 10000
        , .35
        , 146
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 157
        , 'Patrick Sully'
        , 'PSULLY'
        , '011.44.1345.929268'
        , STR_TO_DATE('04-03-2004', '%d-%m-%Y')
        , 'SA_REP'
        , 9500
        , .35
        , 146
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 158
        , 'Allan McEwen'
        , 'AMCEWEN'
        , '011.44.1345.829268'
        , STR_TO_DATE('01-08-2004', '%d-%m-%Y')
        , 'SA_REP'
        , 9000
        , .35
        , 146
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 159
        , 'Lindsey Smith'
        , 'LSMITH'
        , '011.44.1345.729268'
        , STR_TO_DATE('10-03-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 8000
        , .3
        , 146
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 160
        , 'Louise Doran'
        , 'LDORAN'
        , '011.44.1345.629268'
        , STR_TO_DATE('15-12-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 7500
        , .3
        , 146
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 161
        , 'Sarath Sewall'
        , 'SSEWALL'
        , '011.44.1345.529268'
        , STR_TO_DATE('03-11-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 7000
        , .25
        , 146
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 162
        , 'Clara Vishney'
        , 'CVISHNEY'
        , '011.44.1346.129268'
        , STR_TO_DATE('11-11-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 10500
        , .25
        , 147
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 163
        , 'Danielle Greene'
        , 'DGREENE'
        , '011.44.1346.229268'
        , STR_TO_DATE('19-03-2007', '%d-%m-%Y')
        , 'SA_REP'
        , 9500
        , .15
        , 147
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 164
        , 'Mattea Marvins'
        , 'MMARVINS'
        , '011.44.1346.329268'
        , STR_TO_DATE('24-01-2008', '%d-%m-%Y')
        , 'SA_REP'
        , 7200
        , .10
        , 147
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 165
        , 'David Lee'
        , 'DLEE'
        , '011.44.1346.529268'
        , STR_TO_DATE('23-02-2008', '%d-%m-%Y')
        , 'SA_REP'
        , 6800
        , .1
        , 147
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 166
        , 'Sundar Ande'
        , 'SANDE'
        , '011.44.1346.629268'
        , STR_TO_DATE('24-03-2008', '%d-%m-%Y')
        , 'SA_REP'
        , 6400
        , .10
        , 147
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 167
        , 'Amit Banda'
        , 'ABANDA'
        , '011.44.1346.729268'
        , STR_TO_DATE('21-04-2008', '%d-%m-%Y')
        , 'SA_REP'
        , 6200
        , .10
        , 147
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 168
        , 'Lisa Ozer'
        , 'LOZER'
        , '011.44.1343.929268'
        , STR_TO_DATE('11-03-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 11500
        , .25
        , 148
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 169  
        , 'Harrison Bloom'
        , 'HBLOOM'
        , '011.44.1343.829268'
        , STR_TO_DATE('23-03-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 10000
        , .20
        , 148
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 170
        , 'Tayler Fox'
        , 'TFOX'
        , '011.44.1343.729268'
        , STR_TO_DATE('24-01-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 9600
        , .20
        , 148
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 171
        , 'William Smith'
        , 'WSMITH'
        , '011.44.1343.629268'
        , STR_TO_DATE('23-02-2007', '%d-%m-%Y')
        , 'SA_REP'
        , 7400
        , .15
        , 148
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 172
        , 'Elizabeth Bates'
        , 'EBATES'
        , '011.44.1343.529268'
        , STR_TO_DATE('24-03-2007', '%d-%m-%Y')
        , 'SA_REP'
        , 7300
        , .15
        , 148
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 173
        , 'Sundita Kumar'
        , 'SKUMAR'
        , '011.44.1343.329268'
        , STR_TO_DATE('21-04-2008', '%d-%m-%Y')
        , 'SA_REP'
        , 6100
        , .10
        , 148
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 174
        , 'Ellen Abel'
        , 'EABEL'
        , '011.44.1644.429267'
        , STR_TO_DATE('11-05-2004', '%d-%m-%Y')
        , 'SA_REP'
        , 11000
        , .30
        , 149
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 175
        , 'Alyssa Hutton'
        , 'AHUTTON'
        , '011.44.1644.429266'
        , STR_TO_DATE('19-03-2005', '%d-%m-%Y')
        , 'SA_REP'
        , 8800
        , .25
        , 149
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 176
        , 'Jonathon Taylor'
        , 'JTAYLOR'
        , '011.44.1644.429265'
        , STR_TO_DATE('24-03-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 8600
        , .20
        , 149
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 177
        , 'Jack Livingston'
        , 'JLIVINGS'
        , '011.44.1644.429264'
        , STR_TO_DATE('23-04-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 8400
        , .20
        , 149
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 178
        , 'Kimberely Grant'
        , 'KGRANT'
        , '011.44.1644.429263'
        , STR_TO_DATE('24-05-2007', '%d-%m-%Y')
        , 'SA_REP'
        , 7000
        , .15
        , 149
        , NULL
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 179
        , 'Charles Johnson'
        , 'CJOHNSON'
        , '011.44.1644.429262'
        , STR_TO_DATE('04-01-2008', '%d-%m-%Y')
        , 'SA_REP'
        , 6200
        , .10
        , 149
        , 80
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 180
        , 'Winston Taylor'
        , 'WTAYLOR'
        , '650.507.9876'
        , STR_TO_DATE('24-01-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 181
        , 'Jean Fleaur'
        , 'JFLEAUR'
        , '650.507.9877'
        , STR_TO_DATE('23-02-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3100
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 182
        , 'Martha Sullivan'
        , 'MSULLIVA'
        , '650.507.9878'
        , STR_TO_DATE('21-06-2007', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2500
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 183
        , 'Girard Geoni'
        , 'GGEONI'
        , '650.507.9879'
        , STR_TO_DATE('03-02-2008', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2800
        , NULL
        , 120
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 184
        , 'Nandita Sarchand'
        , 'NSARCHAN'
        , '650.509.1876'
        , STR_TO_DATE('27-01-2004', '%d-%m-%Y')
        , 'SH_CLERK'
        , 4200
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 185
        , 'Alexis Bull'
        , 'ABULL'
        , '650.509.2876'
        , STR_TO_DATE('20-02-2005', '%d-%m-%Y')
        , 'SH_CLERK'
        , 4100
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 186
        , 'Julia Dellinger'
        , 'JDELLING'
        , '650.509.3876'
        , STR_TO_DATE('24-06-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3400
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 187
        , 'Anthony Cabrio'
        , 'ACABRIO'
        , '650.509.4876'
        , STR_TO_DATE('07-02-2007', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3000
        , NULL
        , 121
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 188
        , 'Kelly Chung'
        , 'KCHUNG'
        , '650.505.1876'
        , STR_TO_DATE('14-06-2005', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3800
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 189
        , 'Jennifer Dilly'
        , 'JDILLY'
        , '650.505.2876'
        , STR_TO_DATE('13-08-2005', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3600
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 190
        , 'Timothy Gates'
        , 'TGATES'
        , '650.505.3876'
        , STR_TO_DATE('11-07-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 191
        , 'Randall Perkins'
        , 'RPERKINS'
        , '650.505.4876'
        , STR_TO_DATE('19-12-2007', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2500
        , NULL
        , 122
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 192
        , 'Sarah Bell'
        , 'SBELL'
        , '650.501.1876'
        , STR_TO_DATE('04-02-2004', '%d-%m-%Y')
        , 'SH_CLERK'
        , 4000
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 193
        , 'Britney Everett'
        , 'BEVERETT'
        , '650.501.2876'
        , STR_TO_DATE('03-03-2005', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3900
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 194
        , 'Samuel McCain'
        , 'SMCCAIN'
        , '650.501.3876'
        , STR_TO_DATE('01-07-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 195
        , 'Vance Jones'
        , 'VJONES'
        , '650.501.4876'
        , STR_TO_DATE('17-03-2007', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2800
        , NULL
        , 123
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 196
        , 'Alana Walsh'
        , 'AWALSH'
        , '650.507.9811'
        , STR_TO_DATE('24-04-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 197
        , 'Kevin Feeney'
        , 'KFEENEY'
        , '650.507.9822'
        , STR_TO_DATE('23-05-2006', '%d-%m-%Y')
        , 'SH_CLERK'
        , 3000
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 198
        , 'Donald OConnell'
        , 'DOCONNEL'
        , '650.507.9833'
        , STR_TO_DATE('21-06-2007', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 199
        , 'Douglas Grant'
        , 'DGRANT'
        , '650.507.9844'
        , STR_TO_DATE('13-01-2008', '%d-%m-%Y')
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 200
        , 'Jennifer Whalen'
        , 'JWHALEN'
        , '515.123.4444'
        , STR_TO_DATE('17-09-2003', '%d-%m-%Y')
        , 'AD_ASST'
        , 4400
        , NULL
        , 101
        , 10
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 201
        , 'Michael Hartstein'
        , 'MHARTSTE'
        , '515.123.5555'
        , STR_TO_DATE('17-02-2004', '%d-%m-%Y')
        , 'MK_MAN'
        , 13000
        , NULL
        , 100
        , 20
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 202
        , 'Pat Fay'
        , 'PFAY'
        , '603.123.6666'
        , STR_TO_DATE('17-08-2005', '%d-%m-%Y')
        , 'MK_REP'
        , 6000
        , NULL
        , 201
        , 20
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 203
        , 'Susan Mavris'
        , 'SMAVRIS'
        , '515.123.7777'
        , STR_TO_DATE('07-06-2002', '%d-%m-%Y')
        , 'HR_REP'
        , 6500
        , NULL
        , 101
        , 40
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 204
        , 'Hermann Baer'
        , 'HBAER'
        , '515.123.8888'
        , STR_TO_DATE('07-06-2002', '%d-%m-%Y')
        , 'PR_REP'
        , 10000
        , NULL
        , 101
        , 70
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 205
        , 'Shelley Higgins'
        , 'SHIGGINS'
        , '515.123.8080'
        , STR_TO_DATE('07-06-2002', '%d-%m-%Y')
        , 'AC_MGR'
        , 12008
        , NULL
        , 101
        , 110
        );

INSERT INTO empregados(id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario, comissao, id_supervisor, id_departamento) VALUES 
        ( 206
        , 'William Gietz'
        , 'WGIETZ'
        , '515.123.8181'
        , STR_TO_DATE('07-06-2002', '%d-%m-%Y')
        , 'AC_ACCOUNT'
        , 8300
        , NULL
        , 205
        , 110
        );

INSERT INTO historico_cargos
VALUES (102
       , STR_TO_DATE('13-01-2001', '%d-%m-%Y')
       , STR_TO_DATE('24-07-2006', '%d-%m-%Y')
       , 'IT_PROG'
       , 60);

INSERT INTO historico_cargos
VALUES (101
       , STR_TO_DATE('21-09-1997', '%d-%m-%Y')
       , STR_TO_DATE('27-10-2001', '%d-%m-%Y')
       , 'AC_ACCOUNT'
       , 110);

INSERT INTO historico_cargos
VALUES (101
       , STR_TO_DATE('28-10-2001', '%d-%m-%Y')
       , STR_TO_DATE('15-03-2005', '%d-%m-%Y')
       , 'AC_MGR'
       , 110);

INSERT INTO historico_cargos
VALUES (201
       , STR_TO_DATE('17-02-2004', '%d-%m-%Y')
       , STR_TO_DATE('19-12-2007', '%d-%m-%Y')
       , 'MK_REP'
       , 20);

INSERT INTO historico_cargos
VALUES  (114
        , STR_TO_DATE('24-03-2006', '%d-%m-%Y')
        , STR_TO_DATE('31-12-2007', '%d-%m-%Y')
        , 'ST_CLERK'
        , 50
        );

INSERT INTO historico_cargos
VALUES  (122
        , STR_TO_DATE('01-01-2007', '%d-%m-%Y')
        , STR_TO_DATE('31-12-2007', '%d-%m-%Y')
        , 'ST_CLERK'
        , 50
        );

INSERT INTO historico_cargos
VALUES  (200
        , STR_TO_DATE('17-09-1995', '%d-%m-%Y')
        , STR_TO_DATE('17-06-2001', '%d-%m-%Y')
        , 'AD_ASST'
        , 90
        );

INSERT INTO historico_cargos
VALUES  (176
        , STR_TO_DATE('24-03-2006', '%d-%m-%Y')
        , STR_TO_DATE('31-12-2006', '%d-%m-%Y')
        , 'SA_REP'
        , 80
        );

INSERT INTO historico_cargos
VALUES  (176
        , STR_TO_DATE('01-01-2007', '%d-%m-%Y')
        , STR_TO_DATE('31-12-2007', '%d-%m-%Y')
        , 'SA_MAN'
        , 80
        );

INSERT INTO historico_cargos
VALUES  (200
        , STR_TO_DATE('01-07-2002', '%d-%m-%Y')
        , STR_TO_DATE('31-12-2006', '%d-%m-%Y')
        , 'AC_ACCOUNT'
        , 90
        );


ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE hsitorico_cargos ADD CONSTRAINT cargos_hsitorico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE hsitorico_cargos ADD CONSTRAINT departamentos_hsitorico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE hsitorico_cargos ADD CONSTRAINT empregados_hsitorico_cargos_fk
FOREIGN KEY (id_empregados)
REFERENCES empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

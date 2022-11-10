CREATE TABLE public.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE public.regioes IS 'Tabela Regiões, a qual contêm o número e o nome das regiões. ';
COMMENT ON COLUMN public.regioes.id_regiao IS 'Representa a Chave Primária das regiões';
COMMENT ON COLUMN public.regioes.nome IS 'Indica o nome das Regiões. ';


CREATE UNIQUE INDEX regioes_idx
 ON public.regioes
 ( nome );

CREATE TABLE public.paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER,
                CONSTRAINT id_pais PRIMARY KEY (id_pais)
);
COMMENT ON TABLE public.paises IS 'Tabela que contêm as informações dos países. ';
COMMENT ON COLUMN public.paises.id_pais IS 'Representa a Chave Primária da tabela páises ';
COMMENT ON COLUMN public.paises.nome IS 'Indica o nome do país';
COMMENT ON COLUMN public.paises.id_regiao IS 'Representa a chave estrangeira para a tabela regiões. ';


CREATE UNIQUE INDEX paises_idx
 ON public.paises
 ( nome );

CREATE TABLE public.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2),
                CONSTRAINT id_localiza__o PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE public.localizacoes IS 'Tabela que indica a localização dos escritórios que trabalham os empregados. ';
COMMENT ON COLUMN public.localizacoes.id_localizacao IS 'Representa a Chave Primária da tabela';
COMMENT ON COLUMN public.localizacoes.endereco IS 'Indica o endereço com Logradouro e número de um escritório da empresa';
COMMENT ON COLUMN public.localizacoes.cep IS 'Indica o CEP do endereço do escritório ou facilidade da empresa.';
COMMENT ON COLUMN public.localizacoes.cidade IS 'Indica a Cidade que se encontra escritórios ou facilidades da empresa. ';
COMMENT ON COLUMN public.localizacoes.uf IS 'Indica o Estado, podendo ser representado por sigla ou de forma extensa, que está localizado os escritórios ou facilidades da empresa. ';
COMMENT ON COLUMN public.localizacoes.id_pais IS 'Representa a Chave Estrangeira para a tabela países';


CREATE TABLE public.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT id_cargo PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE public.cargos IS 'Tabela responsável por armazenar os cargos que existem no período atual da empresa e o salário mínimo e máximo de cada cargo. ';
COMMENT ON COLUMN public.cargos.id_cargo IS 'Representa a chave primária da tabela';
COMMENT ON COLUMN public.cargos.cargo IS 'Indica o nome do Cargo.';
COMMENT ON COLUMN public.cargos.salario_minimo IS 'Indica o menor salário da empresa. ';
COMMENT ON COLUMN public.cargos.salario_maximo IS 'O maior salário da empresa. ';


CREATE UNIQUE INDEX cargos_idx
 ON public.cargos
 ( cargo );

CREATE TABLE public.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER,
                CONSTRAINT id_departamentos_ PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE public.departamentos IS 'Tabela Departamentos da empresa';
COMMENT ON COLUMN public.departamentos.id_departamento IS 'Representa a chave primária do departamento';
COMMENT ON COLUMN public.departamentos.nome IS 'Nome dos departamentos';
COMMENT ON COLUMN public.departamentos.id_localizacao IS 'Representa a Chave Primária da tabela';


CREATE UNIQUE INDEX departamentos_idx
 ON public.departamentos
 ( nome );

CREATE TABLE public.empregados (
                id_empregados INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER,
                id_supervisor INTEGER NOT NULL,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregados)
);
COMMENT ON TABLE public.empregados IS 'Informações dos empregados';
COMMENT ON COLUMN public.empregados.id_empregados IS 'Representa Chave Primária do empregado';
COMMENT ON COLUMN public.empregados.nome IS 'Nome e Sobrenome do colaborador';
COMMENT ON COLUMN public.empregados.email IS 'E-mail do empregado sem o @';
COMMENT ON COLUMN public.empregados.telefone IS 'Número de telefone do empregado com espaço para o código referente a país e estado. ';
COMMENT ON COLUMN public.empregados.data_contratacao IS 'Data em que o colaborador começou a trabalhar em seu atual cargo. ';
COMMENT ON COLUMN public.empregados.id_cargo IS 'Representa a Chave Estrangeira no relacionamento com a tabela cargos, e é utilizada para indicar o atual cargo do colaborador';
COMMENT ON COLUMN public.empregados.salario IS 'Indica o valor do salário por mês do colaborador, em seu cargo atual';
COMMENT ON COLUMN public.empregados.comissao IS 'Valor referente a porcentagem que os colaboradores do departamento de vendas recebem (somente esse departamento recebe comissão).';
COMMENT ON COLUMN public.empregados.id_departamento IS 'Representa a Chave Estrangeira para a tabela de departamentos, com o intuito de indica o departamento atual do colaborador.';


CREATE UNIQUE INDEX empregados_idx
 ON public.empregados
 ( email );

CREATE TABLE public.hsitorico_cargos (
                id_empregados INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER,
                CONSTRAINT id_empregado PRIMARY KEY (id_empregados, data_inicial)
);
COMMENT ON TABLE public.hsitorico_cargos IS 'Tabela responsável por armazenar a "carreira" de um empregado dentro da empresa, como mudanças de cargo ou de departamento. ';
COMMENT ON COLUMN public.hsitorico_cargos.id_empregados IS 'Representa Chave Primária do empregado';
COMMENT ON COLUMN public.hsitorico_cargos.data_inicial IS 'Indica a Data Inicial do colaborador no atual cargo, de forma que seja maior que a data_final.';
COMMENT ON COLUMN public.hsitorico_cargos.data_final IS 'A Data Final indica o último dia que algum empregado trabalhou em algum cargo. Essa data deve ser maior que a data_inicial. ';
COMMENT ON COLUMN public.hsitorico_cargos.id_cargo IS 'Representa a Chave estrangeira para tabela "cargos". Indica o cargo em que o colaborador pode ter trabalhado no passado. ';
COMMENT ON COLUMN public.hsitorico_cargos.id_departamento IS 'Representa Chave Estrangeira para a tabela departamentos. Indica o Departamento em que o empregado trabalhou algum dia. ';


ALTER TABLE public.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES public.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES public.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES public.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.hsitorico_cargos ADD CONSTRAINT cargos_hsitorico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES public.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.hsitorico_cargos ADD CONSTRAINT departamentos_hsitorico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES public.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.hsitorico_cargos ADD CONSTRAINT empregados_hsitorico_cargos_fk
FOREIGN KEY (id_empregados)
REFERENCES public.empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES public.empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES public.empregados (id_empregados)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

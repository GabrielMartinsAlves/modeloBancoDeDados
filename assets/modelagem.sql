CREATE TABLE EMPLOYEES (
 id BIGSERIAL PRIMARY KEY,
 Names VARCHAR(200) NOT NULL DEFAULT 'NULL',
 IsEngineer BOOLEAN NOT NULL DEFAULT FALSE,
 Emails VARCHAR(120) NOT NULL DEFAULT 'NULL',
 Passwords VARCHAR(50) NOT NULL DEFAULT 'NULL'
);
COMMENT ON TABLE EMPLOYEES IS 'Tabela que armazenará todos os funcionários da empresa';
COMMENT ON COLUMN EMPLOYEES.IsEngineer IS 'Campo binário para definição se é engenheiro ou não';

CREATE TABLE MANUALS (
 id BIGSERIAL PRIMARY KEY,
 PublicationDates DATE NOT NULL DEFAULT CURRENT_DATE,
 Descriptions VARCHAR(350),
 Titles VARCHAR(80) NOT NULL DEFAULT 'Sem Título',
 Versions DECIMAL DEFAULT 0.1
);
COMMENT ON TABLE MANUALS IS 'Manuais para o aprendizado da montagem de produtos';

CREATE TABLE ASSEMBLY_LINES (
 id BIGSERIAL PRIMARY KEY,
 Names VARCHAR(50) NOT NULL DEFAULT 'NULL',
 Descriptions VARCHAR(200) DEFAULT 'Sem descrição'
);
COMMENT ON TABLE ASSEMBLY_LINES IS 'Armazenará as linhas de montagens das quais os funcionários são pertencentes.';

CREATE TABLE PRODUCTS (
 id BIGSERIAL PRIMARY KEY,
 id_ASSEMBLY_LINES INTEGER,
 id_MANUALS INTEGER,
 Names VARCHAR(200) NOT NULL DEFAULT 'NULL',
 Categorys VARCHAR(50) NOT NULL DEFAULT 'NULL',
 Descriptions VARCHAR(300) DEFAULT 'Sem descrição',
 CONSTRAINT fk_PRODUCTS_id_ASSEMBLY_LINES FOREIGN KEY (id_ASSEMBLY_LINES) REFERENCES ASSEMBLY_LINES(id),
 CONSTRAINT fk_MANUALS FOREIGN KEY (id_MANUALS) REFERENCES MANUALS(id)
);
COMMENT ON TABLE PRODUCTS IS 'Equipamentos montados pela Dell';
COMMENT ON COLUMN PRODUCTS.Categorys IS 'Exemplo: monitor, notebook, servidor, etc.';

CREATE TABLE MATERIALS (
 id BIGSERIAL PRIMARY KEY,
 id_MANUALS INTEGER,
 Archives VARCHAR(150) NOT NULL DEFAULT 'NULL',
 Types VARCHAR(50) NOT NULL DEFAULT 'NULL',
 Titles VARCHAR(80) NOT NULL DEFAULT 'Sem Título',
 Descriptions VARCHAR(350) DEFAULT 'Sem descrição',
 CONSTRAINT fk_MATERIALS_id_MANUALS FOREIGN KEY (id_MANUALS) REFERENCES MANUALS(id)
);
COMMENT ON TABLE MATERIALS IS 'Arquivos que serão utilizados nos manuais';
COMMENT ON COLUMN MATERIALS.Archives IS 'Caminho para o material';
COMMENT ON COLUMN MATERIALS.Types IS 'Campo para informar a extensão do arquivo do manual (PDF, vídeo, modelo 3D, etc)';

CREATE TABLE ASSEMBLY_LINES_EMPLOYEES (
 id_EMPLOYEES INTEGER,
 id_ASSEMBLY_LINES INTEGER,
 PRIMARY KEY (id_EMPLOYEES, id_ASSEMBLY_LINES),
 CONSTRAINT fk_ASSEMBLY_LINES_EMPLOYEES_id_EMPLOYEES FOREIGN KEY (id_EMPLOYEES) REFERENCES EMPLOYEES(id),
 CONSTRAINT fk_ASSEMBLY_LINES_EMPLOYEES_id_ASSEMBLY_LINES FOREIGN KEY (id_ASSEMBLY_LINES) REFERENCES ASSEMBLY_LINES(id)
);
COMMENT ON TABLE ASSEMBLY_LINES_EMPLOYEES IS 'Intermédio entre as tabelas de linha de montagem e a tabela de funcionários por conta da relação n pra n';

CREATE TABLE TO_DOS (
 id BIGSERIAL PRIMARY KEY,
 id_EMPLOYEES INTEGER,
 id_MANUALS INTEGER,
 Status BOOLEAN NOT NULL DEFAULT FALSE,
 AssignmentDates DATE NOT NULL DEFAULT CURRENT_DATE,
 CONSTRAINT fk_TO_DOS_id_EMPLOYEES FOREIGN KEY (id_EMPLOYEES) REFERENCES EMPLOYEES(id),
 CONSTRAINT fk_TO_DOS_id_MANUALS FOREIGN KEY (id_MANUALS) REFERENCES MANUALS(id)
);
COMMENT ON TABLE TO_DOS IS 'Lista de manuais a serem lidos pelo funcionário';
COMMENT ON COLUMN TO_DOS.Status IS 'Campo binário para definir se a tarefa foi concluída ou não';
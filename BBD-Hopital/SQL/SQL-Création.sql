ALTER TABLE PATIENT
DROP CONSTRAINT fkPatientService;
ALTER TABLE PATIENT
DROP CONSTRAINT fkPatientLit;
ALTER TABLE EMPLOYE
DROP CONSTRAINT fkEmployeRole;
ALTER TABLE GERER
DROP CONSTRAINT fkGererTraitement;
ALTER TABLE GERER
DROP CONSTRAINT fkGererEmploye;
ALTER TABLE TRAITEMENT
DROP CONSTRAINT fkTraitementPatient;
ALTER TABLE TRAITEMENT
DROP CONSTRAINT fkTraitementStatut;
ALTER TABLE COMPOSER
DROP CONSTRAINT fkComposerMedicament;
ALTER TABLE COMPOSER
DROP CONSTRAINT fkComposerTraitement;
ALTER TABLE EMPLOYE
DROP CONSTRAINT fkEmployeDisponible;
ALTER TABLE MEDICAMENT
DROP CONSTRAINT fkMedicamentCommande;
ALTER TABLE COMMANDE
DROP CONSTRAINT fkCommandeEtatCommande;
ALTER TABLE INFECTION
DROP CONSTRAINT fkInfectionPatient;
ALTER TABLE INFECTION
DROP CONSTRAINT fkInfectionMaladie;
ALTER TABLE DIAGNOSTIQUER;
DROP CONSTRAINT fkDiagnostiquerEmploye
ALTER TABLE DIAGNOSTIQUER
DROP CONSTRAINT fkDiagnostiquerInfection;
commit;

DROP TABLE SERVICE;
DROP TABLE LIT;
DROP TABLE MALADIE;
DROP TABLE PATIENT;
DROP TABLE EMPLOYE;
DROP TABLE ROLE;
DROP TABLE GERER;
DROP TABLE TRAITEMENT;
DROP TABLE COMPOSER;
DROP TABLE MEDICAMENT;
DROP TABLE DISPONIBLE;
DROP TABLE COMMANDE;
DROP TABLE STATUT;
DROP TABLE ETATCOMMANDE;
DROP TABLE INFECTION;
DROP TABLE DIAGNOSTIQUER;
commit;

CREATE TABLE SERVICE (
  id INTEGER,
  service VARCHAR2(30)
);

CREATE TABLE LIT (
  id INTEGER,
  numbloc INTEGER,
  numchambre INTEGER NOT NULL,
  numetage INTEGER NOT NULL,
  nomaile VARCHAR2(10) NOT NULL
);

CREATE TABLE MALADIE (
  id INTEGER,
  nommaladie VARCHAR2(500)
);

CREATE TABLE PATIENT (
  id INTEGER,
  numsecu INTEGER,
  nummutuelle INTEGER,
  civilite CHAR(1) NOT NULL,
  nompatient VARCHAR2(30) NOT NULL,
  prenompatient VARCHAR2(30) NOT NULL,
  datenaissance DATE NOT NULL,
  adresse VARCHAR2(70),
  dateentree DATE NOT NULL,
  datesortie DATE,
  telephone VARCHAR2(15),
  idlit INTEGER,
  idservice INTEGER,
  nivurgence INTEGER NOT NULL,
  etaturgence CHAR(1) NOT NULL
);

CREATE TABLE EMPLOYE (
  id INTEGER,
  login VARCHAR2(30),
  nomemploye VARCHAR2(30) NOT NULL,
  prenomemploye VARCHAR2(30) NOT NULL,
  mdp VARCHAR2(50) NOT NULL,
  idrole INTEGER NOT NULL,
  iddisponible INTEGER
);

CREATE TABLE ROLE (
  id INTEGER,
  nomrole VARCHAR2(15)
);

CREATE TABLE GERER (
  idemploye INTEGER NOT NULL,
  idtraitement INTEGER,
  dateprescription DATE NOT NULL
);

CREATE TABLE TRAITEMENT (
  id INTEGER,
  datetraitement DATE,
  datefintraitement DATE,
  idstatut INTEGER NOT NULL,
  idpatient INTEGER NOT NULL
);

CREATE TABLE COMPOSER (
  idtraitement INTEGER NOT NULL,
  idmedicament INTEGER NOT NULL,
  quantitemedoc INTEGER NOT NULL
);

CREATE TABLE MEDICAMENT (
  id INTEGER,
  nommedicament VARCHAR2(500),
  principeactif VARCHAR2(500) NOT NULL,
  stock INTEGER NOT NULL
);

CREATE TABLE DISPONIBLE (
  id INTEGER,
  disponible VARCHAR2(15)
);

CREATE TABLE COMMANDE (
  id INTEGER,
  datecommande DATE NOT NULL,
  quantitecommande INTEGER NOT NULL,
  idetat INTEGER NOT NULL,
  idMedicament INTEGER NOT NULL
);

CREATE TABLE STATUT (
  id INTEGER,
  statut VARCHAR2(15)
);

CREATE TABLE ETATCOMMANDE (
  id INTEGER,
  etat VARCHAR2(15)
);

CREATE TABLE INFECTION (
  id INTEGER,
  idpatient INTEGER NOT NULL,
  idmaladie INTEGER NOT NULL,
  idemploye INTEGER NOT NULL,
  dateGuerison DATE,
  dateDiagnostic DATE
);

CREATE TABLE DIAGNOSTIQUER (
  idInfection INTEGER NOT NULL,
  idEmploye INTEGER NOT NULL
);
commit;

ALTER TABLE SERVICE ADD CONSTRAINT pkService PRIMARY KEY (id);
ALTER TABLE LIT ADD CONSTRAINT pkLit PRIMARY KEY (id);
ALTER TABLE PATIENT ADD CONSTRAINT pkPatient PRIMARY KEY (id);
ALTER TABLE EMPLOYE ADD CONSTRAINT pkEmploye PRIMARY KEY (id);
ALTER TABLE ROLE ADD CONSTRAINT pkRole PRIMARY KEY (id);
ALTER TABLE GERER ADD CONSTRAINT pkGerer PRIMARY KEY (idemploye, idtraitement);
ALTER TABLE TRAITEMENT ADD CONSTRAINT pkTraitement PRIMARY KEY (id);
ALTER TABLE COMPOSER ADD CONSTRAINT pkComposer PRIMARY KEY (idtraitement, idmedicament);
ALTER TABLE MEDICAMENT ADD CONSTRAINT pkMedicament PRIMARY KEY (id);
ALTER TABLE DISPONIBLE ADD CONSTRAINT pkDisponible PRIMARY KEY (id);
ALTER TABLE COMMANDE ADD CONSTRAINT pkCommande PRIMARY KEY (id);
ALTER TABLE ETATCOMMANDE ADD CONSTRAINT pkEtatCommande PRIMARY KEY (id);
ALTER TABLE STATUT ADD CONSTRAINT pkStatut PRIMARY KEY (id);
ALTER TABLE MALADIE ADD CONSTRAINT pkMaladie PRIMARY KEY (id);
ALTER TABLE INFECTION ADD CONSTRAINT pkInfection PRIMARY KEY (id);
ALTER TABLE Diagnostiquer ADD CONSTRAINT pkMaladie PRIMARY KEY (idInfection, idEmploye);

ALTER TABLE PATIENT ADD CONSTRAINT fkPatientService FOREIGN KEY (idservice) REFERENCES SERVICE (id);
ALTER TABLE PATIENT ADD CONSTRAINT fkPatientLit FOREIGN KEY (idlit) REFERENCES LIT (id);
ALTER TABLE EMPLOYE ADD CONSTRAINT fkEmployeRole FOREIGN KEY (idrole) REFERENCES ROLE (id);
ALTER TABLE EMPLOYE ADD CONSTRAINT fkEmployeDisponible FOREIGN KEY (iddisponible) REFERENCES DISPONIBLE (id); 
ALTER TABLE GERER ADD CONSTRAINT fkGererTraitement FOREIGN KEY (idtraitement) REFERENCES TRAITEMENT (id);
ALTER TABLE GERER ADD CONSTRAINT fkGererEmploye FOREIGN KEY (idemploye) REFERENCES EMPLOYE (id);
ALTER TABLE TRAITEMENT ADD CONSTRAINT fkTraitementPatient FOREIGN KEY (idpatient) REFERENCES PATIENT (id);
ALTER TABLE TRAITEMENT ADD CONSTRAINT fkTraitementStatut FOREIGN KEY (idstatut) REFERENCES STATUT (id);
ALTER TABLE COMPOSER ADD CONSTRAINT fkComposerMedicament FOREIGN KEY (idmedicament) REFERENCES MEDICAMENT (id);
ALTER TABLE COMPOSER ADD CONSTRAINT fkComposerTraitement FOREIGN KEY (idtraitement) REFERENCES TRAITEMENT (id);
ALTER TABLE COMMANDE ADD CONSTRAINT fkMedicamentCommande FOREIGN KEY (idMedicament) REFERENCES Medicament (id);
ALTER TABLE COMMANDE ADD CONSTRAINT fkCommandeEtatCommande FOREIGN KEY (idetat) REFERENCES ETATCOMMANDE (id);
ALTER TABLE INFECTION ADD CONSTRAINT fkInfectionPatient FOREIGN KEY (idPatient) REFERENCES PATIENT (id);
ALTER TABLE INFECTION ADD CONSTRAINT fkInfectionMaladie FOREIGN KEY (idMaladie) REFERENCES MALADIE (id);
ALTER TABLE DIAGNOSTIQUER ADD CONSTRAINT fkDiagnostiquerEmploye FOREIGN KEY (idEmploye) REFERENCES EMPLOYE (id);
ALTER TABLE DIAGNOSTIQUER ADD CONSTRAINT fkDiagnostiquerInfection FOREIGN KEY (idInfection) REFERENCES INFECTION (id);

ALTER TABLE MALADIE ADD CONSTRAINT ukMaladie UNIQUE (nommaladie);
ALTER TABLE PATIENT ADD CONSTRAINT ukPatient UNIQUE (numsecu);
ALTER TABLE EMPLOYE ADD CONSTRAINT ukEmploye UNIQUE (login);
ALTER TABLE MEDICAMENT ADD CONSTRAINT ukMedicament UNIQUE (nommedicament);
ALTER TABLE DISPONIBLE ADD CONSTRAINT ukDisponible UNIQUE (disponible);
ALTER TABLE SERVICE ADD CONSTRAINT ukService UNIQUE (service);
ALTER TABLE STATUT ADD CONSTRAINT ukStatut UNIQUE (statut);
ALTER TABLE ETATCOMMANDE ADD CONSTRAINT ukEtatCommande UNIQUE (etat);
ALTER TABLE ROLE ADD CONSTRAINT ukRole UNIQUE (nomrole);
commit;

CREATE INDEX IDX_PATIENT ON PATIENT (nompatient, prenompatient);
CREATE INDEX IDX_EMPLOYE ON EMPLOYE (nomemploye, prenomemploye);
commit;

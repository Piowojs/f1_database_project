CREATE TABLE sezony ( rok INTEGER PRIMARY KEY);

CREATE TABLE zespoly (nazwa varchar(50) PRIMARY KEY, narodowosc varchar(50) NOT NULL, budzet int NOT NULL, limit_budzetowy int NOT NULL);


CREATE TABLE tory (nazwa varchar(50) PRIMARY KEY, miasto varchar(50) NOT NULL, panstwo varchar(50) NOT NULL, długosc float8 NOT NULL);

CREATE TABLE kierowcy (
imie varchar(50) NOT NULL,
 nazwisko varchar(50) NOT NULL,
 numer int NOT NULL,
 data_urodzenia DATE NOT NULL,
 narodowosc varchar(50) NOT NULL,
 nazwa_zespolu varchar(50),
 CONSTRAINT fk_zespoly
	FOREIGN KEY (nazwa_zespolu)
	REFERENCES zespoly(nazwa)
);

CREATE TABLE kierowcy_w_sezonach (
	kierowcy_imie varchar(50) PRIMARY KEY,
	kierowcy_nazwisko varchar(50) NOT NULL,
	sezon int NOT NULL,
	CONSTRAINT fk_sezony
		FOREIGN KEY (sezon)
		REFERENCES sezony(rok)
	CONSTRAINT fk_imie_kierowcy FOREIGN KEY (kierowcy_imie, kierowcy_nazwisko) REFERENCES kierowcy(imie, nazwisko);
);

CREATE TABLE sponsorzy (
	nazwa varchar(50) PRIMARY KEY,
	inwestycja int NOT NULL,
	nazwa_zespolu varchar(50) NOT NULL,
	CONSTRAINT fk_sponsorzy_zespoly FOREIGN KEY (nazwa_zespolu) REFERENCES zespoly(nazwa) ON DELETE CASCADE
);

-------------------------------------------------------

CREATE TABLE wyscigi (
  data DATE PRIMARY KEY,
  nazwa_toru varchar(50) NOT NULL,
  sezon INT,
  CONSTRAINT fk_wyscigi_tory FOREIGN KEY (nazwa_toru) REFERENCES tory(nazwa),
  CONSTRAINT fk_wyscigi_sezony FOREIGN KEY (sezon) REFERENCES sezony(rok)
);

CREATE TABLE wyniki_zespolow (
  id_wyniku_zespolow SERIAL PRIMARY KEY,
  pozycja int NOT NULL,
  punkty int NOT NULL,
  data_wyscigu DATE NOT NULL,
  nazwa_zespolu varchar(50) NOT NULL,
  CONSTRAINT fk_wyniki_zespolow_wyscigi FOREIGN KEY (data_wyscigu) REFERENCES wyscigi(data),
  CONSTRAINT fk_wyniki_zespolow_zespoly FOREIGN KEY (nazwa_zespolu) REFERENCES zespoly(nazwa)
);

CREATE TABLE wyniki_kierowcow (
  id_wyniku_kierowcow int NOT NULL,
  pozycja int NOT NULL,
  punkty int NOT NULL,
  najszybsze_okrazenie int NOT NULL,
  data_wyscigu DATE NOT NULL,
  imie_kierowcy varchar(50) NOT NULL,
  nazwisko_kierowcy varchar(50) NOT NULL,
  CONSTRAINT fk_wyniki_kierowcow_wyscigi FOREIGN KEY (data_wyscigu) REFERENCES wyscigi(data),
  CONSTRAINT fk_wyniki_kierowcow_kierowcy FOREIGN KEY (imie_kierowcy, nazwisko_kierowcy) REFERENCES kierowcy(imie, nazwisko)
);

CREATE TABLE kwalifikacje_wyniki (
  id_kwalifikacji SERIAL PRIMARY KEY,
  pozycja int NOT NULL,
  czas_q1 float8,
  czas_q2 float8,
  czas_q3 float8,
  data_wyscigu DATE NOT NULL,
  imie_kierowcy varchar(50),
  nazwisko_kierowcy varchar(50),
  CONSTRAINT fk_kwalifikacje_kierowcy FOREIGN KEY (imie_kierowcy, nazwisko_kierowcy) REFERENCES kierowcy(imie, nazwisko),
  CONSTRAINT fk_kwalifikacje_wyscigi FOREIGN KEY (data_wyscigu) REFERENCES wyscigi(data)
);

CREATE TABLE sprinty_wyniki (
  id_wyniku SERIAL PRIMARY KEY,
  pozycja int NOT NULL,
  punkty int NOT NULL,
  data_wyscigu DATE NOT NULL,
  imie_kierowcy varchar(50),
  nazwisko_kierowcy varchar(50),
  CONSTRAINT fk_kwalifikacje_kierowcy FOREIGN KEY (imie_kierowcy, nazwisko_kierowcy) REFERENCES kierowcy(imie, nazwisko),
  CONSTRAINT fk_kwalifikacje_wyscigi FOREIGN KEY (data_wyscigu) REFERENCES wyscigi(data)
);

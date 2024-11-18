# lfet_demo02_risikoanalyse_enum

## dependencies

package [/RBGRP/MAIN](https://github.com/Ennowulff/rbgrp-main) which contains general exceptions

## Demo report 

Demo 02 Risikoanalyse mit ENUM

PROG ZZLFET02_DEMO01_ENUM

![image](https://github.com/user-attachments/assets/d8f9df56-fba3-489b-bc1c-36918d4a4625)


## zif_lfet02_enum_risikoanalyse

Interface für Model

hier findet die Ermittlung und Verwaltung der Werte zum Projekt statt

## zcl_lfet02_enum_rule_risikoan

Modelimplementierung
implementiert zif_lfet02_enum_risikoanalyse

- Definition der ENUMS
- Methode EXECUTE
- GET_TEXT zur Ermittlung der Beschreibung zu ENUM-Werten
- GET_ENUM_VAL_x zur Ermittlung des ENUMS zu nicht eindeutigen Werten (Intervalle)

# Implementierung Model

Idee: generierte Model-Klasse kann out-of-the-box verwendet werden, indem die Werte mit SET_x gesetzt werden.
Für eine 

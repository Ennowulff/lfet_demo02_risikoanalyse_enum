INTERFACE zif_lfet02_enum_risikoanalyse
  PUBLIC.

  TYPES:
    BEGIN OF ENUM enum_risikoanalyse STRUCTURE risikoanalyse,
      "! Eine Risikoanalyse wird empfohlen, ist jedoch nicht zwingend notwendig
      empfohlen,
      "! Eine Risikoanalyse ist nicht notwendig
      nicht_notwendig,
      "! Eine Risikoanalyse ist notwendig
      notwendig,
    END OF ENUM enum_risikoanalyse STRUCTURE risikoanalyse.

  TYPES:
    BEGIN OF ENUM enum_rechtl_rahmenbedingungen STRUCTURE rechtl_rahmenbedingungen,
      "! Es sind keine rechtlichen Rahmenbedingungen zu berücksichtigen
      keine,
      "! Es ist unklar/ nicht geklärt, ob rechtliche Rahmenbedingungen vorhanden sind
      unklar,
      "! Es existieren rechtliche Rahmenbedingungen, die zu berücksichtigen sind
      vorhanden,
    END OF ENUM enum_rechtl_rahmenbedingungen STRUCTURE rechtl_rahmenbedingungen.

  TYPES:
    BEGIN OF ENUM enum_projektumfang STRUCTURE projektumfang,
      "!<=15
      klein,
      "!16-60
      mittel,
      "!> 60
      gross,
    END OF ENUM enum_projektumfang STRUCTURE projektumfang.

  TYPES:
    BEGIN OF ENUM enum_ressourcen_abhaengigkeit STRUCTURE ressourcen_abhaengigkeit,
      "!kein Externer, genau 1 Interner
      int1,
      "!kein Externer, mehr als 1 Interner
      int2plus,
      "!mindestens 1 Extener (Anzahl Interne irrelevant)
      ext1plus,
    END OF ENUM enum_ressourcen_abhaengigkeit STRUCTURE ressourcen_abhaengigkeit.
  TYPES: BEGIN OF _values,
           rechtl_rahmenbedingung   TYPE zif_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen,
           ressourcen_abhaengigkeit TYPE zif_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit,
           projektumfang            TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang,
         END OF _values.

  TYPES: BEGIN OF _state,
           risikoanalyse TYPE zif_lfet02_enum_risikoanalyse=>enum_risikoanalyse,
         END OF _state.

  METHODS do_risikoanalyse
    IMPORTING i_value TYPE zif_lfet02_enum_risikoanalyse=>enum_risikoanalyse.

  METHODS get_risikoanalyse
    RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_risikoanalyse.

  METHODS set_rechtl_rahmenbedingungen
    IMPORTING i_value TYPE zif_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen.

  METHODS set_ressourcen_abhaengigkeit
    IMPORTING i_value TYPE zif_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit.

  METHODS set_projektumfang
    IMPORTING i_value TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang.

  METHODS is_rechtl_rahmenbedingungen
    RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen.

  METHODS is_ressourcen_abhaengigkeit
    RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit.

  METHODS is_projektumfang
    RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang.


  DATA trace TYPE REF TO /rbgrp/if_trace.

ENDINTERFACE.

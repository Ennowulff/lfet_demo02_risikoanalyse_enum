INTERFACE zif_lfet02_enum_risikoanalyse
  PUBLIC.

 TYPES: BEGIN OF _values,
           rechtl_rahmenbedingung   TYPE zcl_lfet02_rule_risikoan_enum=>enum_rechtl_rahmenbedingungen,
           ressourcen_abhaengigkeit TYPE zcl_lfet02_rule_risikoan_enum=>enum_ressourcen_abhaengigkeit,
           projektumfang            TYPE zcl_lfet02_rule_risikoan_enum=>enum_projektumfang,
         END OF _values.

  TYPES: BEGIN OF _state,
           risikoanalyse TYPE zcl_lfet02_rule_risikoan_enum=>enum_risikoanalyse,
         END OF _state.

  METHODS do_risikoanalyse
    IMPORTING
      i_value TYPE zcl_lfet02_rule_risikoan_enum=>enum_risikoanalyse.

  METHODS get_risikoanalyse
    RETURNING
      VALUE(result) TYPE zcl_lfet02_rule_risikoan_enum=>enum_risikoanalyse.

  METHODS set_rechtl_rahmenbedingungen
    IMPORTING
      i_value TYPE zcl_lfet02_rule_risikoan_enum=>enum_rechtl_rahmenbedingungen.

  METHODS set_ressourcen_abhaengigkeit
    IMPORTING
      i_value TYPE zcl_lfet02_rule_risikoan_enum=>enum_ressourcen_abhaengigkeit.

  METHODS set_projektumfang
    IMPORTING
      i_value TYPE zcl_lfet02_rule_risikoan_enum=>enum_projektumfang.

  METHODS is_rechtl_rahmenbedingungen
    RETURNING
      VALUE(result) TYPE zcl_lfet02_rule_risikoan_enum=>enum_rechtl_rahmenbedingungen.

  METHODS is_ressourcen_abhaengigkeit
    RETURNING
      VALUE(result) TYPE zcl_lfet02_rule_risikoan_enum=>enum_ressourcen_abhaengigkeit.

  METHODS is_projektumfang
    RETURNING
      VALUE(result) TYPE zcl_lfet02_rule_risikoan_enum=>enum_projektumfang.


  DATA trace TYPE REF TO /rbgrp/if_trace.

ENDINTERFACE.

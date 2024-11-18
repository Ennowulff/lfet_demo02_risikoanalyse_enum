CLASS zcl_lfet02_enum_risikoanalyse DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_lfet02_enum_risikoanalyse.

    ALIASES trace                        FOR zif_lfet02_enum_risikoanalyse~trace.

    METHODS constructor.

  PRIVATE SECTION.
    DATA values TYPE zif_lfet02_enum_risikoanalyse=>_values.
    DATA state  TYPE zif_lfet02_enum_risikoanalyse=>_state.

ENDCLASS.


CLASS zcl_lfet02_enum_risikoanalyse IMPLEMENTATION.
  METHOD constructor.
    trace = NEW /rbgrp/cl_trace( ).
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_projektumfang.
    IF values-projektumfang IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-projektumfang.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_rechtl_rahmenbedingungen.
    IF values-rechtl_rahmenbedingung IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-rechtl_rahmenbedingung.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_ressourcen_abhaengigkeit.
    IF values-ressourcen_abhaengigkeit IS INITIAL.
      " Implement your customer code here
    ELSE.
      result = values-ressourcen_abhaengigkeit.
    ENDIF.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~set_projektumfang.
    values-projektumfang = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~set_rechtl_rahmenbedingungen.
    values-rechtl_rahmenbedingung = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~set_ressourcen_abhaengigkeit.
    values-ressourcen_abhaengigkeit = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~do_risikoanalyse.
    state-risikoanalyse = i_value.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~get_risikoanalyse.
    result = state-risikoanalyse.
  ENDMETHOD.

ENDCLASS.

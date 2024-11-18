CLASS zcl_lfet02_rule_risikoan_enum DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ENUM enum_risikoanalyse STRUCTURE risikoanalyse,
        "! undefined/ initial value
        undefined,
        "! Eine Risikoanalyse wird empfohlen, ist jedoch nicht zwingend notwendig
        empfohlen,
        "! Eine Risikoanalyse ist nicht notwendig
        nicht_notwendig,
        "! Eine Risikoanalyse ist notwendig
        notwendig,
      END OF ENUM enum_risikoanalyse STRUCTURE risikoanalyse.

    TYPES:
      BEGIN OF ENUM enum_rechtl_rahmenbedingungen STRUCTURE rechtl_rahmenbedingungen,
        undefined,
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

    CLASS-METHODS execute
      IMPORTING i_model TYPE REF TO zif_lfet02_enum_risikoanalyse.

    CLASS-METHODS get_Text
      IMPORTING i_enum        TYPE any
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_enum_val_projektumfang
      IMPORTING i_input       TYPE i
      RETURNING VALUE(result) TYPE enum_projektumfang.

  PRIVATE SECTION.
    CLASS-METHODS get_txt_rechtl_rahmenbed
      IMPORTING i_enum        TYPE enum_rechtl_rahmenbedingungen
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_txt_ressourcen_abh
      IMPORTING i_enum        TYPE enum_ressourcen_abhaengigkeit
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_txt_projektumfang
      IMPORTING i_enum        TYPE enum_projektumfang
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_txt_risikoanalyse
      IMPORTING i_enum        TYPE enum_risikoanalyse
      RETURNING VALUE(result) TYPE string.
ENDCLASS.


CLASS zcl_lfet02_rule_risikoan_enum IMPLEMENTATION.
  METHOD execute.
    " Prolog Standard <----

    i_model->trace->inittrace( name            = 'Risikoanalyse'
                               number_of_rules = '25'
                               version         = '20220613.181835' ).

    IF i_model->is_rechtl_rahmenbedingungen( ) = rechtl_rahmenbedingungen-keine.
      IF i_model->is_ressourcen_abhaengigkeit( ) = ressourcen_abhaengigkeit-int1.
        " Rule R01 ---->
        i_model->trace->dotrace( '1' ).
        i_model->do_risikoanalyse( risikoanalyse-nicht_notwendig ).
        " Rule R01 <----
      ELSEIF i_model->is_ressourcen_abhaengigkeit( ) = ressourcen_abhaengigkeit-int2plus.
        IF i_model->is_projektumfang( ) = projektumfang-klein.
          " Rule R02 ---->
          i_model->trace->dotrace( '2' ).
          i_model->do_risikoanalyse( risikoanalyse-nicht_notwendig ).
        ELSEIF i_model->is_projektumfang( ) = projektumfang-mittel.
          " Rule R03 ---->
          i_model->trace->dotrace( '3' ).
          i_model->do_risikoanalyse( risikoanalyse-empfohlen ).
        ELSE.
          " Rule R04 ---->
          i_model->Trace->dotrace( '4' ).
          i_model->do_risikoanalyse( risikoanalyse-empfohlen ).
        ENDIF.
      ELSE.
        " Rule R05 ---->
        i_model->trace->dotrace( '5' ).
        i_model->do_risikoanalyse( risikoanalyse-empfohlen ).

      ENDIF.
    ELSEIF i_model->is_rechtl_rahmenbedingungen( ) = rechtl_rahmenbedingungen-unklar.
      " Rule R06 ---->
      i_model->trace->dotrace( '6' ).
      i_model->do_risikoanalyse( risikoanalyse-empfohlen ).
    ELSE.
      " Rule R07 ---->
      i_model->trace->dotrace( '7' ).
      i_model->do_risikoanalyse( risikoanalyse-notwendig ).
    ENDIF.
  ENDMETHOD.

  METHOD get_text.
    DATA(enum_name) = cl_abap_typedescr=>describe_by_data( i_enum )->get_relative_name( ).

    result = SWITCH #( enum_name
                       WHEN 'ENUM_PROJEKTUMFANG'            THEN get_txt_projektumfang( i_enum )
                       WHEN 'ENUM_RECHTL_RAHMENBEDINGUNGEN' THEN get_txt_rechtl_rahmenbed( i_enum )
                       WHEN 'ENUM_RESSOURCEN_ABHAENGIGKEIT' THEN get_txt_ressourcen_abh( i_enum )
                       WHEN 'ENUM_PROJEKTUMFANG'            THEN get_txt_projektumfang( i_enum )
                       WHEN 'ENUM_RISIKOANALYSE'            THEN get_txt_risikoanalyse( i_enum )
                       ELSE                                      THROW zcx_lfet02_enum_wrong_value( ) ).
  ENDMETHOD.

  METHOD get_txt_projektumfang.
    result = SWITCH #( i_enum
                       WHEN projektumfang-klein  THEN 'Klein: <=15'
                       WHEN projektumfang-mittel THEN 'Mittel: 16-60'
                       WHEN projektumfang-gross  THEN 'Groß: >60' ).
  ENDMETHOD.

  METHOD get_txt_rechtl_rahmenbed.
    result = SWITCH #( i_enum
                       WHEN rechtl_rahmenbedingungen-keine     THEN 'Keine'
                       WHEN rechtl_rahmenbedingungen-undefined THEN '#undef'
                       WHEN rechtl_rahmenbedingungen-unklar    THEN 'Unklar'
                       WHEN rechtl_rahmenbedingungen-vorhanden THEN 'Vorhanden' ).
  ENDMETHOD.

  METHOD get_txt_ressourcen_abh.
    result = SWITCH #( i_enum
                       WHEN ressourcen_abhaengigkeit-int1     THEN 'mindestens 1 Interner, 0 Externe'
                       WHEN ressourcen_abhaengigkeit-int2plus THEN 'Mehr als 2 Interne, 0 Externe'
                       WHEN ressourcen_abhaengigkeit-ext1plus THEN 'Mindestens 1 Externer, Anzahl Interne irrelevant' ).
  ENDMETHOD.

  METHOD get_txt_risikoanalyse.
    result = SWITCH #( i_enum
                       WHEN risikoanalyse-undefined       THEN '#undef'
                       WHEN risikoanalyse-empfohlen       THEN 'Risikoanalyse wird empfohlen'
                       WHEN risikoanalyse-notwendig       THEN 'Risikoanalyse ist notwendig'
                       WHEN risikoanalyse-nicht_notwendig THEN 'Risikoanalyse ist nicht notwendig' ).
  ENDMETHOD.

  METHOD get_enum_val_projektumfang.
    result = COND #(
      WHEN i_input <= 15             THEN projektumfang-klein
      WHEN i_input BETWEEN 16 AND 60 THEN projektumfang-mittel
      ELSE                                projektumfang-gross ).
  ENDMETHOD.
ENDCLASS.

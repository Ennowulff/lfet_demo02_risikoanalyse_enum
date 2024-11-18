"! <p class="shorttext synchronized" lang="en">LFET Demo02: Rules Engine  Risikoanalyse</p>
"! Diese Klasse wurde generiert und darf nicht verändert werden. Alle Methoden und Werte wurden
"! in der zugehörigen Entscheidungstabelle {XYZ} am dd.mm.yyyy von {USERNAME} definiert und generiert.
CLASS zcl_lfet02_enum_rule_risikoan DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.


    CLASS-METHODS execute
      IMPORTING i_model TYPE REF TO zif_lfet02_enum_risikoanalyse.

    CLASS-METHODS get_Text
      IMPORTING i_enum        TYPE any
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_enum_val_projektumfang
      IMPORTING i_input       TYPE i
      RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang.

  PRIVATE SECTION.
    CLASS-METHODS get_txt_rechtl_rahmenbed
      IMPORTING i_enum        TYPE zif_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_txt_ressourcen_abh
      IMPORTING i_enum        TYPE zif_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_txt_projektumfang
      IMPORTING i_enum        TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang
      RETURNING VALUE(result) TYPE string.

    CLASS-METHODS get_txt_risikoanalyse
      IMPORTING i_enum        TYPE zif_lfet02_enum_risikoanalyse=>enum_risikoanalyse
      RETURNING VALUE(result) TYPE string.
ENDCLASS.


CLASS zcl_lfet02_enum_rule_risikoan IMPLEMENTATION.
  METHOD execute.
    " Prolog Standard <----

    i_model->trace->inittrace( name            = 'Risikoanalyse'
                               number_of_rules = '25'
                               version         = '20220613.181835' ).

    IF i_model->is_rechtl_rahmenbedingungen( ) = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine.
      IF i_model->is_ressourcen_abhaengigkeit( ) = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1.
        " Rule R01 ---->
        i_model->trace->dotrace( '1' ).
        i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig ).
        " Rule R01 <----
      ELSEIF i_model->is_ressourcen_abhaengigkeit( ) = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus.
        IF i_model->is_projektumfang( ) = zif_lfet02_enum_risikoanalyse=>projektumfang-klein.
          " Rule R02 ---->
          i_model->trace->dotrace( '2' ).
          i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig ).
        ELSEIF i_model->is_projektumfang( ) = zif_lfet02_enum_risikoanalyse=>projektumfang-mittel.
          " Rule R03 ---->
          i_model->trace->dotrace( '3' ).
          i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen ).
        ELSE.
          " Rule R04 ---->
          i_model->Trace->dotrace( '4' ).
          i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen ).
        ENDIF.
      ELSE.
        " Rule R05 ---->
        i_model->trace->dotrace( '5' ).
        i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen ).

      ENDIF.
    ELSEIF i_model->is_rechtl_rahmenbedingungen( ) = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-unklar.
      " Rule R06 ---->
      i_model->trace->dotrace( '6' ).
      i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen ).
    ELSE.
      " Rule R07 ---->
      i_model->trace->dotrace( '7' ).
      i_model->do_risikoanalyse( zif_lfet02_enum_risikoanalyse=>risikoanalyse-notwendig ).
    ENDIF.
  ENDMETHOD.

  METHOD get_text.
    CONSTANTS c_enum_projektumfang          TYPE string VALUE 'ENUM_PROJEKTUMFANG' ##NO_TEXT.
    CONSTANTS c_enum_rechtl_rahmenbedingung TYPE string VALUE 'ENUM_RECHTL_RAHMENBEDINGUNGEN' ##NO_TEXT.
    CONSTANTS c_enum_ressourcen_abhaengigkt TYPE string VALUE 'ENUM_RESSOURCEN_ABHAENGIGKEIT' ##NO_TEXT.
    CONSTANTS c_enum_risikoanalyse          TYPE string VALUE 'ENUM_RISIKOANALYSE' ##NO_TEXT.

    DATA(enum_type) = cl_abap_typedescr=>describe_by_data( i_enum ).
    IF enum_Type IS NOT INSTANCE OF cl_abap_enumdescr.
      RAISE EXCEPTION NEW /rbgrp/cx_enum_wrong_type( ).
    ENDIF.

    DATA(enum_name) = enum_type->get_relative_name( ).

    result = SWITCH #( enum_name
                       WHEN c_enum_projektumfang          THEN get_txt_projektumfang( i_enum )
                       WHEN c_enum_rechtl_rahmenbedingung THEN get_txt_rechtl_rahmenbed( i_enum )
                       WHEN c_enum_ressourcen_abhaengigkt THEN get_txt_ressourcen_abh( i_enum )
                       WHEN c_enum_risikoanalyse          THEN get_txt_risikoanalyse( i_enum )
                       ELSE                                    THROW /rbgrp/cx_enum_wrong_value( ) ).
  ENDMETHOD.

  METHOD get_txt_projektumfang.
    result = SWITCH #( i_enum
                       WHEN zif_lfet02_enum_risikoanalyse=>projektumfang-klein  THEN 'Klein: <=15'
                       WHEN zif_lfet02_enum_risikoanalyse=>projektumfang-mittel THEN 'Mittel: 16-60'
                       WHEN zif_lfet02_enum_risikoanalyse=>projektumfang-gross  THEN 'Groß: >60' ).
  ENDMETHOD.

  METHOD get_txt_rechtl_rahmenbed.
    result = SWITCH #( i_enum
                       WHEN zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine     THEN 'Keine'
                       WHEN zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-unklar    THEN 'Unklar'
                       WHEN zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-vorhanden THEN 'Vorhanden' ).
  ENDMETHOD.

  METHOD get_txt_ressourcen_abh.
    result = SWITCH #( i_enum
                       WHEN zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1 THEN
                         'mindestens 1 Interner, 0 Externe'
                       WHEN zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus THEN
                         'Mehr als 2 Interne, 0 Externe'
                       WHEN zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-ext1plus THEN
                         'Mindestens 1 Externer, Anzahl Interne irrelevant' ).
  ENDMETHOD.

  METHOD get_txt_risikoanalyse.
    result = SWITCH #( i_enum
                       WHEN zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen THEN
                         'Risikoanalyse wird empfohlen'
                       WHEN zif_lfet02_enum_risikoanalyse=>risikoanalyse-notwendig THEN
                         'Risikoanalyse ist notwendig'
                       WHEN zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig THEN
                         'Risikoanalyse ist nicht notwendig' ).
  ENDMETHOD.

  METHOD get_enum_val_projektumfang.
    result = COND #(
      WHEN i_input <= 15             THEN zif_lfet02_enum_risikoanalyse=>projektumfang-klein
      WHEN i_input BETWEEN 16 AND 60 THEN zif_lfet02_enum_risikoanalyse=>projektumfang-mittel
      ELSE                                zif_lfet02_enum_risikoanalyse=>projektumfang-gross ).
  ENDMETHOD.
ENDCLASS.

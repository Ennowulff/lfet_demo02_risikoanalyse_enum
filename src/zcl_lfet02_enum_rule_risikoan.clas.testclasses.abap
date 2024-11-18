CLASS ltcl_simple DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    "Die Logik zur Entscheidungstabelle
    DATA model TYPE REF TO zcl_lfet02_enum_modl_risikoana.

    "constants
    CONSTANTS c_rule_1 TYPE string VALUE `1`.
    CONSTANTS c_rule_2 TYPE string VALUE `2`.
    CONSTANTS c_rule_3 TYPE string VALUE `3`.
    CONSTANTS c_rule_4 TYPE string VALUE `4`.
    CONSTANTS c_rule_5 TYPE string VALUE `5`.
    CONSTANTS c_rule_6 TYPE string VALUE `6`.
    CONSTANTS c_rule_7 TYPE string VALUE `7`.

    METHODS setup.
    METHODS test_et
      IMPORTING
        b01  TYPE zif_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen
        b02  TYPE zif_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit
        b03  TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang
        a01  TYPE zif_lfet02_enum_risikoanalyse=>enum_risikoanalyse
        rule TYPE string.

    METHODS r01 FOR TESTING.
    METHODS r02 FOR TESTING.
    METHODS r03 FOR TESTING.
    METHODS r04 FOR TESTING.
    METHODS r05 FOR TESTING.
    METHODS r06 FOR TESTING.
    METHODS r07 FOR TESTING.
ENDCLASS.

CLASS ltcl_simple IMPLEMENTATION.

  METHOD r01.
    test_et(
      b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine
      b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1
      b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-mittel
      a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig
      rule = c_rule_1 ).
  ENDMETHOD.

  METHOD r02.
    test_et(
      b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine
      b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus
      b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-klein
      a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig
      rule = c_rule_2 ).
  ENDMETHOD.

  METHOD r03.
    test_et(
      b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine
      b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus
      b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-mittel
      a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen
      rule = c_rule_3 ).
  ENDMETHOD.

  METHOD r04.
    test_et(
    b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine
    b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int2plus
    b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-gross
    a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen
    rule = c_rule_4 ).
  ENDMETHOD.

  METHOD r05.
    test_et(
      b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine
      b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-ext1plus
      b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-mittel
      a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen
      rule = c_rule_5 ).
  ENDMETHOD.

  METHOD r06.
    test_et(
      b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-unklar
      b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1
      b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-mittel
      a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-empfohlen
      rule = c_rule_6 ).
  ENDMETHOD.

  METHOD r07.
    test_et(
      b01  = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-vorhanden
      b02  = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1
      b03  = zif_lfet02_enum_risikoanalyse=>projektumfang-klein
      a01  = zif_lfet02_enum_risikoanalyse=>risikoanalyse-notwendig
      rule = c_rule_7 ).
  ENDMETHOD.

  METHOD setup.

    "Entscheidungstabellenobjekt erzeugen
    model = NEW zcl_lfet02_enum_modl_risikoana( ).
  ENDMETHOD.

  METHOD test_et.

    "Setzen der Bedingungswerte
    model->zif_lfet02_enum_risikoanalyse~set_rechtl_rahmenbedingungen( b01 ).
    model->zif_lfet02_enum_risikoanalyse~set_ressourcen_abhaengigkeit( b02 ).
    model->zif_lfet02_enum_risikoanalyse~set_projektumfang( b03 ).

    "Risikoermittlung durchführen
    zcl_lfet02_enum_rule_risikoan=>execute( model ).

    "Ernmittlung des Ergebnisses für die Aktion A01
    cl_abap_unit_assert=>assert_equals(
        act = model->zif_lfet02_enum_risikoanalyse~get_risikoanalyse( )
        exp = a01 ).
    "Ermittlung der verwendeten Regel
    cl_abap_unit_assert=>assert_equals(
        act = model->trace->get_trace(  )-used_rule
        exp = rule  ).

  ENDMETHOD.

ENDCLASS.

CLASS lcl_cust_risikoanalyse DEFINITION INHERITING FROM zcl_lfet02_enum_modl_risikoana.
  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS cust_is_projektumfang REDEFINITION.
    METHODS cust_is_rechtl_rahmenbeding REDEFINITION.
    METHODS cust_is_ressourcen_abhaeng REDEFINITION.
ENDCLASS.


CLASS lcl_cust_risikoanalyse IMPLEMENTATION.
  METHOD cust_is_projektumfang.
    result = zif_lfet02_enum_risikoanalyse=>projektumfang-mittel.
  ENDMETHOD.

  METHOD cust_is_rechtl_rahmenbeding.
    result = zif_lfet02_enum_risikoanalyse=>rechtl_rahmenbedingungen-keine.
  ENDMETHOD.

  METHOD cust_is_ressourcen_abhaeng.
    result = zif_lfet02_enum_risikoanalyse=>ressourcen_abhaengigkeit-int1.
  ENDMETHOD.
ENDCLASS.


CLASS ltcl_cust DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    " constants
    CONSTANTS c_rule_1 TYPE string VALUE `1`.

    METHODS r01 FOR TESTING.
ENDCLASS.


CLASS ltcl_cust IMPLEMENTATION.
  METHOD r01.
    " Die Logik zur Entscheidungstabelle
    DATA model TYPE REF TO lcl_cust_risikoanalyse.

    model = NEW #( ).

    " Risikoermittlung durchführen
    zcl_lfet02_enum_rule_risikoan=>execute( model ).

    " Ernmittlung des Ergebnisses für die Aktion A01
    cl_abap_unit_assert=>assert_equals( exp = zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig
                                        act = model->zif_lfet02_enum_risikoanalyse~get_risikoanalyse( ) ).
    " Ermittlung der verwendeten Regel
    cl_abap_unit_assert=>assert_equals( exp = c_rule_1
                                        act = model->trace->get_trace( )-used_rule  ).
  ENDMETHOD.
ENDCLASS.

CLASS ltcl_texts DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    "! make sure that a text is returned for a valid enum value
    METHODS texts FOR TESTING.
    "! make sure that an exception is raised if an enum is used that is not supported by this project
    METHODS wrong_enum FOR TESTING.
ENDCLASS.

CLASS ltcl_texts IMPLEMENTATION.

  METHOD texts.
    cl_abap_unit_assert=>assert_equals(
      exp = 'Risikoanalyse ist nicht notwendig'
      act = zcl_lfet02_enum_rule_risikoan=>get_text(  zif_lfet02_enum_risikoanalyse=>risikoanalyse-nicht_notwendig ) ).
  ENDMETHOD.

  METHOD wrong_enum.
    TYPES: BEGIN OF ENUM wrong_enum,
             enum_fake,
           END OF ENUM wrong_Enum.

    TRY.
        DATA(text) =  zcl_lfet02_enum_rule_risikoan=>get_text( enum_fake ).
        cl_abap_unit_assert=>fail(  ).
      CATCH /rbgrp/cx_enum_wrong_type INTO DATA(error).
        cl_abap_unit_assert=>assert_bound( error ).
    ENDTRY.


  ENDMETHOD.

ENDCLASS.

"! <p class="shorttext synchronized" lang="en">LFET Demo02: Model Implementation Risikoanalyse</p>
"! Diese Model-Klasse dient der Verwendung in ZCL_LFET02_ENUM_RULE_RISIKOAN
"! Diese Klasse kann von außen mit den entsprechenden Werten gefüllt werden.
"! Sollen die Werte erst dann erzeugt werden, wenn sie in der Entscheidungstabelle tatsächlich benötigt werden,
"! dann muss diese Klasse in einer kundeneigenen Klasse abgeleitet werden. Hierbei müssen die Methoden CUST_IS_*
"! redefiniert und mit entsprechendem Coding gefüllt werden.
CLASS zcl_lfet02_enum_modl_risikoana DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_lfet02_enum_risikoanalyse.

    ALIASES trace FOR zif_lfet02_enum_risikoanalyse~trace.

    METHODS constructor.

  PROTECTED SECTION.

    "! <p class="shorttext synchronized" lang="en">Bedingungswerte</p>
    DATA values TYPE zif_lfet02_enum_risikoanalyse=>_values.
    "! <p class="shorttext synchronized" lang="en">Aktueller ermittelter Aktionswert</p>
    DATA state  TYPE zif_lfet02_enum_risikoanalyse=>_state.

    "! <p class="shorttext synchronized" lang="en">Kundencoding für IS_RECHTL_RAHMENBEDING</p>
    "! Diese Methode wird aufgerufen, wenn der Wert "Rechtliche Rahmenbedingunen" (noch) nicht definiert ist.
    "! Wenn Sie den Wert im Vorfel kennen, dann kann der Wert mit SET_RECHTL_RAHMENBEDINGUNGEN gesetzt werden.
    "! Wenn der Wert noch nicht bekannt ist und erst ermittelt werden soll, wenn er wirklich benötigt wird,
    "! dann erzeugen Sie eine Ableitung von dieser Klasse, redefinieren Sie diese Methode und implementieren
    "! Sie das notwendige Coding.
    "! @parameter result | <p class="shorttext synchronized" lang="en">Ergebniswert</p>
    METHODS cust_is_rechtl_rahmenbeding
      RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_rechtl_rahmenbedingungen.

    "! <p class="shorttext synchronized" lang="en">Kundencoding für IS_RESSOURCEN_ABHAENGIGKEIT</p>
    "! Diese Methode wird aufgerufen, wenn der Wert "Ressourcenabhängigkeit" (noch) nicht definiert ist.
    "! Wenn Sie den Wert im Vorfel kennen, dann kann der Wert mit SET_RECHTL_RAHMENBEDINGUNGEN gesetzt werden.
    "! Wenn der Wert noch nicht bekannt ist und erst ermittelt werden soll, wenn er wirklich benötigt wird,
    "! dann erzeugen Sie eine Ableitung von dieser Klasse, redefinieren Sie diese Methode und implementieren
    "! Sie das notwendige Coding.
    "! @parameter result | <p class="shorttext synchronized" lang="en">Ergebniswert</p>
    METHODS cust_is_ressourcen_abhaeng
      RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_ressourcen_abhaengigkeit.

    "! <p class="shorttext synchronized" lang="en">Kundencoding für IS_PROJEKTUMFANG</p>
    "! Diese Methode wird aufgerufen, wenn der Wert "Projektumfang" (noch) nicht definiert ist.
    "! Wenn Sie den Wert im Vorfel kennen, dann kann der Wert mit SET_RECHTL_RAHMENBEDINGUNGEN gesetzt werden.
    "! Wenn der Wert noch nicht bekannt ist und erst ermittelt werden soll, wenn er wirklich benötigt wird,
    "! dann erzeugen Sie eine Ableitung von dieser Klasse, redefinieren Sie diese Methode und implementieren
    "! Sie das notwendige Coding.
    "! @parameter result | <p class="shorttext synchronized" lang="en">Ergebniswert</p>
    METHODS cust_is_projektumfang
      RETURNING VALUE(result) TYPE zif_lfet02_enum_risikoanalyse=>enum_projektumfang .

  PRIVATE SECTION.
    "! <p class="shorttext synchronized" lang="en">Raise Exception if given value is initial</p>
    "! Bedingungswerte dürfen nicht initial sein. Wenn ein Bedingungswert weder im Vorfeld noch durch eine
    "! Kundenimplementierung ermittelt wurde, dann liegt ein Programmierfehler vor, der vom Entwicklungsteam
    "! behoben werden muss
    "! @parameter i_value | <p class="shorttext synchronized" lang="en">any ENUM value</p>
    METHODS raise_if_initial
      IMPORTING
        i_value TYPE any.

ENDCLASS.


CLASS zcl_lfet02_enum_modl_risikoana IMPLEMENTATION.
  METHOD constructor.
    trace = NEW /rbgrp/cl_trace( ).
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_projektumfang.
    IF values-projektumfang IS INITIAL.
      values-projektumfang = cust_is_projektumfang( ).
    ENDIF.
    raise_if_initial( values-projektumfang ).
    result = values-projektumfang.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_rechtl_rahmenbedingungen.
    IF values-rechtl_rahmenbedingung IS INITIAL.
      values-rechtl_rahmenbedingung = cust_is_rechtl_rahmenbeding( ).
    ENDIF.
    raise_if_initial( values-rechtl_rahmenbedingung ).
    result = values-rechtl_rahmenbedingung.
  ENDMETHOD.

  METHOD zif_lfet02_enum_risikoanalyse~is_ressourcen_abhaengigkeit.
    IF values-ressourcen_abhaengigkeit IS INITIAL.
      values-ressourcen_abhaengigkeit = cust_is_ressourcen_abhaeng( ).
    ENDIF.
    raise_if_initial( values-ressourcen_abhaengigkeit ).
    result = values-ressourcen_abhaengigkeit.
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

  METHOD cust_is_projektumfang.
    RAISE EXCEPTION TYPE /rbgrp/cx_redefine.
  ENDMETHOD.

  METHOD cust_is_rechtl_rahmenbeding.
    RAISE EXCEPTION TYPE /rbgrp/cx_redefine.
  ENDMETHOD.

  METHOD cust_is_ressourcen_abhaeng.
    RAISE EXCEPTION TYPE /rbgrp/cx_redefine.
  ENDMETHOD.


  METHOD raise_if_initial.
    IF i_value IS INITIAL.
      RAISE EXCEPTION TYPE /rbgrp/cx_initial_value.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

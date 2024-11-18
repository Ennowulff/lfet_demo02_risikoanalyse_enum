REPORT zzlfet02_demo01_enum.

DATA default_rechtl_rahmenbed TYPE zcl_lfet02_enum_rule_risikoan=>enum_rechtl_rahmenbedingungen VALUE zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-vorhanden.
DATA default_ressourcen_abh   TYPE zcl_lfet02_enum_rule_risikoan=>enum_ressourcen_abhaengigkeit VALUE zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-int1.
DATA default_projektumfang    TYPE zcl_lfet02_enum_rule_risikoan=>enum_projektumfang            VALUE zcl_lfet02_enum_rule_risikoan=>projektumfang-klein.

" GUI zur Eingabe der Bedingungswerte
PARAMETERS p_legal TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_rechtl_rahmenbed.
PARAMETERS p_rssrc TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_ressourcen_abh.
PARAMETERS p_psize TYPE char20 AS LISTBOX LOWER CASE VISIBLE LENGTH 50 DEFAULT default_projektumfang.

" GUI zur Anzeige des ermittelten Aktionsergebnisses und der verwendeten Regel
PARAMETERS p_result TYPE char20 LOWER CASE MODIF ID dsp.
PARAMETERS p_restxt TYPE char40 LOWER CASE MODIF ID dsp.
PARAMETERS p_rule   TYPE char20 LOWER CASE MODIF ID dsp.

" Das Model zur Entscheidungstabelle
DATA model TYPE REF TO zif_lfet02_enum_risikoanalyse.

INITIALIZATION.
  " Model-Objekt  erzeugen
  model = NEW zcl_lfet02_enum_risikoanalyse( ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_LEGAL'
      values = VALUE vrm_values(
          ( key  = zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-vorhanden
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-vorhanden ) )
          ( key  = zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-unklar
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-unklar ) )
          ( key  = zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-keine
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen-keine ) )  ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_RSSRC'
      values = VALUE vrm_values(
          ( key  = zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-int1
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-int1 ) )
          ( key  = zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-int2plus
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-int2plus ) )
          ( key  = zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-ext1plus
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit-ext1plus ) ) ).

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_PSIZE'
      values = VALUE vrm_values(
          ( key  = zcl_lfet02_enum_rule_risikoan=>projektumfang-klein
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>projektumfang-klein ) )
          ( key  = zcl_lfet02_enum_rule_risikoan=>projektumfang-mittel
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>projektumfang-mittel ) )
          ( key  = zcl_lfet02_enum_rule_risikoan=>projektumfang-gross
            text = zcl_lfet02_enum_rule_risikoan=>get_text( zcl_lfet02_enum_rule_risikoan=>projektumfang-gross ) ) ).


AT SELECTION-SCREEN OUTPUT.
  " GUI: Ergebnisfelder auf "nicht eingabebereit" setzen
  LOOP AT SCREEN.
    IF screen-group1 = 'DSP'.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  " Aktion bei "ENTER"

AT SELECTION-SCREEN.
  TRY.
      " Setzen der Bedingungswerte
      ASSIGN COMPONENT p_legal OF STRUCTURE zcl_lfet02_enum_rule_risikoan=>rechtl_rahmenbedingungen TO FIELD-SYMBOL(<legal>).
      model->set_rechtl_rahmenbedingungen( <legal> ).
      ASSIGN COMPONENT p_rssrc OF STRUCTURE zcl_lfet02_enum_rule_risikoan=>ressourcen_abhaengigkeit TO FIELD-SYMBOL(<rssrc>).
      model->set_ressourcen_abhaengigkeit( <rssrc> ).
      ASSIGN COMPONENT p_psize OF STRUCTURE zcl_lfet02_enum_rule_risikoan=>projektumfang TO FIELD-SYMBOL(<psize>).
      model->set_projektumfang( <psize> ).

      " Risikoermittlung durchführen
      zcl_lfet02_enum_rule_risikoan=>execute( model ).

      " Ernmittlung des Ergebnisses
      p_result = model->get_risikoanalyse( ).
      p_restxt = zcl_lfet02_enum_rule_risikoan=>get_text( model->get_risikoanalyse( ) ).
      p_rule   = model->trace->get_trace( )-used_rule.
    CATCH zcx_lfet02_enum_wrong_value.
  ENDTRY.

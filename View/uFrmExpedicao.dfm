inherited FrmExpedicao: TFrmExpedicao
  Caption = 'FrmExpedicao'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        ColCount = 4
        ColumnHeaders.Strings = (
          'Pedido Id'
          'Volume Id'
          'Embalagem'
          'Processo')
        ColWidths = (
          74
          118
          74
          74)
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited ShCadastro: TShape
        Left = 537
        Top = 16
        Visible = False
        ExplicitLeft = 537
        ExplicitTop = 16
      end
      object Label2: TLabel [1]
        Left = 25
        Top = 28
        Width = 59
        Height = 21
        CustomHint = BalloonHint1
        Caption = 'Volume'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      inherited ChkCadastro: TCheckBox
        Left = 484
        Top = 20
        Visible = False
        ExplicitLeft = 484
        ExplicitTop = 20
      end
      object LstASGExpedicao: TAdvStringGrid
        Left = 581
        Top = 0
        Width = 576
        Height = 524
        Cursor = crDefault
        CustomHint = BalloonHint1
        TabStop = False
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 4
        DefaultColWidth = 74
        DefaultRowHeight = 25
        DrawingStyle = gdsClassic
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 2
        ActiveRowColor = 15135200
        HoverRowColor = 15658717
        HoverRowCells = [hcNormal, hcSelected]
        OnRowChanging = LstCadastroRowChanging
        OnDblClickCell = LstCadastroDblClickCell
        OnGetEditorType = LstCadastroGetEditorType
        OnGetEditorProp = LstCadastroGetEditorProp
        HintColor = 5080903
        ActiveCellShow = True
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = []
        ActiveCellColor = 5080903
        Bands.Active = True
        Bands.PrimaryColor = 15523534
        BackGround.ColorTo = 15663069
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          'Pedido Id'
          'Volume Id'
          'Embalagem'
          'Processo')
        ControlLook.FixedGradientHoverFrom = 13619409
        ControlLook.FixedGradientHoverTo = 12502728
        ControlLook.FixedGradientHoverMirrorFrom = 12502728
        ControlLook.FixedGradientHoverMirrorTo = 11254975
        ControlLook.FixedGradientDownFrom = 8816520
        ControlLook.FixedGradientDownTo = 7568510
        ControlLook.FixedGradientDownMirrorFrom = 7568510
        ControlLook.FixedGradientDownMirrorTo = 6452086
        ControlLook.FixedGradientDownBorder = 14007466
        ControlLook.ControlStyle = csClassic
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 74
        FixedRowHeight = 25
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        FloatFormat = '%.2f'
        GridImages = ImgListSimNao
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glListView
        Lookup = True
        MouseActions.DirectEdit = True
        Multilinecells = True
        Navigation.AdvanceOnEnter = True
        Navigation.AdvanceInsert = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PageNumSep = '/'
        ProgressAppearance.Level1ColorTo = clMaroon
        ScrollWidth = 16
        SearchFooter.Color = clBtnFace
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SearchFooter.ResultFormat = '(%d of %d)'
        SelectionColor = clHighlight
        SelectionTextColor = clHighlightText
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.HeaderColorTo = 16579058
        SortSettings.HeaderMirrorColor = 16380385
        SortSettings.HeaderMirrorColorTo = 16182488
        Version = '8.4.2.2'
        WordWrap = False
        ColWidths = (
          74
          118
          74
          74)
        RowHeights = (
          24
          25)
      end
      object EdtVolumeId: TJvCalcEdit
        Left = 93
        Top = 25
        Width = 121
        Height = 29
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ShowButton = False
        TabOrder = 3
        DecimalPlacesAlwaysShown = False
        OnEnter = EdtVolumeIdEnter
        OnExit = EdtVolumeIdExit
        OnKeyUp = EdtVolumeIdKeyUp
      end
      object Panel1: TPanel
        Left = 25
        Top = 73
        Width = 533
        Height = 398
        CustomHint = BalloonHint1
        Enabled = False
        ParentBackground = False
        ParentColor = True
        TabOrder = 4
        object Label3: TLabel
          Left = 23
          Top = 32
          Width = 47
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 391
          Top = 32
          Width = 32
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 23
          Top = 107
          Width = 84
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Destinat'#225'rio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 23
          Top = 184
          Width = 32
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Rota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 163
          Top = 267
          Width = 202
          Height = 30
          CustomHint = BalloonHint1
          Caption = 'Ordem Carregamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object LblOrdem: TLabel
          Left = 187
          Top = 307
          Width = 147
          Height = 65
          CustomHint = BalloonHint1
          Alignment = taCenter
          AutoSize = False
          Caption = 'Ordem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 1
          Top = 1
          Width = 531
          Height = 21
          CustomHint = BalloonHint1
          Align = alTop
          Alignment = taCenter
          Caption = #218'ltimo Volume Expedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1993170
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 171
        end
        object EdtPedidoId: TEdit
          Left = 23
          Top = 55
          Width = 121
          Height = 29
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object EdtDocumentoData: TEdit
          Left = 391
          Top = 55
          Width = 121
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object EdtDestino: TEdit
          Left = 23
          Top = 130
          Width = 490
          Height = 33
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object EdtRota: TEdit
          Left = 23
          Top = 207
          Width = 490
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnIncluir: TsImage
        Left = 141
        Visible = False
        ExplicitLeft = 141
      end
      inherited BtnExcluir: TsImage
        Left = 232
        Visible = False
        ExplicitLeft = 232
      end
      inherited BtnFechar: TsImage
        Left = 73
        ExplicitLeft = 73
      end
      inherited BtnSalvar: TsImage
        Left = 323
        Visible = False
        ExplicitLeft = 323
      end
      inherited BtnCancelar: TsImage
        Left = 278
        Visible = False
        ExplicitLeft = 278
      end
      inherited BtnEditar: TsImage
        Left = 188
        Visible = False
        ExplicitLeft = 188
      end
      inherited BtnPesquisarStand: TsImage
        Left = 369
        Visible = False
        ExplicitLeft = 369
      end
      inherited BtnImprimirStand: TsImage
        Left = 414
        Visible = False
        ExplicitLeft = 414
      end
      inherited BtnExportarStand: TsImage
        Left = 460
        Visible = False
        ExplicitLeft = 460
      end
      inherited BtnExportarPDF: TsImage
        Left = 505
        Visible = False
        ExplicitLeft = 505
      end
      inherited BtnImportarStand: TsImage
        Left = 551
        Visible = False
        ExplicitLeft = 551
      end
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 564
    Top = 104
    ExplicitLeft = 564
    ExplicitTop = 104
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited TmFrameWeb: TTimer
    Left = 298
    Top = 98
  end
end

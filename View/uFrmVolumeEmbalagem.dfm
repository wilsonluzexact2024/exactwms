inherited FrmVolumeEmbalagem: TFrmVolumeEmbalagem
  Caption = 'FrmVolumeEmbalagem'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        ColCount = 8
        ColumnHeaders.Strings = (
          'Id'
          'Descri'#231#227'o'
          'Tipo'
          'Identifica'#231#227'o'
          'Volume(Cm3)'
          'Tara(kg)'
          'Capacidade(kg)'
          'Ativo')
        ColWidths = (
          74
          118
          74
          74
          74
          74
          74
          74)
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Id'
            'Descri'#231#227'o')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      object Label2: TLabel [0]
        Left = 334
        Top = 27
        Width = 26
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tipo'
      end
      object Label3: TLabel [1]
        Left = 25
        Top = 220
        Width = 91
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Capacidade(kg)'
      end
      object Label5: TLabel [2]
        Left = 201
        Top = 220
        Width = 62
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Qtd.Lacres'
      end
      object Label6: TLabel [3]
        Left = 353
        Top = 220
        Width = 70
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Pre'#231'o Custo'
      end
      object Shape2: TShape [4]
        Left = 24
        Top = 258
        Width = 183
        Height = 132
        CustomHint = BalloonHint1
        Brush.Color = clBtnFace
        Pen.Color = clWhite
      end
      inherited ShCadastro: TShape
        Left = 90
        Top = 349
        ExplicitLeft = 90
        ExplicitTop = 349
      end
      object EdtQtdLacres: TJvCalcEdit [6]
        Left = 271
        Top = 217
        Width = 54
        Height = 25
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ShowButton = False
        TabOrder = 6
        DecimalPlacesAlwaysShown = False
      end
      object GroupBox2: TGroupBox [7]
        Left = 24
        Top = 125
        Width = 1015
        Height = 61
        CustomHint = BalloonHint1
        Caption = ' [ Cubagem ] '
        TabOrder = 4
        object Label4: TLabel
          Left = 50
          Top = 26
          Width = 41
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Tara(g)'
        end
        object Label9: TLabel
          Left = 183
          Top = 26
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Altura(cm)'
        end
        object Label10: TLabel
          Left = 328
          Top = 27
          Width = 70
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Largura(cm)'
        end
        object Label11: TLabel
          Left = 483
          Top = 28
          Width = 105
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Comprimento(cm)'
        end
        object Label12: TLabel
          Left = 673
          Top = 29
          Width = 75
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Volume(cm3)'
        end
        object Label7: TLabel
          Left = 849
          Top = 27
          Width = 112
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Aproveitamento(%)'
        end
        object EdtPeso: TJvCalcEdit
          Left = 99
          Top = 22
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
        end
        object EdtAltura: TJvCalcEdit
          Left = 250
          Top = 22
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = False
          OnChange = EdtAlturaChange
        end
        object EdtLargura: TJvCalcEdit
          Left = 403
          Top = 23
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          OnChange = EdtAlturaChange
        end
        object EdtComprimento: TJvCalcEdit
          Left = 592
          Top = 24
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
          OnChange = EdtAlturaChange
        end
        object EdtVolume: TJvCalcEdit
          Left = 754
          Top = 24
          Width = 68
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          Enabled = False
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = False
        end
        object EdtAproveitamento: TJvCalcEdit
          Left = 966
          Top = 23
          Width = 40
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 5
          DecimalPlacesAlwaysShown = False
        end
      end
      object ChkDisponivel: TCheckBox [8]
        Left = 37
        Top = 316
        Width = 130
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Dispon'#237'vel'
        TabOrder = 9
      end
      object ChkCodigoBarras: TCheckBox [9]
        Left = 37
        Top = 277
        Width = 130
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'C'#243'digo de Barras'
        TabOrder = 8
      end
      object EdtEmbalagemId: TLabeledEdit [10]
        Left = 84
        Top = 24
        Width = 111
        Height = 24
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 11
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Id'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnChange = EdtEmbalagemIdChange
        OnExit = EdtEmbalagemIdExit
        OnKeyPress = EdtEmbalagemIdKeyPress
      end
      object EdtCapacidade: TJvCalcEdit [11]
        Left = 122
        Top = 217
        Width = 54
        Height = 25
        CustomHint = BalloonHint1
        DecimalPlaces = 3
        DisplayFormat = ',0.###'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ShowButton = False
        TabOrder = 5
        DecimalPlacesAlwaysShown = False
      end
      object EdtPrecoCusto: TJvCalcEdit [12]
        Left = 427
        Top = 217
        Width = 54
        Height = 25
        CustomHint = BalloonHint1
        DecimalPlaces = 3
        DisplayFormat = ',0.###'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ShowButton = False
        TabOrder = 7
        DecimalPlacesAlwaysShown = False
      end
      object btnPesquisar: TBitBtn [13]
        Left = 195
        Top = 24
        Width = 24
        Height = 24
        CustomHint = BalloonHint1
        Glyph.Data = {
          FA090000424DFA09000000000000360000002800000019000000190000000100
          200000000000C409000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000101
          000158A7007359A800E359A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF59A800EC59A8008E4A930007FFFF
          FF0059A8006C59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF60AC0AFF8AC24BFFABD37EFFBCDC97FFBBDB96FFA9D27BFF88C147FF5EAB
          07FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF58A7
          0098FFFFFF0059A800D259A800FF59A800FF59A800FF59A800FF59A800FF66AF
          14FFB8DA91FFF6FAF1FFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFF4F9EEFFB2D789FF63AE0FFF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800F85680000659A800E959A800FF59A800FF59A800FF59A800FF8AC2
          4AFFF2F8EBFFFEFEFEFFFEFEFEFFFEFEFEFFEEF6E4FFD8EBC3FFD9EBC4FFEFF6
          E6FFFEFEFEFFFEFEFEFFFEFEFEFFEEF6E5FF83BE40FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF52A3001659A800E959A800FF59A800FF59A800FF94C7
          5AFFFDFDFBFFFEFEFEFFFBFCF8FFB7D990FF72B526FF59A800FF59A800FF59A8
          00FF59A800FF76B72CFFBCDC98FFFDFDFBFFFEFEFEFFFBFCF8FF8CC34DFF59A8
          00FF59A800FF59A800FF59A800FF52A3001659A800E959A800FF59A800FF7DBB
          36FFFBFDF9FFFEFEFEFFEAF4DFFF78B82FFF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF7DBB37FFEEF6E5FFFEFEFEFFF9FB
          F5FF75B72BFF59A800FF59A800FF59A800FF52A3001659A800E959A800FF5BAA
          03FFE3F0D4FFFEFEFEFFF0F7E7FF6DB31EFF94C75AFFE7F2DAFFB4D88BFF5BAA
          03FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF73B627FFF4F9
          EEFFFEFEFEFFDBECC7FF59A800FF59A800FF59A800FF52A3001659A800E959A8
          00FF93C759FFFEFEFEFFFEFEFEFF8BC24CFF59A800FFDEEECCFFFEFEFEFFFEFE
          FEFFC8E2AAFF5DAA05FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF95C75BFFFEFEFEFFFEFEFEFF8AC24AFF59A800FF59A800FF52A3001659A8
          00E959A800FFD2E7B9FFFEFEFEFFDBECC8FF59A800FF59A800FFA3CF71FFFEFE
          FEFFFEFEFEFFFEFEFEFFCBE4AFFF99C961FFB8DA92FFB2D789FF86C045FF59A8
          00FF59A800FF59A800FFE5F1D6FFFEFEFEFFC7E2A9FF59A800FF59A800FF52A3
          001659A800E95CAA04FFF9FCF6FFFEFEFEFFA2CE6FFF59A800FF59A800FF59A8
          00FFAED582FFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFD3E8BBFF65AE11FF59A800FFABD37EFFFEFEFEFFF2F8EBFF59A800FF59A8
          00FF52A3001659A800E970B423FFFEFEFEFFFEFEFEFF80BC3BFF59A800FF59A8
          00FF59A800FF59A800FFADD480FFFEFEFEFFFEFEFEFFFEFEFDFFE0EFCFFFEAF4
          DFFFFEFEFEFFFEFEFEFFD0E6B7FF59A800FF8AC24BFFFEFEFEFFFEFEFEFF66AF
          14FF59A800FF52A3001659A800E979B931FFFEFEFEFFFEFEFEFF74B629FF59A8
          00FF59A800FF59A800FF59A800FFB2D789FFFEFEFEFFF9FCF7FF80BC3BFF59A8
          00FF59A800FFADD480FFFEFEFEFFFEFEFEFF7FBC3AFF7EBB38FFFEFEFEFFFEFE
          FEFF70B422FF59A800FF52A3001659A800E972B526FFFEFEFEFFFEFEFEFF7DBB
          37FF59A800FF59A800FF59A800FF59A800FFDAECC6FFFEFEFEFFBFDE9DFF59A8
          00FF59A800FF59A800FF5BA902FFF1F7E9FFFEFEFEFFA7D177FF88C147FFFEFE
          FEFFFEFEFEFF68B017FF59A800FF52A3001659A800E95EAB07FFFBFDF9FFFEFE
          FEFF9CCB66FF59A800FF59A800FF59A800FF59A800FFDDEDCBFFFEFEFEFFB9DA
          93FF59A800FF59A800FF59A800FF59A800FFECF5E2FFFEFEFEFFAAD27CFFA6D0
          76FFFEFEFEFFF6FAF1FF59A800FF59A800FF52A3001659A800E959A800FFD8EB
          C3FFFEFEFEFFD3E8BBFF59A800FF59A800FF59A800FF59A800FFBCDC98FFFEFE
          FEFFF2F8EAFF6DB31EFF59A800FF59A800FF93C759FFFEFEFEFFFEFEFEFF89C1
          49FFDDEDCAFFFEFEFEFFCEE5B3FF59A800FF59A800FF52A3001659A800E959A8
          00FF9CCB67FFFEFEFEFFFEFEFDFF7FBC3AFF59A800FF59A800FF59A800FF74B6
          29FFFBFCF8FFFEFEFEFFF4F9EEFFC3E0A3FFCEE5B4FFFDFEFCFFFEFEFEFFE1EF
          D0FF8AC24BFFFEFEFEFFFEFEFEFF93C658FF59A800FF59A800FF52A3001659A8
          00E959A800FF5FAB08FFECF5E1FFFEFEFEFFE6F2D9FF65AE11FF59A800FF59A8
          00FF59A800FF93C658FFFAFCF7FFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFE8F3
          DCFF7EBC38FFECF5E2FFFEFEFEFFE5F1D6FF5BAA03FF59A800FF59A800FF52A3
          001659A800E959A800FF59A800FF89C149FFFEFEFDFFFEFEFEFFDEEECCFF6BB2
          1BFF59A800FF59A800FF59A800FF70B423FFB5D88DFFD4E8BDFFCEE5B4FFA3CF
          71FF75B72AFFE3F0D4FFFEFEFEFFFDFDFBFF80BD3CFF59A800FF59A800FF59A8
          00FF52A3001659A800E959A800FF59A800FF59A800FFA6D076FFFEFEFEFFFEFE
          FEFFF3F8ECFFA2CE70FF63AD0EFF59A800FF59A800FF59A800FF59A800FF65AF
          12FFA7D178FFF6FAF1FFFEFEFEFFFEFEFDFF9CCB67FF59A800FF59A800FF59A8
          00FF59A800FF52A3001659A800E959A800FF59A800FF59A800FF59A800FF9CCB
          67FFFAFCF7FFFEFEFEFFFEFEFEFFFAFCF7FFD9EBC4FFC4E0A4FFC4E0A4FFDAEC
          C6FFFBFCF8FFFEFEFEFFFEFEFEFFF7FBF3FF95C75BFF59A800FF59A800FF59A8
          00FF59A800FF59A800FF52A3001659A800E959A800FF59A800FF59A800FF59A8
          00FF59A800FF73B627FFCCE4B1FFFEFEFDFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFFEFEFEFFFEFEFEFFFDFDFBFFC7E2A9FF6FB421FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF569F001559A800D259A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF6EB31FFF9FCD6BFFC0DE9EFFD0E6
          B7FFD0E6B6FFBEDD9BFF9CCB67FF6AB11AFF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800F75680000658A7006A59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF58A70096FFFFFF000101000159A8
          007159A800E359A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A800FF59A8
          00FF59A800FF59A800FF59A800FF59A800EC58A7008D4A930007FFFFFF00}
        TabOrder = 11
        TabStop = False
      end
      object CbTipo: TComboBox [14]
        Left = 365
        Top = 24
        Width = 176
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Items.Strings = (
          'Retorn'#225'vel'
          'Pr'#243'pria'
          'Pacote'
          'Reutiliz'#225'vel')
      end
      object edtDescricao: TLabeledEdit [15]
        Left = 84
        Top = 76
        Width = 457
        Height = 25
        CustomHint = BalloonHint1
        CharCase = ecUpperCase
        Ctl3D = True
        EditLabel.Width = 57
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        MaxLength = 30
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
      end
      inherited PnlInfo: TPanel
        Left = 301
        Top = 330
        TabOrder = 12
        ExplicitLeft = 301
        ExplicitTop = 330
      end
      inherited ChkCadastro: TCheckBox
        Left = 37
        Top = 353
        TabOrder = 10
        ExplicitLeft = 37
        ExplicitTop = 353
      end
      object EdtIdentificacao: TLabeledEdit
        Left = 672
        Top = 76
        Width = 70
        Height = 25
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 73
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Identifica'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        MaxLength = 5
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
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
      inherited BtnEditar: TsImage
        Left = 122
        ExplicitLeft = 122
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1019
    Top = 40
    ExplicitLeft = 1019
    ExplicitTop = 40
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 365
    Top = 154
    ExplicitLeft = 365
    ExplicitTop = 154
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
end

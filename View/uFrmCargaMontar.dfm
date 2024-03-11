inherited FrmCargaMontar: TFrmCargaMontar
  Caption = 'FrmCargaMontar'
  ClientHeight = 690
  OnDestroy = FormDestroy
  ExplicitHeight = 692
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Height = 635
    ExplicitHeight = 628
    ClientRectBottom = 635
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 604
      inherited LstCadastro: TAdvStringGrid
        Height = 573
        ColCount = 6
        ColumnHeaders.Strings = (
          'Id'
          'Data'
          'Rota'
          'Transportadora'
          'Placa'
          'A'#231#227'o')
        ExplicitHeight = 571
        ColWidths = (
          74
          118
          74
          74
          74
          74)
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 573
        ExplicitHeight = 566
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Data'
            'Id Loja/Cliente'
            'C'#243'digo ERP'
            'Raz'#227'o / Fantasia'
            'Rota Id'
            'Rota')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ParentColor = False
      ExplicitHeight = 604
      inherited ShCadastro: TShape
        Left = 762
        Top = 5
        Visible = False
        ExplicitLeft = 762
        ExplicitTop = 5
      end
      object Label2: TLabel [1]
        Left = 10
        Top = 23
        Width = 50
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Carga Id'
      end
      object LblProcesso: TLabel [2]
        Left = 162
        Top = 22
        Width = 12
        Height = 16
        CustomHint = BalloonHint1
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Label3: TLabel [3]
        Left = 424
        Top = 21
        Width = 42
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Rota Id'
      end
      object LblRota: TLabel [4]
        Left = 558
        Top = 22
        Width = 12
        Height = 16
        CustomHint = BalloonHint1
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel [5]
        Left = 29
        Top = 586
        Width = 53
        Height = 17
        CustomHint = BalloonHint1
        Anchors = [akBottom]
        Caption = 'Pedidos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 584
      end
      object TotPedidos: TLabel [6]
        Left = 90
        Top = 586
        Width = 7
        Height = 17
        CustomHint = BalloonHint1
        Anchors = [akBottom]
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 584
      end
      object Label11: TLabel [7]
        Left = 311
        Top = 586
        Width = 33
        Height = 17
        CustomHint = BalloonHint1
        Anchors = [akBottom]
        Caption = 'Peso:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 584
      end
      object TotPeso: TLabel [8]
        Left = 354
        Top = 586
        Width = 7
        Height = 17
        CustomHint = BalloonHint1
        Anchors = [akBottom]
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 584
      end
      object TotVolume: TLabel [9]
        Left = 628
        Top = 586
        Width = 7
        Height = 17
        CustomHint = BalloonHint1
        Anchors = [akBottom]
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 584
      end
      object Label15: TLabel [10]
        Left = 569
        Top = 586
        Width = 51
        Height = 17
        CustomHint = BalloonHint1
        Anchors = [akBottom]
        Caption = 'Volume:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitTop = 584
      end
      inherited PnlInfo: TPanel
        Left = 622
        Top = 147
        ExplicitLeft = 622
        ExplicitTop = 140
      end
      inherited ChkCadastro: TCheckBox
        Left = 709
        Top = 9
        Visible = False
        ExplicitLeft = 709
        ExplicitTop = 9
      end
      object EdtCargaId: TJvCalcEdit
        Left = 66
        Top = 15
        Width = 62
        Height = 29
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '#'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ShowButton = False
        TabOrder = 2
        DecimalPlacesAlwaysShown = False
        OnChange = EdtCargaIdChange
        OnEnter = EdtCargaIdEnter
        OnExit = EdtCargaIdExit
      end
      object EdtRotaId: TJvCalcEdit
        Left = 472
        Top = 15
        Width = 53
        Height = 29
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '#'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ShowButton = False
        TabOrder = 3
        DecimalPlacesAlwaysShown = False
        OnEnter = EdtCargaIdEnter
        OnExit = EdtRotaIdExit
        OnKeyUp = EdtRotaIdKeyUp
      end
      object GroupBox1: TGroupBox
        Left = 766
        Top = 0
        Width = 370
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Per'#237'odo Montagem - Data Ressuprimentos ]'
        TabOrder = 4
        object Label5: TLabel
          Left = 20
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label6: TLabel
          Left = 198
          Top = 20
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtDtInicioMontagem: TJvDateEdit
          Left = 56
          Top = 20
          Width = 105
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 0
          OnEnter = EdtCargaIdEnter
          OnExit = EdtDtInicioMontagemExit
          OnKeyUp = EdtRotaIdKeyUp
        end
        object EdtDtTerminoMontagem: TJvDateEdit
          Left = 251
          Top = 20
          Width = 105
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 1
          OnEnter = EdtCargaIdEnter
          OnExit = EdtDtInicioMontagemExit
          OnKeyUp = EdtRotaIdKeyUp
        end
      end
      object GroupBox2: TGroupBox
        Left = 10
        Top = 50
        Width = 1126
        Height = 74
        CustomHint = BalloonHint1
        Caption = ' [ Transporte ] '
        TabOrder = 5
        object Label7: TLabel
          Left = 8
          Top = 24
          Width = 106
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Transportadora Id'
        end
        object LblTransportadora: TLabel
          Left = 120
          Top = 53
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 400
          Top = 24
          Width = 56
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Ve'#237'culo Id'
        end
        object LblVeiculo: TLabel
          Left = 465
          Top = 53
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 771
          Top = 24
          Width = 72
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Motorista Id'
        end
        object LblMotorista: TLabel
          Left = 849
          Top = 53
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LblCapacidadeVolume: TLabel
          Left = 585
          Top = 24
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
        end
        object EdtTransportadoraId: TJvCalcEdit
          Left = 120
          Top = 18
          Width = 86
          Height = 29
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '#'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
          OnEnter = EdtTransportadoraIdEnter
          OnExit = EdtTransportadoraIdExit
          OnKeyUp = EdtTransportadoraIdKeyUp
        end
        object EdtMotoristaId: TJvCalcEdit
          Left = 849
          Top = 18
          Width = 86
          Height = 29
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '#'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          OnEnter = EdtTransportadoraIdEnter
          OnExit = EdtMotoristaIdExit
          OnKeyUp = EdtMotoristaIdKeyUp
        end
        object BtnPesqTransp: TBitBtn
          Left = 204
          Top = 18
          Width = 29
          Height = 29
          CustomHint = BalloonHint1
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C006000000000000000000000000000000000000494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524C516347536F4948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524948524948524B5163277FFF277FFF47536F494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
            634948524948524948524948524948524948524948524948524948524948524C
            50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
            277FFF4B51634948524948524948524948524948524948524948524948524948
            524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
            7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
            4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
            73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
            48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
            4948524948524948524C506148536D277FFF4A52684948524948524948524948
            52494852494852494852494852494852494852435475277FFF4C506149485249
            485249485249485249485249485249485249485249485247536E465370494852
            494852494852494852494852494852494852494852494852435476277FFF4554
            724948524948524948524948524948524948524948524948524948524948524C
            5162277FFF435476494852494852494852494852494852494852494852435475
            277FFF4254764948524948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            4852494852435475277FFF277FFF435475494852494852494852494852494852
            494852494852494852494852494852445475277FFF277FFF4454754948524948
            52494852494852494852494852435475277FFF277FFF43547549485249485249
            4852494852494852494852494852494852494852494852494852425478277FFF
            445475494852494852494852494852494852494852435475277FFF4254764948
            5249485249485249485249485249485249485249485249485249485249485244
            5475277FFF277FFF445475494852494852494852494852494852494852494852
            435476277FFF4C50614948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            48524948524948524C5162277FFF455473494852494852494852494852494852
            494852494852494852494852494852455472277FFF4354764948524948524948
            52494852494852494852494852494852494852435475277FFF4C516249485249
            48524948524948524948524948524948524948524C5162277FFF435476494852
            4948524948524948524948524948524948524948524948524948524C5062277F
            FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
            7FFF4B5163494852494852494852494852494852494852494852494852494852
            4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
            6D277FFF277FFF4B516349485249485249485249485249485249485249485249
            48524948524948524948524948524948524948524B5266465370277FFF277FFF
            277FFF277FFF46537049526A4C51624948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524C50624C51634C51634C5062494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852}
          TabOrder = 3
          TabStop = False
          OnClick = BtnPesqTranspClick
        end
        object BtnPesqVeic: TBitBtn
          Left = 550
          Top = 18
          Width = 29
          Height = 29
          CustomHint = BalloonHint1
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C006000000000000000000000000000000000000494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524C516347536F4948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524948524948524B5163277FFF277FFF47536F494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
            634948524948524948524948524948524948524948524948524948524948524C
            50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
            277FFF4B51634948524948524948524948524948524948524948524948524948
            524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
            7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
            4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
            73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
            48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
            4948524948524948524C506148536D277FFF4A52684948524948524948524948
            52494852494852494852494852494852494852435475277FFF4C506149485249
            485249485249485249485249485249485249485249485247536E465370494852
            494852494852494852494852494852494852494852494852435476277FFF4554
            724948524948524948524948524948524948524948524948524948524948524C
            5162277FFF435476494852494852494852494852494852494852494852435475
            277FFF4254764948524948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            4852494852435475277FFF277FFF435475494852494852494852494852494852
            494852494852494852494852494852445475277FFF277FFF4454754948524948
            52494852494852494852494852435475277FFF277FFF43547549485249485249
            4852494852494852494852494852494852494852494852494852425478277FFF
            445475494852494852494852494852494852494852435475277FFF4254764948
            5249485249485249485249485249485249485249485249485249485249485244
            5475277FFF277FFF445475494852494852494852494852494852494852494852
            435476277FFF4C50614948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            48524948524948524C5162277FFF455473494852494852494852494852494852
            494852494852494852494852494852455472277FFF4354764948524948524948
            52494852494852494852494852494852494852435475277FFF4C516249485249
            48524948524948524948524948524948524948524C5162277FFF435476494852
            4948524948524948524948524948524948524948524948524948524C5062277F
            FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
            7FFF4B5163494852494852494852494852494852494852494852494852494852
            4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
            6D277FFF277FFF4B516349485249485249485249485249485249485249485249
            48524948524948524948524948524948524948524B5266465370277FFF277FFF
            277FFF277FFF46537049526A4C51624948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524C50624C51634C51634C5062494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852}
          TabOrder = 4
          TabStop = False
          OnClick = BtnPesqVeicClick
        end
        object BtnPesqMotorista: TBitBtn
          Left = 933
          Top = 18
          Width = 29
          Height = 29
          CustomHint = BalloonHint1
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C006000000000000000000000000000000000000494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524C516347536F4948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524948524948524B5163277FFF277FFF47536F494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
            634948524948524948524948524948524948524948524948524948524948524C
            50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
            277FFF4B51634948524948524948524948524948524948524948524948524948
            524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
            7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
            4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
            73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
            48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
            4948524948524948524C506148536D277FFF4A52684948524948524948524948
            52494852494852494852494852494852494852435475277FFF4C506149485249
            485249485249485249485249485249485249485249485247536E465370494852
            494852494852494852494852494852494852494852494852435476277FFF4554
            724948524948524948524948524948524948524948524948524948524948524C
            5162277FFF435476494852494852494852494852494852494852494852435475
            277FFF4254764948524948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            4852494852435475277FFF277FFF435475494852494852494852494852494852
            494852494852494852494852494852445475277FFF277FFF4454754948524948
            52494852494852494852494852435475277FFF277FFF43547549485249485249
            4852494852494852494852494852494852494852494852494852425478277FFF
            445475494852494852494852494852494852494852435475277FFF4254764948
            5249485249485249485249485249485249485249485249485249485249485244
            5475277FFF277FFF445475494852494852494852494852494852494852494852
            435476277FFF4C50614948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            48524948524948524C5162277FFF455473494852494852494852494852494852
            494852494852494852494852494852455472277FFF4354764948524948524948
            52494852494852494852494852494852494852435475277FFF4C516249485249
            48524948524948524948524948524948524948524C5162277FFF435476494852
            4948524948524948524948524948524948524948524948524948524C5062277F
            FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
            7FFF4B5163494852494852494852494852494852494852494852494852494852
            4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
            6D277FFF277FFF4B516349485249485249485249485249485249485249485249
            48524948524948524948524948524948524948524B5266465370277FFF277FFF
            277FFF277FFF46537049526A4C51624948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524C50624C51634C51634C5062494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852}
          TabOrder = 5
          TabStop = False
          OnClick = BtnPesqMotoristaClick
        end
        object EdtVeiculoId: TEdit
          Left = 462
          Top = 18
          Width = 90
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnEnter = EdtTransportadoraIdEnter
          OnExit = EdtVeiculoIdExit
          OnKeyUp = EdtVeiculoIdKeyUp
        end
      end
      object BtnPesqRota: TBitBtn
        Left = 523
        Top = 16
        Width = 29
        Height = 29
        CustomHint = BalloonHint1
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C006000000000000000000000000000000000000494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524C516347536F4948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          48524948524948524B5163277FFF277FFF47536F494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
          634948524948524948524948524948524948524948524948524948524948524C
          50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
          277FFF4B51634948524948524948524948524948524948524948524948524948
          524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
          7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
          4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
          73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
          48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
          4948524948524948524C506148536D277FFF4A52684948524948524948524948
          52494852494852494852494852494852494852435475277FFF4C506149485249
          485249485249485249485249485249485249485249485247536E465370494852
          494852494852494852494852494852494852494852494852435476277FFF4554
          724948524948524948524948524948524948524948524948524948524948524C
          5162277FFF435476494852494852494852494852494852494852494852435475
          277FFF4254764948524948524948524948524948524948524948524948524948
          52494852494852494852425476277FFF44547549485249485249485249485249
          4852494852435475277FFF277FFF435475494852494852494852494852494852
          494852494852494852494852494852445475277FFF277FFF4454754948524948
          52494852494852494852494852435475277FFF277FFF43547549485249485249
          4852494852494852494852494852494852494852494852494852425478277FFF
          445475494852494852494852494852494852494852435475277FFF4254764948
          5249485249485249485249485249485249485249485249485249485249485244
          5475277FFF277FFF445475494852494852494852494852494852494852494852
          435476277FFF4C50614948524948524948524948524948524948524948524948
          52494852494852494852425476277FFF44547549485249485249485249485249
          48524948524948524C5162277FFF455473494852494852494852494852494852
          494852494852494852494852494852455472277FFF4354764948524948524948
          52494852494852494852494852494852494852435475277FFF4C516249485249
          48524948524948524948524948524948524948524C5162277FFF435476494852
          4948524948524948524948524948524948524948524948524948524C5062277F
          FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
          7FFF4B5163494852494852494852494852494852494852494852494852494852
          4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
          6D277FFF277FFF4B516349485249485249485249485249485249485249485249
          48524948524948524948524948524948524948524B5266465370277FFF277FFF
          277FFF277FFF46537049526A4C51624948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          48524C50624C51634C51634C5062494852494852494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852}
        TabOrder = 6
        TabStop = False
        OnClick = BtnPesqRotaClick
      end
      object PnlListaCliPedidos: TPanel
        Left = 10
        Top = 136
        Width = 1126
        Height = 430
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Caption = 'PnlListaCliPedidos'
        TabOrder = 7
        DesignSize = (
          1126
          430)
        object LstAdvPedidos: TAdvStringGrid
          Left = 0
          Top = 182
          Width = 1126
          Height = 247
          Cursor = crDefault
          CustomHint = BalloonHint1
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clBtnFace
          ColCount = 11
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
          TabOrder = 0
          HoverRowColor = 15658717
          HoverRowCells = [hcNormal, hcSelected]
          OnClickCell = LstAdvPedidosClickCell
          HintColor = 5080903
          ActiveCellShow = True
          ActiveCellFont.Charset = DEFAULT_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'MS Sans Serif'
          ActiveCellFont.Style = []
          ActiveCellColor = 5080903
          Bands.Active = True
          Bands.PrimaryColor = 16117735
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            'Pedido Id'
            'Data'
            'Ressuprimento'
            'C'#243'digo'
            'Destinat'#225'rio'
            'Volumes'
            'Cxa.Fechada'
            'V.Fracionado'
            'Peso Kg'
            'Vol.m3'
            'Selecione')
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
            74
            74
            74
            74
            74
            74
            74
            74)
          RowHeights = (
            24
            25)
        end
        object LstAdvClientesRota: TAdvStringGrid
          Left = 0
          Top = 0
          Width = 1126
          Height = 176
          Cursor = crDefault
          CustomHint = BalloonHint1
          Align = alTop
          Color = clBtnFace
          ColCount = 10
          DefaultColWidth = 74
          DefaultRowHeight = 25
          DrawingStyle = gdsClassic
          RowCount = 25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
          HoverRowColor = 15658717
          HoverRowCells = [hcNormal, hcSelected]
          OnClickCell = LstAdvClientesRotaClickCell
          HintColor = 5080903
          ActiveCellShow = True
          ActiveCellFont.Charset = DEFAULT_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'MS Sans Serif'
          ActiveCellFont.Style = []
          ActiveCellColor = 5080903
          Bands.Active = True
          Bands.PrimaryColor = 16117735
          BackGround.ColorTo = 15523534
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            'Pessoa Id'
            'C'#243'digo'
            'Destinat'#225'rio'
            'Ordem'
            'Pedidos'
            'V.Cxa.Fech'
            'V.Fracionado'
            'Peso Kg'
            'Vol.m3'
            'Selecione')
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
            74
            74
            74
            74
            74
            74
            74)
          RowHeights = (
            24
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25
            25)
          object PnlResumoCarga: TPanel
            Left = 858
            Top = 0
            Width = 247
            Height = 172
            CustomHint = BalloonHint1
            Align = alRight
            Alignment = taRightJustify
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 4
            ExplicitHeight = 155
            DesignSize = (
              247
              172)
            object Label9: TLabel
              Left = 20
              Top = 4
              Width = 110
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Dados do Ve'#237'culo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object Label12: TLabel
              Left = 24
              Top = 26
              Width = 71
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Capacidade:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label14: TLabel
              Left = 47
              Top = 48
              Width = 48
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Volume:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object LblVolumeVeiculo: TLabel
              Left = 194
              Top = 48
              Width = 31
              Height = 16
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = '0 m3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblPesoVeiculo: TLabel
              Left = 197
              Top = 26
              Width = 28
              Height = 16
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = '0 Kg'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 187
            end
            object Label16: TLabel
              Left = 6
              Top = 74
              Width = 102
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Dados da Carga'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
            end
            object Label17: TLabel
              Left = 59
              Top = 96
              Width = 32
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Peso:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label18: TLabel
              Left = 4
              Top = 121
              Width = 87
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Cubagem(m3):'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object LblPesoCarga: TLabel
              Left = 197
              Top = 98
              Width = 28
              Height = 16
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = '0 Kg'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblVolumeCarga: TLabel
              Left = 194
              Top = 122
              Width = 31
              Height = 16
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = '0 m3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label21: TLabel
              Left = 19
              Top = 148
              Width = 72
              Height = 16
              CustomHint = BalloonHint1
              Caption = 'Qtd.Volume:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object LblQtdVolumeCarga: TLabel
              Left = 217
              Top = 144
              Width = 8
              Height = 16
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
      object BtnCargaPesq: TBitBtn
        Left = 127
        Top = 16
        Width = 29
        Height = 29
        CustomHint = BalloonHint1
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C006000000000000000000000000000000000000494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524C516347536F4948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          48524948524948524B5163277FFF277FFF47536F494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
          634948524948524948524948524948524948524948524948524948524948524C
          50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
          277FFF4B51634948524948524948524948524948524948524948524948524948
          524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
          7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
          4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
          73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
          48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
          4948524948524948524C506148536D277FFF4A52684948524948524948524948
          52494852494852494852494852494852494852435475277FFF4C506149485249
          485249485249485249485249485249485249485249485247536E465370494852
          494852494852494852494852494852494852494852494852435476277FFF4554
          724948524948524948524948524948524948524948524948524948524948524C
          5162277FFF435476494852494852494852494852494852494852494852435475
          277FFF4254764948524948524948524948524948524948524948524948524948
          52494852494852494852425476277FFF44547549485249485249485249485249
          4852494852435475277FFF277FFF435475494852494852494852494852494852
          494852494852494852494852494852445475277FFF277FFF4454754948524948
          52494852494852494852494852435475277FFF277FFF43547549485249485249
          4852494852494852494852494852494852494852494852494852425478277FFF
          445475494852494852494852494852494852494852435475277FFF4254764948
          5249485249485249485249485249485249485249485249485249485249485244
          5475277FFF277FFF445475494852494852494852494852494852494852494852
          435476277FFF4C50614948524948524948524948524948524948524948524948
          52494852494852494852425476277FFF44547549485249485249485249485249
          48524948524948524C5162277FFF455473494852494852494852494852494852
          494852494852494852494852494852455472277FFF4354764948524948524948
          52494852494852494852494852494852494852435475277FFF4C516249485249
          48524948524948524948524948524948524948524C5162277FFF435476494852
          4948524948524948524948524948524948524948524948524948524C5062277F
          FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
          7FFF4B5163494852494852494852494852494852494852494852494852494852
          4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
          6D277FFF277FFF4B516349485249485249485249485249485249485249485249
          48524948524948524948524948524948524948524B5266465370277FFF277FFF
          277FFF277FFF46537049526A4C51624948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          48524C50624C51634C51634C5062494852494852494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852}
        TabOrder = 8
        TabStop = False
        OnClick = BtnCargaPesqClick
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 604
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 604
      inherited DbgImporta: TDBGrid
        Top = 289
        Height = 322
      end
    end
    object TabAcompanhamentoCarga: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Acompanhamento de Cargas'
      ImageIndex = 4
      ExplicitHeight = 604
      DesignSize = (
        1157
        611)
      object LblTotRegCaption: TLabel
        Left = 8
        Top = 142
        Width = 117
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Total de Registro(s):'
      end
      object LblTotRegistro: TLabel
        Left = 131
        Top = 142
        Width = 54
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RgCargaProcesso: TRadioGroup
        Left = 10
        Top = 11
        Width = 969
        Height = 56
        CustomHint = BalloonHint1
        Caption = '[ Carga - Processo ]'
        Columns = 8
        Enabled = False
        ItemIndex = 7
        Items.Strings = (
          'Montada'
          'Carrregada'
          'Em Tr'#226'nsito'
          'Em Entrega'
          'Finalizada'
          'Cancelada'
          'Pendentes'
          'Todos')
        TabOrder = 0
        OnClick = RgCargaProcessoClick
      end
      object LstCargaResumo: TAdvStringGrid
        Left = 10
        Top = 162
        Width = 1133
        Height = 445
        Cursor = crDefault
        CustomHint = BalloonHint1
        ColCount = 13
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
        TabOrder = 1
        ActiveRowColor = 15135200
        HoverRowColor = 15658717
        HoverRowCells = [hcNormal, hcSelected]
        OnRowChanging = LstCadastroRowChanging
        OnClickCell = LstCargaResumoClickCell
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
        Bands.PrimaryColor = 16117735
        BackGround.ColorTo = 15663069
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          'Carga'
          'Data'
          'Processo'
          'Transportadora'
          'Motorista'
          'Placa'#9
          'Pedido(s)'
          'Volume(s)'
          'Vlm.Carregado'
          'rotaid'
          'Tr'#226'n.'
          'Entr.'
          'ProcessoId')
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
        RowIndicator.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000277F
          FFFF00000000000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000277F
          FFFF00000000000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
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
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74)
        RowHeights = (
          24
          25)
      end
      object GroupBox3: TGroupBox
        Left = 10
        Top = 73
        Width = 399
        Height = 60
        CustomHint = BalloonHint1
        Caption = ' [ Per'#237'odo das Cargas ]'
        TabOrder = 2
        object Label13: TLabel
          Left = 20
          Top = 27
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label19: TLabel
          Left = 204
          Top = 26
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtdtCargaInicial: TJvDateEdit
          Left = 56
          Top = 24
          Width = 105
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtdtCargaInicialChange
          OnEnter = EdtCargaIdEnter
          OnExit = EdtDtInicioMontagemExit
          OnKeyUp = EdtRotaIdKeyUp
        end
        object EdtdtCargaFinal: TJvDateEdit
          Left = 257
          Top = 24
          Width = 105
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtdtCargaInicialChange
          OnEnter = EdtCargaIdEnter
          OnExit = EdtDtInicioMontagemExit
          OnKeyUp = EdtRotaIdKeyUp
        end
      end
      object GroupBox5: TGroupBox
        Left = 408
        Top = 73
        Width = 571
        Height = 60
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Caption = '[ Rota ]'
        TabOrder = 3
        object Label20: TLabel
          Left = 19
          Top = 25
          Width = 32
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Inicial'
        end
        object LblRotaInicial: TLabel
          Left = 132
          Top = 26
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 285
          Top = 25
          Width = 26
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Final'
        end
        object LblRotaFinal: TLabel
          Left = 393
          Top = 26
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtRotaIdInicial: TEdit
          Left = 57
          Top = 24
          Width = 45
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtdtCargaInicialChange
          OnExit = EdtRotaIdInicialExit
        end
        object BtnPesqRotaInicial: TBitBtn
          Left = 102
          Top = 24
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000004390FFE24390FFE20000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000004792FFDB277FFFFF277FFFFF4490FFE10000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE7000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00004792FFDB277FFFFF277FFFFF277FFFFF408EFFE70000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE700000000000000000000
            0000000000000000000000000000000000000000000000000000000000004792
            FFDB277FFFFF277FFFFF277FFFFF408EFFE7000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000004792FFDB277F
            FFFF277FFFFF277FFFFF408EFFE700000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000067A5FF40438FFFE32A81
            FFFE277FFFFF277FFFFF2A81FFFE4490FFE168A5FF3B68A5FF3B277FFFFF277F
            FFFF277FFFFF4390FFE20000000000000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005399FFB6277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
            FFFF4390FFE2000000000000000000000000000000000000000000000000277F
            FFFF4390FFE200000000000000005399FFB6277FFFFF277FFFFF3185FFFA5A9D
            FF976AA7FF236AA7FF23599DFF993185FFFA277FFFFF277FFFFF277FFFFF67A5
            FF40000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000067A5FF42277FFFFF277FFFFF4591FFDD000000000000
            0000000000000000000000000000000000004591FFDF277FFFFF277FFFFF67A5
            FF42000000000000000000000000000000000000000000000000000000000000
            00000000000000000000428FFFE5277FFFFF3285FFFA00000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000000000
            000000000000000000002880FFFF277FFFFF5A9DFF9600000000000000000000
            00000000000000000000000000000000000000000000599DFF99277FFFFF2980
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            000000000000000000002980FFFF277FFFFF5A9DFF9400000000000000000000
            000000000000000000000000000000000000000000005A9DFF97277FFFFF2A81
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000418EFFE6277FFFFF3286FFF900000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000066A4FF47277FFFFF277FFFFF4792FFDB000000000000
            0000000000000000000000000000000000004591FFDD277FFFFF277FFFFF68A5
            FF3B00000000000000004390FFE200000000000000000000000000000000277F
            FFFF4390FFE200000000000000005198FFBB277FFFFF277FFFFF3286FFF95A9D
            FF946BA7FF206BA7FF205A9DFF963285FFFA277FFFFF277FFFFF5399FFB40000
            0000000000004390FFE2277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005298FFB8277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF5399FFB4000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000066A5FF45428FFFE52980
            FFFF277FFFFF277FFFFF2A81FFFE428FFFE467A5FF3D00000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE100000000000000000000
            000000000000000000000000000000000000000000004792FFDB277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE1000000000000
            0000000000000000000000000000000000004792FFDB277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqRotaInicialClick
        end
        object EdtRotaIdFinal: TEdit
          Left = 317
          Top = 24
          Width = 45
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnChange = EdtdtCargaInicialChange
          OnExit = EdtRotaIdInicialExit
        end
        object BtnPesqRotaFinal: TBitBtn
          Left = 363
          Top = 24
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000004390FFE24390FFE20000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000004792FFDB277FFFFF277FFFFF4490FFE10000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE7000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00004792FFDB277FFFFF277FFFFF277FFFFF408EFFE70000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE700000000000000000000
            0000000000000000000000000000000000000000000000000000000000004792
            FFDB277FFFFF277FFFFF277FFFFF408EFFE7000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000004792FFDB277F
            FFFF277FFFFF277FFFFF408EFFE700000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000067A5FF40438FFFE32A81
            FFFE277FFFFF277FFFFF2A81FFFE4490FFE168A5FF3B68A5FF3B277FFFFF277F
            FFFF277FFFFF4390FFE20000000000000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005399FFB6277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
            FFFF4390FFE2000000000000000000000000000000000000000000000000277F
            FFFF4390FFE200000000000000005399FFB6277FFFFF277FFFFF3185FFFA5A9D
            FF976AA7FF236AA7FF23599DFF993185FFFA277FFFFF277FFFFF277FFFFF67A5
            FF40000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000067A5FF42277FFFFF277FFFFF4591FFDD000000000000
            0000000000000000000000000000000000004591FFDF277FFFFF277FFFFF67A5
            FF42000000000000000000000000000000000000000000000000000000000000
            00000000000000000000428FFFE5277FFFFF3285FFFA00000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000000000
            000000000000000000002880FFFF277FFFFF5A9DFF9600000000000000000000
            00000000000000000000000000000000000000000000599DFF99277FFFFF2980
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            000000000000000000002980FFFF277FFFFF5A9DFF9400000000000000000000
            000000000000000000000000000000000000000000005A9DFF97277FFFFF2A81
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000418EFFE6277FFFFF3286FFF900000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000066A4FF47277FFFFF277FFFFF4792FFDB000000000000
            0000000000000000000000000000000000004591FFDD277FFFFF277FFFFF68A5
            FF3B00000000000000004390FFE200000000000000000000000000000000277F
            FFFF4390FFE200000000000000005198FFBB277FFFFF277FFFFF3286FFF95A9D
            FF946BA7FF206BA7FF205A9DFF963285FFFA277FFFFF277FFFFF5399FFB40000
            0000000000004390FFE2277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005298FFB8277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF5399FFB4000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000066A5FF45428FFFE52980
            FFFF277FFFFF277FFFFF2A81FFFE428FFFE467A5FF3D00000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE100000000000000000000
            000000000000000000000000000000000000000000004792FFDB277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE1000000000000
            0000000000000000000000000000000000004792FFDB277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 3
          TabStop = False
          OnClick = BtnPesqRotaInicialClick
        end
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 510
    Top = -12
    ExplicitLeft = 510
    ExplicitTop = -12
  end
  inherited PnlErro: TPanel
    Top = 668
    ExplicitTop = 661
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 991
    Top = 20
    ExplicitLeft = 991
    ExplicitTop = 20
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited TmFrameWeb: TTimer
    Left = 287
    Top = 106
  end
  inherited DsPesqGeral: TDataSource
    Left = 285
    Top = 238
  end
  inherited FdMemPesqGeral: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'CargaId'
        DataType = ftInteger
      end
      item
        Name = 'DtInclusao'
        DataType = ftDate
      end
      item
        Name = 'HrInclusao'
        DataType = ftTime
      end
      item
        Name = 'RotaId'
        DataType = ftInteger
      end
      item
        Name = 'Rota'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'TranspId'
        DataType = ftInteger
      end
      item
        Name = 'Transportadora'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'MotoristaId'
        DataType = ftInteger
      end
      item
        Name = 'Motorista'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'VeiculoId'
        DataType = ftInteger
      end
      item
        Name = 'Placa'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'TDestinatario'
        DataType = ftInteger
      end
      item
        Name = 'TPedido'
        DataType = ftInteger
      end
      item
        Name = 'QtdSuprida'
        DataType = ftInteger
      end>
    StoreDefs = True
    Left = 233
    Top = 245
    object FdMemPesqGeralCargaId: TIntegerField
      FieldName = 'CargaId'
    end
    object FdMemPesqGeralDtInclusao: TDateField
      FieldName = 'DtInclusao'
    end
    object FdMemPesqGeralHrInclusao: TTimeField
      FieldName = 'HrInclusao'
    end
    object FdMemPesqGeralRotaId: TIntegerField
      FieldName = 'RotaId'
    end
    object FdMemPesqGeralRota: TStringField
      FieldName = 'Rota'
      Size = 60
    end
    object FdMemPesqGeralTranspId: TIntegerField
      FieldName = 'TranspId'
    end
    object FdMemPesqGeralTransportadora: TStringField
      FieldName = 'Transportadora'
      Size = 100
    end
    object FdMemPesqGeralMotoristaId: TIntegerField
      FieldName = 'MotoristaId'
    end
    object FdMemPesqGeralMotorista: TStringField
      FieldName = 'Motorista'
      Size = 100
    end
    object FdMemPesqGeralVeiculoId: TIntegerField
      FieldName = 'VeiculoId'
    end
    object FdMemPesqGeralPlaca: TStringField
      FieldName = 'Placa'
      Size = 8
    end
    object FdMemPesqGeralTDestinatario: TIntegerField
      FieldName = 'TDestinatario'
    end
    object FdMemPesqGeralTPedido: TIntegerField
      FieldName = 'TPedido'
    end
    object FdMemPesqGeralQtdSuprida: TIntegerField
      FieldName = 'QtdSuprida'
    end
  end
  inherited TmImportacaoCSV: TTimer
    Left = 113
    Top = 253
  end
  object frxMapaCarga: TfrxReport
    Version = '6.4.11'
    DataSet = frxDBDataset1
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Grupo X3'
    ReportOptions.CreateDate = 41746.768122685200000000
    ReportOptions.LastChange = 44838.731451053240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 174
    Top = 483
    Datasets = <
      item
        DataSet = frxDBDataset3
        DataSetName = 'frxDBCargaPedidos'
      end
      item
        DataSet = frxDBDataset2
        DataSetName = 'frxDbCargaPessoas'
      end
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'vModulo'
        Value = Null
      end
      item
        Name = 'vVersao'
        Value = Null
      end
      item
        Name = 'vUsuario'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Height = 41.574830000000000000
          Frame.Typ = []
        end
        object frxMemoView1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 162.519790000000000000
          Width = 393.071120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'eXactWms')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 162.519790000000000000
          Top = 15.118120000000000000
          Width = 393.071120000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Mapa de Carga')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 34.015770000000000000
          Frame.Typ = []
          Picture.Data = {
            07544269746D6170F6380200424DF6380200000000003600000028000000C800
            0000B60000000100200000000000C03802000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000A000000420000
            006500000067000000530000001F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000015000000470000007B000000800000
            0080000000800000008000000075000000150000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000680000008000000080000000800000
            00800000007F0000008000000080000000330000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000006A0000008000000080000000800000
            0080000000800000008000000080000000360000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000A0000001F000000270000007A0000
            0080000000800000008000000080000000100000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000080000003A000000670000006F0000
            006F0000006F000000630000004B0000001C0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000070000
            002F000000540000006A0000006F0000006F00000067000000490000001F0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000001A000000570000006F0000006F0000006F0000006F0000006F0000
            006F0000006F0000003E00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000D00000037000000620000006F0000006F00000067000000480000
            0019000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000040000002E000000670000007A000000800000
            0080000000800000008000000071000000350000000400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00160000003C0000005E0000006F0000006F0000006F000000590000003B0000
            0009000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000002000000350000006B0000006F0000006F0000006F0000006F0000
            006F0000006F0000006600000010000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000010000000470000006B0000006F0000006F0000006F000000600000
            0046000000100000000000000000000000000000000000000000000000000000
            00000000000000000000000000080000006E0000008000000080000000800000
            0080000000800000008000000080000000800000003F00000005000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000002A000000770000
            0080000000800000008000000080000000800000008000000080000000800000
            0059000000120000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0009000000730000008000000080000000800000008000000080000000800000
            0080000000800000005F00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0019000000780000008000000080000000800000008000000080000000800000
            007E0000003B0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000140000006D000000800000008000000080000000800000
            0080000000800000008000000080000000800000006500000019000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000A000000550000
            0080000000800000008000000080000000800000008000000080000000800000
            00740000003F0000000500000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000380000008000000080000000800000008000000080000000800000
            008000000080000000800000001F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00180000007B0000008000000080000000800000008000000080000000800000
            0080000000780000002B00000000000000000000000000000000000000000000
            00000000000000000000000000390000008000000080000000800000007A0000
            00700000007D0000008000000080000000800000007D0000002B000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000004100000080000000800000
            0080000000800000008000000074000000780000008000000080000000800000
            0080000000710000002200000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0023000000800000008000000080000000710000007000000070000000700000
            0070000000700000003700000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000D0000
            00760000008000000080000000800000007D0000007600000080000000800000
            00800000007C0000002600000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000014000000750000008000000080000000800000007C000000600000
            004E0000005C0000007A00000080000000800000008000000067000000060000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000E00000071000000800000
            008000000080000000800000007E000000700000007C00000080000000800000
            0080000000800000004D00000006000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000600000008000000080000000790000007000000070000000700000
            0070000000700000006700000004000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0059000000800000008000000080000000760000007200000080000000800000
            0080000000800000007500000017000000000000000000000000000000000000
            000000000000000000000000006A000000800000008000000057000000040000
            00060000000A0000002B0000007800000080000000800000005D000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000002B0000008000000080000000800000
            007D00000043000000120000000400000008000000180000004C000000780000
            0080000000800000006F0000000B000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0028000000800000008000000071000000080000000400000004000000040000
            0004000000040000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000004F0000
            0080000000800000007E0000003B000000060000000800000021000000740000
            0080000000800000006400000003000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00070000006A000000800000008000000080000000480000000C000000000000
            00000000000200000012000000550000007E0000008000000072000000060000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000040000006600000080000000800000
            0080000000670000002A00000006000000040000000B000000280000006C0000
            0080000000800000007D0000004E000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000350000000400000004000000040000
            0004000000040000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000070000
            007A00000080000000800000003F00000004000000060000000F000000390000
            007C000000800000008000000042000000000000000000000000000000000000
            0000000000000000000000000076000000800000007E00000019000000000000
            000000000000000000000000003B000000800000008000000079000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000002000000740000008000000080000000780000
            00190000000000000000000000000000000000000000000000000000002F0000
            007A00000080000000800000004C000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000007B0000
            00800000008000000046000000000000000000000000000000000000002A0000
            0080000000800000007F00000019000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            003A000000800000008000000080000000390000000000000000000000000000
            00000000000000000000000000010000003F0000006300000029000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000002C0000008000000080000000800000
            004F0000000000000000000000000000000000000000000000000000000A0000
            005700000080000000800000007D0000001C0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000160000
            007F000000800000007A00000000000000000000000000000000000000000000
            0053000000800000008000000059000000000000000000000000000000000000
            0000000000000000000000000075000000800000007C0000000E000000000000
            000000000000000000000000003B00000080000000800000007A000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000001F0000008000000080000000800000001D0000
            0000000000000000000000000000000000000000000000000000000000000000
            0047000000800000008000000072000000070000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000D000000800000
            00800000007D0000001A00000000000000000000000000000000000000040000
            0070000000800000008000000031000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000020000
            006F00000080000000800000005A000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000005C00000080000000800000006D0000
            0000000000000000000000000000000000000000000000000000000000000000
            000E0000006E0000008000000080000000460000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000170000
            007E000000800000007100000000000000000000000000000000000000000000
            005C00000080000000800000005A000000000000000000000000000000000000
            0000000000000000000000000050000000670000005200000002000000000000
            0000000000000000002200000073000000800000008000000066000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000004100000080000000800000006E000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00130000007C00000080000000800000001F0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000017000000800000
            00800000007A0000000B00000000000000000000000000000000000000000000
            006200000080000000800000003D000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000190000
            007E000000800000007D00000019000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000007A0000008000000080000000300000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000480000008000000080000000630000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000A0000
            005E000000670000003800000000000000000000000000000001000000370000
            007E000000800000008000000042000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000010000
            00250000005D0000008000000080000000800000008000000036000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000053000000800000008000000051000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00040000006C0000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000300000
            0080000000800000007300000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000D00000080000000800000007E000000170000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000002A0000008000000080000000720000000500000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000470000002700000027000000270000
            00270000001E0000000100000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000050000002E0000006C000000800000
            0080000000800000007B0000001B000000000000000000000000000000000000
            0000000000000000000000000000000000000000000800000039000000740000
            0080000000800000008000000080000000800000005400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000005E000000800000008000000041000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000640000008000000080000000390000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000370000
            0080000000800000006600000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000001400000080000000800000007D0000000F0000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000001C0000008000000080000000770000000A00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000800000008000000080000000800000
            00800000007E0000001A00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000C00000046000000780000008000000080000000800000
            0080000000800000003700000000000000000000000000000000000000000000
            0000000000000000000000000000000000270000007600000080000000800000
            00800000008000000080000000700000003A0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000005F00000080000000800000003F000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000630000008000000080000000390000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000360000
            0080000000800000006600000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000001400000080000000800000007D0000000E0000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000001A0000008000000080000000780000000B00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000800000008000000080000000800000
            0080000000800000002200000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0001000000390000007C00000080000000800000008000000080000000800000
            0065000000260000000000000000000000000000000000000000000000000000
            00000000000000000000000000200000007E0000008000000080000000800000
            00800000005B0000002900000002000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000056000000800000008000000049000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00010000006B0000008000000080000000330000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000002D0000
            0080000000800000007200000003000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000010000000800000008000000080000000150000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000250000008000000080000000750000000600000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000580000003C0000003C0000003C0000
            003C000000380000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            003B000000800000008000000080000000800000007C00000051000000200000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000730000008000000080000000800000004A0000
            000F000000000000000000000007000000550000006700000046000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000044000000800000008000000064000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000A0000007A0000008000000080000000210000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000001C0000
            0080000000800000008000000025000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000020000007A00000080000000800000002D0000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000003D00000080000000800000006E0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000B0000
            007C00000080000000800000007E0000003C0000000700000000000000000000
            000F0000005F0000006700000030000000000000000000000000000000000000
            0000000000000000000D0000007D000000800000007E00000033000000000000
            000000000000000000000000001B0000007F0000008000000071000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000002300000080000000800000007E000000140000
            0000000000000000000000000000000000000000000000000000000000000000
            003800000080000000800000007D0000000B0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000050000
            006A00000080000000800000005E000000070000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000005E0000008000000080000000610000
            0000000000000000000000000000000000000000000000000000000000000000
            00030000006C0000008000000080000000540000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000290000
            0080000000800000007E00000011000000000000000000000000000000000000
            0034000000800000008000000051000000000000000000000000000000000000
            000000000000000000180000007E000000800000007A0000000B000000000000
            0000000000000000000000000023000000800000008000000071000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000090000007400000080000000800000005F0000
            000D000000000000000000000000000000000000000000000000000000190000
            007800000080000000800000005E000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            003C00000080000000800000007F000000370000000300000000000000000000
            0000000000000000000000000000000000360000005B0000002E000000030000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000003C00000080000000800000007F0000
            0033000000010000000000000000000000000000000000000000000000000000
            0048000000800000008000000080000000220000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000300000
            0080000000800000006900000000000000000000000000000000000000000000
            003E000000800000008000000050000000000000000000000000000000000000
            000000000000000000100000007B000000800000008000000038000000020000
            000000000000000000030000004F000000800000008000000060000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000410000008000000080000000800000
            006A00000027000000020000000000000000000000050000002E0000007B0000
            0080000000800000007B0000001E000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00040000006600000080000000800000007E0000005100000014000000000000
            000000000000000000120000004C00000080000000800000007B0000001E0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000080000006D00000080000000800000
            007D0000004F0000001100000000000000000000000000000017000000530000
            0080000000800000008000000067000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000670000008000000080000000310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000270000
            0080000000800000007B00000021000000000000000000000000000000060000
            006900000080000000800000003F000000000000000000000000000000000000
            000000000000000000000000005E0000008000000080000000800000006B0000
            005800000057000000700000008000000080000000800000003F000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000003000000530000007E000000800000
            008000000080000000730000005A000000640000007D00000080000000800000
            0080000000800000003800000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000150000006D000000800000008000000080000000800000006B0000
            00580000006C0000007F000000800000008000000080000000720000000C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000001C0000006E000000800000
            0080000000800000008000000066000000570000007200000080000000800000
            008000000080000000720000000F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000630000008000000080000000620000005700000057000000570000
            005700000057000000510000000B000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000100000
            007500000080000000800000007E000000650000005700000059000000770000
            008000000080000000800000001D000000000000000000000000000000000000
            0000000000000000000000000022000000750000008000000080000000800000
            0080000000800000008000000080000000800000007100000002000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000007000000470000007D0000
            0080000000800000008000000080000000800000008000000080000000800000
            00780000002F0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            002800000080000000800000006E000000040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000018000000800000
            00800000007A0000000700000000000000000000000000000000000000000000
            005F00000080000000800000003F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000001800000058000000800000008000000080000000800000
            0080000000800000008000000080000000800000005D00000009000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000001C000000630000
            0080000000800000008000000080000000800000008000000080000000800000
            0080000000600000000900000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000420000008000000080000000800000008000000080000000800000
            008000000080000000800000001F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00340000007E0000008000000080000000800000008000000080000000800000
            0080000000800000006100000000000000000000000000000000000000000000
            0000000000000000000000000000000000140000004500000073000000780000
            007C0000007C0000007C0000007A000000530000000A00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000001000000150000
            00440000006F000000780000007C0000007C0000007B000000660000003E0000
            0004000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            001E000000780000007C0000005C000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000010000000750000
            007C0000006D0000000200000000000000000000000000000000000000000000
            00500000007A0000007900000022000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000090000002600000058000000770000007C0000
            007C0000007C00000077000000560000002A0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000090000
            002A0000005C000000770000007C0000007C0000007C00000077000000550000
            0025000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000C00000056000000780000007C0000007C0000007C0000007C0000
            007C0000007C000000790000000F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00010000001C00000053000000750000007A0000007C0000007C0000007C0000
            0074000000450000000300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000C0000
            000C0000000C0000000C00000002000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000A0000000C0000000C0000000400000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000A0000000C00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000A0000
            000C000000000000000000000000000000000000000000000000000000000000
            00000000000C0000000A00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000020000000C0000
            000C0000000C0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0035000000520000002000000011000000470000004900000027000000030000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000A0000000C0000000C0000000C0000000C0000
            000C0000000C0000000600000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000020000000C0000000C0000000C0000000C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            007200000080000000730000007E00000080000000800000007E0000004B0000
            0001000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            004B0000008000000080000000800000008000000080000000800000007F0000
            0015000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000C0000006400000080000000800000006A0000004100000078000000720000
            000F000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000004000000140000000F000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000037F1370D38F1387138F1387838F1387838F1387838F1
            387838F1387838F1387838F1387838F1387838F1387838F1387838F1387838F1
            387338F1385737F2370F00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000038F1381C38F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1387638F2381E000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000038F1381C38F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1386439F139040000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000036F2360B38F1385738F1385A38F1385A38F1385A38F1
            385A38F1385A38F1385A38F1385A38F1385A38F1385A38F1385A38F1385A38F1
            386E38F1388038F1388038F1387C38F238150000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383838F1388038F1388038F1388038F138210000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F038220000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F038220000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000175D1702145A1A42145A1A4B145A1A4B165C1810000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591933145A1A4B145A
            1A4B145A1A4B145A1922000000000000000000000000145A192A145A1A4B145A
            1A4B155A19310000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000145B1917145A1A4B145A
            1A4B145A1A42145A1A050000000000000000000000001357170A14591938145A
            1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A
            1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A44175B
            1B030000000000000000145B1921145A1A4B145A1A4B145A193D000000000000
            0000000000000000000000000000000000000000000000000000000000001459
            1929145A1A4B145A1A4B145A1A35106020010000000000000000000000000000
            000000000000000000000000000000000000145A1A30145A1A4B145A1A4B1359
            192C0000000000000000000000000000000014581909145A1938145A1A4A145A
            1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A
            1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A4B145A1A46125B15050000
            0000000000000000000049FF490138F1382C38F1384738F1384B38F1384B38F1
            384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1
            384B38F1384A38F2382D38F13808000000000000000000000000000000000000
            0000000000003AF23A0538F1383438F1384A38F1384B38F1384B38F1384B38F1
            384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1
            386338F1388038F1388038F1388038F038220000000000000000000000000000
            000039F3390838F1383738F1384A38F1384B38F1384B38F1384B38F1384B38F1
            384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1384B38F1384639F1
            391C37F137060000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000145A1929145A1A80145A1A80145A
            1A80145A1A801459192F000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A100000000000000000145A1A2B145A1A7E145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A00000000000000000000000014591828145A1A7D145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80135B18190000
            0000000000003AF53A0838F1386538F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1386938F138160000000000000000000000000000
            000039F2391A38F1387238F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F0382200000000000000000000000038F2
            382738F1387838F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            387E38F1385136F4360600000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000145A1814145A1A7D145A1A80145A1A80145A
            1A80145A194C00000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A100000000015591913145A1A7F145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A190D145A1A7E145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80135B18190000
            000036F3360738F1386638F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2386537F13707000000000000000038F2
            380C38F1387838F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F03822000000000000000038F2381138F1
            387D38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2384400000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000014591A0A145A1A6F145A1A80145A1A80145A1A80145A
            1A641359180700000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1000000000145A1A4F145A1A80145A1A80145A1A80145A
            1A7E145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A
            1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A781459
            1A0B000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A49145A1A80145A1A80145A1A80145A1A7E145A
            1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A
            1A7A145A1A7A145A1A7A145A1A7A145A1A80145A1A80145A1A80135B18190000
            000037F2371E38F1388038F1388038F1388038F1388038F1387A38F1387A38F1
            387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1
            387A38F1387D38F1388038F1388038F1387F38F13828000000000000000038F1
            383638F1388038F1388038F1388038F1387E38F1387A38F1387A38F1387A38F1
            387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1
            387E38F1388038F1388038F1388038F03822000000000000000038F1384538F1
            388038F1388038F1388038F1387E38F1387A38F1387A38F1387A38F1387A38F1
            387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1387A38F1387F38F1
            388038F1388038F1387338F13808000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000011581804145A1A64145A1A80145A1A80145A1A80145A1A6A1658
            19050000000000000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A61145A1A80145A1A80145A1A771458
            190E1558180C1558180C1558180C1558180C1558180C1558180C1558180C1558
            180C1558180C1558180C1558180C1558180C1558180C1558180C155818070000
            0000000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A5D145A1A80145A1A80145A1A78145819141558
            180C1558180C1558180C1558180C1558180C1558180C1558180C1558180C1558
            180C1558180C1558180C145A1A42145A1A80145A1A80145A1A80135B18190000
            000037F1373638F1388038F1388038F1388038F2382F38F2380C38F2380C38F2
            380C38F2380C38F2380C38F2380C38F2380C38F2380C38F2380C38F2380C38F2
            380C38F1382D38F1388038F1388038F1388038F1383D000000000000000038F2
            385038F1388038F1388038F1387B38F2381F38F2380C38F2380C38F2380C38F2
            380C38F2380C38F2380C38F2380C38F2380C38F2380C38F2380C38F2380C38F1
            384638F1388038F1388038F1388038F03822000000000000000038F1386038F1
            388038F1388038F1387838F2381638F2380C38F2380C38F2380C38F2380C38F2
            380C38F2380C38F2380C38F2380C38F2380C38F2380C37F2370D38F1385138F1
            388038F1388038F1387E38F13817000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000E551C01145A1A5B145A1A80145A1A80145A1A80145A1A79145819150000
            00000000000000000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A6C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A60145A1A80145A1A80145A1A6E125B17030000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000145A1A3D145A1A80145A1A80145A1A80135B18190000
            000038F3381438F1384438F1384438F1383E3AF13A0600000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000039F1391638F1388038F1388038F1388038F13840000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F2382938F1
            384438F1384439F1392800000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000038F1383E38F1
            388038F1388038F1388038F13818000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000145A193E145A1A80145A1A80145A1A80145A1A7B135A1921000000000000
            00000000000000000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A6C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A60145A1A80145A1A80145A1A6E125B17030000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000145A1A3D145A1A80145A1A80145A1A80135B18190000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000039F1391638F1388038F1388038F1388038F13840000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F038220000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000038F1383E38F1
            388038F1388038F1388038F13818000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000001559
            1929145A1A80145A1A80145A1A80145A1A801459193700000000000000000000
            00000000000000000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A6C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A60145A1A80145A1A80145A1A6E125B17030000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000145A1A3D145A1A80145A1A80145A1A80135B18190000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000039F1391738F1388038F1388038F1388038F13840000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F038220000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000038F1383F38F1
            388038F1388038F1388038F13818000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A37185918051858
            1806185818061858180618581806185818061858180618581806155A1918145A
            1A7B145A1A80145A1A80145A1A80145A19481858180618581806125B1B020000
            00000000000000000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A78145A
            1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A
            1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A41175D
            1704000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A60145A1A80145A1A80145A1A78145A1A4F145A
            1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A1A4C145A
            1A4C145A1A4C145A1A4C145A1A69145A1A80145A1A80145A1A80135B18190000
            0000000000000000000039FF390138F2383038F1384738F1384C38F1384C38F1
            384C38F1384C38F1384C38F1384C38F1384C38F1384C38F1384C38F1384C38F1
            384C38F1386238F1388038F1388038F1388038F23833000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F038220000000000000000000000000000
            000039F0390738F2383A38F1384A38F1384C38F1384C38F1384C38F1384C38F1
            384C38F1384C38F1384C38F1384C38F1384C38F1384C38F1384D38F1387838F1
            388038F1388038F1387D37F23710000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A79145A1A7A145A
            1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A7A145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A7A145A1A7A145A1A79145A1A741459
            1A43155A1A0800000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A60145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80135B18190000
            00000000000038F1380B38F1386638F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1387938F4380E000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F0382200000000000000000000000038F1
            382238F1387E38F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1386839FF3901000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A5F1457170A000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A60145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80135B18190000
            000039F2390538F1386838F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1382E00000000000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000039F1391038F1
            387A38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1387C38F2381200000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A8014591939000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145A1A4F145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80135B18190000
            000038F1381D38F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1387F38F1386637F2372C0000000000000000000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1384238F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387B38F1
            385A37F237120000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A72145A1A50145A
            1A4F145A1A4F145A1A4F145A1A4F145A1A4F145A1A4F145A1A4F145A1A4F145A
            1A4F145A1A4F145A1A4F145A1A4F145A1A4F145A1A4F145A1A54145A1A78145A
            1A80145A1A80145A1A65000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A6D1060
            2005106020051060200510602005106020051060200510602005106020051060
            2005106020051060200510602005145A1A44145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A0000000000000000145C2102106020051060200510602005106020051060
            2005106020051060200510602005106020051060200510602005106020051060
            20051060200510602005145A1A3F145A1A80145A1A80145A1A80135B18190000
            000038F1383738F1388038F1388038F1388037F2372940EF400540EF400540EF
            400540EF400540EF400540EF400540EF400540EF400540EF400540EF400540EF
            400538F4380100000000000000000000000000000000000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1386038F1
            388038F1388038F1387838F2381140EF400540EF400540EF400540EF400540EF
            400540EF400540EF400540EF400540EF400540EF40053EEE3E05000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A39000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A195F145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A6C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000155A1A42145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000145A1A3D145A1A80145A1A80145A1A80135B18190000
            000038F1383938F1388038F1388038F1388038F1381800000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1386138F1
            388038F1388038F1387000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A1A5C145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591940145A1A80145A
            1A80145A1A7D145A1A1010602001145A1A64145A1A80145A1A80145A1A6C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000155A1A42145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A000000000000
            000000000000000000000000000000000000000000000000000000000000145A
            1A66145A1A80145A1A80145A1A6B106020020000000000000000000000000000
            000000000000000000000000000010602002145A1A72145A1A80145A1A80145A
            1A5A000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000145A1A3D145A1A80145A1A80145A1A80135B18190000
            000038F1383938F1388038F1388038F1388038F1381800000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000038F038093BF03B0D3AF13A0C37F33707000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1386138F1
            388038F1388038F1387000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000003BF0
            3B0D3BF03B0D3AF13A0B2EE82E01000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A1A5C145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591943145A1A80145A
            1A80145A1A7D145A1A1011551101145A1A63145A1A80145A1A80145A1A6C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000145A1A46145A1A80145A1A80145A1A801359
            1912000000000000000014591958145A1A80145A1A80145A1A7A1C551C010000
            000000000000000000000000000000000000000000000000000000000000145A
            1A6A145A1A80145A1A80145A1A6B14591C040000000000000000000000000000
            00000000000000000000000000000F5A1E02145A1A74145A1A80145A1A80145A
            1A5A000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000145A1A41145A1A80145A1A80145A1A80135A18190000
            000038F1383938F1388038F1388038F1388038F1381A00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000037F1371138F1388038F1388038F1387F38F13837000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1386138F1
            388038F1388038F1387036EF3602000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000038F1383238F1
            388038F1388038F1387737F33715000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A1A5C145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A78145A1A5714591A4D14591A4D14591A4D14591A4D14591A4D1459
            1A4D14591A4D14591A4D14591A4D14591A4D1359194F145A1A7A145A1A80145A
            1A80145A1A791357190700000000145A195B145A1A80145A1A80145A1A7D145A
            195314591A4D14591A4D14591A4D14591A4D14591A4D14591A4D14591A4D1459
            1A4D14591A4D14591A4D1459194E145A1A7A145A1A80145A1A80145A1A7E1458
            190A000000000000000014591958145A1A80145A1A80145A1A80145A1A571459
            1A4D14591A4D14591A4D14591A4D14591A4D14591A4D14591A4D145A1953145A
            1A80145A1A80145A1A80145A1A7A145A1A5614591A4D14591A4D14591A4D1459
            1A4D14591A4D14591A4D14591A4D14591A57145A1A80145A1A80145A1A80145A
            1950000000000000000014591A2614591A4D14591A4D14591A4D14591A4D1459
            1A4D14591A4D14591A4D14591A4D14591A4D14591A4D14591A4D14591A4D1459
            1A4D14591A4D1459194E145A1A79145A1A80145A1A80145A1A7F1458190E0000
            000038F1382F38F1388038F1388038F1388038F1386838F2384E38F1384D38F1
            384D38F1384D38F1384D38F1384D38F1384D38F1384D38F1384D38F1384D38F1
            384D38F1386838F1388038F1388038F1388038F13836000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1385538F1
            388038F1388038F1387A38F2385938F1384D38F1384D38F1384D38F1384D38F1
            384D38F1384D38F1384D38F1384D38F1384D38F1384D38F2384E38F1387938F1
            388038F1388038F1387C37F1370E000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A1A5C145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A5F0000000000000000145A1934145A1A7E145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A590F5A
            1E01000000000000000014591958145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A801459
            1A210000000000000000145A1A60145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A6012581A020000
            000037F3370E38F1387738F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1387A38F23810000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F03822000000000000000038F1383138F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1386637F43701000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A1A5C145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A731459190F000000000000000015591908145A195C145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A74135919160000
            0000000000000000000014591958145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145919550000
            00000000000000000000145A1A60145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A7514591919000000000000
            00000000000038F1383538F1387D38F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2383500000000000000000000000038F1
            385238F1388038F1388038F138763AF43A090000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            383238F1388038F1388038F1388038F0382200000000000000003DF33D0138F1
            384D38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1387938F2381200000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A36000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000145A1A5C145A
            1A80145A1A80145A1A75000000000000000000000000145A1A68145A1A80145A
            1A80145A1A80145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A76145A1A551359
            191000000000000000000000000000000000125B1B0314591941145A1A6F145A
            1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A78145A1A7614591A5114591A0C000000000000
            00000000000000000000145A1948145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A78145A1A78145A1A6E145A1939175B17030000
            0000000000000000000014591A4E145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A1A78145A
            1A78145A1A78145A1A78145A1A76145A1A551458180D00000000000000000000
            0000000000000000000038F2382738F1386138F1387538F1387838F1387838F1
            387838F1387838F1387838F1387838F1387838F1387838F1387838F1387838F1
            387838F1387738F1386338F238260000000000000000000000000000000038F2
            384238F1387538F1387538F1386338F338050000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F1
            382338F1387438F1387538F1387038F1381300000000000000000000000038F2
            380738F2383C38F1386A38F1387738F1387838F1387838F1387838F1387838F1
            387838F1387838F1387838F1387838F1387838F1387838F1387838F1387638F1
            385739F239130000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A4E145918111458
            1810145818101458181014581810145818101458181014581810145818101458
            1810145818101458181014581810145818101458181014581912145A1A6D145A
            1A80145A1A80145A1A74000000000000000000000000145A1A68145A1A80145A
            1A80145A1A6B1458180C1458180C1458180C1458180C1458180C1458180C1458
            180C1458180C1458180C1458180C1458180C1459180C145A1906000000000000
            0000000000000000000000000000000000000000000000000000115919041458
            180C1458180C1458180C1458180C1458180C1458180C1458180C1458180C1458
            180C1458180C1458180C1458180C165916040000000000000000000000000000
            00000000000000000000155918051458180C1458180C1458180C1458180C1458
            180C1458180C1458180C1458180C1458180C1458180C1458180C1458180C1458
            180C1458180C1458180C1458180C1458180C1458180C1458180C1458180C1458
            180C1458180C1458180C1458180C1459180A1555150100000000000000000000
            00000000000000000000145819061458180C1458180C1458180C1458180C1458
            180C1458180C1458180C1458180C1458180C1458180C1458180C1458180C1458
            180C1458180C1458180C15581B05000000000000000000000000000000000000
            000000000000000000000000000035F7350238F3380B38F3380C38F3380C38F3
            380C38F3380C38F3380C38F3380C38F3380C38F3380C38F3380C38F3380C38F3
            380C3AF13A0900000000000000000000000000000000000000000000000037F4
            370139F2390739F2390736EF3602000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000039F2390739F2390738F43804000000000000000000000000000000000000
            00000000000038F5380538F3380C38F3380C38F3380C38F3380C38F3380C38F3
            380C38F3380C38F3380C38F3380C38F3380C38F3380C38F3380C3BF13B060000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A7D145A1A7C145A
            1A7C145A1A7C145A1A7C145A1A7C145A1A7C145A1A7C145A1A7C145A1A7C145A
            1A7C145A1A7C145A1A7C145A1A7C145A1A7C145A1A7C145A1A80145A1A80145A
            1A80145A1A8014591A60000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A8014591A16000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145A1A16145A1A7D145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A1A80145A
            1A771459192C00000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145C1A021459193A145919401459194014591940145919401459
            1940145919401459194014591940145919401459194014591940145919401459
            1940145919401459194014591940145919401459194014591940145A19311358
            180A0000000000000000000000000000000000000000145A1A68145A1A80145A
            1A80145A1A660000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000014591A62145A1A80145A
            1A80145A1A5F0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000115A1809125B1711125B
            1711135B17040000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155515010F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A
            1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A
            1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A1E020F5A
            1E020D5E1B010000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000001C551C01145A1A0F165A1A1015591910145A
            1A10155A19101559191015591910145A1810155A191014591810145A1910165A
            1A10145A191015591910155A19101559191014591810165A1A1014591810155A
            1910155A1910155A1A101459191017631A0E32D5320639F2390539F2390539F2
            390539F2390539F2390539F2390539F2390539F2390539F2390539F2390539F2
            390539F2390539F2390539F2390539F2390539F2390539F2390539F2390539F2
            390539F2390539F2390539F2390539F2390539F2390539F2390539F2390539F2
            390539F2390539F2390539F2390539F2390539F2390539F2390539F2390539F2
            390539F2390539F2390539F2390539F2390539F2390539F2390539F239050000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1A28155A1A62145A1962145919621459196214591962145A
            1962145A19621459196214591962145A196214591962145A1962155A1962155A
            1962155A1962155A1A62145A1962145A1A62155A1962145A1962145A1A62145A
            19621458192D0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000014591823155A1A7E155A1980145A1980155A
            1980155A1980145A19801459198014591980155A1980155A1980145A19801559
            1980145A1980155A1980145918801559198015591980155A1980155A19801559
            1980155A1980155A1980155A198018671C7628AC2A7038F1386F38F1386F38F1
            386F38F1386F38F2386F38F1386F38F1386F38F1386F38F1386F38F1386F38F1
            386F38F1386F38F1386F38F1386F38F2386F38F1386F38F1386F38F1386F38F1
            386F38F1386F38F1386F38F1386F38F1386F38F1386F38F1386F38F1386F38F2
            386F38F1386F38F1386F38F1386F38F1386F38F1386F38F1386F38F1386F38F1
            386F38F1386F38F1386F38F2386F38F1386F38F1386F38F1386F38F1386D38F2
            3817000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198015591980155A1980145A1A80145A1980155A
            1980155A1A80155A1980155A198014591980155A1A8015591980155A1980155A
            1980145A198015591980155A198015591980155A1980145A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000125B120114581850155A1A8014591980155A1A80155A
            1980145A1980155A1980155A1A80145A1980155A1980155A1A80155A1980155A
            1980145A1980155A198014591980155A1980155A1980155A1980155A19801459
            1980145A1980155A1A80155A1980145A1980249C278038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F2388038F1388038F1388038F2388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A19801459198014591980155A198015591980155A
            1980145A198014591980155A198015591980145A19801559198014591980155A
            1A8015591980155A1980145A198014591980155A1980155A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000001458181014591975145A1980155A1980145A1980155A
            1A80155A1A80155A1980155A1980155A1980155A1980145A1980155A1A80155A
            1980155A1980155A198014591980145A198014591980155A198015591980155A
            198014591980155A198015591980155E1A8030CE318038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F2388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1A38155A1A80155A1A80155A1A8014591880155A1980145A
            198014591980155A198015591980145919801559198014591980145A1980155A
            1980155A1A80155A1980145A19801559198014591980155A1980145919801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155515011559183C145A1980145A1980155A1A80155A1A801559
            19801459198015591980145A1980155A1980155A1980145A1980155A19801559
            1980155A1980155A19801559198015591980155A198014591980155A1980145A
            1980155A1A80155A1A80155919801C7A1F8037EB378038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980145919801459198015591980155A1980155A
            1980145A1980155A1980145A1980155A1980155A198014591980155A1980145A
            1980145A1980155A198015591980155A1980155A1980155A1980155A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000011591B0715591967155A1980145A1880155A1980145A1980155A
            1980155A1980145A1980155A1A80155A1A80145918801559198014591880155A
            1980155A198014591980155A1A801559198014591980155A198014591980145A
            1980155A1980155A19801559198029AF2A8038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980145A1980155A1980155A1980155A
            1A80155A1980155A1980145A1980155A1980155A198015591980155A1980155A
            1980155A1A80145A1980155A1A80145A1880155A198015591980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001558191F1459197D15591980155A1980145A1980155A1980155A
            1980155A1980155A1980155A1980155A1980155A1980145A198015591980145A
            1980155A1980155A19801559198014591980145A1980145A1980155A1980155A
            1980155A1980155A198017651B8033DE348038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980145A198015591980155A19801559
            198015591980155A1980155A198014591980155A1980155A198014591980155A
            1980155A1980155919801559198014591980155A198015591980145919801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000124912011459184F155A198014591980155A1980145A1980145A1980155A
            1980155A1980155A19801459198014591980145A198014591880145A1980155A
            1A80145A1980155A1A80155A1980145A1980155A198015591980155A1980155A
            1980155A1980155A19801F88228038F1388038F2388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F2388038F2
            388038F2388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A198015591980145A1980155A1980145919801559
            1980155A198014591980155A1980155A1980155A1A80155A1980155A1A80155A
            198015591980145A1980155A1980155A1980155A1980155A1980145A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001358160F145919771459198014591980145A1980145A1980145A19801459
            1980155919801459198015591980145A1980155A1A801559198015591980155A
            1980145A1980155A198015591980155A1980145A1980155A1A80145A1980145A
            1980155A1980165C1A802BBB2D8038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F2388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145919801459198015591980155A1980155A1980155A
            1980155A198015591980155A1980155A1980145A1980145A198014591880155A
            198015591980145919801459198014591880155A1980155A1980155A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000001C55
            1C0114591937155A1A801459188015591980155A1980155A198015591980155A
            1A801459198014591980145A198014591980145A1980155A1980155A19801459
            1980155A1980145A198015591980155A1980155A1980155A1980145A1980155A
            1A80155A1980196C1D8036E8368038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F2388038F2388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A1980155A1980155A1980155A1980145A
            1A80145A198015591980155A1980155A1980145A1980155A198015591980145A
            19801559198014591980145A198015591980155A1A80155A1980155A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000001353
            160514591865155A19801459198015591980145A1880155A1980155A1980155A
            1980155A1A80155A1980155A198014591980155A198014591980155919801459
            1980155A1A80155A19801559198015591980155A1A80155A1980155A19801459
            1980155A1980259D278038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F2388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A19381459188015591980155A1980155A1A80145A1980155A
            1980145A1980145A198014591980155A19801459198014591980155A19801459
            1980155A1A8015591980155A1980155A1980155A1980155A1A8015591980145A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000001459
            171B1559197D155A19801559198015591980155A19801459198014591980155A
            19801459198014591980155A198015591980155A1980155A198015591980155A
            1980145A1980155A198014591980155A1980155A1980145A1980155A19801559
            198016601A8031D1328038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F2388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1938155A1980145A1980155A1980155A1980155A1980155A
            19801559198014591980155A1980155A198015591980155A1980145A19801459
            1980155A198015591980155A1A80145A1980155A198014591980145A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000006600011559
            195215591980155A1A8015591980155A1980155A1980155A1A80155A1980155A
            19801459198015591980155A1980155A1980155A1980155A1980155A1A801559
            1980155A1980145A198014591980155A1980155A1A80155A1980145A19801459
            18801C781F8037EC378038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A1980155A1A80145A198015591980155A1980155A
            1980155A1980155A1980155A1A80145A1980145A1980145A198015591980155A
            198014591980155A1A80155A1980155A1980145A1980155A1980155A1A80155A
            1980145818360000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000001457160E1559
            1974145919801459198015591980155A1980145A1980145A1980155A1980155A
            1980155A1980155A19801559198015591980155A1A80155A1980145A1980155A
            19801459198014591980155A1980155A1980155A1980155A1A8014591980145A
            198028AD2B8038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A198015591980155A198015591980155A
            1980145A1980155A1980155A1980155A1980155A1980155A1980155A1980155A
            1980155A1A80155A1A80155A1A80155A1980155A198015591980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000015591939155A
            197F155A198015591980155A1980155A198014591980155A1A80155A1980155A
            1980155A198015591980155A1A801559198015591980155A1A80155919801459
            1980155A1980155A1A80155A1A80145A1980155A1980155A1980155A1A801765
            1B8034DF358038F1388038F2388038F1388038F1388038F2388038F1388038F1
            388038F2388038F2388038F2388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F2388038F1388038F1388038F2388038F2388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388038F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000015591938155A1980155A198014591980145A1980145A1980155A
            198014591980155A198014591980145A1980155A1980155A1980155A19801559
            1980155A1A80155A1980155A198014591980145A198014591980155A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000135B1704155A19611459
            1980145A1980145A1980155A19801559198015591980155A198014591980145A
            198015591980155A19801459198015591980155A198014591880155A1980145A
            1880155A1980155A1A801459198014591980145A1980155A198014591980218B
            248037F0388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F2388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1A80155A1A80155A1A80155A1980155A19801559
            1980145A1980145A1980155A1980155919801459198015591980155A19801559
            1980155A1980155A19801459198015591980155A1A8015591980155A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000001458181B1559197B1559
            1980145A1880145A1980145A1980145A19801459198015591980155A1980155A
            198014591980155A1980155A1A8015591980155A1A8015591980155A1A80155A
            198014591980155A1980155A1980155A198015591980155A1980155C1A802DC3
            2F8038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F2388038F2388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193814591980145A19801459198014591980155A1980155A
            1980145A1980145A1980155A198015591980155A1980155A1980145A19801559
            19801459198014591980155A19801559198015591980155A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000001458194F145A1980155A
            1980145A1980155A1A8015591980155A198015591980155A1980155A1980155A
            1980155A1980155A1980145A1980145A1980155A1980155A1980145A19801559
            1980155A1980155A1980145A1980155A1A80145A1980145A1980196C1D8036E7
            368038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A1980155A1980155A1A80155A1980155A
            1980155A1A8014591980155A1980155A1980145A1980155A1980155A1980155A
            1980155A1A8015591980155A198014591980155A198014591980155A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000001359180D14591976155919801559
            198014591980155A1980155A1980155A198015591980155A1980155A19801559
            198014591980145A1980155A1980155A198014591980155A1980155A1A80155A
            1A80155A1980155A1980155A19801459198015591980155A1980249C268038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193815591980155A198015591980145A1980155919801559
            1980155A198015591980145A198014591980155A19801559198015591980155A
            1980155A1980155A198014591980145A1980145A1980155A1980155A1980155A
            1A80145818360000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000014591834155A197F15591980145A
            1980155A1980155A1980155A1980155A1980145A1980155A1980155A1980155A
            1980145919801459198015591980155A1980155A1980155A198014591980155A
            19801559198014591980155A1980155A1980155A1980165F1A8032D6328038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A198015591980155A1980155A1980155A
            1980155A1A8015591980155A198015591980155A1980155A198015591980145A
            1980145A198014591980145A198015591980145A1980155A1A80155A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000155819041459185D155A1980155A1980155A
            1980145A198015591980145A19801559198014591980155A1980155A1980155A
            1980155A1980155A1A80145A19801559198015591980155A1980145A19801459
            198014591980155A1980145A1980155A1980145A19801D7E208037EC378038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F2
            388038F1388038F2388038F1388038F2388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A3814591980155A1980155A19801459198015591980155A
            1980145A1980155A1980155A1980145A198015591980145A198014591980155A
            19801559198014591980155A1980145A1980155A1980155A1980155919801559
            1980145819360000000000000000000000000000000000000000000000000000
            00000000000000000000000000001558171C1459197B155A1980155A1980145A
            1980155A1980155A1980145A1980155A1980155A1980145A1980145A1980145A
            1980155A1980145A1980145919801559198015591980155A1980155A1A80155A
            1980155A198014591980145A198014591980155A198029B22B8038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F2388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A1980155A1980155A1A80155A1A80145A
            1980155A1980145A1980155A1980155A1A8014591980155A1980145A1980155A
            1980145919801559198014591980155A198014591980155A1980145A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            00000000000000000000006619011459184A155A198014591980155A1A801459
            1980155A198015591980145A1980155A1980155A1980155A198015591980155A
            1A80145A1880155A1980155A198014591980155A1980155A1980145A1A80145A
            198014591980155A1A80155A19801459198018651C8033DD348038F1388038F2
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1387C38F1387738F1387738F1387738F1387738F1387738F2387738F1
            387738F1387738F1387738F1387738F1387738F1387738F1387738F1387738F2
            387938F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F2388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193814591980155A198014591980155A1980155A1980155A
            1980155A1980155A1980155A1A80155A19801559198014591980155A1980155A
            1A80155A198014591880155A198015591980155A1980155A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000013581809145919731559198014591980145A1A801559
            1980155A1980145A1980155A1A8015591980155A1980145A1980155A1980145A
            1980155A1980155A198015591980145A198014591980155A198014591980155A
            1980155A19801559198014591880155A1980208E248038F0388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            387238F1381C3BEF3B093BEF3B093BEF3B093BF13B0939EF39093BEF3B0939EF
            39093BF13B093BEF3B093BEF3B093BEF3B093BEF3B093BEF3B093BEF3B0939F1
            392238F2388038F2388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980145A198015591980155A1A801459
            1980155A1A80155A1A80155A1980155A1980145A1980155A1980155A1980155A
            1980155A1A80155A1A80155A1980155A1980155A1980155A1980145A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            000000000000000000001458182D155A197F1559198015591980155A19801459
            1980155A1980145A1980145A1980155A1A80145A198014591980145A1980145A
            198015591980145A198015591980155A1980155A198014591880145A19801459
            19801559198015591980155A1980155C19802FC7308038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F2388038F2386A38F2
            380F000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A1A80155A1980155A1980155A1980165A
            1A8014591980155A1A80155A1980155A1980155919801459198014591980155A
            1980145A198014591980155A1980155A1980155A1A80155A1980155A1980155A
            1980145819360000000000000000000000000000000000000000000000000000
            0000000000000C5112031459185E145A19801459198015591980155919801559
            1980155A1980155A1980155A1A8014591980155A1980155A1980155A1A801559
            1980155A198014591980155A1980145919801559198014591980155A1A80155A
            198015591980155A1A80155A1A801A701E8036EA378038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F2386738F4380A0000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F2388038F1388038F1388038F2388038F1388038F2
            388038F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1938145A1980145A1980145A1980155A198015591980155A
            1A80155A1A80155A1980155A19801559198014591980155A1A80155A1980155A
            1980145A1980155A198015591980145A198015591980155A1A80155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000001459181A1459197A155A1980155A198014591980145A1980155A
            1980155A1A80155A198014591980145A1980155A1980145A1980145A1980155A
            19801559198014591980155A1980145A1980145A198014591980145A1980145A
            1980155A1980155A1A80145A1980259F278038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2385A37EF3706000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193814591980145A19801459198015591980155A1980145A
            1980155A1980155A1980145A198015591980155A1980155A1980155A19801559
            198014591980155A198015591980155A19801459198014591980145919801459
            1880145818360000000000000000000000000000000000000000000000000000
            0000125B12021558184715591980145A1980145A1980155A1980155A1980155A
            1A80155A1A80155A198015591980155919801559198015591980155A1980155A
            19801559198014591980155A1980155A198015591980145A1980145A1980155A
            1980155A1980155A198017601B8030D0318038F1388038F1388038F1388038F2
            388038F1388038F1388038F2388038F2385C37F2370600000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980155A1980145A1980155919801559
            1980155A1A80155A1980145A1980155A1980155A198014591980155A1980155A
            1A80155A1A80155A198014591980155A1A80155A1980155A1A80155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000135A150A1559196E155A1980145A198014591880155A198014591980155A
            1980145A1980145A1980155A1980155919801459198015591980155A1980145A
            198014591980155A1980145A198014591980145A1980155A1980145918801459
            1980155A1980145A19801D7F218037EF378038F1388038F1388038F1388038F1
            388038F1388038F1388038F2384B3AEE3A020000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F1388038F2388038F2388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001559193814591980155A1980155A1980155A1A80155A1A80145A
            1980155A1A801559198014591980155A198015591980155A1980145A1980155A
            1980155A1980155A1980155A1980155A198014591880155A1980155A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            00001559182A1559197F15591980155A1980155A198014591980145A1980145A
            1980155A1980155A198014591880155A1980155A1980145A1980145A19801459
            19801459198015591980155A198015591980155A1980155A198015591980155A
            1980145A1980155B19802AB42C8038F1388038F2388038F1388038F2388038F1
            388038F1387F37F2374030EF3001000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F3
            381E38F2388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980155A1A80155A198015591980145A
            1980155A19801459198014591880155A198014591980155A1980145A1980155A
            198014591980145A1980155A1980155A1A8015591980155A198014591980155A
            1980145819360000000000000000000000000000000000000000000000001355
            13021459185B155A198014591980155A1980155A1980155A1980155A19801559
            1980145A19801459198015591980145A198014591980145A1880155919801459
            198014591980155A1980145A1980155A1A80145A1980155A1980155A1980155A
            1980145A198018681C8034E0358038F1388038F1388038F1388038F2388038F1
            387E38F2383B0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F2388038F2388038F1388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A19381459198015591980155A1980145A1980155A1980145A
            1980155A1980145A19801559198015591980155A198014591880155A1A801459
            198014591980155A1980145918801559198015591980155A1980145A1980145A
            1880145718360000000000000000000000000000000000000000000000001358
            18171459197B1459198015591980155A1980155A1980155A1980155A1980155A
            1980145A1A8014591880145A1980155A1980145A1980145A1A80155A1980145A
            1980155A1980155A198015591980155A1980155A1980145A1980155A1980155A
            198014591980208B238038F0388038F1388038F1388038F1388038F1387D37F1
            372A000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038EF
            381E38F0388038F1388038F1388038F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198015591980155A1980155A198014591980155A
            198015591980155A1980155A1980155A1980155A1A80155A1980145A1980145A
            1980155A1980155A1A8015591980145919801559198014591980155919801559
            1980145818360000000000000000000000000000000000000000105010011459
            19431559198014591880155A1A80155A1A80155A198015591980145A1980155A
            1980155A1A80155A1980155A1980145A1980155A1980155A1980155A1980155A
            19801559198015591980145A1980155A1980155A1A8015591980145A19801559
            1980155C1A802DC22F8038F1388038F1388038F2388038F1387938F338240000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000036E7
            361E37EA378038EE388038F0388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F2388038F1388038F1388038F2388038F1388038F2387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1938155A198015591980145A198014591980155A1980145A
            198014591980145A1980155A1980155A1980155A19801459198014591880155A
            1980145A198014591980155A198014591980155A1980155A1980155A19801459
            1980145818360000000000000000000000000000000000000000135718091459
            196C145A1980155A1980155A1980155A1980155A1980155A1980155A1980155A
            198014591980145A19801559198015591980155A19801459198014591980155A
            1980155A1980145A1980145A1980155A198015591980155A1980155919801559
            19801A711E8036E8368038F1388038F1388038F1387638F2381D000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000033DA
            341E34DE348036E5368037EB378038EF388038F0388038F1388038F2388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A19801559198014591980155A1A801459
            1980155A198015591980155A1980145A1980145A1980155A198014591980155A
            1980155A1980155A1A80155A198015591980145A1A8014591880155A19801459
            1980145818360000000000000000000000000000000000000000145818271559
            197E155A198015591980145A1880145A1980155A1980155A1A8015591980155A
            198014591880145A198015591980145919801559198015591980155A1A80145A
            1980155A1980155A1980155A1980155919801559198015581980155819801558
            1980259F288038F1388038F1388038F1386C36F3361100000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002FCD
            321E31D1328033D8338034E0358035E6368037EB388037EE378038F0388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A198014591980155A198015591980155A1980145A
            1980155A1980145A1980145A1980145A1980155A19801559198015591980155A
            1980155919801459188015591980155A198014591980155A1980155A1980145A
            198014581836000000000000000000000000000000000E390E011459195E155A
            1980145919801559198015591980155A1980145A1980155A1980155A1980155A
            19801459198014591980145A1980155A198015591980155A1980145A19801459
            198014591980155819801458198014571880155719801556198014551880165B
            198031D2328038F1388038F2386B38F3380F0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002FC8
            301E2FC9318030CC328031D1328033D9348034DF358035E5368037EB378038EE
            388038F0388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A3815591980155A1980155A198015591980155A1980155A
            19801559198015591980155A1980145A1980155A1A80155A1A8014591980145A
            1980155A1980155A1980155A1A80155A1980155A198015591980155A19801559
            19801458183600000000000000000000000000000000155916141559197C145A
            1980145A1980155A1A80145A1980155A1980155A1980155A1980155A1A80155A
            1A80155A1980155A1A80155A1980155A19801459198015591A80155819801458
            1980145719801556198015551980145518801453188014521880145118801C74
            1F8037ED378038F2386138F43807000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000002EFF2E0137F1
            374234E135802FCC31802FC7318030CB318031D1338032D8348034E0358035E6
            368037EB378038EF388038F1388038F1388038F2388038F2388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193815591980155A198014591980145A198014591980145A
            1980155A1980155A1980145A1980155A198015591980155A198014591880155A
            1980155A19801459198014591980155A198014591980155A1980155A1A801559
            1980145819360000000000000000000000000000000013591842145A19801559
            19801459198015591980155A1A80155A1980145A1980155A1980145A19801459
            19801559198015591A8015581A80145818801557198015571980155618801455
            188014541880145218801451188014501880144E1880144D1880144C18802AB0
            2B8038F2385B36F4360300000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000037F2370E38F3385E38F1
            388038F1388037EC378031D533802FC730802EC7308030CC328031D1338033D9
            348034E0358036E8378037EC378038F0388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F1388038F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A1980155A1980145A1980145919801559
            198014591980155A1980145A1980145A1980155A1980155A1980145A1980155A
            1980155A198014591980145A1980145A1980155A1980155A1980155A19801559
            197D145919220000000000000000000000000E5A18071459196C155A1A80155A
            1980155A1980155A1980155A198015591980155A19801559198015591A801558
            198015571A8015571A8014561980155519801554188014531880145118801450
            1880144F1880144D1880144C1880144A1880144917801449188017581A8031D3
            324F39F839020000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000037F2372838F1387438F1388038F1
            388038F2388038F1388038F0388035E436802FCB31802EC430802EC7318030CD
            328031D4338034DC358036E4368037EB378038EF388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F2388038F1388038F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193815591980155A1980155A1980155A1980145A1A80155A
            1980145A1980155A1980155A1980155A1A8015591980145A1980155A1980145A
            1980155A1980155A1A80145A1980155A1A8015591980155A1980155A19801559
            196A14561806000000000000000000000000155819261459197F145A1980155A
            19801459198014591980155919801559198015581A8015571980155619801555
            198014541880145318801452188014501880144F1880144E1880144C1880144B
            1880144A18801449178014481780144717801446178014471880185F1B611F7D
            2503000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000003AF63A0438F2384238F1387E38F1388038F2388038F1
            388038F1388038F1388038F2388038F1388037ED378032D733802EC630802EC5
            30802FC9318031D0328033D9348034E1358036E9368037ED378038F0388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A198015591980155A1A80145A19801559
            1980145A198014591980155A1980145A198014591980155A1980155A19801459
            19801459198015591980155A1980155A1A801459198015591980145919801559
            183A000000000000000000000000004E27011458195D145A1A80145A1A801459
            1980155819801458198015571980155619801555188015541880145218801451
            1880144F1880144E1880144C1880144B1780144A178014491780144817801447
            1780144617801446168014471780144A178014501880145519801458186B1558
            1928185318030000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000036F1361038F2386038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F2388038F1388038F1388038F1388035E3358030CD
            32802EC530802FC7318030CD328031D5338033DD358035E5368037EB378038EF
            388038F0388038F1388038F1388038F1388038F2388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198015591980155A1980155A1980155A1980145A
            1980155A1980155A1A8014591980155A1A80155A1980155A1980155A1980155A
            1A801459198014591980155A198014591980145A198014591980145919751359
            170E000000000000000000000000135617131458197A15581980155819801557
            19801557198014551980145418801452188014511880144F1880144E1880144C
            1880144B18801449178014481780144717801447178014461780144516801448
            1780144C1780145218801556198015591A80155A198014591980155A19801459
            1878145919461257190B00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000002EE8
            2E0137F2372A38F2387738F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388037ED
            378033D933802EC430802EC630802FCB318031D1328033DA348035E2358036E8
            368037ED388038F0388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193815591980155A1980155A1980155A198014591980155A
            198014591980155A1A80145A1980155A1980145A1980155A1980145A1880155A
            1980155A1980155A1980155A1980155A1980155A1980155A19801458194E0E55
            1C010000000000000000000000001557193F1557198014561980145519801454
            18801452188014511880144F1880144D1880144C1880144A1780144917801447
            17801447178014461880144517801446178014481780144E1880145418801558
            1980155A1980155A1980155A1980145A198015591980155A1A8015591980145A
            19801459197F155919601358181F145714020000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000035F1350738F1
            384F38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388035E6368030CD32802EC530802EC8308030CD328032D4338033DC
            348035E4368037EA378038EE388038F0388038F1388038F1388038F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A1980155A1980155A198015591980145A
            198015591980155A1980155A1A80155A198014591980155A1980155A1980145A
            198015591980145A1980155A1980155A1980155A19801559197C135918200000
            0000000000000000000014531C06155518691454188014521880145118801450
            1880144E1880144C1880144B1780144917801448178014471880144617801445
            178014451680144A178014501880145519801458198014591980145A1980145A
            1980155A1980155A1980145A198015591980145A1980155A1980145A1980145A
            1980145A1980155A1980155A19701559193A1455190700000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000038F2381838F2386638F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F2388038F1388037EE378033DA34802EC630802EC530802FC9318031CF
            328032D6338034DF358036E7378037ED378038F0388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A19381559198014591880155A198014591980155A1980155A
            198014591980155A1980155A1980145A1980145A1980155A198015591980155A
            198014591980155A1980155A1980155919801559198014591966145817060000
            00000000000000000000155118261451187E144F1880144E1880144C1880144A
            1780144917801448178014471780144618801446188014471780144C17801452
            18801557188014591980145A1980155A1A80155A198014591980155A1980155A
            1980155A1980155A1A80155A198015591980145A198015591980155A1980155A
            198014591980155A1980155A19801459197C1459185813581714105010010000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000038F2382E38F2387A38F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F2388038F2388038F1388038F1388038F2
            388038F1388038F1388038F2388038F0388036E7368030CD32802EC430802EC6
            30802FCB318031D1328033DB348035E4368037EB378038EF388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000015591938145A1980155A198015591980155A1980145A1980155A
            198015591980155A1A80145A198014591980155A198014591980155A1980155A
            1980155A1980155A1980145A1980145A1A801459198015581930000000000000
            0000000000000C491803144C1756144C1780144B188014491780144817801447
            1780144616801446178014491780144E1880145418801559198014591980155A
            1A80155A198015591980155A1980145A198015591980145A1980155A1980155A
            1980155A19801559198015591980145A198014591980155A1980155A1980155A
            1980155A1980145A1980145A198014591980145A197F14591970145818301254
            1604000000000000000000000000000000000000000000000000000000000000
            0000000000000000000035F0350438F2385338F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388037EE378033DB34802EC4
            30802EC430802EC7308030CE328032D7338035E2358036EA378037EE387F37F0
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A188014591980155A198014591980155A1980155A
            1980155A1980155A1A80155A19801459188015591980155A1980155919801559
            1980155A1980155A1A8014591980155919801559197213581B09000000000000
            000000000000124917131448177814471780144717801446178014471780144B
            1780145018801555198015591980155A1980155A19801459198015591980155A
            1980145A19801459198014591980145A1980155A1980155A1980155A19801459
            19801459198014591980155A1A8014591880155A1980145A198014591980155A
            1980145A1980155A198015591980145A1A8014591980155A1A801459197C1459
            1951125717101555150100000000000000000000000000000000000000000000
            00000000000038F3381B38F2387038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388036E9
            378030CB32802EC330802EC5308030CB318032D4338034DE358036E6367F36EA
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A19381459198015591980155A1980155A198015591980155A
            1A80155A1980145A1980155A1980145A1980155A1A80155A1980155A19801459
            198014591980145A1980155A1A80155919801559194700000000000000000000
            0000000000001345173E1446177F14481780144D178015521880145719801459
            1980155A1980155A1980145A198015591980155A198015591980155A19801459
            1980145A1980155A1980145A198014591980155A19801459198014591980155A
            1A801459198015591980145A1980155A1980155A1A80155A1980145A19801559
            1980155A19801559198015591980155A198015591980155A1A80155A19801559
            19801559196813591913000000000000000000000000000000000000000037FF
            370138F1383D38F1387C38F1388038F2388038F1388038F1388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388037EF388033D834802EC631802EC330802FC9318031D1338033DA347F34E0
            351C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A198015591980155A1980145A198014591980155A
            1A80145A1980145A1980145A1980155A1980155A1980155A1A80145919801459
            1980155A1980155A1A80155A19801559197A1459181E00000000000000000000
            0000124F1505144E18671554198014581980155A198014591980155A1980155A
            1980145A198014591880155A1980155A1980145A1980155A1980155A19801459
            1980155A1980155A1980145A1A8014591980155A1980155A1980145A1980145A
            1980155A1980155A1980155A1980155A1980155A1980155A1A80155A1980155A
            1980155A1980155A1980165A1A80155A198015591980155A1980155A1980155A
            19801559197C1359191D0000000000000000000000000000000038F4380E38F2
            385438F1388038F1388038F1388038F1388038F2388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388036E7368030CE32802EC230802FC7318030CD327F31D2
            321C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A1980155A1980155A1980155A1980155A
            1980155A1980155A19801459188014591980155A1A80155A1980145A1980155A
            1980155A1A80145A1980155A1980155918600E5C150200000000000000000000
            0000165716051458193B1559197414591880155A1A80155A1A80155A1980155A
            1980145A1980155A1980155A19801459188015591980155A198014591980155A
            1A80155A1A8015591980145A1980145919801459198015591980145A1980155A
            198015591980145A1980155A1980145A1980155A1A80155A1980155919801559
            1980155A1980155A1980145A198014591980155A19801459198015591980155A
            19801459197C1359191D00000000000000000000000038F2381F38F1387238F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F0388033DB34802FC530802EC4307F2EC6
            2F1C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1A38155A1980145A198015591980155A1980155A1980155A
            1980155A1980155A1A80155A1980145A198015591980155A1980155A1A80155A
            1980155A1980155A19801559197E1659182A0000000000000000000000000000
            000000000000164D1601155918211459195D1559197F14591980155A1980155A
            19801559198015591980155A1980155A1980145A1980155A1A80155A1980145A
            198014591980145A198014591980145A198014591980145A1980155A1980155A
            1980155A1980155A1980155A19801559198015591980145A1980145919801559
            1980155A1A8015591980155A1980155A1980155A1980155A1980155A19801559
            19801559197C1359191D0000000035F4350137F2374038F2387F38F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F2388038F2388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388036E7368031D1337F2EC2
            2E1C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A19801459198014591980145A1880155A1980155A
            1980155A1A80155A1980145A198014591880145A1980155A1980155A1980145A
            1980155A1A8015591980155A197B1458191E1959190100000000000000000000
            00000000000000000000000000001257160B145A18401459197714591980145A
            198015591980155A198015591980155A1980155A1A801559198015591980145A
            1880155A1980145A1980155A1A80155A198014591880155A1980155A19801559
            1980145A1980155A1A80155A198015591980155A1A8015591980145A1980155A
            1980145A1980145A18801559198014591980145A198014591880155A1980145A
            19801559197C1359191D38F3380D38F2386238F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F1388038F1388038F1387F38EE384B36E4
            3602000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A1980155A198015591980155A1980145A
            1980155A1980155A1980155A1980145A1980155A1980155A1980145918801459
            19801559198015591980155A1980155A196A1359181E00000000000000000000
            0000000000000000000000000000000000001351180314591921155919631459
            197F155A1980155A1A8015591980145A1980155A198014591980155A1980155A
            1A8015591980155A198015591980145A19801559198015591980145919801559
            1980165A1A80145A198014591980145A1980155A1980155A1980155A19801459
            1980155A1980155A1980155A1980145A1980155A1A80155A1980155A1A80155A
            19801559197C28AF294238F1387338F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F2388038F1388038F1388038F1
            388038F2388038F2388038F2388038F1388038F1387838F23828000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198015591980155A198015591980145A1980155A
            198014591980155A198015591980145A1980155A1980145A1880145A1980155A
            1980155A1980155A198014591980155A198015591971135A1820105218020000
            00000000000000000000000000000000000000000000000000001459190C1559
            19471459187814591980155A1980155A1A80145A1980155A1980155A19801559
            198015591980155A1A80155A1980155A1980155A1980155A1980145A1980155A
            1980155A1980145A19801559198015591980155A1A80155A1980145919801559
            198014591980145A188014591880155A1980155A1980145A1980155A1980155A
            1980165E1A8030CF318038F1388038F2388038F1388038F2388038F1388038F2
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1386039F1390D00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A1980155A1A80155A1980155A1A80145A
            19801459198015591980145A1980155A1980155A198015591980145A1980155A
            1980145A1980155A19801459198014591980145A198015591970145919260000
            0000000000000000000000000000000000000000000000000000000000000D4F
            13021458182914581867155A197E155A1980155A198014591980155A1980145A
            1980155A1A80145A19801459198014591980155A1980155A1980145919801459
            1980155A19801459198014591980155A1A80155A1980155A1980155919801459
            1980155A1980155A1980155A1980155A19801559198015591980145A19801559
            1980165F1A8030CF318038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F2388038F2
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F2388038F2388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2383B37F037060000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A1980155A1A80155A198014591980155A
            1A80155A198015591980145A1980145A198014591980145A1980155A1980145A
            1980145A19801459198014591980145A1980145A1980145A1980145918731558
            1829155515010000000000000000000000000000000000000000000000000000
            000000000000135818111559194C1559197C1559198015591980145A1980155A
            1980155A1980145A198015591980155A1980155A198015591980155A1980145A
            1980155A1980155A1A80155A198015591980155A198014591980145A19801459
            1980155A1A80155A1980155A1980155A1980145A1980155A1980155A19801459
            1980165F1A8030CE318038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2387338F3382700000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A198014591880155A1980155A1980155A
            1980145A1980145A1980145A198014591880155A1980145A1880145A1980155A
            1980155A1980155A1980155A1980155A1980155A1980155A1980155A19801459
            1976145818230000000000000000000000000000000000000000000000000000
            000000000000000000000B531603155A192D15591A6C1459197F155A19801459
            1980145A1980145A1980155A198014591880155A1980155A198015591980155A
            19801459198014591980155A1980155A1980145A1980155A1980145A1980145A
            1980145A1980145A1980155A1A80155A1980155A1A80145A198015591980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            385A36F2360A0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1938155A1980155A1980155A1A80155A1980155A19801459
            1980145A1980145A1980145A1980155A1A80155A198015591980155A19801559
            1980155A1A8015591980155A1980155A1980145A198014591980145A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            00000000000000000000000000001555150113581913155919501559197B145A
            1980145A198014591980145A1980155A198015591980155A1980155A1980155A
            1980145A1980155A1980145A1980155A1980155A1980145A198014591880145A
            1980155A1980155A1980155A1980155A1A80155A1980145A1980145919801459
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F2388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1387C38F2383C0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A1980155A1A80155A1980155A1A80155A19801459
            1980145A1980145A198015591980155A1980155A1980155A1980155A1980155A
            1980155A1980155A1A8014591980155A1980155A1A80155A1980155A1A80155A
            1980145818360000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000155318071459182F1459
            1970145A197F15591980155A1A8014591980155A198014591980155A1980155A
            1980155919801559198014591980155A19801559198015591980155919801459
            198015591980155A1980145A1980145A1A8015591980155A1980145918801459
            1980165F1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F2388038F1388038F1388038F2388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F2387438F23821000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A19381559198015591980145A198014591980155A1980155A
            1A80155A1980155A1980155A1A80155A1980145A1880155A198015591980155A
            1980155A1980155A198015591980155A1980155A198014591980145A1980155A
            1A80145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000001458
            181714591857145A197E155A19801459198014591980155A1980145A1980145A
            1980155A1980155A1980155A198015591980155A1980155A1980155919801459
            1980155A1980155A1980155A1980155A1980155A1980155A198014591980155A
            1A80165E1A8030CF318038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2385637F3370B00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980145A1980155A1A80155A1980145A
            198015591980155A1980155A1980155A1980155A1A80155A1980155A1980155A
            1980155A1980155A1980155A1980155919801559198015591980145A19801559
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000155A19081458193714591976155A1A80145A1980155A1980145A1980145A
            198014591980155A1A8014591980155A1980155A198014591980155A19801559
            1980155A1980155A19801459198014591880145A1980155A1980145919801459
            1980175F1A8030CF318038F1388038F2388038F2388038F1388038F1388038F2
            388038F2388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1387A37F23738000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A1980155A1980155A1980155A19801559
            198014591980155A19801559198015591980155A1A80155A1980155A1A801459
            1980155A198014591880155A198015591980145A1980145A1980145A1980155A
            1A80145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000145414031559195915591980145A1980155A1980145A1980155A
            198014591880155A1980155A1980155A198015591980145A1980155A1980155A
            1980155A1980155A198014591980155A1980155A19801459198015591980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F2388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1386B38F3381700000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198015591980155A1980145A1A80145A19801559
            1980155A198014591980155A1980145A1980155A1980155A1980155A19801459
            1980155A1980155A1980155A198015591980155A1A80155A1A80155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315581958155A1980155A198014591980155A1980155A
            198014591980155A1980155A1980145A1980155A1A8014591980155A1980155A
            1A80155A1980155A198014591980145A1980145A1980155A1980155A1A80155A
            1980155E198030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F2388038F1388038F1388038F2388038F1388038F1388038F1387D38F2
            38553FF23F040000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193814591980155A1980145A1980155A1980145A1980145A
            198014591980145A1980155A1980155A1980145A198014591980155A1A80145A
            1980155A1980145A1980155A1980155A1980155A1980155A198015591980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000115711031558195815591980155A19801559198015591980145A
            1980155A198014591980155A1980155A198014591880155A1980155A1980155A
            198014591980145A1980155A1980145A19801459188015591980145A1A80145A
            1980165E1A8030CE318038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1387938F2382F33EE
            3301000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A1A80155A1A80155A1980155A1980155A1A80155A
            1A80155A1980155A1980155A1980155A1A801559198015591980145A1980155A
            1980155A1980155A1980155A1980155A1980155A1A80145A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1A80155A1980155A1A80155A1980155A
            1A8014591980155A1980155A1980155A1980155A1A80155A1980155A1980155A
            1980155919801559198014591980155A1980155A1980145A1980155A1980145A
            1980165E1A8030CF318038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F2
            388038F1388038F1388038F2388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1386838F33816000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A198015591980145A1980155A1A80145A1A801559
            1980155A1A8015591980155A1980145A1A80155A198015591980145A1980155A
            1980155A1980145A1980155A1980155A1980155A1980155A1A80155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A198014591980155A1980155A1A80155A
            1980155A1980155A1980155A1980155919801459198015591980155A1980155A
            1A80155A198014591880155A1980155A1980155A198014591980145A1980155A
            1A80165E1A8030CF318038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1387F38F2384834F4340300000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000037F0370738F1384436F1
            360C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A1980155A1980155A198015591980155A1980155A
            198015591980145A1980155A1980155919801559198015591980155A1A801559
            1980155919801459198015591980145A198015591980155A1980155A19801559
            1980145819360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315581958155A1980155A1980155A1980145A19801559
            1980155A1980145A1980145A1980145A1980155A1980155A1A80145A1980155A
            1980155A198014591980155A1A8015591980155A1980145A1980155A19801559
            1980155E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F2388038F2387837F23729000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000037F3372D38F2387338F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A198015591980145A1980155A1980145A
            1980155A1980145A198015591980155A1980145A1980155A1980155A1980155A
            198015591980145A1980155A1A801459188014591980155A1980145A19801559
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1980155A1980145A198015591980155A
            1980155919801459198014591980145A1980155A1A80155A1980155A1980155A
            198014591980155A1980155A198015591980155A1980155A1980155A19801559
            1980165E1A8030CF318038F1388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1386637F2371100000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000037F2370C38F2385438F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A198015591980155A1A8014591980155A19801459
            1980155A1980155A198015591980145A1980145A1980155A1980155A1A80155A
            1980155A1980145A1980155A1A8015591980155A1980155A1A80155A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1980155A1980155A198015591980145A
            1980155A1A80155A1980145A1980155A1980155A198015591980155A19801559
            1980145A1A80155A1980145A1980145A1980155A1A80155A1980155A19801559
            1980165E1A8030CF318038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F38F1
            384239F239050000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000038F2383138F2387538F1388038F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198014591980145A1980145A1980145A1980145A
            1980155A1980155A1980145A198015591980145A1980155A1980155A1A801459
            1980155A1980155A1980155A1980155A1980155A1980155A198014591980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1980155A1A80155A1980155A1980155A
            1980155A198015591980145A198014591980145A19801459198014591980155A
            1980155A1A80155A1A80145A198014591980155A1A80145A1980155A1980155A
            1980155E1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1387238F238230000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000037F3
            371138F2385838F2387F38F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980145A1980155A1980155A1980155919801459
            198015591980155A1980155A1980155A198015591980155A1980155A1A80155A
            19801459188015591980145A198015591980145A1980155A1A8014591880155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1980155A1980155A1980155A1A80155A
            1A80145A198014591980155A19801559198015591980145A1980155A1980155A
            1980155A1980145A198015591980155A1980155A1980155A1980145A1980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2385C38F3380D000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000030EF300137F1373138F1
            387638F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193814591980155A1980145A1980155A198015591980155A
            1980155A1980155A1980145A1980145A1980145A1980155A1980155A1980155A
            1980145A1980155A1980155A198014591980155A1980155A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1980155A1980155A198015591980155A
            1A80155919801459188014591980145A1980155A1980155A1980145A19801459
            198015591980145A1980155A1980155A1980155A1A80145A1A80155A1980145A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F2388038F2388038F2388038F1388038F1
            388038F1388038F1388038F2387D38F2384033F6330200000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000035F3350D37F1375038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193814591980155A19801459198014591880155A1A80155A
            198014591980145A1980155A1980155A1980155A1980155A1980155A1980155A
            1980145A1980155A1A80145A1980155A1980145A1980155A1980155A1A80155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000115711031559195814591980155A19801459188014591980155A
            198015591980145A1980155A1980155A198015591980155A198014591980155A
            1980155A1980145A19801459198015591980145919801559198014591980155A
            1A80165E1A8030CF318038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2387438F23822000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000038F2382E38F2387638F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A198014591980155A198015591980155A
            1980155A1980155A19801559198015591980155A198014591980155A1980145A
            1980145A1880155A1A80145A1980155A198015591980155A1980145A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A1A8014591980155A198015591980155A
            198014591980145A1980155A1A8015591980155A1980155A1980155A1980145A
            1980155A1980155A1980145A198014591980145A1A801559198015591980145A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F2388038F2388038F1388038F1388038F1
            388038F2385339F4390800000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000039F4390D38F1385738F1388038F2388038F2388038F1388038F2
            388038F2388038F1388038F1388038F2388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193815591980155A1980155A1980155A1980155A1980155A
            1980145A1980145A19801559198015591980145A1980155A198015591980155A
            1980145A1980145A198014591980155A1980155A1980155A1980145A1980145A
            1980145819360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110314591958155A1980155A1A80155A1980155A1980155A
            1980155A198014591980145A1980155A1980155A1980155A1980145A1980155A
            1A80155A198015591980155A198014591980155A19801459188015591980155A
            1980165E1A8030CE318038F2388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F2388038F2387937F2
            373B2AFF2A010000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000037ED
            370138F2383038F2387A38F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980155A1980155A1980155A1980155A
            1980155A1980155A1A80155A1980145A198015591980155A1980145A19801559
            198014591880155A1A80145A1980145A1980145A1980155A198014591980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000011571103155919581459198014591980145A1980155919801459
            1980155A1A80155A198014591980145A198015591980155A1980155A1980155A
            1980145919801559198014591980155A1980145A1980155A1980155A1980155A
            1980165F1A8030CE318038F2388038F1388038F2388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1386D38F2381C0000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000037F3371238F1
            385C38F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A19381559198014591980145A1980155A1980155A19801559
            1980155A198014591980155A1A8015591980155A198015591980155A19801459
            198014591880155A1980145A198015591980155A198015591980145A19801459
            1880145819360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000115711031559195815591980155A1980155A1980155A1980145A
            1980155A198015591980155A1A80155A1980145A1980155A198015591980155A
            1980155A1980145A198015591980145A1980155A1A8015591980155A1A80155A
            1980165E1A8030CF318038F2388038F1388038F1388038F2388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2385A36F33609000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000033F5330338F2382E38F2387838F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001559193814591980155A198014591880145A1980155A1980155A
            1980155A1980155A1980155A1980155A198014591980155A198015591980155A
            1980155A1980155A1A80155A1980155A1980155A198015591980145A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958145A1980155A1980155A1980155A1980155A
            1980155A1980155A1980155A1980155A1980145A198014591980155A19801459
            18801559198014591980145A198014591980155A1980155A1980155A1980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2387A37F237310000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000037F4371037F2376138F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1938155A198014591980155A1980155A1980155A1980145A
            1980155A1980155A1980165A1A80155A1980145A1980155A198014591980155A
            1980155A1980145A198015591980155A198015591980155A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000115711031559195814591980155A1A80145A1980155A1980155A
            1980155A19801459198015591980155A19801559198014591980155A1980155A
            1980155A1980145A1980155A1980145A1980145A1980145A1980145A1980155A
            1980155E1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2386A38F43813000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000003BF53B0238F3383038F2387938F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2388038F2
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A38155A1A8014591980155A1A80155A1A80155919801559
            1980155A1980155A198015591980155A1A8015591980155A198014591980155A
            1980155A1A8014591880155A1A80155A1980155A1980145A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315581958155A198014591980155A1980155A1980155A
            1980145A1A80155A1980145A198015591980155A1980145A1980155A1980155A
            1980155A19801459198014591980155A1980155A19801459188014591980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F2
            388038F2387034F4340500000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000038F4380D38F1385938F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F2388038F1388038F2388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1938155A1980155A1A8015591980155A1980145919801459
            1980145A1980155A1980145A1980155A1980145A198014591980155A19801559
            19801459198015591980145A1980155919801459198015591980155A1980145A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315581958155A198014591980155A1980155A1980155A
            1980155A1980155A1980155A1980155A1A80155A1980155A1980145919801559
            1980155A1980155A1980145A1980155A1980155A1980145A1980155A19801459
            1980165E1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381638F2387D38F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1A38145A1980155A1980155A1A80145A198015591980155A
            198015591980145A1980155A1A80145A1980155A198014591980145919801459
            1980145A1980155A1980155A198014591980145A1980155A1980155A19801459
            1980145819360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A198015591980155A1980145A1980155A
            1980145A188015591980145A1980155A1980145A1980155A1980155A19801559
            1980155A1A8015591980155A1980155A1A80155A1980145A1980155A1980155A
            1980165E1A8030CE318038F1388038F2388038F1388038F1388038F1388038F1
            388038F2386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F2388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F2388038F2388038F1388038F2388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A19801459198014591980155A1980145A1980155A
            1980155A1980155A1980155A1980155A198014591980155A1980155A19801559
            1980145A198015591980145A198015591980155A1980155A1980145A19801459
            1880145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958155A198014591880155A198015591980145A
            1980155A1980155A198014591980155A19801559198015591980155A1A80155A
            1980145A1980145A1980155A198014591980155A1980155A1980155A1980155A
            1980165E1A8030CF318038F1388038F2388038F1388038F1388038F1388038F2
            388038F1386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F3
            381E38F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A19801559198014591980155A1980155A19801559
            1980155A1980155A1A80155A1A8015591980145A1980145A1A80155A1A801559
            1980155A1980155A1980155A1980155A1980155A1980155A1980145A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000011571103155919581559198015591980155A1980155A19801559
            1980155A1980145A1980155A1980155A1980155A1980155A1980155A1980155A
            1A80155A1980155A1980155A1980155A19801459198015591980155A1980145A
            1980165E1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F2388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980145A1980155A1980155A1980145919801559
            1980155A1A80145A1A80155A1980155A1980145A1980155A1A8014591980155A
            1980145A1880155A19801459198014591980155A1A80155A1980155A1980145A
            1980145819360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000115711031558195815591980145A1980155A1A80155A19801559
            1980145A1980155A1980155A198015591980155A1980155A1A80155A1980155A
            198014591980155A1980145A1980155A1980155A198014591980145A1980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F2388038F1388038F1
            388038F2386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A198014591980155A1980145A198014591980145A
            1A80145A1980145A1980155A1980155A1980155A1980145A198014591980155A
            19801559198014591880155A1980145919801459198014591980155A19801459
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000115711031559195814591980145A1980145A1A80155A1980155A
            1980145A1980145A1980155A1980155A1980155A19801459198015591980155A
            198015591980145A1980145A1880155A1980155A1980145A1980155A1980155A
            1980165E1A8030CE318038F1388038F2388038F1388038F2388038F1388038F1
            388038F2386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1980155A1980155A1980155A1980155A19801459
            1980155A19801559198014591980155A1980155A1980145A1980155A1A801559
            1980145A1980145A1980155A1980155A1980155A198014591980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958145A1980155A19801559198015591980155A
            19801559198014591980155A198015591980145A1980155A1980155A1980145A
            1980155A1980155A1980155A1980155A1980155A1A80145A1980155A1A801559
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F2386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F2388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F2388038F1388038F1388038F1388038F2388038F2
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000015591938155A1980145A1980145A1980155A1980155919801459
            198015591980155A1980155A1A80155A1980155A1980155A1980155A1980155A
            1A80155A1980155A1980155A1980155A1980155A1980155A1980155A1980155A
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958145A1980155A198015591980155A19801559
            1980155A1980145A1980145A1980155A1980155A1980155A1980155A1980155A
            1980145A1980155A1980155A198014591980155A1980155A1A80155A1980155A
            1980165F1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1386433F5330300000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000000038F2
            381E38F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F2388038F1388038F2
            388038F1388038F2388038F2388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A193815591980155A19801559198014591980145919801559
            198014591880155A1980155A1980155A1A801459188015591980155A1980155A
            1980145A198014591980155A1A80155A1980155A198015591980145919801559
            1980145818360000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000001157110315591958145A1980155919801459198015591980155A
            1980155A1A80155A1980155A19801559198015591980155A198015591980155A
            198015591980155A19801459198014591980155A1A8014591980155A1980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F2386436F2360635F335043AF33A0435F335043AF33A043AF33A043AF3
            3A043AF33A0435F335043AF33A0435F335043AF33A0435F335043AF33A0438F2
            382238F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A19801459198014591980155A1980145A1980155A
            19801559198015591980155A198015591980155A1980145A1980145A1980145A
            1980145A1980155A198015591980145A1880155A1980155A1A80155A19801559
            198014591838165E1604165E1604165E1604165E1604165E1604165E1604165E
            1604165E1604165E1604165E1604165E1604165E1604165E1604165E1604165E
            1604165E1604145C14071559195A145A1980155A1980145A1980155A1980145A
            1980155A1A80155A1980155919801459198014591980155A198015591980155A
            1A8015591980155A1A80155A19801559198014591980155A1980155A19801559
            1980165E1A8030CF318038F1388038F2388038F1388038F1388038F2388038F2
            388038F1387C38F2386F38F2386F38F2386F38F2386F38F2386F38F1386F38F1
            386F38F2386F38F2386F38F2386F38F1386F38F1386F38F1386F38F2386F38F2
            387238F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980155A19801459198014591980155A1A80155A
            1980155A1980155A1980155A1980155A1980155A1A8015591980155A1980155A
            1980155A1A80155A19801559198014591980145A1980155A1980155A19801559
            19801559196A155A195D15591A5D1559195D145A1A5D155A195D155A1A5D155A
            195D1459185D1559195D1559195D1459195D155A1A5D1559195D1459195D145A
            195D145A195D1459195D15591978155A1A80155A1980155A1A80155A1980145A
            1980155A1A80155A1980155A198015591980155A1980155A1980155A1A80155A
            1980155A1A80155A1980155A198015591980155A1980155A1980155A1980155A
            1A80165F1A8030D0328038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F2388038F1388038F2388038F1388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F2388038F1388038F1388038F2388038F1
            388038F1388038F2388038F2388038F2388038F2388038F1388038F2387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1A8015591980145A1980145A1980155A1980155A
            1A80145A1980155A198014591980155A198014591980155A1980155A1980155A
            1980155A1A80155A1980155A19801559198015591980145A198015591980155A
            198015591980155A1980145A19801459198015591980145A1980155919801559
            1980155A1980155A1980145A1980155A1980155A198014591980155919801459
            1980155A198014591980155A198015591980155A1A80155A1980145A1980155A
            198014591980145A1980155A1A8014591980155A1980155A1980155919801559
            198015591980155A1980145A198015591980155A1A80145A1980155A19801559
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F2
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F2
            388038F2388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000165A1A3815591980155A198014591980155A1980155A19801459
            1980155A198014591980155A1980155A1A80155A1980145A1980155A1980145A
            1980155A1980155A1980145A1980155A1980145A19801459198015591980155A
            1980145A1980155A198014591980155A1980155A19801559198014591980145A
            1980155A1980145A1980155A1980155A1980155A198015591980145A1980145A
            1980145A1980155A1980155A198014591980155A198015591980155A1980155A
            1980155A198015591980155A1980155A1A80145A1980155A1980155A1980155A
            1980155A1980155A198015591980155A198014591980145A1980155A1980155A
            1980165F1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938155A1A8015591980145A1980155A198014591980155A
            198014591880155A1A80145A1980155A19801459198014591980145918801559
            198015591980155A198015591980155A1980155A1A80155A1980145A1980155A
            198015591980155A198015591980145A1980155A1980155A1980155A1980155A
            1980155A198014591980155A1A80145A1980155A1980155A1980155A1A80145A
            1980155A1980155A198014591980145A1980145A1980145A1980145A1980145A
            198014591980155A1980145A1980155A1980155A1980155A1980145A1980155A
            1980155A1980155A1980155A1980145A198014591980145A1A80155919801459
            1980165E1A8030CF318038F2388038F1388038F1388038F1388038F2388038F1
            388038F2388038F1388038F2388038F2388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F2388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1A38155A1980155A1980145A1980155A1980155A1980155A
            1980145A1980155A1A80155A1980155A1980155A198014591980145A19801459
            1980155A198015591980145A1980145A1980155A1980155A1980145A19801459
            198014591980155A1A80145A198015591980155A1980155A198015591980155A
            1980155A1980155A1980155A1980155A1A80155A1980155A1A80145A1980145A
            1980155A1A80145919801459198015591980145A1880155A1A8014591980155A
            19801559198014591980155A1A80155A1980155A1980155A198014591880145A
            1980155A1980145A1980155A1980155A1980155A1980155A1980155A1A80145A
            1980165E1A8030CF328038F1388038F2388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F2388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000155A1938145A1980145A198014591980155A1980155A1980145A
            1980145A1980145A1980145A1980145A1880145A198015591980145A1980145A
            1980155A1980145A198015591980155A1980155A1980155A1A80155A19801559
            1980155A1980155A1980145A198015591980155A1980155A1980155A1980145A
            1980145A198014591980155A198014591880145A198014591980155A1980155A
            1980155A1980155A1980145A1980155A1A80155A1980145A1980155A1980155A
            198015591980155A1980155A1A8015591980145A198014591980155A1980155A
            198014591980155A1980155A198014591980145A1980155A198015591980155A
            1980165F1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F2
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000105614061559186015591980155A1980145A1980155A1980145A19801559
            198015591980155A1980155A1980145A198015591980155A1A80155A1980155A
            1980155A1980145A1980145A1980145A1980145A1980155A1980155A1980155A
            1A80145A198014591980155A1980155A1980155A198014591980155A1980155A
            1980155A1980155A198014591880155A1A80155A1980155A1980155A1980155A
            198014591980155A1A8015591980155A1980155A1980155A1A80155A1980155A
            1980155A1980145A1980155A1980145A1980155A1A801459198015591980155A
            1A80155A1980155A1980155A1A80145919801559198014591980145A1980145A
            1980165F1A8030CF328038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F2388038F2388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000F52
            0F02155919431459197F145A1980155A1980155A1A80155A198014591980155A
            1980155A1980145A1980155919801559198015591980145A1980155A1980155A
            1980155A1980145918801559198015591980155A1980155A1980145919801459
            1980145A1980145A1980155A198014591980155A1980155A1980155A1980155A
            1980155A1A80155A198014591980155A1980145A1980145A1980155A1A80155A
            1980145A1980145A1980145A198014591980155A1980145A1980145A19801559
            198015591980155A19801459188014591880155A1A801559198015591980155A
            198014591980155A198015591980155A1980145A1980155A1A80145A1980155A
            1980165F1A8030CF318038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F2388038F2
            388038F1388038F2388038F1388038F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000001459
            18361559197D155A1980155A19801559198014591880155A1980155A1980155A
            1980155A1980155A1980145A1980155A1980155A1A80155A1980145A1980145A
            198015591980145A19801459198015591980155A198015591980155A1980155A
            1980155A1980155A1980155A1A801459198015591980155A198014591980145A
            198015591980145A1980155A1980155A1980155A1980145A1980145A19801459
            1880155A1980155A19801459198015591980145A1980155A1980155A1980155A
            1980155A198015591980155A1980145A1980155A1980155A1980155A1980145A
            1980155A1980145A198014591880155A1A8015591980155A1980155A19801459
            1880165E1A8030CE318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F2388038F2388038F2
            388038F2388038F1388038F1388038F1388038F2388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000001459181F1459
            1977155A198015591980155A1980145A1980145A1980155A198014591880155A
            1980155A1980155A1980155A198015591980155A1980155A1980155A1980155A
            198015591980145919801459188015591980155A1980155A1980155A1A80155A
            19801559198015591980145A1980155A1980155A1980145A1980155A1980145A
            1980145A198015591980155A1980145A1980155A198014591880155A1980155A
            1A80155A1980145A1980145A1980155A1980155A19801559198015591980155A
            1980155A198015591980155A1980155919801459198015591980145A19801459
            1980155A1980145A198015591980155A1980155A1980155A1980155A1980155A
            1980165E1A8030CF318038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F1388038F2
            388038F1388038F1388038F1388038F1388038F2388038F1388038F2388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000001358171114591871155A
            1980155A1980155A198015591980155A1980155A1980145A1980155A1980155A
            1980155A198014591980155A1980155A198014591980155A1980155A19801459
            1980155A198014591980155A1980145A1980155A1980155A198015591980145A
            1980155A1980155A1980155A1980145A1980155A1980155A1980155A1980155A
            198014591980155A1980155A1A80155A1980155919801459198014591980145A
            198015591980155A198014591980155A198015591980155A1980155A1980155A
            1980155A1980155A1A80145A198015591980155A1A8014591980155919801459
            1980155A1A80155A1980155A198014591980155A1980145A1980155A19801559
            1980165E1A8030CE318038F2388038F2388038F1388038F1388038F2388038F1
            388038F1388038F2388038F2388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000135317081459185E155A1980145A
            19801559198015591980155A198014591980155A1980155A1980145A1980155A
            1980145919801459198015591980155A19801559198014591980145919801559
            1980155A1980145A1980155A198014591980145A19801459198014591980155A
            1980155A1980155A19801559198015591980155A1A80155A1A80155919801559
            1980155A198014591980145A198014591980145A198015591980155A1980155A
            1980155A19801559198015591980165A1A8014591980145A1980155A1980155A
            19801459198014591980155A1980155A1980145A1980155A1980155A1980155A
            1980155A1980155A198015591980155A1980145A1980155A1A80145A1980145A
            1980165E1A8030CF328038F1388038F2388038F1388038F1388038F2388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000125818051459194E1459198015591980155A
            1980155A1A80155A1980155A1980145A19801559198014591980155A1980155A
            198015591980155A1980155A1A80155A1A8015591980145A1980145919801559
            1980145A1980155A1980155A198015591980155A1980155A1A80155A1980145A
            19801459198015591980145A1980155A1A80155A1980155A1980145A1980155A
            1980155A1980155A1A80155A1A80155A1980155A1A80155A1980155A1980155A
            198015591980155A1980155A1980155A1A80145A1980155A1980145A1980155A
            198014591980155A1980155A1980155A1A8015591980155A1980145A1980155A
            1980155A198014591980145A1980155A1980155A1A80145A1980155A19801459
            1880165E1A8030CF318038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F1387F37F1
            371C000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000124912011459183C1459197E1559198015591980155A
            1980155A1980155A198015591980145A1980155A1980155A1980155A1980155A
            1980155A1980155A1980155A1980145A1980145A1980155A1980155A1980155A
            1980155A1980155A198015591980155A198014591980155A1980155A1A80155A
            1980145A19801559198015591980155A1980155A1980145A1980145A19801559
            198015591980155A198015591980145A1980145A19801459198015591980145A
            19801559198014591880145919801459198014591980155A198015591980145A
            1980155A1980155A1A80155A198015591980155A19801559198015591980145A
            1980145A1980155A1980155A198015591980155A1980155A1980145919801459
            1980155E1A8030CF318038F2388038F2388038F1388038F2388038F1388038F1
            388038F2388038F2388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F2388038F2388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1387F37F1
            371A000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000015551501145919251459197A15591980145A1980155A1980155A
            1980155A198014591880155919801559198015591980155A198014591980155A
            1980155A1980155A198015591980155A1980155A1980155A1A80155A1980155A
            1980155A1980155A1A80155A198014591980145A1980145A1980155A19801459
            198014591880155A1980155A1980155A1980155A198015591980145919801459
            1980155A1980155A1980145A1980155A1980155A1980155A1A80155A19801459
            1980145A1A80155A1980155A1980155A1980155A1980155A198014591980155A
            19801559198014591980145A198014591980155A1980155A1980155A1980155A
            1980155A1980155A1A80155A198014591980155A1A80155A1980155A1980155A
            198016601A8031D4328038F2388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F2388038F2
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1387739F3
            390B000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000125816151459197315591980155A1980145A1980155A1A80155A
            1980155A1A80155A1980155A1A80155A1980155A1980155A1980155919801459
            1980155A1A80155A1980155A1980155A198014591880155A198015591980155A
            1980145A1980155A19801459198015591980155A198015591980155A1980145A
            19801459198014591980145A1980145A1980155A198014591980155A1980155A
            19801459198014591980145A1980155A1980155A1980155A1980155A1A801559
            1980155A198014591980145A1980145919801459198015591980155919801559
            198014591980145A19801459198015591980155A198015591980155A1A80155A
            1980145A1980155A1980155A1980155A1980155A1980145A1980145A19801559
            19801A6E1D8036E9368038F1388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F2388038F2388038F238540000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00001459170B145818661459198014591980155A1980155A1980155A19801559
            1980155A1A8014591980155A1980155A1980155A198014591880155A1980155A
            1980145A1980145A1880155A1980155919801559198015591980155A19801559
            1980145A1980145A198014591980145919801559198015591980155A1980155A
            1980145A198014591980155A198015591980155A1980155A1980155A1980155A
            1980155A1980155A1980155A1A80145919801459198014591980145919801459
            1880145A1980145A198015591980155A1980155919801559198015591980155A
            1980155A1980155A1980155A1A80155A1980155A198015591980155A1A80155A
            198015591980155A1980155A1980155A1A8014591980155A198015591980155A
            198028AB2A8038F2388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F2388038F2388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1387B38F238110000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000000000000115A
            180515591955155A1980145A1980155A1980145A19801459198014591980155A
            1A80145A1980155A1980145A1980155A1980145A1A80155A1980145A1980155A
            1980155A1A80145A1980155A198014591980155A1980145A1980155A19801559
            1980155A1980155919801459198015591980155A1980145A1980155A19801559
            1980145918801459198014591980155A1980155A1A80145A1980145A19801459
            1980145A1980145A198015591980145A198015591980145A1980155A1980155A
            1980145A1980145A1980155A1980145A198015591980155A1A80155A19801559
            19801459198015591980145A1980155A1980155A1980155A1980155A1A80155A
            1A801559198015591980145A1980155A1980145A1980155A1980145A19801D7A
            208036EB378038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F2388038F1388038F1388038F1388038F1388038F2388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F2388038F1388038F1388038F1388038F1388038F1
            388038F2388038F2388038F1388038F2388038F1387D38F33828000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000004400011558
            19421559197F14591980155A198015591980155A1980145A198014591880145A
            19801559198015591980155A1980145A1980155A1980145A1980145A1980155A
            1980155A1980145A198014591980145A1980155A198014591980155A1980155A
            198015591980155A1980155A1A80145A1980145A1980145A1880155919801559
            1980155A1A80145A1980155A198015591980145A198015591980155919801459
            18801459188015591980155A1980155A1980155A1980155A1980145918801559
            198014591980155A1980155A198015591980155A1980155A1980155A1980155A
            19801459198014591980155A1A80155A198015591980155A198015591980155A
            1A8015591980155A1980145A19801459198014591980155A1980196A1C8032D7
            338038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F2388038F1388038F1388038F2388038F1388038F1388038F1388038F1
            388038F1388038F2388038F1388038F2388038F2388038F1388038F1388038F1
            388038F1388038F1388038F1388038F1388037F2373F00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000001458192A1559
            197D1559198014591980145A1A8015591980155A1980155A1980155A1980145A
            1980155A1980155A198015591980145A198014591980145A1980155A19801559
            1980155A1A8015591980155A1980155A198014591980155A198015591980155A
            1980155A1980155A1A80145A198014591980155A1980155A1980155A19801559
            1980155A1980155A1980145A198015591980155A1980155A198015591980155A
            1980145A198015591980155A198015591980155A1980155A198015591980155A
            1980145A1980155A1980155A19801459198015591980155A198015591980155A
            198014591980145A1980145A198015591980155A1980155A1980145A1980145A
            19801459198015591980155A1980145A198015591980196B1D8030D1328038F2
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F2388038F1388038F2388038F1388038F1388038F1
            388038F2388038F1388038F1388038F1388038F1388038F2388038F1388038F1
            388038F1388038F1388038F1388038F1388038F1388038F1388038F1388038F2
            388038F1388038F2388038F1387B38F238370000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000001359181514591973155A
            1980155A1980145A198014591980145A1980155A1980155A1980145A19801459
            1980145A1980155A1980145A1980145A1980155A1980155A1980145919801559
            19801459198015591980155A198015591980155A19801559198015591980155A
            1980145A1980145A1980145A1980155A198015591980155A1980155A1980155A
            1980155A1980145A1980155A1A80155A1A80155A1980155A1A80145A19801459
            1980145919801459198014591980155A1980145A1980155A1980155A1A80155A
            1980155A1980145A1980145A1980155A1980155A1980145A198015591980155A
            1980155A1A80145A1980155A198014591980155A198015591980155A1980155A
            1980155A1A8014591980145A1980155A19801B761F7E31D4327938F1387938F1
            387938F1387938F1387938F1387938F1387938F1387938F1387938F1387938F1
            387938F1387938F1387938F1387938F1387938F2387938F1387938F1387938F1
            387938F1387938F1387938F1387938F1387938F1387938F1387938F1387938F1
            387938F2387938F2387938F1387938F1387938F1387938F1387938F2387938F1
            387938F2387938F2387938F1387938F2387938F1387938F1387938F1387938F1
            387938F2387838F1385837F33718000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000001359190914581810155A
            1910155A191014591810145A1910165A1A10145A1810145A1A10145A1A10165A
            1A10145A1910165A1A10145A1A1014591810155A1910155A1A10155A1A101559
            1910165A1A10145A1810155A1910155A1A10145A1910145A1910145A18101559
            1910155A1910145A1910155A1910165A1A10145818101559191014591910155A
            1910155A1A1015591910155A1A10165A1A10155A1910145A181014591910165A
            1A1015591910155A1A1014591910155A1910145A1910155A1910145A1A10155A
            1910155A1A10145A1810155A191015591910145A1910145A1810145A1810145A
            1910145A1810145A1810155A191014591910155A1A10165A1A10155A1910145A
            1910145A1A101458181015591910155A19102ABB2D0D38F1380B38F2380B38F1
            380B38F4380B38F1380B38F1380B38F1380B38F1380B38F1380B38F1380B38F1
            380B38F1380B38F1380B38F1380B38F1380B38F2380B38F1380B38F1380B38F1
            380B38F1380B38F2380B38F1380B38F1380B38F2380B38F2380B38F1380B38F1
            380B38F1380B38F1380B38F1380B38F1380B38F1380B38F1380B38F1380B38F2
            380B38F2380B38F1380B38F1380B38F2380B38F1380B38F1380B38F2380B38F2
            380B38F238073BEC3B0100000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object SysMemo1: TfrxSysMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            'Data: [DATE]')
        end
        object SysMemo3: TfrxSysMemoView
          AllowVectorExport = True
          Left = 597.165740000000000000
          Top = 22.677180000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            'Horas: [Time]')
        end
      end
      object ColumnHeader1: TfrxColumnHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 128.504020000000000000
        Top = 83.149660000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ColumnHeader1OnBeforePrint'
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 86.929190000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Carga: ')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 98.267780000000000000
          Top = 22.677180000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Rota: ')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = -0.000002440000000000
          Top = 124.724487560000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxDBDataset1CargaId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'CargaId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."CargaId"]')
          ParentFont = False
        end
        object frxDBDataset1RotaId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Top = 22.677180000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'RotaId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."RotaId"]')
          ParentFont = False
        end
        object frxDBDataset1Rota: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 211.653680000000000000
          Top = 22.677180000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Rota'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Rota"]')
          ParentFont = False
        end
        object frxDBDataset1DtInclusao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 415.748300000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DtInclusao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."DtInclusao"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 366.614410000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Data: ')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 45.354360000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Transportadora: ')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 60.472480000000000000
          Top = 71.811070000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Motorista: ')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 98.267780000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ve'#237'culo: ')
          ParentFont = False
        end
        object frxDBDataset1TranspId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Top = 45.354360000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'TranspId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."TranspId"]')
          ParentFont = False
        end
        object frxDBDataset1Transportadora: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 211.653680000000000000
          Top = 45.354360000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          DataField = 'Transportadora'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Transportadora"]')
          ParentFont = False
        end
        object frxDBDataset1MotoristaId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Top = 71.811070000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'MotoristaId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."MotoristaId"]')
          ParentFont = False
        end
        object frxDBDataset1Motorista: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 211.653680000000000000
          Top = 71.811070000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Motorista'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Motorista"]')
          ParentFont = False
        end
        object frxDBDataset1VeiculoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Top = 98.267780000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'VeiculoId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."VeiculoId"]')
          ParentFont = False
        end
        object frxDBDataset1Placa: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 211.653680000000000000
          Top = 98.267780000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Placa'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Placa"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 604.724800000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Rhemasys Solu'#231#245'es')
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = -0.000000000000000444
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Lblusuario: TfrxMemoView
          AllowVectorExport = True
          Left = 230.551330000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Usu'#225'rio: ')
        end
        object vUsuario: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[vUsuario]')
        end
        object SysMemo2: TfrxSysMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'P'#225'g: [Page#] de [TOTALPAGES#]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 317.480520000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset2
        DataSetName = 'frxDbCargaPessoas'
        RowCount = 0
        object frxDBCargaPedidosPedidoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PedidoId'
          DataSet = frxDBDataset2
          DataSetName = 'frxDbCargaPessoas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDbCargaPessoas."PedidoId"]')
          ParentFont = False
        end
        object frxDBCargaPedidosQtdVolume: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 457.323130000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'QtdVolume'
          DataSet = frxDBDataset2
          DataSetName = 'frxDbCargaPessoas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbCargaPessoas."QtdVolume"]')
          ParentFont = False
        end
        object frxDBCargaPedidosItens: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 631.181510000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'Itens'
          DataSet = frxDBDataset2
          DataSetName = 'frxDbCargaPessoas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbCargaPessoas."Itens"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Pedido:')
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 396.850650000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Volumes:')
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 585.827150000000000000
          Top = 3.779530000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Itens:')
        end
        object frxDBCargaPedidosDocumentoOriginal: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 302.362400000000000000
          Top = 3.779530000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset3
          DataSetName = 'frxDBCargaPedidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDbCargaPessoas."DocumentoOriginal"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 200.315090000000000000
          Top = 3.779530000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Ressuprimento:')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = cl3DLight
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 272.126160000000000000
        Width = 718.110700000000000000
        Condition = 'frxDbCargaPessoas."PessoaId"'
        DrillDown = True
        ExpandDrillDown = True
        object Line3: TfrxLineView
          AllowVectorExport = True
          Top = 15.118120000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxDbCargaPessoasPessoaId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 94.488250000000000000
          Top = -3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset2
          DataSetName = 'frxDbCargaPessoas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDbCargaPessoas."CodPessoaERP"]')
          ParentFont = False
        end
        object frxDbCargaPessoasRazao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 181.417440000000000000
          Top = -3.779530000000000000
          Width = 370.393940000000000000
          Height = 18.897650000000000000
          DataField = 'Razao'
          DataSet = frxDBDataset2
          DataSetName = 'frxDbCargaPessoas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDbCargaPessoas."Razao"]')
          ParentFont = False
        end
        object frxDbCargaPessoasOrdem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 627.401980000000000000
          Top = -3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Ordem'
          DataSet = frxDBDataset2
          DataSetName = 'frxDbCargaPessoas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDbCargaPessoas."Ordem"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = -3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Destinat'#225'rio:')
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = -3.779530000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Ordem:')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 37.795300000000000000
        Top = 362.834880000000000000
        Width = 718.110700000000000000
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 366.614410000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd.Volumes:')
        end
        object SysMemo4: TfrxSysMemoView
          AllowVectorExport = True
          Left = 457.323130000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDbCargaPessoas."QtdVolume">,MasterData1)]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 536.693260000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Itens:')
        end
        object SysMemo5: TfrxSysMemoView
          AllowVectorExport = True
          Left = 631.181510000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDbCargaPessoas."Itens">,MasterData1)]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 120.944960000000000000
        Top = 461.102660000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Fechamento da Carga:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 30.236240000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Destinat'#225'rio(s):')
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pedido(s):')
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 86.929190000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Volume(s):')
        end
        object frxDBDataset1TDestinatario: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 143.622140000000000000
          Top = 30.236240000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'TDestinatario'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."TDestinatario"]')
          ParentFont = False
        end
        object frxDBDataset1TPedido: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 143.622140000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'TPedido'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."TPedido"]')
          ParentFont = False
        end
        object SysMemo6: TfrxSysMemoView
          AllowVectorExport = True
          Left = 143.622140000000000000
          Top = 86.929190000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDbCargaPessoas."QtdVolume">,MasterData1)]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CargaId=CargaId'
      'DtInclusao=DtInclusao'
      'HrInclusao=HrInclusao'
      'RotaId=RotaId'
      'Rota=Rota'
      'TranspId=TranspId'
      'Transportadora=Transportadora'
      'MotoristaId=MotoristaId'
      'Motorista=Motorista'
      'VeiculoId=VeiculoId'
      'Placa=Placa'
      'TDestinatario=TDestinatario'
      'TPedido=TPedido'
      'QtdSuprida=QtdSuprida')
    DataSet = FdMemPesqGeral
    BCDToCurrency = False
    Left = 250
    Top = 477
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 384
    Top = 465
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'frxDbCargaPessoas'
    CloseDataSource = False
    DataSet = FDMemCargaPessoas
    BCDToCurrency = False
    Left = 334
    Top = 479
  end
  object frxDBDataset3: TfrxDBDataset
    UserName = 'frxDBCargaPedidos'
    CloseDataSource = False
    DataSet = FDMemCargaPedidos
    BCDToCurrency = False
    Left = 436
    Top = 479
  end
  object FDMemCargaPessoas: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    IndexFieldNames = 'CargaId'
    MasterSource = DsPesqGeral
    MasterFields = 'CargaId'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 229
    Top = 311
    object FDMemCargaPessoasCargaId: TIntegerField
      FieldName = 'CargaId'
    end
    object FDMemCargaPessoasPessoaId: TIntegerField
      FieldName = 'PessoaId'
    end
    object FDMemCargaPessoasRazao: TStringField
      FieldName = 'Razao'
      Size = 100
    end
    object FDMemCargaPessoasOrdem: TIntegerField
      FieldName = 'Ordem'
    end
    object FDMemCargaPessoasCodPessoaERP: TIntegerField
      FieldName = 'CodPessoaERP'
    end
    object FDMemCargaPessoasPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
    object FDMemCargaPessoasQtdVolume: TIntegerField
      FieldName = 'QtdVolume'
    end
    object FDMemCargaPessoasItens: TIntegerField
      FieldName = 'Itens'
    end
    object FDMemCargaPessoasDocumentoNr: TStringField
      FieldName = 'DocumentoNr'
    end
    object FDMemCargaPessoasDocumentoOriginal: TStringField
      FieldName = 'DocumentoOriginal'
    end
  end
  object DsCargaPessoas: TDataSource
    AutoEdit = False
    DataSet = FDMemCargaPessoas
    Left = 273
    Top = 298
  end
  object DsCargaPedidos: TDataSource
    AutoEdit = False
    DataSet = FDMemCargaPedidos
    Left = 269
    Top = 352
  end
  object FDMemCargaPedidos: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    IndexFieldNames = 'PessoaId'
    MasterSource = DsCargaPessoas
    MasterFields = 'PessoaId'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 229
    Top = 365
    object FDMemCargaPedidosCargaId: TIntegerField
      FieldName = 'CargaId'
    end
    object FDMemCargaPedidosPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
    object FDMemCargaPedidosPessoaId: TIntegerField
      FieldName = 'PessoaId'
    end
    object FDMemCargaPedidosQtdVolume: TIntegerField
      FieldName = 'QtdVolume'
    end
    object FDMemCargaPedidosItens: TIntegerField
      FieldName = 'Itens'
    end
    object FDMemCargaPedidosDocumentoNr: TStringField
      FieldName = 'DocumentoNr'
    end
    object FDMemCargaPedidosDocumentoOriginal: TStringField
      FieldName = 'DocumentoOriginal'
    end
  end
  object FDMemResumoCarga: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 425
    Top = 327
  end
end

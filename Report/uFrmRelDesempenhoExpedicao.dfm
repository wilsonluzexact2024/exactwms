inherited FrmRelDesempenhoExpedicao: TFrmRelDesempenhoExpedicao
  Caption = 'FrmRelDesempenhoExpedicao'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LblTotRegCaption: TLabel
        Top = 126
        ExplicitTop = 126
      end
      inherited LblTotRegistro: TLabel
        Top = 126
        ExplicitTop = 126
      end
      object Label8: TLabel [3]
        Left = 354
        Top = 126
        Width = 83
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Demanda(Un):'
      end
      object LbltotalDemanda: TLabel [4]
        Left = 443
        Top = 126
        Width = 57
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
      object Label9: TLabel [5]
        Left = 514
        Top = 126
        Width = 89
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Unid.Separada:'
      end
      object LblTotalSeparacao: TLabel [6]
        Left = 609
        Top = 126
        Width = 56
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
      object Label5: TLabel [7]
        Left = 232
        Top = 126
        Width = 60
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Volume(s):'
      end
      object LblTotalVolumes: TLabel [8]
        Left = 295
        Top = 126
        Width = 45
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
      inherited PnlInfo: TPanel
        TabOrder = 7
      end
      inherited ChkCadastro: TCheckBox
        TabOrder = 9
      end
      inherited LstReport: TAdvStringGrid
        Top = 149
        Height = 375
        ColCount = 11
        TabOrder = 8
        ColumnHeaders.Strings = (
          'Data'
          'Id'
          'Usu'#225'rio'
          'Volumes'
          'Demanda'
          'Unidades'
          'Inicio'
          'T'#233'rmino'
          'Hr.Trabalhada'
          'Volume/Hora'
          'Unid/Hora')
        ExplicitTop = 149
        ExplicitHeight = 375
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
      end
      object GroupBox1: TGroupBox
        Left = 175
        Top = 3
        Width = 167
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Data da Produ'#231#227'o ]'
        TabOrder = 1
        TabStop = True
        object Label2: TLabel
          Left = 22
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label3: TLabel
          Left = 5
          Top = 76
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicioProducao: TJvDateEdit
          Left = 58
          Top = 19
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtInicioProducaoChange
        end
        object EdtTerminoProducao: TJvDateEdit
          Left = 58
          Top = 75
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
        end
      end
      object GroupBox6: TGroupBox
        Left = 485
        Top = 3
        Width = 492
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Usu'#225'rio ]'
        TabOrder = 3
        TabStop = True
        object Label11: TLabel
          Left = 40
          Top = 21
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object Lblusuario: TLabel
          Left = 174
          Top = 22
          Width = 279
          Height = 16
          CustomHint = BalloonHint1
          AutoSize = False
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtUsuarioId: TEdit
          Left = 57
          Top = 19
          Width = 84
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
          OnChange = EdtInicioProducaoChange
          OnExit = EdtUsuarioIdExit
        end
        object BtnPesqUsuario: TBitBtn
          Left = 142
          Top = 18
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
          OnClick = BtnPesqUsuarioClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 979
        Top = 3
        Width = 492
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Processo ]'
        TabOrder = 6
        Visible = False
        object Label12: TLabel
          Left = 9
          Top = 23
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblProcesso: TLabel
          Left = 158
          Top = 22
          Width = 326
          Height = 16
          CustomHint = BalloonHint1
          AutoSize = False
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtProcessoId: TEdit
          Left = 58
          Top = 20
          Width = 72
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
          OnChange = EdtInicioProducaoChange
          OnExit = EdtProcessoIdExit
        end
        object BtnPesqProcesso: TBitBtn
          Left = 130
          Top = 20
          Width = 24
          Height = 24
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
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqProcessoClick
        end
      end
      object GbPeriodoPedido: TGroupBox
        Left = 9
        Top = 3
        Width = 167
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Dados dos Pedido ]'
        TabOrder = 0
        TabStop = True
        object Label10: TLabel
          Left = 22
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label13: TLabel
          Left = 5
          Top = 76
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicioPedido: TJvDateEdit
          Left = 58
          Top = 19
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
        end
        object EdtTerminoPedido: TJvDateEdit
          Left = 58
          Top = 75
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
        end
      end
      object GbAnalise: TGroupBox
        Left = 485
        Top = 48
        Width = 238
        Height = 65
        CustomHint = BalloonHint1
        Caption = ' [ An'#225'lise ]'
        TabOrder = 4
        object RbDataPedido: TRadioButton
          Left = 14
          Top = 32
          Width = 91
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Data Pedido'
          Enabled = False
          TabOrder = 0
        end
        object RbProducao: TRadioButton
          Left = 122
          Top = 32
          Width = 107
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Data Produ'#231#227'o'
          Enabled = False
          TabOrder = 1
        end
      end
      object GbIndiceProdutividade: TGroupBox
        Left = 720
        Top = 48
        Width = 257
        Height = 65
        CustomHint = BalloonHint1
        Caption = ' [ Ind'#237'ces de Produtividade: ]'
        TabOrder = 5
        object Label6: TLabel
          Left = 63
          Top = 16
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label7: TLabel
          Left = 155
          Top = 16
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object EdtMeta: TEdit
          Left = 38
          Top = 33
          Width = 56
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Text = '0'
        end
        object EdtTolerancia: TEdit
          Left = 155
          Top = 33
          Width = 58
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clYellow
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          Text = '0'
        end
      end
      object GroupBox2: TGroupBox
        Left = 340
        Top = 3
        Width = 146
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Embalagem ]'
        TabOrder = 2
        object ChkCxaFechada: TCheckBox
          Left = 12
          Top = 26
          Width = 110
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Caixa Fechada'
          Enabled = False
          TabOrder = 0
        end
        object ChkCxaFracionada: TCheckBox
          Left = 12
          Top = 74
          Width = 118
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Caixa Fracionada'
          Enabled = False
          TabOrder = 1
        end
      end
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnPesquisarStand: TsImage
        Top = 6
        ExplicitTop = 6
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 994
    Top = 188
    ExplicitLeft = 994
    ExplicitTop = 188
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 689
    Top = 203
    ExplicitLeft = 689
    ExplicitTop = 203
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralData: TDateField
      FieldName = 'DataProducao'
    end
    object FdMemPesqGeralUsuarioId: TIntegerField
      FieldName = 'UsuarioId'
    end
    object FdMemPesqGeralNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object FdMemPesqGeralProcessoEtapaId: TIntegerField
      FieldName = 'ProcessoEtapaId'
    end
    object FdMemPesqGeralProcesso: TStringField
      FieldName = 'Processo'
      Size = 30
    end
    object FdMemPesqGeralQtdVolume: TIntegerField
      FieldName = 'QtdVolume'
    end
    object FdMemPesqGeralDemanda: TIntegerField
      FieldName = 'Demanda'
    end
    object FdMemPesqGeralExpedido: TIntegerField
      FieldName = 'Expedido'
    end
    object FdMemPesqGeralHoraTrabalhada: TStringField
      FieldName = 'HoraTrabalhada'
      Size = 15
    end
    object FdMemPesqGeralVolumePorHora: TIntegerField
      FieldName = 'VolumePorHora'
    end
    object FdMemPesqGeralUnidadePorHora: TIntegerField
      FieldName = 'UnidadePorHora'
    end
    object FdMemPesqGeralMeta: TIntegerField
      FieldName = 'Meta'
    end
    object FdMemPesqGeralTolerancia: TIntegerField
      FieldName = 'Tolerancia'
    end
    object FdMemPesqGeralDataPedido: TDateField
      FieldName = 'DataPedido'
    end
    object FdMemPesqGeralInicio: TDateTimeField
      FieldName = 'Inicio'
    end
    object FdMemPesqGeralTermino: TDateTimeField
      FieldName = 'Termino'
    end
    object FdMemPesqGeralData2: TDateField
      FieldName = 'Data'
    end
  end
  inherited frxDBDataset1: TfrxDBDataset
    Left = 384
    Top = 389
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44850.940916446760000000
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Line#> Mod 2) then Begin'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := $00EBEBEB;'
      '  End'
      '  else Begin'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := ClNone;'
      '  End;'
      
        '  If (<frxDBDataset1."UnidadePorHora">) >= (<frxDBDataset1."Meta' +
        '">) then'
      '     frxDBDataset1UnidadePorHora.Font.Color := ClGreen          '
      
        '  Else If (<frxDBDataset1."UnidadePorHora">) >= (<frxDBDataset1.' +
        '"Tolerancia">) then'
      '     frxDBDataset1UnidadePorHora.Font.Color := ClYellow'
      '  Else'
      
        '     frxDBDataset1UnidadePorHora.Font.Color := ClRed;           ' +
        '                   '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Datasets = <
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
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            'Desempenho da Expedi'#231#227'o')
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Height = 45.354360000000000000
        inherited Line2: TfrxLineView
          Left = -0.000002440000000000
        end
        inherited Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 60.472480000000000000
          HAlign = haRight
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Usu'#225'rio')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 306.141930000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Volume')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 359.055350000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Demanda')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Expedido')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Horas')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 597.165740000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vol/Hr')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 650.079160000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Unid/Hr')
        end
        object frxDBDataset1Meta: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 359.055350000000000000
          Top = 22.677180000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'Meta'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Meta"]')
          ParentFont = False
        end
        object frxDBDataset1Tolerancia: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 506.457020000000000000
          Top = 22.677180000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'Tolerancia'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Tolerancia"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 124.724490000000000000
          Top = 22.677180000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Ind'#237'ces de Produtividade:')
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 313.700990000000000000
          Top = 22.677180000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Meta:')
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 430.866420000000000000
          Top = 22.677180000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Toler'#226'ncia:')
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Top = 41.574830000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 272.126160000000000000
      end
      inherited MasterData1: TfrxMasterData
        Top = 188.976500000000000000
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 638.740570000000000000
          Top = 11.338590000000000000
          Width = 75.590551180000000000
          Visible = False
          DataField = 'Nome'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Nome"]')
          WordWrap = False
        end
        object frxDBDataset1Data: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Data'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Data"]')
        end
        object frxDBDataset1Nome: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 68.031540000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          DataField = 'Nome'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Nome"]')
        end
        object frxDBDataset1QtdVolume: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 306.141930000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'QtdVolume'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdVolume"]')
        end
        object frxDBDataset1Apanhe: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 427.086890000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Expedido"]')
        end
        object frxDBDataset1Demanda: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 359.055350000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Demanda'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Demanda"]')
        end
        object frxDBDataset1HoraTrabalhada: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'HoraTrabalhada'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."HoraTrabalhada"]')
        end
        object frxDBDataset1VolumePorHora: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 597.165740000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'VolumePorHora'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VolumePorHora"]')
          ParentFont = False
        end
        object frxDBDataset1UnidadePorHora: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 650.079160000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."UnidadePorHora"]')
          ParentFont = False
        end
      end
    end
  end
end

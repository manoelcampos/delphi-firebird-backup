object FrmBackupRestore: TFrmBackupRestore
  Left = 305
  Top = 246
  ActiveControl = rdBackup
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Backup e Restaura'#231#227'o de Banco de Dados Firebird/Interbase'
  ClientHeight = 389
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    420
    389)
  PixelsPerInch = 96
  TextHeight = 13
  object btnExecutar: TBitBtn
    Left = 8
    Top = 356
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Executar'
    Default = True
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = btnExecutarClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 403
    Height = 331
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Backup/Restore'
      DesignSize = (
        395
        303)
      object Label1: TLabel
        Left = 24
        Top = 144
        Width = 115
        Height = 13
        Caption = '&Tipo de Banco de Dados'
        FocusControl = cmbTipoBanco
      end
      object Label2: TLabel
        Left = 24
        Top = 192
        Width = 261
        Height = 13
        Caption = '&Arquivo de Backup (N'#227'o pode conter espa'#231'o no nome)'
        FocusControl = EdtBackup
      end
      object Bevel1: TBevel
        Left = 207
        Top = 244
        Width = 165
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object Label3: TLabel
        Left = 24
        Top = 237
        Width = 178
        Height = 13
        Caption = 'Login no Servidor de Banco de Dados'
      end
      object lbEdtServidor: TLabeledEdit
        Left = 24
        Top = 64
        Width = 275
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 113
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome ou IP do &Servidor'
        TabOrder = 2
        Text = 'localhost'
        OnChange = lbEdtServidorChange
      end
      object lbEdtBanco: TLabeledEdit
        Left = 24
        Top = 112
        Width = 347
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 122
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome do &Banco de Dados'
        TabOrder = 3
        OnChange = lbEdtServidorChange
      end
      object cmbTipoBanco: TComboBox
        Left = 24
        Top = 160
        Width = 209
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        Sorted = True
        TabOrder = 5
        Text = 'Firebird 1.5 ou Superior'
        OnChange = cmbTipoBancoChange
        Items.Strings = (
          'Firebird 1.5 ou Superior'
          'Interbase/Firebird 1.0')
      end
      object EdtBackup: TJvFilenameEdit
        Left = 24
        Top = 208
        Width = 350
        Height = 21
        OnAfterDialog = EdtBackupAfterDialog
        DisabledColor = clBtnFace
        DefaultExt = '.fbk'
        Filter = 'Backup Firebird (*.fbk)|*.fbk|Backup Interbase (*.gbk)|*.gbk'
        DialogOptions = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist]
        DialogTitle = 'Salvar arquivo'
        Color = 14870505
        DirectInput = False
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000010000000000000101
          0100020202000303030004040400050505000606060007070700080808000909
          09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
          1100121212001313130014141400151515001616160017171700181818001919
          19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
          210022222200232323002424240025252500262626002D282800352B2A003C2D
          2C00432F2E0049313000533433005C3635006C3937007A3A3800833B3800893B
          38008C3B38008F3B3800913A3800923A3700923A370093393600933836009338
          3500933735009336340093363400933433009333320093323100922F2E00922D
          2D00922C2B00922B2B00922B2B00922C2B00922D2C00922E2E0092302F009232
          31009334330094373500943A3700953C3900953D3A00953F3B0097403D009841
          3E009A423E009A423F009B423F009C4340009E4341009C4340009A433F009943
          3F0098433F0097433F0097433F0096433F0096433F0095434000934541008F47
          43008A4A4700854D4B007F524F0079575500735C5B006F6060006D6363006B66
          66006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
          7100727272007373730074747400757575007676760077777700787878007979
          79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E00817B7B008A7777009174
          7400987171009E6E6E00A46B6B00A9696900AD676700B1666600B8646400BE63
          6300C1626200C4636300C6636300C7646500C8646500C9646500CA656600CB66
          6600CB666600CB666600CA666600CB666600CC666600CD666600CD666600CD66
          6600CD666600CD656600CC656600CB656600CA656600CA666600C9666600C966
          6600C8676700C8686800C86A6A00C86C6C00C76D6D00C66F6E00C6717000C574
          7300C4787700C47C7B00C37F7E00C3858400C48A8A00C5919000C4969500C498
          9800C2999900C59C9B00C89E9E00C9A0A000C9A3A300CAA8A800C9AEAE00CAB3
          B300CAB9B900CBBDBE00CDC1C200CEC5C600CFC8C900CEC9CA00CEC9CA00CECA
          CB00CECACB00CECBCB00CDCBCC00CDCBCC00CECBCC00CDCBCC00CECBCC00CECA
          CC00CFC8CC00D2BECF00D6AED200DC94D900E27DDE00E961E500EF47EC00F335
          F100F721F600FB0CFB00FD06FD00FE02FE00FE00FE00FE00FE00FE00FE00FE00
          FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
          FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01FE00FE02FE00FD07
          FD00FB1CFA00F641F600F169F100ED8CED00E9ACE900E6C5E600E5D4E400E4DA
          E400E4E0E400E5E3E500E6E5E700E8E8E900ECECED00F0F1F100F5F5F500F7F7
          F700F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800DEDEDEDEDEDE
          DEDEDEDEDEDEDEDEDEDEDEDE5B5BB2B2B2B2B2B2B2485BDEDEDEDE5B9A8CF243
          43F4F3F2C943565BDEDEDE5B9B8AF34343F2F4F2C843565BDEDEDE5B9B8AF343
          43F2F4F4C843565BDEDEDE5B9B8AF4F4F2F2F2F2C843565BDEDEDE5B9B8CA2A8
          A8A48BA59F8B9B5BDEDEDE5B88ABB4B7B7B7B5B5B7B7965BDEDEDE5B96FFFFFF
          FFFFFFFFFFFF965BDEDEDE5B96FFFFFFFFFFFFFFFFFF965BDEDEDE5B96FFC7C7
          C7C7C7C7C7FF965BDEDEDE5B96FFFFFFFFFFFFFFFFFF965BDEDEDE5B96FFC7C7
          C7C7C7C7C7FF965BDEDEDE5B96FFFFFFFFFFFFFFFFFF965BDEDEDEDE5BFFFFFF
          FFFFFFFFFFFF5BDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE}
        ImageKind = ikCustom
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 6
        OnChange = lbEdtServidorChange
      end
      object lbEdtUsuario: TLabeledEdit
        Left = 24
        Top = 274
        Width = 113
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = '&Usu'#225'rio'
        TabOrder = 7
        OnChange = lbEdtServidorChange
      end
      object lbEdtSenha: TLabeledEdit
        Left = 152
        Top = 274
        Width = 113
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = '&Senha'
        PasswordChar = '*'
        TabOrder = 8
        OnChange = lbEdtServidorChange
      end
      object rdBackup: TRadioButton
        Left = 22
        Top = 20
        Width = 89
        Height = 17
        Caption = '&Criar Backup'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdBackupClick
      end
      object rdRestore: TRadioButton
        Left = 126
        Top = 20
        Width = 129
        Height = 17
        Hint = 
          'Por medida de seguran'#231'a, para restaurar um backup, '#13#10'o usu'#225'rio d' +
          'ever'#225' digitar o nome de usu'#225'rio e senha do '#13#10'servidor de banco d' +
          'e dados.'#13#10'A substitui'#231#227'o de bancos existentes est'#225' desativada.'
        Caption = '&Restaurar Backup'
        TabOrder = 1
        OnClick = rdRestoreClick
      end
      object cbxDataAtual: TCheckBox
        Left = 248
        Top = 154
        Width = 129
        Height = 31
        Caption = '&Inserir data atual no arquivo de backup'
        Checked = True
        State = cbChecked
        TabOrder = 4
        WordWrap = True
      end
    end
    object TabSheetLog: TTabSheet
      Caption = 'Informa'#231#245'es'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 395
        Height = 303
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 136
    Top = 356
    Width = 75
    Height = 25
    Caption = '&Sobre'
    DoubleBuffered = True
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 216
    Top = 356
    Width = 195
    Height = 25
    Caption = 'Par'#226'metros de Linha de Comando'
    DoubleBuffered = True
    Kind = bkHelp
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
    WordWrap = True
    OnClick = BitBtn2Click
  end
  object JvUIBBackup1: TUIBBackup
    Protocol = proTCPIP
    LibraryName = 'fbclient.dll'
    OnVerbose = JvUIBBackup1Verbose
    Verbose = True
    Left = 344
    Top = 56
  end
  object JvUIBRestore1: TUIBRestore
    Protocol = proTCPIP
    LibraryName = 'fbclient.dll'
    OnVerbose = JvUIBBackup1Verbose
    Verbose = True
    Left = 344
    Top = 120
  end
end

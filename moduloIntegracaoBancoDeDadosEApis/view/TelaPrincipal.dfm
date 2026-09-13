object frmTelaPrincipal: TfrmTelaPrincipal
  Left = 0
  Top = 0
  Caption = 'Informa'#231#245'es sobre pa'#237'ses'
  ClientHeight = 507
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnlConsultarPais: TPanel
    Left = 0
    Top = 0
    Width = 388
    Height = 97
    Align = alTop
    TabOrder = 0
    object lblPais: TLabel
      Left = 24
      Top = 19
      Width = 119
      Height = 15
      Caption = 'Digite o nome do pa'#237's:'
    end
    object btnConsultar: TButton
      Left = 288
      Top = 39
      Width = 75
      Height = 25
      Caption = 'Consultar'
      TabOrder = 0
      OnClick = btnConsultarClick
    end
    object edtPais: TEdit
      Left = 24
      Top = 40
      Width = 249
      Height = 23
      TabOrder = 1
    end
  end
  object pnlInfoPais: TPanel
    Left = 0
    Top = 97
    Width = 388
    Height = 410
    Align = alClient
    TabOrder = 1
    object lblNomeOficial: TLabel
      Left = 24
      Top = 16
      Width = 71
      Height = 15
      Caption = 'Nome oficial:'
    end
    object lblCapital: TLabel
      Left = 24
      Top = 80
      Width = 40
      Height = 15
      Caption = 'Capital:'
    end
    object lblRegiao: TLabel
      Left = 24
      Top = 144
      Width = 39
      Height = 15
      Caption = 'Regi'#227'o:'
    end
    object lblPopulacao: TLabel
      Left = 24
      Top = 204
      Width = 59
      Height = 15
      Caption = 'Popula'#231#227'o:'
    end
    object lblMoeda: TLabel
      Left = 24
      Top = 272
      Width = 40
      Height = 15
      Caption = 'Moeda:'
    end
    object edtNomeOficial: TEdit
      Left = 24
      Top = 37
      Width = 339
      Height = 23
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtCapital: TEdit
      Left = 24
      Top = 101
      Width = 339
      Height = 23
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtRegiao: TEdit
      Left = 24
      Top = 165
      Width = 339
      Height = 23
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtPopulacao: TEdit
      Left = 24
      Top = 225
      Width = 339
      Height = 23
      Enabled = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtMoeda: TEdit
      Left = 24
      Top = 293
      Width = 339
      Height = 23
      Enabled = False
      ReadOnly = True
      TabOrder = 4
    end
  end
end

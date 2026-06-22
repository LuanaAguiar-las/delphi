object frmTelaPrincipal: TfrmTelaPrincipal
  Left = 0
  Top = 0
  Caption = 'Cadastro de produtos'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 60
    Align = alTop
    TabOrder = 0
    object btnNovo: TButton
      Left = 16
      Top = 16
      Width = 75
      Height = 30
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 112
      Top = 16
      Width = 75
      Height = 30
      Caption = 'Editar'
      Enabled = False
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnRemover: TButton
      Left = 208
      Top = 16
      Width = 75
      Height = 30
      Caption = 'Remover'
      Enabled = False
      TabOrder = 2
      OnClick = btnRemoverClick
    end
  end
  object pnlProdutos: TPanel
    Left = 0
    Top = 60
    Width = 624
    Height = 381
    Align = alClient
    TabOrder = 1
    object grdProdutos: TDBGrid
      Left = 1
      Top = 1
      Width = 622
      Height = 379
      Align = alClient
      DataSource = dtsProdutos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 480
    Top = 68
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    OnDataChange = dtsProdutosDataChange
    Left = 480
    Top = 124
  end
end

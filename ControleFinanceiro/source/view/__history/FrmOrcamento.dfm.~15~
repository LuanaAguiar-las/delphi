object frmCadOrcamento: TfrmCadOrcamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Or'#231'amento financeiro pessoal'
  ClientHeight = 720
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pnlOrcamento: TPanel
    Left = 8
    Top = 8
    Width = 904
    Height = 140
    BevelOuter = bvLowered
    TabOrder = 0
    object lblMesAno: TLabel
      Left = 8
      Top = 8
      Width = 127
      Height = 15
      Caption = 'M'#234's e ano (MM/AAAA):'
    end
    object lblSalario: TLabel
      Left = 176
      Top = 8
      Width = 102
      Height = 15
      Caption = 'Sal'#225'rio l'#237'quido (R$):'
    end
    object lblRendaExtra: TLabel
      Left = 344
      Top = 8
      Width = 88
      Height = 15
      Caption = 'Renda extra (R$):'
    end
    object lblMeta: TLabel
      Left = 512
      Top = 8
      Width = 142
      Height = 15
      Caption = 'Meta de investimento (R$):'
    end
    object lblObservacao: TLabel
      Left = 8
      Top = 60
      Width = 65
      Height = 15
      Caption = 'Observa'#231#227'o:'
    end
    object edtMesAno: TEdit
      Left = 8
      Top = 28
      Width = 150
      Height = 23
      TabOrder = 0
    end
    object edtSalario: TEdit
      Left = 176
      Top = 28
      Width = 150
      Height = 23
      TabOrder = 1
      OnChange = edtSalarioChange
      OnExit = edtSalarioExit
    end
    object edtRendaExtra: TEdit
      Left = 344
      Top = 28
      Width = 150
      Height = 23
      TabOrder = 2
      OnChange = edtRendaExtraChange
      OnExit = edtRendaExtraExit
    end
    object edtMeta: TEdit
      Left = 512
      Top = 28
      Width = 150
      Height = 23
      TabOrder = 3
      OnChange = edtMetaChange
      OnExit = edtMetaExit
    end
    object edtObservacao: TEdit
      Left = 8
      Top = 80
      Width = 654
      Height = 23
      TabOrder = 4
    end
    object btnSalvar: TButton
      Left = 668
      Top = 10
      Width = 220
      Height = 36
      Caption = '&Salvar or'#231'amento'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object btnCarregarOrcamento: TButton
      Left = 672
      Top = 52
      Width = 220
      Height = 30
      Caption = '&Carregar m'#234's/ano'
      TabOrder = 6
      OnClick = btnCarregarOrcamentoClick
    end
    object btnNovoOrcamento: TButton
      Left = 672
      Top = 90
      Width = 220
      Height = 30
      Caption = '&Novo/limpar or'#231'amento'
      TabOrder = 7
      OnClick = btnNovoOrcamentoClick
    end
  end
  object pnlTotais: TPanel
    Left = 8
    Top = 156
    Width = 904
    Height = 70
    BevelOuter = bvLowered
    Color = 15790320
    ParentBackground = False
    TabOrder = 1
    object pnlCardRenda: TPanel
      Left = 8
      Top = 6
      Width = 272
      Height = 56
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object lblRendaTotalTit: TLabel
        Left = 0
        Top = 6
        Width = 272
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'RENDA TOTAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblRendaTotalVal: TLabel
        Left = 0
        Top = 26
        Width = 272
        Height = 22
        Alignment = taCenter
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlCardDespesas: TPanel
      Left = 316
      Top = 6
      Width = 272
      Height = 56
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object lblTotalDespesasTit: TLabel
        Left = 0
        Top = 6
        Width = 272
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'TOTAL DESPESAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalDespesasVal: TLabel
        Left = 0
        Top = 26
        Width = 272
        Height = 22
        Alignment = taCenter
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlCardSaldo: TPanel
      Left = 624
      Top = 6
      Width = 272
      Height = 56
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object lblSaldoLivreTit: TLabel
        Left = 0
        Top = 6
        Width = 272
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'SALDO LIVRE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSaldoLivreVal: TLabel
        Left = 0
        Top = 26
        Width = 272
        Height = 22
        Alignment = taCenter
        AutoSize = False
        Caption = 'R$ 0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlDespesa: TPanel
    Left = 8
    Top = 234
    Width = 904
    Height = 72
    BevelOuter = bvLowered
    TabOrder = 2
    object lblDescricao: TLabel
      Left = 8
      Top = 5
      Width = 54
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object lblValor: TLabel
      Left = 220
      Top = 6
      Width = 29
      Height = 15
      Caption = 'Valor:'
    end
    object lblCategoria: TLabel
      Left = 332
      Top = 6
      Width = 54
      Height = 15
      Caption = 'Categoria:'
    end
    object lblFormaPagamento: TLabel
      Left = 494
      Top = 6
      Width = 117
      Height = 15
      Caption = 'Forma de pagamento:'
    end
    object edtDescricao: TEdit
      Left = 8
      Top = 26
      Width = 200
      Height = 23
      TabOrder = 0
    end
    object edtValor: TEdit
      Left = 220
      Top = 26
      Width = 100
      Height = 23
      TabOrder = 1
    end
    object cmbCategoria: TComboBox
      Left = 332
      Top = 26
      Width = 150
      Height = 23
      Style = csDropDownList
      TabOrder = 2
    end
    object cmbFormaPagamento: TComboBox
      Left = 494
      Top = 26
      Width = 150
      Height = 23
      Style = csDropDownList
      TabOrder = 3
    end
    object chkPago: TCheckBox
      Left = 658
      Top = 29
      Width = 50
      Height = 17
      Caption = 'Pago'
      TabOrder = 4
    end
    object btnAdicionarDespesa: TButton
      Left = 718
      Top = 25
      Width = 88
      Height = 25
      Caption = '+ A&dicionar'
      TabOrder = 5
      OnClick = btnAdicionarDespesaClick
    end
    object btnRemoverDespesa: TButton
      Left = 812
      Top = 25
      Width = 84
      Height = 25
      Caption = '- &Remover'
      TabOrder = 6
      OnClick = btnRemoverDespesaClick
    end
  end
  object gridDespesas: TStringGrid
    Left = 8
    Top = 314
    Width = 904
    Height = 320
    ColCount = 6
    DefaultRowHeight = 22
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goRowSelect]
    TabOrder = 3
    OnMouseDown = gridDespesasMouseDown
  end
  object pnlCotacao: TPanel
    Left = 8
    Top = 642
    Width = 904
    Height = 44
    BevelOuter = bvLowered
    Color = clAzure
    ParentBackground = False
    TabOrder = 4
    object lblCotacao: TLabel
      Left = 190
      Top = 14
      Width = 706
      Height = 17
      AutoSize = False
      Caption = 
        'Clique em "Consultar cota'#231#227'o" para ver os valores do D'#243'lar e Eur' +
        'o.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6307840
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object btnCotacao: TButton
      Left = 8
      Top = 8
      Width = 170
      Height = 28
      Caption = 'Consultar cota'#231#227'o (&API)'
      TabOrder = 0
      OnClick = btnCotacaoClick
    end
  end
end

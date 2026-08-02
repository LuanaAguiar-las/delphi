object frmAcessoConta: TfrmAcessoConta
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Acesso conta'
  ClientHeight = 166
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 35
    Width = 95
    Height = 15
    Caption = 'Selecione a conta:'
  end
  object lblSenha: TLabel
    Left = 256
    Top = 35
    Width = 77
    Height = 15
    Caption = 'Digite a senha:'
  end
  object cmbSelecaoConta: TComboBox
    Left = 16
    Top = 56
    Width = 209
    Height = 23
    TabOrder = 0
  end
  object btnAcessar: TButton
    Left = 280
    Top = 112
    Width = 97
    Height = 25
    Caption = 'Acessar'
    TabOrder = 1
    OnClick = btnAcessarClick
  end
  object edtSenha: TEdit
    Left = 256
    Top = 56
    Width = 121
    Height = 23
    TabOrder = 2
  end
end

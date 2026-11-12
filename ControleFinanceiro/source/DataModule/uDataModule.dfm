object dtmDataBase: TdtmDataBase
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Port=5433'
      'DriverID=PG'
      'Database=CONTROLE_FINANCEIRO'
      'User_Name=postgres'
      'Password=senha')
    Connected = True
    Left = 504
    Top = 32
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\18\bin\libpq.dll'
    Left = 504
    Top = 144
  end
end

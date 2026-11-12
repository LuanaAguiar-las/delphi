unit OrcamentoService;

interface

uses
  OrcamentoModel, OrcamentoDespesaModel, uDataModule,
  System.SysUtils, System.Generics.Collections, FireDAC.Comp.Client;

type
  TOrcamentoService = class
    private
      FQueryMaster: TFDQuery;
      FQueryDetail: TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;
      function Salvar(const AOrcamento: TOrcamento): boolean;
      function Excluir(const AId: integer): boolean;
      function ObterPorId(const AId: integer): TOrcamento;
      function ListarTodos: TObjectList<TOrcamento>;
      function ListarTodasDespesas: TObjectList<TOrcamentoDespesa>;
      function ObterDespesaPorId(const AId: integer): TOrcamentoDespesa;
      function InserirDespesa(const ADespesa: TOrcamentoDespesa): boolean;
      function AtualizarDespesa(const ADespesa: TOrcamentoDespesa): boolean;
      function ExcluirDespesa(const AId: integer): boolean;
  end;

implementation

{ TOrcamentoService }

function TOrcamentoService.AtualizarDespesa(const ADespesa: TOrcamentoDespesa): boolean;
begin
  FQueryDetail.Close;
  FQueryDetail.Params.Clear;
  FQueryDetail.SQL.Clear;
  FQueryDetail.SQL.Text :=
    'UPDATE orcamento_despesa ' +
    'SET id_categoria = :id_categoria, id_forma_pagamento = :id_forma_pagamento, ' +
    '    descricao = :descricao, valor = :valor, pago = :pago ' +
    'WHERE id = :id';

  FQueryDetail.ParamByName('id_categoria').AsInteger := ADespesa.IdCategoria;
  FQueryDetail.ParamByName('id_forma_pagamento').AsInteger := ADespesa.IdFormaPagamento;
  FQueryDetail.ParamByName('descricao').AsString := ADespesa.Descricao;
  FQueryDetail.ParamByName('valor').AsCurrency := ADespesa.Valor;
  FQueryDetail.ParamByName('pago').AsBoolean := ADespesa.Pago;
  FQueryDetail.ParamByName('id').AsInteger := ADespesa.Id;
  FQueryDetail.ExecSQL;

  Result := FQueryDetail.RowsAffected > 0;
end;

function TOrcamentoService.ExcluirDespesa(const AId: integer): boolean;
begin
  FQueryDetail.Close;
  FQueryDetail.Params.Clear;
  FQueryDetail.SQL.Clear;
  FQueryDetail.SQL.Text := 'DELETE FROM orcamento_despesa WHERE id = :id';
  FQueryDetail.ParamByName('id').AsInteger := AId;
  FQueryDetail.ExecSQL;

  Result := FQueryDetail.RowsAffected > 0;
end;

constructor TOrcamentoService.Create;
begin
  inherited Create;
  FQueryMaster := TFDQuery.Create(nil);
  FQueryMaster.Connection := dtmDataBase.FDConnection;

  FQueryDetail := TFDQuery.Create(nil);
  FQueryDetail.Connection := dtmDataBase.FDConnection;
end;

destructor TOrcamentoService.Destroy;
begin
  FQueryMaster.Free;
  FQueryDetail.Free;
  inherited Destroy;
end;

function TOrcamentoService.Excluir(const AId: integer): boolean;
begin
  FQueryMaster.Close;
  FQueryMaster.Params.Clear;
  FQueryMaster.SQL.Clear;
  FQueryMaster.SQL.Text := 'DELETE FROM orcamento WHERE id = :id';
  FQueryMaster.ParamByName('id').AsInteger := AId;
  FQueryMaster.ExecSQL;

  Result := FQueryMaster.RowsAffected > 0;
end;

function TOrcamentoService.InserirDespesa(const ADespesa: TOrcamentoDespesa): boolean;
begin
  FQueryDetail.Close;
  FQueryDetail.Params.Clear;
  FQueryDetail.SQL.Clear;
  FQueryDetail.SQL.Text :=
    'INSERT INTO orcamento_despesa ' +
    '(id_categoria, id_forma_pagamento, descricao, valor, pago) ' +
    'VALUES (:id_categoria, :id_forma_pagamento, :descricao, :valor, :pago) RETURNING id';

  FQueryDetail.ParamByName('id_categoria').AsInteger := ADespesa.IdCategoria;
  FQueryDetail.ParamByName('id_forma_pagamento').AsInteger := ADespesa.IdFormaPagamento;
  FQueryDetail.ParamByName('descricao').AsString := ADespesa.Descricao;
  FQueryDetail.ParamByName('valor').AsCurrency := ADespesa.Valor;
  FQueryDetail.ParamByName('pago').AsBoolean := ADespesa.Pago;
  FQueryDetail.Open;

  if not FQueryDetail.IsEmpty then
  begin
    ADespesa.Id := FQueryDetail.FieldByName('id').AsInteger;
    Result := True;
  end
  else
    Result := False;
end;

function TOrcamentoService.ListarTodasDespesas: TObjectList<TOrcamentoDespesa>;
var
  Despesa: TOrcamentoDespesa;
begin
  Result := TObjectList<TOrcamentoDespesa>.Create(True);
  try
    FQueryDetail.Close;
    FQueryDetail.SQL.Text :=
      'SELECT d.*, c.nome AS categoria_nome, f.nome AS forma_pagamento_nome ' +
      'FROM orcamento_despesa d ' +
      'LEFT JOIN categoria c ON c.id = d.id_categoria ' +
      'LEFT JOIN forma_pagamento f ON f.id = d.id_forma_pagamento ' +
      'ORDER BY d.id DESC';
    FQueryDetail.Open;

    while not FQueryDetail.Eof do
    begin
      Despesa := TOrcamentoDespesa.Create;
      Despesa.Id := FQueryDetail.FieldByName('id').AsInteger;
      Despesa.IdCategoria := FQueryDetail.FieldByName('id_categoria').AsInteger;
      Despesa.CategoriaNome := FQueryDetail.FieldByName('categoria_nome').AsString;
      Despesa.IdFormaPagamento := FQueryDetail.FieldByName('id_forma_pagamento').AsInteger;
      Despesa.FormaPagamentoNome := FQueryDetail.FieldByName('forma_pagamento_nome').AsString;
      Despesa.Descricao := FQueryDetail.FieldByName('descricao').AsString;
      Despesa.Valor := FQueryDetail.FieldByName('valor').AsCurrency;
      Despesa.Pago := FQueryDetail.FieldByName('pago').AsBoolean;

      Result.Add(Despesa);
      FQueryDetail.Next;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TOrcamentoService.ListarTodos: TObjectList<TOrcamento>;
var
  Orcamento: TOrcamento;
  QryLista: TFDQuery;
  Ids: array of Integer;
  Count, I: Integer;
begin
  Result := TObjectList<TOrcamento>.Create(True);
  QryLista := TFDQuery.Create(nil);
  try
    QryLista.Connection := dtmDataBase.FDConnection;
    QryLista.SQL.Text := 'SELECT id FROM orcamento ORDER BY id DESC';
    QryLista.Open;

    // Coleta todos os IDs primeiro, para liberar o cursor antes de chamar ObterPorId
    Count := 0;
    SetLength(Ids, 64);
    while not QryLista.Eof do
    begin
      if Count >= Length(Ids) then
        SetLength(Ids, Length(Ids) * 2);
      Ids[Count] := QryLista.FieldByName('id').AsInteger;
      Inc(Count);
      QryLista.Next;
    end;
    QryLista.Close;

    for I := 0 to Count - 1 do
    begin
      Orcamento := ObterPorId(Ids[I]);
      if Assigned(Orcamento) then
        Result.Add(Orcamento);
    end;
  except
    QryLista.Free;
    Result.Free;
    raise;
  end;
  QryLista.Free;
end;

function TOrcamentoService.ObterDespesaPorId(const AId: integer): TOrcamentoDespesa;
begin
  Result := nil;
  FQueryDetail.Close;
  FQueryDetail.SQL.Text :=
    'SELECT d.*, c.nome AS categoria_nome, f.nome AS forma_pagamento_nome ' +
    'FROM orcamento_despesa d ' +
    'LEFT JOIN categoria c ON c.id = d.id_categoria ' +
    'LEFT JOIN forma_pagamento f ON f.id = d.id_forma_pagamento ' +
    'WHERE d.id = :id';
  FQueryDetail.ParamByName('id').AsInteger := AId;
  FQueryDetail.Open;

  if not FQueryDetail.IsEmpty then
  begin
    Result := TOrcamentoDespesa.Create;
    Result.Id := FQueryDetail.FieldByName('id').AsInteger;
    Result.IdCategoria := FQueryDetail.FieldByName('id_categoria').AsInteger;
    Result.CategoriaNome := FQueryDetail.FieldByName('categoria_nome').AsString;
    Result.IdFormaPagamento := FQueryDetail.FieldByName('id_forma_pagamento').AsInteger;
    Result.FormaPagamentoNome := FQueryDetail.FieldByName('forma_pagamento_nome').AsString;
    Result.Descricao := FQueryDetail.FieldByName('descricao').AsString;
    Result.Valor := FQueryDetail.FieldByName('valor').AsCurrency;
    Result.Pago := FQueryDetail.FieldByName('pago').AsBoolean;
  end;
end;

function TOrcamentoService.ObterPorId(const AId: integer): TOrcamento;
var
  Despesa: TOrcamentoDespesa;
begin
  Result := nil;

  FQueryMaster.Close;
  FQueryMaster.Params.Clear;
  FQueryMaster.SQL.Clear;
  FQueryMaster.SQL.Text :=
    'SELECT o.id, o.mes_ano, o.salario_liquido, o.renda_extra, ' +
    '       o.meta_investimento, o.observacao ' +
    'FROM orcamento o ' +
    'WHERE o.id = :id';
  FQueryMaster.ParamByName('id').AsInteger := AId;
  FQueryMaster.Open;

  if not FQueryMaster.IsEmpty then
  begin
    Result := TOrcamento.Create;
    Result.Id := FQueryMaster.FieldByName('id').AsInteger;
    Result.MesAno := FQueryMaster.FieldByName('mes_ano').AsString;
    Result.SalarioLiquido := FQueryMaster.FieldByName('salario_liquido').AsCurrency;
    Result.RendaExtra := FQueryMaster.FieldByName('renda_extra').AsCurrency;
    Result.MetaInvestimento := FQueryMaster.FieldByName('meta_investimento').AsCurrency;
    Result.Observacao := FQueryMaster.FieldByName('observacao').AsString;

    FQueryDetail.Close;
    FQueryDetail.Params.Clear;
    FQueryDetail.SQL.Clear;
    FQueryDetail.SQL.Text :=
      'SELECT d.id, d.id_orcamento, d.id_categoria, d.id_forma_pagamento, ' +
      '       d.descricao, d.valor, d.pago, ' +
      '       c.nome AS categoria_nome, f.nome AS forma_pagamento_nome ' +
      'FROM orcamento_despesa d ' +
      'LEFT JOIN categoria c ON c.id = d.id_categoria ' +
      'LEFT JOIN forma_pagamento f ON f.id = d.id_forma_pagamento ' +
      'WHERE d.id_orcamento = :id_orcamento ' +
      'ORDER BY d.id';

    FQueryDetail.ParamByName('id_orcamento').AsInteger := AId;
    FQueryDetail.Open;

    while not FQueryDetail.Eof do
    begin
      Despesa := TOrcamentoDespesa.Create;
      Despesa.Id := FQueryDetail.FieldByName('id').AsInteger;
      Despesa.IdOrcamento := FQueryDetail.FieldByName('id_orcamento').AsInteger;
      Despesa.IdCategoria := FQueryDetail.FieldByName('id_categoria').AsInteger;
      Despesa.CategoriaNome := FQueryDetail.FieldByName('categoria_nome').AsString;
      Despesa.IdFormaPagamento := FQueryDetail.FieldByName('id_forma_pagamento').AsInteger;
      Despesa.FormaPagamentoNome := FQueryDetail.FieldByName('forma_pagamento_nome').AsString;
      Despesa.Descricao := FQueryDetail.FieldByName('descricao').AsString;
      Despesa.Valor := FQueryDetail.FieldByName('valor').AsCurrency;
      Despesa.Pago := FQueryDetail.FieldByName('pago').AsBoolean;

      Result.Despesas.Add(Despesa);
      FQueryDetail.Next;
    end;
  end;
end;

function TOrcamentoService.Salvar(const AOrcamento: TOrcamento): boolean;
var Despesa: TOrcamentoDespesa;
begin
  Result := False;

  dtmDataBase.FDConnection.StartTransaction;
  try
    if AOrcamento.Id = 0 then
    begin
      FQueryMaster.Close;
      FQueryMaster.Params.Clear;
      FQueryMaster.SQL.Clear;
      FQueryMaster.SQL.Text :=
        'INSERT INTO orcamento '+
        '(mes_ano, salario_liquido, renda_extra, meta_investimento, observacao) ' +
        'VALUES (:mes_ano, :salario_liquido, :renda_extra, :meta_investimento, :observacao) RETURNING id';

      FQueryMaster.ParamByName('mes_ano').AsString := AOrcamento.MesAno;
      FQueryMaster.ParamByName('salario_liquido').AsCurrency := AOrcamento.SalarioLiquido;
      FQueryMaster.ParamByName('renda_extra').AsCurrency := AOrcamento.RendaExtra;
      FQueryMaster.ParamByName('meta_investimento').AsCurrency := AOrcamento.MetaInvestimento;
      FQueryMaster.ParamByName('observacao').AsString := AOrcamento.Observacao;
      FQueryMaster.Open;

      if not FQueryMaster.IsEmpty then
        AOrcamento.Id := FQueryMaster.FieldByName('id').AsInteger;
    end
    else
    begin
      FQueryMaster.Close;
      FQueryMaster.Params.Clear;
      FQueryMaster.SQL.Clear;
      FQueryMaster.SQL.Text :=
        'UPDATE orcamento ' +
        'SET mes_ano = :mes_ano, salario_liquido = :salario_liquido, ' +
        'renda_extra = :renda_extra, meta_investimento = :meta_investimento, ' +
        'observacao = :observacao ' +
        'WHERE id = :id';

      FQueryMaster.ParamByName('mes_ano').AsString := AOrcamento.MesAno;
      FQueryMaster.ParamByName('salario_liquido').AsCurrency := AOrcamento.SalarioLiquido;
      FQueryMaster.ParamByName('renda_extra').AsCurrency := AOrcamento.RendaExtra;
      FQueryMaster.ParamByName('meta_investimento').AsCurrency := AOrcamento.MetaInvestimento;
      FQueryMaster.ParamByName('observacao').AsString := AOrcamento.Observacao;
      FQueryMaster.ParamByName('id').AsInteger := AOrcamento.Id;
      FQueryMaster.ExecSQL;

      FQueryDetail.Close;
      FQueryDetail.Params.Clear;
      FQueryDetail.SQL.Clear;
      FQueryDetail.SQL.Text := 'DELETE FROM orcamento_despesa WHERE id_orcamento = :id_orcamento';
      FQueryDetail.ParamByName('id_orcamento').AsInteger := AOrcamento.Id;
      FQueryDetail.ExecSQL;
    end;

    for Despesa in AOrcamento.Despesas do
    begin
      FQueryDetail.Close;
      FQueryDetail.Params.Clear;
      FQueryDetail.SQL.Clear;
      FQueryDetail.SQL.Text :=
        'INSERT INTO orcamento_despesa ' +
        '(id_orcamento, id_categoria, id_forma_pagamento, descricao, valor, pago) ' +
        'VALUES (:id_orcamento, :id_categoria, :id_forma_pagamento, :descricao, :valor, :pago) RETURNING id';

      FQueryDetail.ParamByName('id_orcamento').AsInteger := AOrcamento.Id;
      FQueryDetail.ParamByName('id_categoria').AsInteger := Despesa.IdCategoria;
      FQueryDetail.ParamByName('id_forma_pagamento').AsInteger := Despesa.IdFormaPagamento;
      FQueryDetail.ParamByName('descricao').AsString := Despesa.Descricao;
      FQueryDetail.ParamByName('valor').AsCurrency := Despesa.Valor;
      FQueryDetail.ParamByName('pago').AsBoolean := Despesa.Pago;
      FQueryDetail.Open;

      if not FQueryDetail.IsEmpty then
        Despesa.Id := FQueryDetail.FieldByName('id').AsInteger;
    end;

    dtmDataBase.FDConnection.Commit;
    Result := True;
  except
    dtmDataBase.FDConnection.Rollback;
    raise;
  end;
end;

end.

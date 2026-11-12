unit FormaPagamentoService;

interface

uses
  FormaPagamentoModel, uDataModule,
  System.SysUtils, System.Generics.Collections, FireDAC.Comp.Client;

type
  TFormaPagamentoService = class
    private
      FQuery: TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;
      function Inserir(const AFormaPagamento: TFormaPagamento): boolean;
      function Atualizar(const AFormaPagamento: TFormaPagamento): boolean;
      function Excluir(const AId: integer): boolean;
      function ObterPorId(const AId: integer): TFormaPagamento;
      function ListarTodas: TObjectList<TFormaPagamento>;
  end;

implementation

{ TFormaPagamentoService }

function TFormaPagamentoService.Atualizar(
  const AFormaPagamento: TFormaPagamento): boolean;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'UPDATE forma_pagamento SET nome = :nome WHERE id = :id';

  FQuery.ParamByName('nome').AsString := AFormaPagamento.Nome;
  FQuery.ParamByName('id').AsInteger := AFormaPagamento.Id;
  Fquery.ExecSQL;

  Result := Fquery.RowsAffected > 0;
end;

constructor TFormaPagamentoService.Create;
begin
  inherited Create;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := dtmDatabase.FDConnection;
end;

destructor TFormaPagamentoService.Destroy;
begin
  FQuery.Free;
  inherited Destroy;
end;

function TFormaPagamentoService.Excluir(const AId: integer): boolean;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'DELETE FROM forma_pagamento WHERE id = :id';

  FQuery.ParamByName('id').AsInteger := AId;
  Fquery.ExecSQL;

  Result := Fquery.RowsAffected > 0;
end;

function TFormaPagamentoService.Inserir(
  const AFormaPagamento: TFormaPagamento): boolean;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'INSERT INTO forma_pagamento (nome) VALUES (:nome) RETURNING id';

  FQuery.ParamByName('nome').AsString := AFormaPagamento.Nome;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    AFormaPagamento.Id := FQuery.FieldByName('id').AsInteger;
    Result := True;
  end;
end;

function TFormaPagamentoService.ListarTodas: TObjectList<TFormaPagamento>;
var FormaPagamento: TFormaPagamento;
begin
  Result := TObjectList<TFormaPagamento>.Create(True);
  try
    FQuery.Close;
    FQuery.SQL.Text := 'SELECT id, nome FROM forma_pagamento ORDER BY nome';
    FQuery.Open;

    while not FQuery.Eof do
    begin
      FormaPagamento := TFormaPagamento.Create;
      FormaPagamento.Id := FQuery.FieldByName('id').AsInteger;
      FormaPagamento.Nome := FQuery.FieldByName('nome').AsString;

      Result.Add(FormaPagamento);
      FQuery.Next;
    end;

  except
    Result.Free;
    raise;
  end;
end;

function TFormaPagamentoService.ObterPorId(const AId: integer): TFormaPagamento;
begin
  Result := nil;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT id, nome FROM forma_pagamento WHERE id = :id';

  FQuery.ParamByName('id').AsInteger := AId;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    Result := TFormaPagamento.Create;
    Result.Id := FQuery.FieldByName('id').AsInteger;
    Result.Nome := FQuery.FieldByName('nome').AsString;
  end;
end;

end.

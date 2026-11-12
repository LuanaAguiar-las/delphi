unit CategoriaService;

interface

uses
  CategoriaModel, uDataModule,
  System.SysUtils, System.Generics.Collections, FireDAC.Comp.Client;

type
  TCategoriaService = class
    private
      FQuery: TFDQuery;
    public
      constructor Create;
      destructor Destroy; override;
      function Inserir(const ACategoria: TCategoria): boolean;
      function Atualizar(const ACategoria: TCategoria): boolean;
      function Excluir(const AId: integer): boolean;
      function ObterPorId(const AId: integer): TCategoria;
      function ListarTodas: TObjectList<TCategoria>;
  end;

implementation

{ TCategoriaService }

function TCategoriaService.Atualizar(const ACategoria: TCategoria): boolean;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'UPDATE categoria SET nome = :nome WHERE id = :id';

  FQuery.ParamByName('nome').AsString := ACategoria.Nome;
  FQuery.ParamByName('id').AsInteger := ACategoria.Id;
  Fquery.ExecSQL;

  Result := Fquery.RowsAffected > 0;
end;

constructor TCategoriaService.Create;
begin
  inherited Create;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := dtmDatabase.FDConnection;
end;

destructor TCategoriaService.Destroy;
begin
  FQuery.Free;
  inherited Destroy;
end;

function TCategoriaService.Excluir(const AId: integer): boolean;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'DELETE FROM categoria WHERE id = :id';

  FQuery.ParamByName('id').AsInteger := AId;
  Fquery.ExecSQL;

  Result := Fquery.RowsAffected > 0;
end;

function TCategoriaService.Inserir(const ACategoria: TCategoria): boolean;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'INSERT INTO categoria (nome) VALUES (:nome) RETURNING id';

  FQuery.ParamByName('nome').AsString := ACategoria.Nome;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    ACategoria.Id := FQuery.FieldByName('id').AsInteger;
    Result := True;
  end;
end;

function TCategoriaService.ListarTodas: TObjectList<TCategoria>;
var Categoria: TCategoria;

begin
  Result := TObjectList<TCategoria>.Create(True);
  try
    FQuery.Close;
    FQuery.SQL.Text := 'SELECT id, nome FROM categoria ORDER BY nome';
    FQuery.Open;

    while not FQuery.Eof do
    begin
      Categoria := TCategoria.Create;
      Categoria.Id := FQuery.FieldByName('id').AsInteger;
      Categoria.Nome := FQuery.FieldByName('nome').AsString;

      Result.Add(Categoria);
      FQuery.Next;
    end;

  except
    Result.Free;
    raise;
  end;
end;

function TCategoriaService.ObterPorId(const AId: integer): TCategoria;
begin
  Result := nil;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT id, nome FROM categoria WHERE id = :id';

  FQuery.ParamByName('id').AsInteger := AId;
  FQuery.Open;

  if not FQuery.IsEmpty then
  begin
    Result := TCategoria.Create;
    Result.Id := FQuery.FieldByName('id').AsInteger;
    Result.Nome := FQuery.FieldByName('nome').AsString;
  end;
end;

end.

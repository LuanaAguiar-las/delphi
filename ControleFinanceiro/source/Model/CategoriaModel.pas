unit CategoriaModel;

interface

uses
System.SysUtils;

type
  TCategoria = class
    private
      FId: integer;
      Fnome: string;
      procedure SetNome(const Value: string);

    public
      Constructor Create;
      property Id: integer read FId write FId;
      property Nome: string read FNome write SetNome;
  end;

implementation

{ TCategoria }

constructor TCategoria.Create;
begin
  inherited Create;
  FId := 0;
  FNome := string.Empty;
end;

procedure TCategoria.SetNome(const Value: string);
begin
  if Trim(Value) = '' then
    raise Exception.Create('Infome o nome da categoria.');

  FNome := Trim(Value);
end;

end.

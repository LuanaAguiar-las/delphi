unit Model.Paises;

interface

type
  TPaisesModel = class

  private
    FNome: string;
    FCapital: string;
    FRegiao: string;
    FPopulacao: string;
    FMoeda: string;

  public
    property Nome: string read FNome;
    property Capital: string read FCapital;
    property Regiao: string read FRegiao;
    property Populacao: string read FPopulacao;
    property Moeda: string read FMoeda;

    procedure CarregarDados(const ANome, ACapital, ARegiao, APopulacao, AMoeda: string);
  end;

implementation

procedure TPaisesModel.CarregarDados(const ANome, ACapital, ARegiao, APopulacao, AMoeda: string);
begin
  FNome := ANome;
  FCapital := ACapital;
  FRegiao := ARegiao;
  FPopulacao := APopulacao;
  FMoeda := AMoeda;

end;

end.

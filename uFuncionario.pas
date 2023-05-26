unit uFuncionario;

interface

type
  TFuncionario = class
  private
    FNome: string;
    FId: Integer;
    FSituacaoDesc: string;
    FSituacao: string;
    FSexo: string;
    FIdDepartamento: Integer;
    FIdCargo: Integer;
    FIdCidade: Integer;
    FSalario: Integer;
    FIdBairro: Integer;
    FDataCriacao: TDateTime;
    FNascimento: string;
    procedure SetNome(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetSexo(const Value: string);
    procedure SetSituacao(const Value: string);
    procedure SetSituacaoDesc(const Value: string);
    procedure SetDataCriacao(const Value: TDateTime);
    procedure SetIdBairro(const Value: Integer);
    procedure SetIdCargo(const Value: Integer);
    procedure SetIdCidade(const Value: Integer);
    procedure SetIdDepartamento(const Value: Integer);
    procedure SetSalario(const Value: Integer);
    procedure SetNascimento(const Value: string);
  public
    property Id : Integer read FId write SetId;
    property Nome : string read FNome write SetNome;
    property Sexo: string read FSexo write SetSexo;
    property Situacao: string read FSituacao write SetSituacao;
    property SituacaoDesc: string read FSituacaoDesc write SetSituacaoDesc;
    property IdDepartamento: Integer read FIdDepartamento write SetIdDepartamento;
    property IdCargo: Integer read FIdCargo write SetIdCargo;
    property Salario: Integer read FSalario write SetSalario;
    property IdCidade: Integer read FIdCidade write SetIdCidade;
    property IdBairro: Integer read FIdBairro write SetIdBairro;
    property DataCriacao: TDateTime read FDataCriacao write SetDataCriacao;
    property Nascimento: string read FNascimento write SetNascimento;
  end;

implementation

{ TFuncionario }

procedure TFuncionario.SetDataCriacao(const Value: TDateTime);
begin
  FDataCriacao := Value;
end;

procedure TFuncionario.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TFuncionario.SetIdBairro(const Value: Integer);
begin
  FIdBairro := Value;
end;

procedure TFuncionario.SetIdCargo(const Value: Integer);
begin
  FIdCargo := Value;
end;

procedure TFuncionario.SetIdCidade(const Value: Integer);
begin
  FIdCidade := Value;
end;

procedure TFuncionario.SetIdDepartamento(const Value: Integer);
begin
  FIdDepartamento := Value;
end;

procedure TFuncionario.SetNascimento(const Value: string);
begin
  FNascimento := Value;
end;

procedure TFuncionario.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TFuncionario.SetSalario(const Value: Integer);
begin
  FSalario := Value;
end;

procedure TFuncionario.SetSexo(const Value: string);
begin
  FSexo := Value;
end;

procedure TFuncionario.SetSituacao(const Value: string);
begin
  FSituacao := Value;
end;

procedure TFuncionario.SetSituacaoDesc(const Value: string);
begin
  FSituacaoDesc := Value;
end;

end.

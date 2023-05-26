unit uDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDM = class(TDataModule)
    conRH: TADOConnection;
    qryGridFunc: TADOQuery;
    qryExec: TADOQuery;
    dsGridFunc: TDataSource;
    qryGridFuncnomeFuncionario: TWideStringField;
    qryGridFuncsexo: TStringField;
    qryGridFuncdepartamento: TWideStringField;
    qryGridFunccargo: TWideStringField;
    qryGridFuncidFuncionario: TAutoIncField;
    qryGridFuncidCargo: TAutoIncField;
    qryGridFuncidDepartamento: TAutoIncField;
    qryGridFuncsalario: TFMTBCDField;
    qryGridFuncsalarioCargo: TFMTBCDField;
    qryGridFuncidCidade: TAutoIncField;
    qryGridFunccidade: TWideStringField;
    qryGridFuncidBairro: TAutoIncField;
    qryGridFuncbairro: TWideStringField;
    qryGridFuncdataCriacao: TDateTimeField;
    qryGridFuncsituacao: TStringField;
    qryGridFuncsituacaoDesc: TStringField;
    qryGridFuncnascimento: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uFuncionario;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Funcionarios1: TMenuItem;
    Panel1: TPanel;
    edtFiltroNome: TLabeledEdit;
    dbgFuncionario: TDBGrid;
    StatusBar1: TStatusBar;
    btnIncluir: TButton;
    btnPesquisar: TButton;
    btnRemover: TButton;
    btnAlterar: TButton;
    procedure FormShow(Sender: TObject);
    procedure Funcionarios1Click(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtFiltroNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgFuncionarioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgFuncionarioDblClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
  private
    { Private declarations }

    procedure pCriarFuncionario;
    procedure pGravarFuncionario;

  public
    { Public declarations }
    FFuncionario: TFuncionario;

    procedure pContarRegistro;
    procedure pAbrirTelaInclusao;
    procedure pAbrirTelaAlteracao;
    procedure pAbrirGridFuncionario;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
uses uDM, vCadFuncionario, uFuncLH;

procedure TfrmMain.btnAlterarClick(Sender: TObject);
begin
  Self.pCriarFuncionario;
  Self.pGravarFuncionario;
  Self.pAbrirTelaAlteracao;
end;

procedure TfrmMain.btnIncluirClick(Sender: TObject);
begin
  Self.pCriarFuncionario;
  Self.pAbrirTelaInclusao;
end;

procedure TfrmMain.btnPesquisarClick(Sender: TObject);
begin
  Self.pAbrirGridFuncionario;
end;

procedure TfrmMain.btnRemoverClick(Sender: TObject);
begin
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('delete from funcionario where idFuncionario = '+ DM.qryGridFuncidFuncionario.AsString);
    ExecSQL;
  end;
  pAbrirGridFuncionario;
end;

procedure TfrmMain.edtFiltroNomeKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
    Self.pAbrirGridFuncionario;

  if not (Key in['A'..'Z','a'..'z',#8,#32,#3,#22,#24]) then
  Key := #0;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Habilitar a sele��o da linha ao clicar na c�lula.
  dbgFuncionario.Options := dbgFuncionario.Options + [dgRowSelect];
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // Abrir o grid ao executar o programa
  Self.pAbrirGridFuncionario;
end;

procedure TfrmMain.Funcionarios1Click(Sender: TObject);
begin
  btnIncluirClick(Sender);
end;

procedure TfrmMain.dbgFuncionarioDblClick(Sender: TObject);
begin
  btnAlterarClick(Sender);
end;

procedure TfrmMain.dbgFuncionarioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // Mudar a cor da linha quando o funcion�rio estiver cancelado.
  if DM.qryGridFunc.FieldByName('situacaoDesc').AsString = 'CANCELADO' then
  begin
    dbgFuncionario.Canvas.Brush.Color := clSilver;
    dbgFuncionario.Canvas.FillRect(Rect);
  end;

  // Manter cor de sele��o mesmo se sair do GRID.
  if (gdSelected in State) then
  begin
    dbgFuncionario.Canvas.Brush.Color := clHighlight;
    dbgFuncionario.Canvas.Font.Color := clHighlightText;
  end;

    dbgFuncionario.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmMain.pAbrirGridFuncionario;
var vValorFiltro: string;
begin
  vValorFiltro := Trim(edtFiltroNome.Text);
  vValorFiltro := '%'+vValorFiltro+'%';
  with DM.qryGridFunc do
  begin
    Close;
    Parameters.ParamByName('varNome').Value := vValorFiltro;
    Open;
  end;
  Self.pContarRegistro;
end;

procedure TfrmMain.pAbrirTelaAlteracao;
var t, i: Integer;
begin
  frmCadFuncionario.btnLimpar.Visible := False;

  frmCadFuncionario.pLimparCamposCadFuncionario;
  frmCadFuncionario.edtNomeFuncionario.Text := FFuncionario.Nome;

  //## SEXO ##
  //Definir item da lista
  t := frmCadFuncionario.cbxSexo.Items.Count-1;
  for i := 0 to t do
  begin
    if frmCadFuncionario.cbxSexo.Items.Strings[i] = DM.qryGridFuncsexo.AsString then
    begin
      frmCadFuncionario.cbxSexo.ItemIndex := i;
      Break;
    end;
  end;

  //## CIDADE ##
  //Preencher lista
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cidade from cidade');
    Open;
    First;
  end;
  frmCadFuncionario.cbxCidade.Items.Clear;
  repeat
    frmCadFuncionario.cbxCidade.Items.Add(DM.qryExec.FieldByName('cidade').AsString);
    DM.qryExec.Next;
  until DM.qryExec.Eof;
  DM.qryExec.Close;
  //Definir item da lista
  t := frmCadFuncionario.cbxCidade.Items.Count-1;
  for i := 0 to t do
  begin
    if frmCadFuncionario.cbxCidade.Items.Strings[i] = DM.qryGridFunccidade.AsString then
    begin
      frmCadFuncionario.cbxCidade.ItemIndex := i;
      Break;
    end;
  end;
  // Preencher lblIdCidade
  frmCadFuncionario.lblIdCidade.Caption := DM.qryGridFuncidCidade.AsString;

  //## BAIRRO ##
  //Preencher lista
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select bairro from bairro where idCidade = '+ DM.qryGridFuncidCidade.AsString);
    Open;
    First;
  end;
  frmCadFuncionario.cbxBairro.Items.Clear;
  repeat
    frmCadFuncionario.cbxBairro.Items.Add(DM.qryExec.FieldByName('bairro').AsString);
    DM.qryExec.Next;
  until DM.qryExec.Eof;
  DM.qryExec.Close;
  //Definir item da lista
  t := frmCadFuncionario.cbxBairro.Items.Count-1;
  for i := 0 to t do
  begin
    if frmCadFuncionario.cbxBairro.Items.Strings[i] = DM.qryGridFuncbairro.AsString then
    begin
      frmCadFuncionario.cbxBairro.ItemIndex := i;
      Break;
    end;
  end;
  // Preencher lblIdBairro
  frmCadFuncionario.lblIdBairro.Caption := DM.qryGridFuncidBairro.AsString;

  //## DEPARTAMENTO ##
  //Preencher lista
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select departamento from departamento');
    Open;
    First;
  end;
  frmCadFuncionario.cbxDepartamento.Items.Clear;
  repeat
    frmCadFuncionario.cbxDepartamento.Items.Add(DM.qryExec.FieldByName('departamento').AsString);
    DM.qryExec.Next;
  until DM.qryExec.Eof;
  DM.qryExec.Close;
  //Definir item da lista
  t := frmCadFuncionario.cbxDepartamento.Items.Count-1;
  for i := 0 to t do
  begin
    if frmCadFuncionario.cbxDepartamento.Items.Strings[i] = DM.qryGridFuncdepartamento.AsString then
    begin
      frmCadFuncionario.cbxDepartamento.ItemIndex := i;
      Break;
    end;
  end;
  // Preencher lblIdDepartamento
  frmCadFuncionario.lblIdDepartamento.Caption := DM.qryGridFuncidDepartamento.AsString;

  //## CARGO ##
  //Preencher lista
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cargo from cargo where idDepartamento = '+ DM.qryGridFuncidDepartamento.AsString);
    Open;
    First;
  end;
  frmCadFuncionario.cbxCargo.Items.Clear;
  repeat
    frmCadFuncionario.cbxCargo.Items.Add(DM.qryExec.FieldByName('cargo').AsString);
    DM.qryExec.Next;
  until DM.qryExec.Eof;
  DM.qryExec.Close;
  //Definir item da lista
  t := frmCadFuncionario.cbxCargo.Items.Count-1;
  for i := 0 to t do
  begin
    if frmCadFuncionario.cbxCargo.Items.Strings[i] = DM.qryGridFunccargo.AsString then
    begin
      frmCadFuncionario.cbxCargo.ItemIndex := i;
      Break;
    end;
  end;
  // Preencher lblIdCargo
  frmCadFuncionario.lblIdCargo.Caption := DM.qryGridFuncidCargo.AsString;

  //## SITUA��O ##
  //Definir item da lista
  t := frmCadFuncionario.cbxSituacao.Items.Count-1;
  for i := 0 to t do
  begin
    if frmCadFuncionario.cbxSituacao.Items.Strings[i] = DM.qryGridFuncsituacaoDesc.AsString then
    begin
      frmCadFuncionario.cbxSituacao.ItemIndex := i;
      Break;
    end;
  end;
  // Preencher lblIdSituacao
  frmCadFuncionario.lblIdSituacao.Caption := DM.qryGridFuncsituacao.AsString;

  frmCadFuncionario.edtSalario.Text :=  FormatFloat('#,###.##',DM.qryGridFuncsalario.AsCurrency);
  frmCadFuncionario.edtDataCriacao.Text := DateTimeToStr(FFuncionario.DataCriacao);
  frmCadFuncionario.medNascimento.Text :=   FormatDateTime('dd/mm/yyyy',dm.qryGridFuncnascimento.AsDateTime);
  frmCadFuncionario.lblTipoTransacao.Caption := 'U';
  frmCadFuncionario.ShowModal;
end;

procedure TfrmMain.pAbrirTelaInclusao;
begin
  frmCadFuncionario.btnLimpar.Visible := True;

  //## CIDADE ##
  //Preencher lista
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select cidade from cidade');
    Open;
    First;
  end;
  frmCadFuncionario.cbxCidade.Items.Clear;
  repeat
    frmCadFuncionario.cbxCidade.Items.Add(DM.qryExec.FieldByName('cidade').AsString);
    DM.qryExec.Next;
  until DM.qryExec.Eof;
  DM.qryExec.Close;
  frmCadFuncionario.cbxCidade.ItemIndex := -1;

  //## DEPARTAMENTO ##
  //Preencher lista
  with DM.qryExec do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select departamento from departamento');
    Open;
    First;
  end;
  frmCadFuncionario.cbxDepartamento.Items.Clear;
  repeat
    frmCadFuncionario.cbxDepartamento.Items.Add(DM.qryExec.FieldByName('departamento').AsString);
    DM.qryExec.Next;
  until DM.qryExec.Eof;
  DM.qryExec.Close;
  frmCadFuncionario.cbxDepartamento.ItemIndex := -1;

  frmCadFuncionario.pLimparCamposCadFuncionario;
  frmCadFuncionario.lblTipoTransacao.Caption := 'I';
  frmCadFuncionario.ShowModal;
end;

procedure TfrmMain.pContarRegistro;
begin
  if dm.qryGridFunc.Active then
  begin
    StatusBar1.Panels.Items[2].Text :=  uFuncLH.FormatarInteiro(dm.qryGridFunc.RecordCount);
  end;
end;

procedure TfrmMain.pCriarFuncionario;
begin
  FFuncionario := TFuncionario.Create();
end;

procedure TfrmMain.pGravarFuncionario;
begin
  FFuncionario.Id             := DM.qryGridFunc.FieldByName('IdFuncionario').AsInteger;
  FFuncionario.Nome           := DM.qryGridFunc.FieldByName('NomeFuncionario').AsString;
  FFuncionario.Sexo           := DM.qryGridFunc.FieldByName('sexo').AsString;
  FFuncionario.Situacao       := DM.qryGridFunc.FieldByName('situacao').AsString;
  FFuncionario.SituacaoDesc   := DM.qryGridFunc.FieldByName('situacaoDesc').AsString;
  FFuncionario.IdDepartamento := DM.qryGridFunc.FieldByName('idDepartamento').AsInteger;
  FFuncionario.IdCargo        := DM.qryGridFunc.FieldByName('idCargo').AsInteger;
  FFuncionario.Salario        := DM.qryGridFunc.FieldByName('salario').AsInteger;
  FFuncionario.IdCidade       := DM.qryGridFunc.FieldByName('idCidade').AsInteger;
  FFuncionario.IdBairro       := DM.qryGridFunc.FieldByName('idBairro').AsInteger;
  FFuncionario.DataCriacao    := DM.qryGridFunc.FieldByName('dataCriacao').AsDateTime;
  FFuncionario.Nascimento     := FormatDateTime('dd/mm/yyyy',DM.qryGridFunc.FieldByName('nascimento').AsDateTime);
end;

end.

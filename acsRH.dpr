program acsRH;

uses
  Vcl.Forms,
  vMain in 'vMain.pas' {frmMain},
  uDM in 'uDM.pas' {DM: TDataModule},
  vCadFuncionario in 'vCadFuncionario.pas' {frmCadFuncionario},
  uFuncLH in 'uFuncLH.pas',
  uFuncionario in 'uFuncionario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCadFuncionario, frmCadFuncionario);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmCadFuncionario, frmCadFuncionario);
  Application.Run;
end.

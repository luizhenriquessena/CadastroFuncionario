unit uFuncLH;

interface

uses
  Controls, SysUtils, Grids, DBGrids;

  function FormatarReal(vValor:Real):String;
  function FormatarInteiro(vValor:Integer):String;
  function FormatarDecimal(vValor:Real):String;
  function ApenasNumeros(vValor:string):Integer;
  function ApenasLetras(vValor:string):string;
  procedure DimensionarGrid(dbg: TDbGrid; var formulario);

  var
  vTXT1: String;
  vN1: Integer;
  vR1: Real;
implementation

function FormatarReal(vValor:Real) : String; //Fun��o para formatar valor para Real R$
begin
  vTXT1  := FormatFloat('R$ #,##0.00',vValor);
  Result := vTXT1;
end;

function FormatarInteiro(vValor:Integer):String; //Fun��o para formatar valor para inteiro com pontua��o.
begin
  vTXT1  := FormatFloat('#,##0',vValor);
  Result := vTXT1;
end;

function ApenasNumeros(vValor:String):Integer; // Fun��o para deixar apenas o numeros
var i, vNumero : Integer;
begin
  vTXT1 := '';

  for i := 1 to Length(vValor) do
  begin
    if (vValor[i] in ['0'..'9']) then
    begin
      vTXT1 := vTXT1 + Copy(vValor,i,1);
    end;
  end;

  if Length(vTXT1)>0 then
    vNumero := StrtoInt(vTXT1);

  result := vNumero;
end;

function ApenasLetras(vValor:String):String; // Fun��o para deixar apenas as letras
var i : Integer;
begin
  vTXT1 := '';

  for i := 1 to Length(vValor) do
  begin
    if (vValor[i] in ['A'..'Z','a'..'z',#32]) then
    begin
      vTXT1 := vTXT1 + Copy(vValor,i,1);
    end;
  end;

  result := vTXT1;
end;

function FormatarDecimal(vValor:Real) :String; //Fun��o para formatar valor com decimal
begin
  vTXT1  := FormatFloat('#,##0.00',vValor);
  Result := vTXT1;
end;

procedure DimensionarGrid(dbg: TDbGrid; var formulario);
var
   f, t, Idx: Integer;
begin
   for Idx := 0 to dbg.Columns.Count - 1  do
   begin
     f := dbg.Canvas.TextWidth(Dbg.Columns[Idx].Field.AsString + 'AAA');
     t := dbg.Canvas.TextWidth(Dbg.Columns[Idx].Title.Caption+'AAA');
     if f < t then
       dbg.Columns[Idx].Width := t
     else
       dbg.Columns[Idx].Width := f;
   end;
end;
end.

unit uSimbolTaktis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, uDBAsset_FontTaktis, StdCtrls, ufrmSummaryVehicle;

type
  TSimbolTaktis = class(TForm)
    drwgrdFontTaktis: TDrawGrid;
    btnOK: TButton;
    btnCancel: TButton;
    edt_searchsimbol: TEdit;
    lbl1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure drwgrdFontTaktisDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edt_searchsimbolKeyPress(Sender: TObject; var Key: Char);
    procedure filtersearch; //dng
  private
    { Private declarations }
  public
    { Public declarations }
    FontType : Byte;  // 0 : AD, 1 : AL, 2 : AU
    FontTaktisList : TList;
  end;

var
  SimbolTaktis: TSimbolTaktis;

implementation


{$R *.dfm}

uses uDataModule, uPlottingEditor;

procedure TSimbolTaktis.btnCancelClick(Sender: TObject);
begin
  edt_searchsimbol.Text := '';
  Close;
end;

procedure TSimbolTaktis.btnOKClick(Sender: TObject);
begin
  frmSummaryVehicle.edtFontID.Text := IntToStr(TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_ID);
  frmSummaryVehicle.lblFontTaktis.Font.Name := TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_NAME;
  frmSummaryVehicle.lblFontTaktis.Font.Size := 30;
  frmSummaryVehicle.lblFontTaktis.Font.Style := [fsBold];
  frmSummaryVehicle.lblFontTaktis.Caption := Char(TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_INDEX);
  frmSummaryVehicle.lblKeteranganSymbol.Caption := TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.KETERANGAN;
  Close;
end;

procedure TSimbolTaktis.drwgrdFontTaktisDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 b, i : integer;
 aFontTaktis : TFontTaktis;
begin
  if not (gdFixed in state) then
  begin
    if FontTaktisList.Count > 0 then
    begin
      drwgrdFontTaktis.Canvas.Font.Name := 'calibri';
      aFontTaktis := TFontTaktis(FontTaktisList.Items[aRow]);
      drwgrdFontTaktis.Canvas.Font.Size := 12;
      drwgrdFontTaktis.Canvas.TextOut(Rect.Left + 10, Rect.Top + 10, IntToStr(aRow + 1) + '.');
     // drwgrdFontTaktis.Canvas.TextOut(Rect.Left + 100, Rect.Top + 10, '( '+ aFontTaktis.FData.FONT_NAME + ' )');

      drwgrdFontTaktis.Canvas.TextOut(Rect.Left + 120, Rect.Top + 10, aFontTaktis.FData.KETERANGAN);
      drwgrdFontTaktis.Canvas.Font.Name := aFontTaktis.FData.FONT_NAME;
      drwgrdFontTaktis.Canvas.Font.Style := [fsBold];
      drwgrdFontTaktis.Canvas.Font.Size := 24;
      drwgrdFontTaktis.Canvas.TextOut(Rect.Left + 60, Rect.Top, char(aFontTaktis.FData.FONT_INDEX));
    end;
  end;
end;

procedure TSimbolTaktis.edt_searchsimbolKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    filtersearch;
  end;
end;

procedure TSimbolTaktis.filtersearch;
var
 i : Integer;
begin
  if Assigned(FontTaktisList) then
    FontTaktisList.Clear
  else
    FontTaktisList.Create;

  dmTTT.getFilterSimbol(edt_searchsimbol.Text,FontType,FontTaktisList);
  drwgrdFontTaktis.RowCount := FontTaktisList.Count;
  drwgrdFontTaktis.SetFocus;
end;

procedure TSimbolTaktis.FormCreate(Sender: TObject);
begin
  FontTaktisList := TList.Create;
end;

procedure TSimbolTaktis.FormDestroy(Sender: TObject);
begin
  FontTaktisList.Free;
end;

procedure TSimbolTaktis.FormShow(Sender: TObject);
begin
  if Assigned(FontTaktisList) then
    FontTaktisList.Clear
  else
    FontTaktisList.Create;

  dmTTT.getAllFontTaktis(FontTaktisList, FontType);
end;

end.
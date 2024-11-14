unit ufrmSelectSimbolTaktis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, uClassData, StdCtrls;

type
  TfrmSelectSimbolTaktis = class(TForm)
    drwgrdFontTaktis: TDrawGrid;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure drwgrdFontTaktisDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FontTaktisList : TList;
  public
    { Public declarations }
    FontType : Byte;  // 0 : AD, 1 : AL, 2 : AU
  end;

var
  frmSelectSimbolTaktis: TfrmSelectSimbolTaktis;

implementation

{$R *.dfm}

uses uDataModule,ufrmOverlayTools;

procedure TfrmSelectSimbolTaktis.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelectSimbolTaktis.btnOKClick(Sender: TObject);
begin
  frmOverlayTools.lblSymbolTaktis.Font.Name := TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_NAME;
  frmOverlayTools.lblSymbolTaktis.Font.Size := 30;
  frmOverlayTools.lblSymbolTaktis.Font.Style := [fsBold];
  frmOverlayTools.lblSymbolTaktis.Caption := Char(TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_INDEX);

  frmOverlayTools.lblTacticalSymbolPlatform.Font.Name := TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_NAME;
  frmOverlayTools.lblTacticalSymbolPlatform.Font.Size := 30;
  frmOverlayTools.lblTacticalSymbolPlatform.Font.Style := [fsBold];
  frmOverlayTools.lblTacticalSymbolPlatform.Caption := Char(TFontTaktis(FontTaktisList.Items[drwgrdFontTaktis.Row]).FData.FONT_INDEX);
  Close;
end;

procedure TfrmSelectSimbolTaktis.drwgrdFontTaktisDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 b, i : integer;
 aFontTaktis : TFontTaktis;
begin
  if not (gdFixed in state) then
  begin
    drwgrdFontTaktis.Canvas.Font.Name := 'calibri';
    aFontTaktis := TFontTaktis(FontTaktisList.Items[aRow]);
    drwgrdFontTaktis.Canvas.TextOut(Rect.Left + 120, Rect.Top + 10, aFontTaktis.FData.KETERANGAN);
    drwgrdFontTaktis.Canvas.Font.Name := aFontTaktis.FData.FONT_NAME;
    drwgrdFontTaktis.Canvas.Font.Style := [fsBold];
    drwgrdFontTaktis.Canvas.Font.Size := 24;
    drwgrdFontTaktis.Canvas.TextOut(Rect.Left + 60, Rect.Top, char(aFontTaktis.FData.FONT_INDEX));

  end;
end;

procedure TfrmSelectSimbolTaktis.FormCreate(Sender: TObject);
begin
  FontTaktisList := TList.Create;
end;

procedure TfrmSelectSimbolTaktis.FormDestroy(Sender: TObject);
begin
  FontTaktisList.Free;
end;

procedure TfrmSelectSimbolTaktis.FormShow(Sender: TObject);
begin
  if Assigned(FontTaktisList) then
    FontTaktisList.Clear
  else
    FontTaktisList.Create;

  dmINWO.getAllFontTaktis(FontTaktisList, 0);
end;

end.

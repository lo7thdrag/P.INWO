unit ufrmOverlayTools;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ColorGrd, Vcl.Imaging.pngimage;

const
  ovText      = 1;
  ovLine      = 2;
  ovRectangle = 3;
  ovCircle    = 4;
  ovEllipse   = 5;
  ovArc       = 6;
  ovSector    = 7;
  ovGrid      = 8;
  ovPolygon   = 9;

type
  E_OverlayMapCursor = (mcSelect, mcAdd, mcEdit, mcRulerStart, mcRulerEnd);

  TfrmOverlayTools = class(TForm)
    btnSelect: TImage;
    pnlArrow: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblArrowName: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnStartPos: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    btnEndPos: TSpeedButton;
    edtStartLong: TEdit;
    edtStartLatt: TEdit;
    edtEndLong: TEdit;
    edtEndLatt: TEdit;
    pnlBase: TPanel;
    Bevel1: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    lblBaseName: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnPosBase: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblSymbolTaktis: TLabel;
    edtLongBase: TEdit;
    edtLattBase: TEdit;
    btnEditBase: TButton;
    btnDeleteBase: TButton;
    btnClearBase: TButton;
    btnInsertBase: TButton;
    lvBase: TListView;
    edtQty: TEdit;
    edtPlatform: TEdit;
    btnplatform: TButton;
    pnlLogistic: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    lblLogisticName: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    btnPosLog: TSpeedButton;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    edtLongLog: TEdit;
    edtLattLog: TEdit;
    btnEditLog: TButton;
    btnDeleteLog: TButton;
    btnClearLog: TButton;
    btnInsertLog: TButton;
    lvLogistic: TListView;
    cbbStatus: TComboBox;
    edtItemLog: TEdit;
    pnlRadar: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    btnPosRadar: TSpeedButton;
    Label31: TLabel;
    lblRadarName: TLabel;
    edtLongRadar: TEdit;
    edtLattRadar: TEdit;
    edtRadius: TEdit;
    pnlShape: TPanel;
    pnlMainTop: TPanel;
    cbbTypeTools: TComboBox;
    grpText: TGroupBox;
    lblTextPosition: TLabel;
    lblTextField: TLabel;
    lblTextSize: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl92: TLabel;
    bvl12: TBevel;
    bvl13: TBevel;
    lbl96: TLabel;
    lbl97: TLabel;
    SpeedButton: TSpeedButton;
    edtTextField: TEdit;
    cbbTextSize: TComboBox;
    edtTextPosLAt: TEdit;
    edtTextPosLong: TEdit;
    grpArc: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl9: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    btn1: TSpeedButton;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl39: TLabel;
    lbl75: TLabel;
    lbl77: TLabel;
    lbl78: TLabel;
    lbl12: TLabel;
    bvl1: TBevel;
    lbl13: TLabel;
    bvl2: TBevel;
    edtArcPosLat: TEdit;
    edtArcPosLong: TEdit;
    edtArcRadius: TEdit;
    edtArcStartAngle: TEdit;
    edtArcEndAngle: TEdit;
    grpCircle: TGroupBox;
    lbl34: TLabel;
    lbl35: TLabel;
    lbl36: TLabel;
    btn2: TSpeedButton;
    lbl14: TLabel;
    lbl15: TLabel;
    bvl3: TBevel;
    lbl84: TLabel;
    lbl86: TLabel;
    lbl87: TLabel;
    lbl16: TLabel;
    edtCirclePosLong: TEdit;
    edtCircleRadius: TEdit;
    edtCirclePosLat: TEdit;
    grpEllipse: TGroupBox;
    lbl17: TLabel;
    lblHorizontal: TLabel;
    lbl18: TLabel;
    lblVertical: TLabel;
    lbl19: TLabel;
    bvl4: TBevel;
    lbl20: TLabel;
    btn3: TSpeedButton;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl105: TLabel;
    lbl106: TLabel;
    lbl107: TLabel;
    lbl108: TLabel;
    edtEllipsePosLat: TEdit;
    edtEllipsePosLong: TEdit;
    edtHorizontal: TEdit;
    edtVertical: TEdit;
    grpGrid: TGroupBox;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    bvl5: TBevel;
    lbl30: TLabel;
    lbl31: TLabel;
    btn4: TSpeedButton;
    lbl32: TLabel;
    lbl33: TLabel;
    lbl115: TLabel;
    lbl116: TLabel;
    lbl117: TLabel;
    lbl118: TLabel;
    lbl119: TLabel;
    lbl120: TLabel;
    lbl121: TLabel;
    lbl37: TLabel;
    bvl7: TBevel;
    lbl38: TLabel;
    lbl40: TLabel;
    edtTablePosLat: TEdit;
    edtTablePosLong: TEdit;
    edtTableWidth: TEdit;
    edtTableColumn: TEdit;
    edtTableRow: TEdit;
    edtTableRotationAngle: TEdit;
    edtTableHeight: TEdit;
    grpLine: TGroupBox;
    btn5: TSpeedButton;
    lbl41: TLabel;
    lbl42: TLabel;
    btn6: TSpeedButton;
    lbl43: TLabel;
    lbl44: TLabel;
    lbl45: TLabel;
    lbl46: TLabel;
    lbl47: TLabel;
    lbl48: TLabel;
    lbl94: TLabel;
    lbl99: TLabel;
    bvl8: TBevel;
    edtLineStartPosLat: TEdit;
    edtLineStartPosLong: TEdit;
    edtLineEndPosLat: TEdit;
    edtLineEndPosLong: TEdit;
    grpPolygon: TGroupBox;
    lbl49: TLabel;
    btn7: TSpeedButton;
    lbl50: TLabel;
    lbl51: TLabel;
    lbl122: TLabel;
    lbl123: TLabel;
    edtPolyPosLat: TEdit;
    edtPolyPosLong: TEdit;
    lvPolyVertex: TListView;
    btnDelPoly: TButton;
    btnEditPoly: TButton;
    btnDeletePoly: TButton;
    grpRectangle: TGroupBox;
    lbl60: TLabel;
    lbl61: TLabel;
    btn9: TSpeedButton;
    btn10: TSpeedButton;
    lbl62: TLabel;
    lbl63: TLabel;
    lbl64: TLabel;
    lbl65: TLabel;
    bvl11: TBevel;
    lbl100: TLabel;
    lbl101: TLabel;
    lbl102: TLabel;
    lbl103: TLabel;
    lbl104: TLabel;
    edtRectStartPosLat: TEdit;
    edtRectStartPosLong: TEdit;
    edtRectEndPosLat: TEdit;
    edtRectEndPosLong: TEdit;
    grpSector: TGroupBox;
    lblSectorCenter: TLabel;
    lblSectorInner: TLabel;
    lblSectorOuter: TLabel;
    lblSectorStartAngle: TLabel;
    lblSectorEndAngle: TLabel;
    lbl52: TLabel;
    lbl53: TLabel;
    lbl54: TLabel;
    lbl55: TLabel;
    bvlAngle: TBevel;
    lbl56: TLabel;
    lbl57: TLabel;
    btn8: TSpeedButton;
    lbl58: TLabel;
    lbl59: TLabel;
    bvl9: TBevel;
    lbl109: TLabel;
    lbl110: TLabel;
    lbl111: TLabel;
    lbl112: TLabel;
    lbl113: TLabel;
    lbl114: TLabel;
    edtSectorPosLat: TEdit;
    edtSectorInner: TEdit;
    edtSectorOuter: TEdit;
    edtSectorStartAngle: TEdit;
    edtSectorEndAngle: TEdit;
    edtSectorPosLong: TEdit;
    grpShapeSymbol: TGroupBox;
    btnRectangle: TImage;
    btnPolygon: TImage;
    btnGrid: TImage;
    btnSector: TImage;
    btnArc: TImage;
    btnEllipse: TImage;
    btnCircle: TImage;
    btnLine: TImage;
    btnText: TImage;
    grpColorEditing: TGroupBox;
    btnOutline: TImage;
    btnFill: TImage;
    pnlOutline: TPanel;
    pnlFill: TPanel;
    grbColour: TGroupBox;
    colorChoose: TColorGrid;
    pnl1: TPanel;
    btnNoFill: TStaticText;
    grpLineEditing: TGroupBox;
    pnlPenEditing: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    cbbWeightPen: TComboBox;
    cbbDashesPen: TComboBox;
    Label34: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label35: TLabel;
    Bevel4: TBevel;
    Label36: TLabel;
    Bevel5: TBevel;
    Label37: TLabel;
    Label38: TLabel;
    Bevel6: TBevel;
    Label39: TLabel;
    Label40: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label41: TLabel;
    Bevel9: TBevel;
    Label42: TLabel;
    Bevel10: TBevel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label46: TLabel;
    pnlObject: TPanel;
    pnlMain: TPanel;
    grpColorForce: TGroupBox;
    grpObjectSymbol: TGroupBox;
    Image3: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    pnlMainBottom: TPanel;
    btnApply: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    grpIntelegent: TGroupBox;
    Label17: TLabel;
    Label52: TLabel;
    edtLongIntel: TEdit;
    btnPositionIntel: TSpeedButton;
    Label18: TLabel;
    Label53: TLabel;
    edtLattIntel: TEdit;
    Label19: TLabel;
    mmoInfo: TMemo;
    Label64: TLabel;
    Label77: TLabel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    rbRed: TRadioButton;
    rbBlue: TRadioButton;
    grpNone: TGroupBox;
    Label72: TLabel;
    grpBase: TGroupBox;
    Label68: TLabel;
    grpLogistic: TGroupBox;
    Label15: TLabel;

    procedure btnOutlineClick(Sender: TObject);
    procedure btnHandleShape(Sender: TObject);
    procedure cbbTypeToolsChange(Sender: TObject);

  private
    { Private declarations }
    FTipeOverlay: Integer; { tipe overlay utk kebutuhan tampilan }
    FMapCursor: E_OverlayMapCursor;
  public
    { Public declarations }
    IdAction: Byte; { 1: add; 2: Edit; 3: Delete }

    ShapeType: Integer;

    procedure RefreshMousePointer;
    procedure ClearFlagPoint;
    procedure ClearEditText;
    procedure Canceled;
    procedure LoadPanelText;
    procedure LoadPanelLine;
    procedure LoadPanelRectangle;
    procedure LoadPanelCircle;
    procedure LoadPanelEllipse;
    procedure LoadPanelArc;
    procedure LoadPanelSector;
    procedure LoadPanelGrid;
    procedure LoadPanelPolygon;
    procedure SetNoFill(val: Boolean);

  end;

var
  frmOverlayTools: TfrmOverlayTools;

implementation

{$R *.dfm}


{ TfrmOverlayTools }

procedure TfrmOverlayTools.btnHandleShape(Sender: TObject);
var
  isDynamic: Boolean;
begin
//  LoadNormalButtonImage;
  btnDelete.Enabled := false;

  RefreshMousePointer;
  ClearFlagPoint;
  ClearEditText;
  Canceled;
  IdAction := 1;

  ShapeType := TImage(Sender).Tag;

  case ShapeType of
    0: { Select }
      begin
        btnSelect.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCursor_Select.PNG');
        grpNone.BringToFront;

        { merubah cursor }
        FMapCursor := mcEdit;

        {$REGION ' Button Handle '}
        btnOutline.Visible := false;
        btnFill.Visible := false;
        pnlPenEditing.Visible := false;
        {$ENDREGION}
      end;
    ovText:
      LoadPanelText;
    ovLine:
      LoadPanelLine;
    ovRectangle:
      LoadPanelRectangle;
    ovCircle:
      LoadPanelCircle;
    ovEllipse:
      LoadPanelEllipse;
    ovArc:
      LoadPanelArc;
    ovSector:
      LoadPanelSector;
    ovGrid:
      LoadPanelGrid;
    ovPolygon:
      LoadPanelPolygon
  end;
end;

procedure TfrmOverlayTools.Canceled;
var
  j: Integer;
//  ShapeStatic: TMainStaticShape;
//  ShapeDynamic: TMainDynamicShape;
begin
//  for j := 0 to DrawOverlay.DynamicList.Count - 1 do
//  begin
//    ShapeDynamic := DrawOverlay.DynamicList.Items[j];
//    ShapeDynamic.isSelected := false;
//  end;
//
//  for j := 0 to DrawOverlay.StaticList.Count - 1 do
//  begin
//    ShapeStatic := DrawOverlay.StaticList.Items[j];
//    ShapeStatic.isSelected := false;
//  end;
//
//  Map1.Repaint;
end;

procedure TfrmOverlayTools.cbbTypeToolsChange(Sender: TObject);
begin
  if cbbTypeTools.ItemIndex = 0 then
    pnlShape.BringToFront
  else if cbbTypeTools.ItemIndex = 1 then
    pnlObject.BringToFront;
end;

procedure TfrmOverlayTools.ClearEditText;
begin
  // reset data & set button buat ambil koordinat down jadi false

  { Text }
  edtTextPosLAt.Text := '';
  edtTextPosLong.Text := '';
  edtTextField.Text := 'None';

  SpeedButton.Down := false;

  { Line }
  edtLineStartPosLong.Text := '';
  edtLineStartPosLat.Text := '';
  edtLineEndPosLong.Text := '';
  edtLineEndPosLat.Text := '';

//  SpeedButton1.Down := false;
//  SpeedButton2.Down := false;

  { Rectangle }
  edtRectStartPosLong.Text := '';
  edtRectStartPosLat.Text := '';
  edtRectEndPosLong.Text := '';
  edtRectEndPosLat.Text := '';

//  SpeedButton3.Down := false;
//  SpeedButton4.Down := false;

  { Circle }
  edtCircleRadius.Text := '1';
  edtCirclePosLong.Text := '';
  edtCirclePosLat.Text := '';

//  SpeedButton5.Down := false;

  { Ellipse }
  edtHorizontal.Text := '1';
  edtVertical.Text := '1';
  edtEllipsePosLong.Text := '';
  edtEllipsePosLat.Text := '';

//  SpeedButton6.Down := false;

  { Arc }
  edtArcRadius.Text := '1';
  edtArcPosLong.Text := '';
  edtArcPosLat.Text := '';
  edtArcStartAngle.Text := '0';
  edtArcEndAngle.Text := '0';

//  SpeedButton7.Down := false;

  { Sector }
  edtSectorInner.Text := '1';
  edtSectorOuter.Text := '1';
  edtSectorPosLong.Text := '';
  edtSectorPosLat.Text := '';
  edtSectorStartAngle.Text := '0';
  edtSectorEndAngle.Text := '0';

//  SpeedButton8.Down := false;

  { Grid }
  edtTableHeight.Text := '1';
  edtTableWidth.Text := '1';
  edtTablePosLong.Text := '';
  edtTablePosLat.Text := '';
  edtTableColumn.Text := '1';
  edtTableRow.Text := '1';
  edtTableRotationAngle.Text := '0';

//  SpeedButton9.Down := false;

  { Polygon }

  edtPolyPosLat.Text := '';
  edtPolyPosLong.Text := '';
  lvPolyVertex.Clear;

//  SpeedButton10.Down := false;

end;

procedure TfrmOverlayTools.ClearFlagPoint;
begin
//  DrawFlagPoint.FList.Clear;
//  Map1.Refresh;
//  Map1.Repaint;
end;

procedure TfrmOverlayTools.LoadPanelArc;
begin
  btnArc.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnArc_Select.PNG');

  grpArc.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
  {$ENDREGION}

end;

procedure TfrmOverlayTools.LoadPanelCircle;
begin
  lblShape.Caption := 'Circle';
  btnCircle.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnCircle_Select.PNG');

{$REGION ' Dynamic Handle '}
  grpCircleD.BringToFront;
  grpCircleD.Visible := True;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpCircle.BringToFront;
  grpCircle.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelEllipse;
begin
  lblShape.Caption := 'Ellipse';
  btnEllipse.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnEllipse_Select.PNG');

{$REGION ' Dynamic Handle '}
  grpEllipseD.BringToFront;
  grpEllipseD.Visible := True;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpEllipse.BringToFront;
  grpEllipse.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelGrid;
begin
  lblShape.Caption := 'Grid';
  btnGrid.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnGrid_Select.PNG');

{$REGION ' Dynamic Handle '}
  grpGridD.BringToFront;
  grpGridD.Visible := True;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpGrid.BringToFront;
  grpGrid.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelLine;
begin
  lblShape.Caption := 'Line';
  btnLine.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnLine_Select.PNG');

{$REGION ' Dynamic Handle '}
//  grpLineD.BringToFront;
//  grpLineD.Visible := True;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpLine.BringToFront;
  grpLine.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelPolygon;
begin
  lblShape.Caption := 'Polygon';
  btnPolygon.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnPolygon_Select.PNG');

{$REGION ' Dynamic Handle '}
//  grpPolygonD.BringToFront;
//  grpPolygonD.Visible := True;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpPolygon.BringToFront;
  grpPolygon.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelRectangle;
begin
  lblShape.Caption := 'Rectangle';
  btnRectangle.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnRectangle_Select.PNG');

{$REGION ' Dynamic Handle '}
//  grpRectangleD.BringToFront;
//  grpRectangleD.Visible := True;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpRectangle.BringToFront;
  grpRectangle.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelSector;
begin
  btnSector.Picture.LoadFromFile ('data\Image DBEditor\Interface\Button\btnSector_Select.PNG');

  grpSector.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelText;
begin
  lblShape.Caption := 'Text';
  btnText.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnText_Select.PNG');

{$REGION ' Dynamic Handle '}
//  grpTextD.BringToFront;
//  grpTextD.Visible := false;
{$ENDREGION}
{$REGION ' Static Handle '}
  grpText.BringToFront;
  grpText.Visible := True;
{$ENDREGION}
{$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);
{$ENDREGION}
end;

procedure TfrmOverlayTools.RefreshMousePointer;
begin
//  Map1.CurrentTool := miSelectTool;
//  Map1.MousePointer := miDefaultCursor;

  btnSelect.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnCursor_Normal.PNG');
  btnText.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnText_Normal.PNG');
  btnLine.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnLine_Normal.PNG');
  btnRectangle.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnRectangle_Normal.PNG');
  btnCircle.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnCircle_Normal.PNG');
  btnEllipse.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnEllipse_Normal.PNG');
  btnArc.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnArc_Normal.PNG');
  btnSector.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnSector_Normal.PNG');
  btnGrid.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnGrid_Normal.PNG');
  btnPolygon.Picture.LoadFromFile
    ('data\Image DBEditor\Interface\Button\btnPolygon_Normal.PNG');

//  FisNoFill := True;
end;

end.

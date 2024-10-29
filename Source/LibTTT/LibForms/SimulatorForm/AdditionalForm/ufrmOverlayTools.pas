unit ufrmOverlayTools;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ColorGrd, Vcl.Imaging.pngimage, RzBmpBtn;

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
    Image11: TImage;
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
    grpRadar: TGroupBox;
    Label68: TLabel;
    grpArrow: TGroupBox;
    Label15: TLabel;
    grplogistik: TGroupBox;
    Label16: TLabel;
    Label22: TLabel;
    Label61: TLabel;
    edtLongLog: TEdit;
    Label23: TLabel;
    Label62: TLabel;
    edtLattLog: TEdit;
    btnPosLog: TSpeedButton;
    Label24: TLabel;
    lvLogistic: TListView;
    edtItemLog: TEdit;
    cbbStatus: TComboBox;
    Label26: TLabel;
    Label25: TLabel;
    btnInsertLog: TButton;
    btnEditLog: TButton;
    btnDeleteLog: TButton;
    btnClearLog: TButton;
    Label65: TLabel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    grpBase: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Bevel17: TBevel;
    Label9: TLabel;
    Label48: TLabel;
    edtLongBase: TEdit;
    btnPosBase: TSpeedButton;
    edtLattBase: TEdit;
    Label47: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lvBase: TListView;
    Label12: TLabel;
    Label49: TLabel;
    edtPlatform: TEdit;
    Label13: TLabel;
    Label50: TLabel;
    edtQty: TEdit;
    Label14: TLabel;
    Label51: TLabel;
    lblSymbolTaktis: TLabel;
    Bevel1: TBevel;
    btnplatform: TButton;
    btnInsertBase: TButton;
    btnEditBase: TButton;
    btnDeleteBase: TButton;
    btnClearBase: TButton;
    Bevel18: TBevel;
    Label3: TLabel;
    Label54: TLabel;
    edtStartLong: TEdit;
    btnStartPos: TSpeedButton;
    Label4: TLabel;
    Label55: TLabel;
    edtStartLatt: TEdit;
    Label5: TLabel;
    Label56: TLabel;
    Label6: TLabel;
    Label57: TLabel;
    edtEndLatt: TEdit;
    edtEndLong: TEdit;
    btnEndPos: TSpeedButton;
    Label1: TLabel;
    Bevel19: TBevel;
    Label2: TLabel;
    Bevel20: TBevel;
    Label29: TLabel;
    Label58: TLabel;
    edtLongRadar: TEdit;
    btnPosRadar: TSpeedButton;
    edtLattRadar: TEdit;
    Label59: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label60: TLabel;
    edtRadius: TEdit;
    Label7: TLabel;
    grpObjNone: TGroupBox;
    Label8: TLabel;
    btnIntelegent: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
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

    procedure GbrText;
    procedure GbrLine;
    procedure GbrRectangle;
    procedure GbrCircle;
    procedure GbrEllipse;
    procedure GbrArc;
    procedure GbrSector;
    procedure GbrGrid;
    procedure GbrPolygon;
    procedure GbrFlagPoint(mx, my :Double);

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

procedure TfrmOverlayTools.GbrArc;
//var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
begin
//  if CekInput(ovArc) then
    Exit;

//  if IsEditObject then
  begin
   //   Action := 2;
//    if not FindIdSelectedShape then
      Exit;
  end
//  else
//    Action := 1;

//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovArc;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;

//  recShapeStatic.PostStart.X := dmsToLong(edtArcPosLong.Text);
//  recShapeStatic.PostStart.Y := dmsToLatt(edtArcPosLat.Text);
//  recShapeStatic.radius1 := StrToFloat(edtArcRadius.Text);
//  recShapeStatic.StartAngle := StrToInt(edtArcStartAngle.Text);
//  recShapeStatic.EndAngle := StrToInt(edtArcEndAngle.Text);
//  recShapeStatic.color := pnlOutline.Color;

//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);

  //      if Action = caEdit then
  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
  //      else
  //        recShapeStatic.idxDraw := idxDrawOverlay;

  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrCircle;
// var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
//
begin
//  if CekInput(ovCircle) then
//    Exit;
//
//  if IsEditObject then
//    begin
//      Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//    end
//  else
//    Action := 1;
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovCircle;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.PostStart.X := dmsToLong(edtCirclePosLong.Text);
//  recShapeStatic.PostStart.Y := dmsToLatt(edtCirclePosLat.Text);
//  recShapeStatic.Radius1 := StrToFloat(edtCircleRadius.Text);
//  recShapeStatic.color := pnlOutline.Color;
//
//  if FisNoFill  then
//  recShapeStatic.BrushStyle := bsClear
//  else
//  begin
//  recShapeStatic.BrushStyle := bsSolid;
//  recShapeStatic.ColorFill := pnlFill.Color;
//  end;
//
//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;
//
//  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrEllipse;
//var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
begin
//  if CekInput(ovEllipse) then
//    Exit;
//
//  if IsEditObject then
//  begin
//    Action := 2;
//
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//  Action := 1;
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovEllipse;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.PostStart.X := dmsToLong(edtEllipsePosLong.Text);
//  recShapeStatic.PostStart.Y := dmsToLatt(edtEllipsePosLat.Text);
//  recShapeStatic.Radius1 := StrToFloat(edtHorizontal.Text);
//  recShapeStatic.Radius2 := StrToFloat(edtVertical.Text);
//  recShapeStatic.color := pnlOutline.Color;
//
//  if FisNoFill  then
//    recShapeStatic.BrushStyle := bsClear
//  else
//  begin
//    recShapeStatic.BrushStyle := bsSolid;
//    recShapeStatic.ColorFill := pnlFill.Color;
//  end;
//
//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;
//
//  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrFlagPoint(mx, my: Double);
//var
//  ObjectFlagPoint : TFlagPoint;
begin
//  ObjectFlagPoint := TFlagPoint.Create(simMgrClient.Converter);
//  ObjectFlagPoint.Post.X := mx;
//  ObjectFlagPoint.Post.Y := my;
//  simMgrClient.DrawFlagPoint.FList.Add(ObjectFlagPoint);
end;

procedure TfrmOverlayTools.GbrGrid;
//var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
begin
//  if CekInput(ovGrid) then
//    Exit;
//
//  if IsEditObject then
//  begin
//     Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    Action := 1;
//
//  case StateOverlay of
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovGrid;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.PostStart.X := dmsToLong(edtTablePosLong.Text);
//  recShapeStatic.PostStart.Y := dmsToLatt(edtTablePosLat.Text);
//  recShapeStatic.Radius1 := StrToFloat(edtTableHeight.Text);
//  recShapeStatic.Radius2 := StrToFloat(edtTableWidth.Text);
//  recShapeStatic.Kolom := StrToInt(edtTableColumn.Text);
//  recShapeStatic.Baris := StrToInt(edtTableRow.Text);
//  recShapeStatic.Rotasi := StrToInt(edtTableRotationAngle.Text);
//  recShapeStatic.color := pnlOutline.Color;
//
//  if FisNoFill  then
//    recShapeStatic.BrushStyle := bsClear
//  else
//  begin
//    recShapeStatic.BrushStyle := bsSolid;
//    recShapeStatic.ColorFill := pnlFill.Color;
//  end;
//
//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;;
//
//  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
//end;
end;

procedure TfrmOverlayTools.GbrLine;
//var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;

begin
//  if CekInput(ovLine) then
//    Exit;
//
//  if IsEditObject then
//  begin
//      Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    Action := 1;
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovLine;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.postStart.X := dmsToLong(edtLineStartPosLong.Text);
//  recShapeStatic.postStart.Y := dmsToLatt(edtLineStartPosLat.Text);
//  recShapeStatic.postEnd.X := dmsToLong(edtLineEndPosLong.Text);
//  recShapeStatic.postEnd.Y := dmsToLatt(edtLineEndPosLat.Text);
//
//  recShapeStatic.color := pnlOutline.color;
//  recShapeStatic.lineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.weight := StrToInt(cbbWeightPen.Text);
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;
//
//  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrPolygon;
//var
//  i : Integer;
//  li : TListItem;
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
begin
//  if CekInput(ovPolygon) then
//    Exit;
//
//  if IsEditObject then
//  begin
//    Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    Action := 1;
//
//      recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//      recShapeStatic.ShapeType := ovPolygon;
//      recShapeStatic.IdSelectShape := NoShapeInList;
//      recShapeStatic.IdAction := Action;
//
//      recShapeStatic.color := pnlOutline.Color;
//
//  if FisNoFill  then
//  begin
//  recShapeStatic.BrushStyle := bsClear;
//  end
//  else
//  begin
//  recShapeStatic.BrushStyle := bsSolid;
//  recShapeStatic.ColorFill := pnlFill.Color;
//  end;
//
//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;
//
//  for i := 0 to 12 do
//  begin
//  li := lvPolyVertex.Items[i];
//
//  recShapeStatic.PolyPoint[i].X := 0;
//  recShapeStatic.PolyPoint[i].Y := 0;
//  end;

//  for i := 0 to lvPolyVertex.Items.Count - 1 do
//  begin
//  li := lvPolyVertex.Items[i];
//
//  recShapeStatic.PolyPoint[i].X := dmsToLong(li.SubItems[0]);
//  recShapeStatic.PolyPoint[i].Y := dmsToLatt(li.SubItems[1]);
//  end;
//
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//
//  SpeedButton10.Down := False;
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrRectangle;
//var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
begin
//  if CekInput(ovRectangle) then
//    Exit;
//
//  if IsEditObject then
//  begin
//    Action := 2;
//  if not FindIdSelectedShape then
//    Exit;
//  end
//  else
//    Action := 1;
//
//  case StateOverlay of
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovRectangle;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.postStart.X := dmsToLong(edtRectStartPosLong.Text);
//  recShapeStatic.postStart.Y := dmsToLatt(edtRectStartPosLat.Text);
//  recShapeStatic.postEnd.X := dmsToLong(edtRectEndPosLong.Text);
//  recShapeStatic.postEnd.Y := dmsToLatt(edtRectEndPosLat.Text);
//
//  recShapeStatic.color := pnlOutline.Color;
//
//  if FisNoFill  then
//  begin
//    recShapeStatic.BrushStyle := bsClear;
//  end
//  else
//  begin
//    recShapeStatic.BrushStyle := bsSolid;
//    recShapeStatic.ColorFill := pnlFill.Color;
//  end;
//
//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);
//
////      if Action = caEdit then
////        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
////      else
////        recShapeStatic.idxDraw := idxDrawOverlay;
//
//      {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrSector;
//var
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;
begin
//  if CekInput(ovSector) then
//    Exit;
//
//  if IsEditObject then
//  begin
//      Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    Action := 1;
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovSector;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.PostStart.X := dmsToLong(edtSectorPosLong.Text);
//  recShapeStatic.PostStart.Y := dmsToLatt(edtSectorPosLat.Text);
//  recShapeStatic.Radius1 := StrToFloat(edtSectorOuter.Text);
//  recShapeStatic.Radius2 := StrToFloat(edtSectorInner.Text);
//  recShapeStatic.StartAngle := StrToInt(edtSectorStartAngle.Text);
//  recShapeStatic.EndAngle := StrToInt(edtSectorEndAngle.Text);
//  recShapeStatic.color := pnlOutline.Color;
//
//  recShapeStatic.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
//  recShapeStatic.Weight := StrToInt(cbbWeightPen.Text);
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;
//
//  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
end;

procedure TfrmOverlayTools.GbrText;
//var
//  Size : Byte;
//  recShapeStatic : TRecCmd_OverlayStaticShape;
//  recShapeDynamic : TRecCmd_OverlayDynamicShape;

begin
//  if CekInput(ovText) then
//    Exit;
//
//  Size := 10;
//
//  if IsEditObject then
//  begin
//      Action := caEdit;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    Action := caAdd;
//
//  recShapeStatic.TemplateId := FSelectedOverlay.OverlayIndex;
//  recShapeStatic.ShapeType := ovText;
//  recShapeStatic.IdSelectShape := NoShapeInList;
//  recShapeStatic.IdAction := Action;
//
//  recShapeStatic.PostStart.X := dmsToLong(edtTextPosLong.Text);
//  recShapeStatic.PostStart.Y := dmsToLatt(edtTextPosLat.Text);
//  recShapeStatic.Size := StrToInt(cbbTextSize.Text);
//  recShapeStatic.Words := edtTextField.Text;
//  recShapeStatic.color := pnlOutline.Color;
//
//  //      if Action = caEdit then
//  //        recShapeStatic.idxDraw := simMgrClient.DrawOverlayTemplate.idxOverlay
//  //      else
//  //        recShapeStatic.idxDraw := idxDrawOverlay;
//
//  {Kirim data disini}
//  simMgrClient.netSend_CmdOverlayStaticShape(recShapeStatic);
//  isInputProblem := False;
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
//  btnOutlineClick(nil);
  {$ENDREGION}

end;

procedure TfrmOverlayTools.LoadPanelCircle;
begin
  btnCircle.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCircle_Select.PNG');

  grpCircle.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelEllipse;
begin
  btnEllipse.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnEllipse_Select.PNG');

  grpEllipse.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelGrid;
begin
  btnGrid.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnGrid_Select.PNG');

  grpGrid.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelLine;
begin
  btnLine.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnLine_Select.PNG');

  grpLine.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelPolygon;
begin
  btnPolygon.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnPolygon_Select.PNG');

  grpPolygon.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelRectangle;
begin
  btnRectangle.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnRectangle_Select.PNG');

  grpRectangle.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelSector;
begin
  btnSector.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnSector_Select.PNG');

  grpSector.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelText;
begin
  btnText.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnText_Select.PNG');

  grpText.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
//  btnOutlineClick(nil);
  {$ENDREGION}
end;

procedure TfrmOverlayTools.RefreshMousePointer;
begin
//  Map1.CurrentTool := miSelectTool;
//  Map1.MousePointer := miDefaultCursor;

  btnSelect.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCursor_Normal.PNG');
  btnText.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnText_Normal.PNG');
  btnLine.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnLine_Normal.PNG');
  btnRectangle.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnRectangle_Normal.PNG');
  btnCircle.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnCircle_Normal.PNG');
  btnEllipse.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnEllipse_Normal.PNG');
  btnArc.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnArc_Normal.PNG');
  btnSector.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnSector_Normal.PNG');
  btnGrid.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnGrid_Normal.PNG');
  btnPolygon.Picture.LoadFromFile('data\Image DBEditor\Interface\Button\btnPolygon_Normal.PNG');

//  FisNoFill := True;
end;

procedure TfrmOverlayTools.SetNoFill(val: Boolean);
begin

end;

end.

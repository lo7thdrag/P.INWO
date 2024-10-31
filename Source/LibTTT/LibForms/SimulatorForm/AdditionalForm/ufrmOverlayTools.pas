unit ufrmOverlayTools;

interface

uses
  MapXLib_TLB, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ColorGrd, Vcl.Imaging.pngimage, RzBmpBtn,

  uConstantaData, uRecordData, uSimMgr_Client, uBaseCoordSystem, uClassData, uDataTypes, uFormula;

type
  E_ShapeColor = (scOutline, scFill);

  TfrmOverlayTools = class(TForm)
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
    grpColorEditing: TGroupBox;
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
    btnSelect: TRzBmpButton;
    btnPolygon: TRzBmpButton;
    btnGrid: TRzBmpButton;
    btnSector: TRzBmpButton;
    btnArc: TRzBmpButton;
    btnEllipse: TRzBmpButton;
    btnCircle: TRzBmpButton;
    btnRectangle: TRzBmpButton;
    btnLine: TRzBmpButton;
    btnText: TRzBmpButton;
    btnOutline: TRzBmpButton;
    btnFill: TRzBmpButton;
    procedure btnHandleShape(Sender: TObject);
    procedure cbbTypeToolsChange(Sender: TObject);
    procedure btnOutlineClick(Sender: TObject);
    procedure btnHandleShapePosition(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFillClick(Sender: TObject);

  private
    FShapeType : Integer;
    FShapeId : Integer;
    FisInputProblem : Boolean;
    FTagTombolPosition : Integer;
    FShapeColor : E_ShapeColor;
//    FMapCursor: TMapCursor;
    FSelectedOverlayTab : TOverlayTab;
    FAction : Byte;

  public
    IsEditObject : Boolean;
    isNoFill : Boolean;
    IdAction: Byte; { 1: add; 2: Edit; 3: Delete }

//    ShapeType: Integer;

    procedure Apply;
    procedure Deleted;
    procedure Canceled;

//    procedure RefreshMousePointer;
    procedure ClearFlagPoint;
    procedure ClearEditText;
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

    procedure SelectShape(mx, my :Double);
    procedure SetPosition(mx, my :Double);

    function FindIdSelectedShape: Boolean;
    function CekInput(IdObject : Integer): Boolean;

    property SelectedOverlayTab : TOverlayTab read FSelectedOverlayTab write  FSelectedOverlayTab;

  end;

var
  frmOverlayTools: TfrmOverlayTools;

implementation

uses
  ufrmSituationBoard, ufrmTacticalDisplay;
{$R *.dfm}


{ TfrmOverlayTools }

procedure TfrmOverlayTools.Apply;
begin
  case FShapeType of
    ovText : GbrText;
    ovLine : GbrLine;
    ovRectangle : GbrRectangle;
    ovCircle : GbrCircle;
    ovEllipse : GbrEllipse;
    ovArc : GbrArc;
    ovSector : GbrSector;
    ovGrid : GbrGrid;
    ovPolygon : GbrPolygon;
  end;
end;

procedure TfrmOverlayTools.btnApplyClick(Sender: TObject);
begin
  case TButton(Sender).Tag of
    0: {Apply}
    begin
      Apply;
      if FisInputProblem  then
        Exit
      else
        btnHandleShape(btnSelect);
    end;
    1: {Delete}
    begin
      Deleted;
      btnHandleShape(btnSelect);
    end;
    2: {Cancel}
    begin
      Canceled;
      btnHandleShape(btnSelect);
    end;
    3: {Close}
    begin
      Canceled;
//      grpTemplate.Left := 17;

//      UpdateOverlayTemplateList;
    end;
  end;
  ClearEditText;
  ClearFlagPoint;
end;

procedure TfrmOverlayTools.btnFillClick(Sender: TObject);
begin
  FShapeColor := scFill;
end;

procedure TfrmOverlayTools.btnHandleShape(Sender: TObject);
begin
  ClearFlagPoint;
  ClearEditText;
  FAction := caAdd;

  FShapeType := TRzBmpButton(Sender).Tag;

  case FShapeType of
    0: { Select }
      begin
        grpNone.BringToFront;

        { merubah cursor }
        frmSituationBoard.MapCursor := mcEdit;

        {$REGION ' Button Handle '}
        btnOutline.Visible := false;
        btnFill.Visible := false;
        pnlPenEditing.Visible := false;
        btnSelect.Down := True;
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

procedure TfrmOverlayTools.btnOutlineClick(Sender: TObject);
begin
  FShapeColor := scOutline;
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

function TfrmOverlayTools.CekInput(IdObject: Integer): Boolean;
begin
  Result := False;


  case IdObject of
    ovText:{Text}
    begin
      if(edtTextPosLong.Text = '') or (edtTextPosLAt.Text= '')or
        (edtTextField.Text = '')or(cbbTextSize.Text = '')then
      begin
        ShowMessage('Data yang dimasukkan tidak lengkap');
        Result := True;
      end
      else if (StrToInt(cbbTextSize.Text) > 72 )or (StrToInt(cbbTextSize.Text) = 0 )then
      begin
        ShowMessage('Ukuran tulisan tidak sesuai');
        Result := True;
      end;
    end;
//    ovLine:{Line}
//    begin
//    if (edtLineStartPosLong.Text ='') or (edtLineStartPosLat.Text = '')or
//    (edtLineEndPosLong.Text = '') or (edtLineEndPosLat.Text = '')then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end
//    else if (edtLineStartPosLong.Text = edtLineEndPosLong.Text) and (edtLineStartPosLat.Text = edtLineEndPosLat.Text)then
//    begin
//    lblWarning.Caption := 'Invalid input..., Start and End position can not be identical';
//    Result := True;
//    end;;
//    end;
    ovRectangle:{Rectangle}
    begin
      if (edtRectStartPosLong.Text = '')or(edtRectStartPosLat.Text = '')or
      (edtRectEndPosLong.Text = '')or (edtRectEndPosLat.Text = '')or
      (edtRectStartPosLong.Text= '')or (edtRectStartPosLat.Text= '')or
      (edtRectEndPosLat.Text= '')or(edtRectEndPosLong.Text= '') then
      begin
        ShowMessage('Data yang dimasukkan tidak lengkap');
        Result := True;
      end
      else if (edtRectStartPosLong.Text = edtRectEndPosLong.Text ) and (edtRectStartPosLat.Text = edtRectEndPosLat.Text )then
      begin
        ShowMessage('Data yang dimasukkan tidak sesuai, Posisi Top-Left dan Bottom-Right tidak boleh sama');
        Result := True;;
      end;
    end;
//    ovCircle:{Circle}
//    begin
//    if (edtCirclePosLong.Text = '')or (edtCirclePosLat.Text = '') or
//    (edtCircleRadius.Text = '')or(edtCirclePosLong.text='')or
//    (edtCirclePosLat.Text= '') then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end
//    else if (edtCircleRadius.Text = '0' ) then
//    begin
//    lblWarning.Caption := 'Invalid radius input, minimum radius > 0';
//    Result := True;
//    end;
//    end;
//    ovEllipse:{Ellipse}
//    begin
//    if (edtEllipsePosLong.Text = '')or (edtEllipsePosLat.Text = '')
//    or(edtHorizontal.Text = '') or (edtVertical.Text = '')or
//    (edtEllipsePosLat.text= '')or
//    (edtEllipsePosLong.Text= '') then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end
//    else if (edtHorizontal.Text = '0') or (edtVertical.Text = '0')then
//    begin
//    lblWarning.Caption := 'Invalid radius input, minimum radius > 0';
//    Result := True;
//    end;
//    end;
//    ovArc:{Arc}
//    begin
//    if (edtArcPosLong.Text = '') or (edtArcPosLat.Text = '')or
//    (edtArcRadius.Text = '')or(edtArcStartAngle.Text = '')or
//    (edtArcEndAngle.Text = '')then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end
//    else if (edtArcRadius.Text = '0') then
//    begin
//    lblWarning.Caption := 'Invalid radius input, minimum radius > 0';
//    Result := True;
//    end
//    else if (edtArcEndAngle.Text = edtArcStartAngle.Text) then
//    begin
//    lblWarning.Caption := 'Invalid input..., Start and End Angle can not be identical';
//    Result := True;
//    end;
//    end;
//    ovSector:{Sector}
//    begin
//    if(edtSectorInner.Text = '') or (edtSectorOuter.Text = '')or
//    (edtSectorStartAngle.Text = '') or (edtSectorEndAngle.Text = '')or
//    (edtSectorPosLat.Text = '')or (edtSectorPosLong.Text = '')then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end
//    else if (edtSectorInner.Text = '0')or (edtSectorOuter.Text = '0')then
//    begin
//    lblWarning.Caption := 'Invalid radius input, minimum radius > 0';
//    Result := True;
//    end
//    else if (edtSectorStartAngle.Text = edtSectorEndAngle.Text) then
//    begin
//    lblWarning.Caption := 'Invalid input..., Start and End Angle can not be identical';
//    Result := True;
//    end
//    else if (edtSectorInner.Text = edtSectorOuter.Text) then
//    begin
//    lblWarning.Caption := 'Invalid input..., Inner and Outer Radius can not be identical';
//    Result := True;
//    end;
//    end;
//    ovGrid:{Grid}
//    begin
//    if (edtTablePosLong.Text = '')or (edtTablePosLat.Text ='') or
//    (edtTableHeight.Text = '')or (edtTableColumn.Text = '') or
//    (edtTableWidth.Text = '') or (edtTableRow.Text = '')or
//    (edtTableRotationAngle.Text = '')or(edtTablePosLat.Text ='')
//    or(edtTablePosLong.Text='') then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end
//
//    else if (edtTableHeight.Text = '0') or (edtTableColumn.Text = '0') or (edtTableWidth.Text = '0')
//    or (edtTableRow.Text = '0') then
//    begin
//    lblWarning.Caption := 'Invalid input, minimum Col, Row and height > 0';
//    Result := True;
//    end;
//    end;
//    ovPolygon:{Polygon}
//    begin
//    if lvPolyVertex.Items.Count < 1 then
//    begin
//    lblWarning.Caption := 'Incomplete Data Input';
//    Result := True;
//    end;
//    end;
  end;

  if Result then
  begin
    FisInputProblem := True;
  end;
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

  { Rectangle }
  edtRectStartPosLong.Text := '';
  edtRectStartPosLat.Text := '';
  edtRectEndPosLong.Text := '';
  edtRectEndPosLat.Text := '';

  { Circle }
  edtCircleRadius.Text := '1';
  edtCirclePosLong.Text := '';
  edtCirclePosLat.Text := '';

  { Ellipse }
  edtHorizontal.Text := '1';
  edtVertical.Text := '1';
  edtEllipsePosLong.Text := '';
  edtEllipsePosLat.Text := '';

  { Arc }
  edtArcRadius.Text := '1';
  edtArcPosLong.Text := '';
  edtArcPosLat.Text := '';
  edtArcStartAngle.Text := '0';
  edtArcEndAngle.Text := '0';

  { Sector }
  edtSectorInner.Text := '1';
  edtSectorOuter.Text := '1';
  edtSectorPosLong.Text := '';
  edtSectorPosLat.Text := '';
  edtSectorStartAngle.Text := '0';
  edtSectorEndAngle.Text := '0';

  { Grid }
  edtTableHeight.Text := '1';
  edtTableWidth.Text := '1';
  edtTablePosLong.Text := '';
  edtTablePosLat.Text := '';
  edtTableColumn.Text := '1';
  edtTableRow.Text := '1';
  edtTableRotationAngle.Text := '0';

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

procedure TfrmOverlayTools.Deleted;
var
  recShape : TRecTCPSendOverlayShape;

begin

  if not FindIdSelectedShape then
      Exit;

  if Assigned(FSelectedOverlayTab) then
  begin
    recShape.IdAction := caDelete;
    recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
    recShape.IdSelectShape := FShapeId;
    recShape.ShapeType := FShapeType;

    simMgrClient.netSend_CmdOverlayShape(recShape);
  end;

end;

function TfrmOverlayTools.FindIdSelectedShape: Boolean;
var
  i : Integer;
  overlaTabTemp : TOverlayTab;
  mainShapeTemp : TMainShape;

begin
  Result := False;

  if Assigned(FSelectedOverlayTab) then
  begin
    for I := 0 to FSelectedOverlayTab.MemberList.Count - 1 do
    begin
      mainShapeTemp := FSelectedOverlayTab.MemberList[i];
      if mainShapeTemp.isSelected = True then
      begin
        FShapeId := i;
        Result := True;
        break;
      end;
    end;
  end;

  if Result = false then
  begin
    MessageDlg('Gambar yang anda pilih tidak valid', mtWarning, [mbOK], 0);
  end;

end;

procedure TfrmOverlayTools.FormShow(Sender: TObject);
begin
  cbbTypeTools.ItemIndex := 0;
  cbbTypeToolsChange(nil);
  btnHandleShape(btnSelect);
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
var
  Size : Byte;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovText) then
    Exit;

  Size := 10;

//  if IsEditObject then
//  begin
//      FAction := caEdit;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    FAction := caAdd;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovText;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtTextPosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtTextPosLat.Text);
  recShape.Size := StrToInt(cbbTextSize.Text);
  recShape.Words := edtTextField.Text;
  recShape.color := pnlOutline.Color;

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.LoadPanelArc;
begin
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
  grpText.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.SelectShape(mx, my :Double);
var
  i, j, k, Hr,Vr, r,
  x1, x2, x3, x4, x5,
  y1, y2, y3, y4, y5 : Integer;

  Idx, Idy, Odx, Ody,
  RKiAts, RKaAts, RKiBwh, RKaBwh,
  BKiAts, BKaAts, BKiBwh, BKaBwh : Double;

  IptS, IptE, OptS, OptE, ptPos : t2DPoint;

  rect1, rect2, rect3, rect4 : TRect;

  mainShapeTemp : TMainShape;
  textTemp : TTextShape;
  countList : Integer;
  pos: TPoint;

begin
  if Assigned(SelectedOverlayTab) then
  begin
    for i := 0 to SelectedOverlayTab.MemberList.Count - 1 do
    begin
      mainShapeTemp := SelectedOverlayTab.MemberList[i];
      mainShapeTemp.isSelected := False;
    end;

    for countList := SelectedOverlayTab.MemberList.Count-1 downto 0 do
    begin
      mainShapeTemp := SelectedOverlayTab.MemberList[countList];


      if mainShapeTemp is TTextShape then
      begin
        {$REGION ' Text Section '}
        textTemp := TTextShape(mainShapeTemp);

        mainShapeTemp.Converter.ConvertToScreen(mx, my, pos.X, pos.Y);
        mainShapeTemp.Converter.ConvertToScreen(textTemp.postStart.X, textTemp.postStart.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.checkText(x1, y1, textTemp.Size, textTemp.words);
        ptPos := SelectedOverlayTab.Formula.PointTo2D(pos.X, pos.Y);

        if ptToArea(rect1, ptPos) then
        begin
          FShapeType := ovText;
          edtTextPosLat.Text  := formatDMS_latt(textTemp.postStart.Y);
          edtTextPosLong.Text := formatDMS_long(textTemp.postStart.X);
          cbbTextSize.Text    := IntToStr(textTemp.size);
          edtTextField.Text   := textTemp.words;
          pnlOutline.color    := textTemp.Color;
          textTemp.isSelected := true;
          FShapeId := textTemp.ShapeId;
          FAction := caEdit;

          LoadPanelText;

          break;
        end;
        {$ENDREGION}
      end
      else
      begin
        IsEditObject := False;
      end;
    end;
  end;

  Show;
end;

procedure TfrmOverlayTools.SetNoFill(val: Boolean);
begin
  if val then
  begin
    isNoFill := True;
    pnlFill.Caption := 'No Fill';
    pnlFill.Color := $00383534;
  end
  else
  begin
    isNoFill := False;
    pnlFill.Caption := '';
    pnlFill.Color := $00383534;
  end;
end;

procedure TfrmOverlayTools.SetPosition(mx, my: Double);
begin
  case FTagTombolPosition of
    0:
      begin
        edtTextPosLAt.Text := formatDMS_latt(my);
        edtTextPosLong.Text := formatDMS_long(mx);
      end;
    1:
      begin
        edtLineStartPosLat.Text := formatDMS_latt(my);
        edtLineStartPosLong.Text := formatDMS_long(mx);
      end;
    2:
      begin
        edtLineEndPosLat.Text := formatDMS_latt(my);
        edtLineEndPosLong.Text := formatDMS_long(mx);
      end;
    3:
      begin
        edtRectStartPosLat.Text := formatDMS_latt(my);
        edtRectStartPosLong.Text := formatDMS_long(mx);
      end;
    4:
      begin
        edtRectEndPosLat.Text := formatDMS_latt(my);
        edtRectEndPosLong.Text := formatDMS_long(mx);
      end;
    5:
      begin
        edtCirclePosLat.Text := formatDMS_latt(my);
        edtCirclePosLong.Text := formatDMS_long(mx);
      end;
    6:
      begin
        edtEllipsePosLat.Text := formatDMS_latt(my);
        edtEllipsePosLong.Text := formatDMS_long(mx);
      end;
    7:
      begin
        edtArcPosLat.Text := formatDMS_latt(my);
        edtArcPosLong.Text := formatDMS_long(mx);
      end;
    8:
      begin
        edtSectorPosLat.Text := formatDMS_latt(my);
        edtSectorPosLong.Text := formatDMS_long(mx);
      end;
    9:
      begin
        edtTablePosLat.Text := formatDMS_latt(my);
        edtTablePosLong.Text := formatDMS_long(mx);
      end;
    10:
      begin
        edtPolyPosLat.Text := formatDMS_latt(my);
        edtPolyPosLong.Text := formatDMS_long(mx);
      end;
  end;
  show
end;

procedure TfrmOverlayTools.btnHandleShapePosition(Sender: TObject);
begin
  if (Sender is TSpeedButton) then
  begin
    FTagTombolPosition := TSpeedButton(Sender).Tag;

    if FTagTombolPosition = 10 then
    begin
//      if not SpeedButton10.Down then
//        frmSituationBoard.Map1.CurrentTool := mtSelectObject
//      else
//        frmSituationBoard.Map1.CurrentTool := mtAddOverlay;
    end
    else
    begin
      frmSituationBoard.MapCursor := mcAdd;
//      frmSituationBoard.Map1.MousePointer := miCrossCursor;
    end;
  end;
end;

end.

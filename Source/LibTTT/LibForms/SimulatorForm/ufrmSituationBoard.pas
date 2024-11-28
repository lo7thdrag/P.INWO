unit ufrmSituationBoard;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons,

  {Project Uses}
  MapXLib_TLB, uCoordConvertor, uLibSetting, uT3SimManager, uSimMgr_Client, uRecordData, uNetBaseSocket, uClassData, ufrmCreateTab,
  ufrmImageInsert, ufrmOverlayTools, uConstantaData, ufrmBrowseMap, uBaseCoordSystem,
  Vcl.Menus;

type

  TfrmSituationBoard = class(TForm)
    pnlHome: TPanel;
    pnlHeaderSituationBoard: TPanel;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btn10: TSpeedButton;
    btn11: TSpeedButton;
    btn12: TSpeedButton;
    btn13: TSpeedButton;
    btnCreateTab: TSpeedButton;
    pnlImage: TPanel;
    Image1: TImage;
    pnlEditImage: TPanel;
    pnlMap: TPanel;
    Map1: TMap;
    imgBackground: TImage;
    Image3: TImage;
    pnlCloseImage: TPanel;
    pnlCloseSituationBoard: TPanel;
    pnlToolBar: TPanel;
    pnlAlignToolBar: TPanel;
    ToolBar1: TToolBar;
    btnDecrease: TToolButton;
    cbSetScale: TComboBox;
    btnIncrease: TToolButton;
    btnPan: TToolButton;
    btnCenterGame: TToolButton;
    btnZoom: TToolButton;
    btnout: TToolButton;
    btnGameArea: TToolButton;
    btnRuller: TToolButton;
    ImageList1: TImageList;
    btnOverlayTools: TToolButton;
    pnlMain: TPanel;
    pnlCloseMap: TPanel;
    btnselect: TToolButton;
    pmTabProperties: TPopupMenu;
    miRename: TMenuItem;
    miDelete: TMenuItem;

    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnTabClick(Sender: TObject);
    procedure btnCreateTabClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlCloseClick(Sender: TObject);
    procedure btnEditImageAddressClick(Sender: TObject);
    procedure btnDecreaseClick(Sender: TObject);
    procedure cbSetScaleChange(Sender: TObject);
    procedure btnIncreaseClick(Sender: TObject);
    procedure btnPanClick(Sender: TObject);
    procedure btnGameCenterClick(Sender: TObject);
    procedure btnZoomClick(Sender: TObject);
    procedure btnoutClick(Sender: TObject);
    procedure btnGameAreaClick(Sender: TObject);
    procedure btnRullerClick(Sender: TObject);
    procedure Map1DrawUserLayer(ASender: TObject; const Layer: IDispatch; hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
    procedure Map1MapViewChanged(Sender: TObject);
    procedure Map1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Map1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Map1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnOverlayToolsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tabMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure btnselectClick(Sender: TObject);
    procedure miRenameClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);

  private
    FCanvas: TCanvas;
    FLyrDraw: CMapXLayer;
//    FConverter: TCoordConverter;
    FMapCursor: TMapCursor;
    FSelectedOverlayTab : TOverlayTab;
    FSelectedTabProperties : TTabProperties;

//    Fmx, Fmy: Double;

    procedure RoundCornerOf(Control: TWinControl; val1, val2: Integer);

  public
    centLong, centLatt: Double;

    procedure LoadTabMap;
    procedure LoadTabImage;

    procedure LoadMap(Geoset: String);
    procedure LoadOverlay(IdOverlayTab: Integer);

    procedure UpdateTab;
    procedure RefreshTab;

    property MapCursor : TMapCursor read FMapCursor write  FMapCursor;
  end;

  function frmSituationBoard_Instance: TfrmSituationBoard;

var
  frmSituationBoard: TfrmSituationBoard;

implementation

{$R *.dfm}

function frmSituationBoard_Instance: TfrmSituationBoard;
begin
  if not Assigned(frmSituationBoard) then
    Application.CreateForm(TfrmSituationBoard, frmSituationBoard);

  Result := frmSituationBoard;
end;

procedure EnableComposited(WinControl:TWinControl);
var
  i:Integer;
  NewExStyle:DWORD;
begin
  NewExStyle := GetWindowLong(WinControl.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED;
  SetWindowLong(WinControl.Handle, GWL_EXSTYLE, NewExStyle);

  for I := 0 to WinControl.ControlCount - 1 do
    if WinControl.Controls[i] is TWinControl then
      EnableComposited(TWinControl(WinControl.Controls[i]));
end;

procedure TfrmSituationBoard.RoundCornerOf(Control: TWinControl; val1, val2: Integer);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, val1, val2);
    SetWindowRgn(Handle, Rgn, True) ;
    Invalidate
  end;
end;

procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;

procedure TfrmSituationBoard.tabMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos: Winapi.Windows.TPoint;

begin

  if Button = mbRight then
  begin
    GetCursorPos(pos);
    pmTabProperties.Popup(pos.X, pos.Y);
    FSelectedTabProperties := SimManager.SimTabProperties.GetTapProperties(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, TSpeedButton(Sender).Tag);
  end;

//  RefreshTab;
end;

procedure TfrmSituationBoard.btnCreateTabClick(Sender: TObject);
begin
  if not Assigned(frmCreateTab) then
    frmCreateTab := TfrmCreateTab.Create(Self);

  try
    with frmCreateTab do
    begin
      Show;
    end;
  finally
  end;
end;

procedure TfrmSituationBoard.btnTabClick(Sender: TObject);
begin
  FSelectedTabProperties := SimManager.SimTabProperties.GetTapProperties(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, TSpeedButton(Sender).Tag);

  RefreshTab;
end;

procedure TfrmSituationBoard.btnZoomClick(Sender: TObject);
begin
  btnZoom.Down := not btnZoom.Down;
  btnPan.Down := false;

  FMapCursor := mcSelect;
  Map1.CurrentTool := miZoomInTool;
  Map1.MousePointer := miZoomInCursor;

  btnZoom.ImageIndex := 5;
end;

procedure TfrmSituationBoard.Button1Click(Sender: TObject);
var
  ipTemp : string ;
  rec : TRecTCPSendRemote;

begin
//  if cbbPapanSituasi.ItemIndex = -1 then
//  begin
//    ShowMessage('Silahkan pilih Papan Situasi ');
//    Exit;
//  end;
//
//  ipTemp := SimManager.SimConsole.GetIPAddress(cbbPapanSituasi.Text);
//
//  rec.pid.ipReceiver := StrIp_To_LongIp(ipTemp);
//  rec.FServer := StrIp_To_LongIp(ipTemp);
//  rec.FClient := StrIp_To_LongIp(simMgrClient.MyConsoleData.IpAdrres);
//  rec.FPort := vGameDataSetting.RemotePort;
////  rec.FColor := mColor;
//  rec.FControl := False;
//  rec.OrderID := REMOTE_STATE_TRUE;
//
//  simMgrClient.netSend_CmdRemote(rec);
end;

procedure TfrmSituationBoard.cbSetScaleChange(Sender: TObject);
var
  z: Double;
  s: string;
begin
  Map1.OnMapViewChanged := nil;

  if cbSetScale.ItemIndex < 0 then
    Exit;

  if (cbSetScale.ItemIndex <= 16) then
  begin
    s := cbSetScale.Items[cbSetScale.ItemIndex];
    try
      z := StrToFloat(s);
      Map1.ZoomTo(z, Map1.CenterX, Map1.CenterY);
    finally

    end;
  end
  else
    cbSetScale.ItemIndex := cbSetScale.ItemIndex - 1;

  Map1.OnMapViewChanged := Map1MapViewChanged;
end;
procedure TfrmSituationBoard.FormCreate(Sender: TObject);
begin
  EnableComposited(pnlHome);
  EnableComposited(pnlImage);
  EnableComposited(pnlMap);
  FCanvas := TCanvas.Create;
end;

procedure TfrmSituationBoard.FormDestroy(Sender: TObject);
begin
  FCanvas.Free;
end;

procedure TfrmSituationBoard.FormResize(Sender: TObject);
begin
  RoundCornerOf(pnlEditImage, 15, 15);
  UpdateTab;
  RefreshTab;
end;

procedure TfrmSituationBoard.FormShow(Sender: TObject);
begin
  pnlHome.BringToFront;

  UpdateTab;
  RefreshTab;
end;

procedure TfrmSituationBoard.btnDecreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 16 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex + 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmSituationBoard.btnEditImageAddressClick(Sender: TObject);
begin
  if not Assigned(frmImageInsert) then
    frmImageInsert := TfrmImageInsert.Create(Self);

  try
    with frmImageInsert do
    begin
      TabId := FSelectedTabProperties.IdTab;
      TabCaption := FSelectedTabProperties.CaptionTab;
      Show;
    end;
  finally
  end;
end;

procedure TfrmSituationBoard.btnGameAreaClick(Sender: TObject);
begin
  btnGameArea.ImageIndex := 10;

  if not Assigned(frmBrowseMap) then
    frmBrowseMap := TfrmBrowseMap.Create(Self);

  try
    with frmBrowseMap do
    begin
      TabId := FSelectedTabProperties.IdTab;
      TabCaption := FSelectedTabProperties.CaptionTab;
      Show;
    end;
  finally
  end;
end;

procedure TfrmSituationBoard.btnGameCenterClick(Sender: TObject);
begin
  Map1.CenterX := centLong;
  Map1.CenterY := centLatt;
end;

procedure TfrmSituationBoard.btnIncreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 0 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex - 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmSituationBoard.btnoutClick(Sender: TObject);
begin
  if btnZoom.Down then
    btnZoom.Down := False;

  btnout.Down := not btnout.Down;
  btnPan.Down := false;

  FMapCursor := mcSelect;

  Map1.CurrentTool := miZoomoutTool;
  Map1.MousePointer := miZoomoutCursor;

  btnout.ImageIndex := 8;
end;

procedure TfrmSituationBoard.btnOverlayToolsClick(Sender: TObject);
begin
  with frmOverlayTools do
  begin
    SelectedOverlayTab := FSelectedOverlayTab;
    Show;
  end;
end;

procedure TfrmSituationBoard.btnPanClick(Sender: TObject);
begin
  btnPan.Down := not btnPan.Down;
  btnZoom.Down := false;

  FMapCursor := mcSelect;

  Map1.CurrentTool := miPanTool;
  Map1.MousePointer := miPanCursor;

  btnPan.ImageIndex := 6;
end;

procedure TfrmSituationBoard.btnRullerClick(Sender: TObject);
begin
//  btnRuller.Down := not btnRuller.Down;
//
//  if btnRuller.Down then
//  begin
//    btnRuller.ImageIndex := 12;
//    with frmRuler do
//    begin
//      IDForm := 1;
//      Show;
//    end;
//  end
//  else
//  begin
//    btnRuller.ImageIndex := 11;
//    frmRuler.Hide;
//    Map1.Repaint;
//  end;
end;

procedure TfrmSituationBoard.btnselectClick(Sender: TObject);
begin
  FMapCursor := mcSelect;

  Map1.CurrentTool := miSelectTool;
  Map1.MousePointer := miDefaultCursor;
end;

procedure TfrmSituationBoard.LoadMap(Geoset: String);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if Map1 = nil then
    Exit;

  InitOleVariant(z);
  Map1.Layers.RemoveAll;

  Map1.Geoset := Geoset;

  if Geoset <> '' then
  begin
    for i := 1 to Map1.Layers.Count do
    begin
      Map1.Layers.Item(i).Selectable := false;
      Map1.Layers.Item(i).Editable := false;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := Map1.Layers.Add(mInfo, 1);

    Map1.Layers.AnimationLayer := FLyrDraw;
    Map1.MapUnit := miUnitNauticalMile;
  end;

  Map1.BackColor := RGB(192, 224, 255);
end;

procedure TfrmSituationBoard.LoadOverlay(IdOverlayTab: Integer);
begin
  Map1.Refresh;
  Map1.Repaint;
end;

procedure TfrmSituationBoard.LoadTabImage;
begin
  Image1.Picture.LoadFromFile(vMapSetting.ImageGame + FSelectedTabProperties.AddressTab);
end;

procedure TfrmSituationBoard.LoadTabMap;
begin
  pnlAlignToolBar.Width := round((pnlToolBar.Width - 433) / 2);

  LoadMap(vMapSetting.MapGSTGame + FSelectedTabProperties.AddressTab);
  LoadOverlay(FSelectedTabProperties.IdOverlayTab);
  FSelectedOverlayTab := SimManager.SimOverlay.GetOverlayTabByID(FSelectedTabProperties.IdOverlayTab)
end;

procedure TfrmSituationBoard.Map1DrawUserLayer(ASender: TObject;
  const Layer: IDispatch; hOutputDC, hAttributeDC: Integer; const RectFull, RectInvalid: IDispatch);
  var
  sx, sy, ex, ey: Integer;
//  itemStart, itemEnd  : TFlagPoint;
begin
  if not Assigned(FCanvas) then
    Exit;
  FCanvas.Handle := hOutputDC;

  SimManager.SimOverlay.Draw(FCanvas, Map1, FSelectedTabProperties.IdOverlayTab);
//  DrawOverlay.drawAll(FCanvas, Map1);
  simMgrClient.DrawFlagPoint.Draw(FCanvas);

//  if Assigned(DrawOverlay.FSelectedDraw) then
//  begin
//    DrawOverlay.FSelectedDraw.isSelected := True;
//    DrawOverlay.FSelectedDraw.Draw(FCanvas, Map1);
//  end;

//  {$REGION ' Menggambar Ruler '}
//  if frmRuler.isShow  then
//  begin
//    DrawFlagPoint.Draw(FCanvas);
//
//    if DrawFlagPoint.FList.Count = 2 then
//    begin
//      itemStart := DrawFlagPoint.FList[0];
//      itemEnd := DrawFlagPoint.FList[1];
//
//      FConverter.ConvertToScreen(itemStart.Post.X, itemStart.Post.Y, sx, sy);
//      FConverter.ConvertToScreen(itemEnd.Post.X, itemEnd.Post.Y, ex, ey);
//
//      with FCanvas do
//      begin
//        Brush.Style := bsClear;
//        Pen.Color := clRed;
//        Pen.Width := 2;
//
//        MoveTo(sx, sy);
//        LineTo(ex, ey);
//      end;
//    end;
//  end;
//  {$ENDREGION}
end;

procedure TfrmSituationBoard.Map1MapViewChanged(Sender: TObject);
var
  tempZoom: Double;
begin
  if Map1.CurrentTool = miZoomInTool then
  begin
    if Map1.Zoom <= 0.125 then
      tempZoom := 0.125;
    if (Map1.Zoom > 0.125) AND (Map1.Zoom < 1) then
      tempZoom := Map1.Zoom;
    if (Map1.Zoom >= 1) AND (Map1.Zoom <= 2500) then
      tempZoom := round(Map1.Zoom);
    if Map1.Zoom > 2500 then
      tempZoom := 2500;

    Map1.OnMapViewChanged := nil;
    Map1.ZoomTo(tempZoom, Map1.CenterX, Map1.CenterY);

    // if (Map1.Zoom > 0.125) AND (Map1.Zoom < 0.25) then
    // begin
    // cbSetScale.text := FormatFloat('0.000', tempZoom);
    // end
    // else if (Map1.Zoom >= 0.25) AND (Map1.Zoom < 0.5) then
    // begin
    // cbSetScale.text := FormatFloat('0.00', tempZoom);
    // end
    // else if (Map1.Zoom >= 0.5) AND (Map1.Zoom < 1) then
    // begin
    // cbSetScale.text := FormatFloat('0.0', tempZoom);
    // end
    // else
    // cbSetScale.text := floattostr(tempZoom);
    Map1.OnMapViewChanged := Map1MapViewChanged;
  end;
end;

procedure TfrmSituationBoard.pnlCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSituationBoard.RefreshTab;
begin
  if Assigned(FSelectedTabProperties) then
  begin
    case FSelectedTabProperties.TypeTab of
      0 :
      begin
        LoadTabMap;
        pnlMap.BringToFront;
      end;
      1 :
      begin
        LoadTabImage;
        pnlImage.BringToFront;
      end;
    end;
  end;
end;

procedure TfrmSituationBoard.UpdateTab;
var
  i, tagTemp : Integer;
  widthTemp : Integer;

begin
  widthTemp := Round(pnlHeaderSituationBoard.Width/13);

  tagTemp := 1;
  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TSpeedButton then
    begin
      if TSpeedButton(Components[i]).Tag < 14 then
      begin
        TSpeedButton(Components[i]).Width := 0;
        if SimManager.SimTabProperties.GetActiveTab(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, tagTemp) then
        begin
          if TSpeedButton(Components[i]).Tag = tagTemp then
          begin
            TSpeedButton(Components[i]).Width := widthTemp;
            TSpeedButton(Components[i]).Caption := SimManager.SimTabProperties.GetCaptionTab(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, tagTemp);
          end;
          inc(tagTemp);
        end
      end;
    end;
  end;
end;

procedure TfrmSituationBoard.Map1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos: TPoint;
  xTemp, yTemp : Double;
  posXTemp, posYTemp : Integer;

begin
  simMgrClient.Converter.ConvertToMap(X, Y, xTemp, yTemp);

  {$REGION ' Klik Kiri '}
  if Button = mbLeft then
  begin
    { Untuk kebutuhan overlay }
    if FMapCursor = mcEdit then
    begin
      frmOverlayTools.SelectShape(xTemp, yTemp);
    end
    else if FMapCursor = mcAdd then
    begin
      frmOverlayTools.SetPosition(xTemp, yTemp);

      with frmOverlayTools do
      begin
        case ShapeType of
          ovText, ovCircle, ovEllipse, ovArc, ovSector, ovGrid, ovIntelijen, ovRadar, ovLogistic, ovPangkalan, ovPlatform:
          begin
            if simMgrClient.DrawFlagPoint.FlagList.Count > 0 then
              simMgrClient.DrawFlagPoint.FlagList.Clear;

            GbrFlagPoint(xTemp, yTemp);
          end;
          ovLine, ovRectangle:
          begin
            if simMgrClient.DrawFlagPoint.FlagList.Count = 0 then
            begin
              GbrFlagPoint(0, 0);
              GbrFlagPoint(0, 0);
            end;
            EditFlagPoint(TagTombolPosition, xTemp, yTemp)
          end;
          ovPolygon:
          begin
            GbrFlagPoint(xTemp, yTemp);

            if SpeedButton10.Down then
            begin
              if lvPolyVertex.Items.Count > 12 then
              begin
                ShowMessage('kelebihan bro');
                Exit;
              end;

              with lvPolyVertex.Items.Add do
              begin
                SubItems.Add(formatDMS_long(xTemp));
                SubItems.Add(formatDMS_latt(yTemp));
              end;
              RefreshLvPolyVertexList;
            end;
          end;
        end;
      end;

      Map1.Refresh;
      Map1.Repaint;
    end;

//    else if  FMapCursor = mcRulerStart then
//    begin
//      OnAddRuller(mx,my);
//      frmRuler.Show;
//      map1.Repaint;
//    end
//    else if  FMapCursor = mcRulerEnd then
//    begin
//      OnAddRuller(mx,my);
//      frmRuler.Show;
//      map1.Repaint;
//    end

  end
{$ENDREGION}
//{$REGION ' Klik kanan '}
//  else if Button = mbRight then
//  begin
//    GetCursorPos(pos);
//
//    if IdAction = 2 then
//      pmOverlayEdit.Popup(pos.X, pos.Y);
//  end;
//
//  if isCapturingScreen then
//  begin
//    with fscrCapture do
//    begin
//      PDown.X := X;
//      PDown.Y := Y;
//      PActually.X := X;
//      PActually.Y := Y;
//      MouseIsDown := True;
//      canvas.DrawFocusRect(RECT(X, Y, X, Y));
//    end;
//  end;
//{$ENDREGION}
end;

procedure TfrmSituationBoard.Map1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
// var
// xx: Double;
// yy: Double;
begin
//  FConverter.ConvertToMap(X, Y, xx, yy);
//
//  lblBearing.Caption := FormatFloat('0.00', CalcBearing(Map1.CenterX,
//    Map1.CenterY, xx, yy));
//  lblDistance.Caption := FormatFloat('0.00',
//    FConverter.Distance_nmi(Map1.CenterX, Map1.CenterY, xx, yy));
//  getGridCursorPos;

end;

procedure TfrmSituationBoard.Map1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  if isCapturingScreen then
//  begin
//    with fscrCapture do
//    begin
//      PActually.X := X;
//      PActually.Y := Y;
//      MouseIsDown := True;
//
//      // TmpBmp := TBitmap.Create;
//      //
//      // with TmpBmp do
//      // begin
//      // Width := round(abs(PActually.X - PDown.X));
//      // Height := round(abs(PActually.Y - PDown.Y));
//      // BitBlt(TmpBmp.canvas.Handle, 0, 0, Width, Height,
//      // fscrCapture.Image1.canvas.Handle, Map1.Left + PDown.X, PDown.Y,
//      // SRCCOPY);
//      // fCaptureRes.imgCaptureResult.AutoSize := false;
//      // fCaptureRes.imgCaptureResult.Picture.Bitmap.Assign(TmpBmp);
//      // fCaptureRes.Width := Width + 10;
//      // fCaptureRes.Height := Height + fCaptureRes.Panel3.Height + 10;
//      // fCaptureRes.ShowModal;
//      //
//      // if fCaptureRes.recapture then
//      // fCaptureRes.recapture := false
//      // else
//      // isCapturingScreen := false;
//      // MouseIsDown := false;
//      // end;
//    end;
//  end;
//  Map1.Repaint; // dimatikan dl, msh coba polygon nya
end;

procedure TfrmSituationBoard.miDeleteClick(Sender: TObject);
var
  rec : TRecTCPSendSituationBoardTabProperties;

begin

  if Assigned(FSelectedTabProperties) then
  begin
    rec.OrderID := DELETE_TAB;
    rec.TabId := FSelectedTabProperties.IdTab;
    rec.OverlayTab := FSelectedTabProperties.IdOverlayTab;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.TabCaption := '';
    rec.TabType := 0;
    rec.TabAddres := '';

    simMgrClient.netSend_CmdSituationBoardTabProperties(rec);
  end;
end;

procedure TfrmSituationBoard.miRenameClick(Sender: TObject);
begin
//
end;

end.

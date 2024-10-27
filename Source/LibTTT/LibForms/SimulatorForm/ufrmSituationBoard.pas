unit ufrmSituationBoard;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons,

  {Project Uses}
  MapXLib_TLB, uCoordConvertor, uLibSetting, uT3SimManager, uSimMgr_Client, uRecordData, uNetBaseSocket, uClassData, ufrmCreateTab,
  ufrmImageInsert;

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
    pnlEditMap: TPanel;
    imgBackground: TImage;
    Image3: TImage;
    pnlCloseImage: TPanel;
    pnlCloseMap: TPanel;
    Image2: TImage;
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

    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnTabClick(Sender: TObject);
    procedure btnCreateTabClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pnlCloseClick(Sender: TObject);
    procedure btnEditImageAddressClick(Sender: TObject);


  private
    FLyrDraw: CMapXLayer;
    FConverter: TCoordConverter;

    procedure RoundCornerOf(Control: TWinControl; val1, val2: Integer);

  public
    SelectedTabProperties : TTabProperties;

    procedure LoadTabMap;
    procedure LoadTabImage;

    procedure LoadMap(Geoset: String);

    procedure UpdateTab;
    procedure RefreshTab;
  end;

var
  frmSituationBoard: TfrmSituationBoard;

implementation

{$R *.dfm}


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

procedure TfrmSituationBoard.btnCreateTabClick(Sender: TObject);
begin
  frmCreateTab := TfrmCreateTab.Create(Self);
  try
    with frmCreateTab do
    begin
      ShowModal;
    end;
  finally
    frmCreateTab.Free;
  end;
end;

procedure TfrmSituationBoard.btnTabClick(Sender: TObject);
begin
  SelectedTabProperties := SimManager.SimTabProperties.GetTapProperties(simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex,
  TSpeedButton(Sender).Tag);

  RefreshTab;
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

procedure TfrmSituationBoard.FormResize(Sender: TObject);
begin
  RoundCornerOf(pnlEditImage, 15, 15);
  RoundCornerOf(pnlEditMap, 15, 15);
  UpdateTab;
  RefreshTab;
end;

procedure TfrmSituationBoard.FormShow(Sender: TObject);
begin
  pnlHome.BringToFront;

  UpdateTab;
  RefreshTab;
end;

procedure TfrmSituationBoard.btnEditImageAddressClick(Sender: TObject);
begin
  frmImageInsert := TfrmImageInsert.Create(Self);
  try
    with frmImageInsert do
    begin
      TabId := SelectedTabProperties.IdTab;
      TabCaption := SelectedTabProperties.CaptionTab;
      ShowModal;
    end;
  finally
    frmImageInsert.Free;
  end;
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

procedure TfrmSituationBoard.LoadTabImage;
begin
  Image1.Picture.LoadFromFile(vMapSetting.ImageGame + SelectedTabProperties.AddressTab);
end;

procedure TfrmSituationBoard.LoadTabMap;
begin
  pnlAlignToolBar.Width := round((pnlToolBar.Width - 433) / 2);
  LoadMap(vMapSetting.MapGSTGame + SelectedTabProperties.AddressTab);
end;

procedure TfrmSituationBoard.pnlCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSituationBoard.RefreshTab;
begin
  if Assigned(SelectedTabProperties) then
  begin
    case SelectedTabProperties.TypeTab of
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
        if SimManager.SimTabProperties.GetActiveTab(simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex, tagTemp) then
        begin
          if TSpeedButton(Components[i]).Tag = tagTemp then
          begin
            TSpeedButton(Components[i]).Width := widthTemp;
            TSpeedButton(Components[i]).Caption := SimManager.SimTabProperties.GetCaptionTab(simMgrClient.MyConsoleData.
              UserRoleData.UserRoleIndex, tagTemp);
          end;

          inc(tagTemp);
        end;
      end;
    end;
  end;
end;

end.

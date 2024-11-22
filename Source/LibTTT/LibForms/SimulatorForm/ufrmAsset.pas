unit ufrmAsset;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ComCtrls,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData, uDBAsset_Vehicle;

type
  TfrmAsset = class(TForm)
    btnApply: TImage;
    btnCancel: TImage;
    btnOK: TImage;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnl2ControlPage: TPanel;
    pgcAssets: TPageControl;
    tsGeneral: TTabSheet;
    GroupBox5: TGroupBox;
    Label49: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label4: TLabel;
    Label18: TLabel;
    edtClass: TEdit;
    edtNation: TEdit;
    edtName: TEdit;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    lbl28: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edtLengthDimension: TEdit;
    edtWidthDimension: TEdit;
    edtHeightDimension: TEdit;
    edtWeightDimension: TEdit;
    edtDraftDimension: TEdit;
    gbDefaultModel: TGroupBox;
    Image: TImage;
    btnDefaultModel: TButton;
    GroupBox3: TGroupBox;
    lbl1: TLabel;
    Label3: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    edtHullNumber: TEdit;
    edtCallSign: TEdit;
    GroupBox4: TGroupBox;
    lbl3: TLabel;
    lbl12: TLabel;
    lbl4: TLabel;
    Label134: TLabel;
    cbbDomain: TComboBox;
    cbbCategory: TComboBox;
    tsAssets: TTabSheet;
    Label5: TLabel;
    Label48: TLabel;
    Label6: TLabel;
    cbbSensors: TComboBox;
    GroupBox13: TGroupBox;
    lvSensors: TListView;
    btnSensors: TButton;
    cbbWeapons: TComboBox;
    GroupBox8: TGroupBox;
    lvWeapon: TListView;
    cbbCountermeasures: TComboBox;
    GroupBox9: TGroupBox;
    lvCountermeasures: TListView;
    btnWeapon: TButton;
    btnCountermeasures: TButton;
    tsLogistic: TTabSheet;
    Label2: TLabel;
    grbTime: TGroupBox;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    medtEnduranceTime: TMaskEdit;
    grbRange: TGroupBox;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    edtMaximumRange: TEdit;
    grbCapacity: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label33: TLabel;
    Label42: TLabel;
    Label55: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    edtLubricantsCapacity: TEdit;
    edtWaterCapacity: TEdit;
    edtFoodCapacity: TEdit;
    edtFuel: TEdit;
    grbConsumption: TGroupBox;
    Label1: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label56: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label7: TLabel;
    Label19: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    edtLubricantsConsumtion: TEdit;
    edtWaterComsumption: TEdit;
    edtFoodComsumption: TEdit;
    edtMinimumConsumtion: TEdit;
    edtMaximumConsumtion: TEdit;
    edtCruiseConsumtion: TEdit;
    edtHighConsumtion: TEdit;
    cbxEnduranceType: TComboBox;
    tsTransport: TTabSheet;
    GroupBox10: TGroupBox;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    edtMaxWeightDeckUnitCarried: TEdit;
    edtWidthDeckUnitCarried: TEdit;
    EdtLengthDeckUnitCarried: TEdit;
    cbbAmphibious: TCheckBox;
    cbbLand: TCheckBox;
    grpPersonelUnitCarried: TGroupBox;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    edtMaxCapacity: TEdit;
    cbbCarriedUnit: TCheckBox;
    cbbPersonelUnitCarried: TCheckBox;
    grpHangarUnitCarried: TGroupBox;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    EdtMaxCapacityHangarUnitCarried: TEdit;
    edtMaxWeightHangarUnitCarried: TEdit;
    cbbFixWing: TCheckBox;
    cbbRotary: TCheckBox;
    cbbHangerUnitCarried: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox6: TGroupBox;
    Label17: TLabel;
    Label54: TLabel;
    Label57: TLabel;
    edtOfficer: TEdit;
    GroupBox2: TGroupBox;
    lvTacticalSymbol: TListView;
    GroupBox7: TGroupBox;
    cbGangwayFront: TCheckBox;
    cbGangwayRear: TCheckBox;
    cbGangwayPort: TCheckBox;
    cbGangwayStarboard: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure cbbDomainChange(Sender: TObject);
    procedure cbbCategoryChange(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
    procedure btnOpenDialogImageClick(Sender: TObject);
    procedure btnRadarClick(Sender: TObject);
    procedure btnSonarClick(Sender: TObject);
    procedure btnESMClick(Sender: TObject);
    procedure btnEODClick(Sender: TObject);
    procedure btnMADClick(Sender: TObject);
    procedure btnSonobuoyClick(Sender: TObject);
    procedure btnVisualDetectorClick(Sender: TObject);
    procedure btnIFFClick(Sender: TObject);
    procedure btnMissilesClick(Sender: TObject);
    procedure btnTorpedosClick(Sender: TObject);
    procedure btnMinesClick(Sender: TObject);
    procedure btnGunsClick(Sender: TObject);
    procedure btnBomb_DepthChargesClick(Sender: TObject);
    procedure btnAccousticDecoyClick(Sender: TObject);
    procedure btnAirBubbleClick(Sender: TObject);
    procedure btnChaffClick(Sender: TObject);
    procedure btnFloatingDecoyClick(Sender: TObject);
    procedure btnInfraredDecoyClick(Sender: TObject);
    procedure btnRadarJummerClick(Sender: TObject);
    procedure btnDefensiveJummerClick(Sender: TObject);
    procedure btnTowedJummer_DecoyClick(Sender: TObject);
    procedure btnEmbarkedPlatformsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure ValidationFormatInput();
    procedure edtNumeralkeyPress(Sender: TObject; var Key: Char);
    function GetNumberOfKoma(s : string): Boolean;
    procedure CheckBoxDataClick(Sender: TObject);
    procedure cbxEnduranceTypeChange(Sender: TObject);

  private
    FSelectedAsset : TAsset ;

    function CekInput : Boolean;
    procedure UpdateVehicleData;
    procedure UpdateModelData;

    procedure UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);
    procedure UpdateCbbTypeItems(const aDomain, aCategory, IdType: Byte);

  public
    isOK : Boolean;
    afterClose : Boolean;
    LastName : string;

    property SelectedAsset : TAsset read FSelectedAsset write FSelectedAsset;
  end;

var
  frmAsset: TfrmAsset;

implementation

{$R *.dfm}
uses
  ufrmRadarOnBoardPickList, ufrmSonarOnBoardPickList, ufrmESMOnBoardPickList,
  ufrmEODOnBoardPickList, ufrmMADOnBoardPickList, ufrmSonobuoyOnBoardPickList,
  ufrmVisualDetectorOnBoardPickList, ufrmIFFOnBoardPickList, ufrmMissileOnBoardPickList,
  ufrmTorpedoOnBoardPickList, ufrmMineOnBoardPickList, ufrmGunOnBoardPickList,
  ufrmBombOnBoardPickList, ufrmAcousticDecoyOnBoardPickList, ufrmAirBubbleOnBoardPickList,
  ufrmChaffOnBoardPickList, ufrmFloatingDecoyOnBoardPickList, ufrmInfraredDecoyOnBoardPickList,
  ufrmRadarNoiseJammerOnBoardPickList, ufrmSelfDefensiveJammerOnBoardPickList,
  ufrmTowedJammerDecoyOnBoardPickList, ufrmEmbarkedOnBoardPickList, uSimbolTaktis;

procedure TfrmAsset.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateVehicleData;

  with FSelectedAsset.FData do
    btnApply.Enabled := Vehicle_Index = 0;

  isOK := True;
  afterClose := True;
  btnCancel.Enabled := True;
end;

procedure TfrmAsset.btnApplyClick(Sender: TObject);
begin
  with FSelectedAsset do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION 'General'}
    LastName := edtClass.Text;
    FData.Vehicle_Identifier := edtClass.Text;

    FData.Platform_Domain := cbbDomain.ItemIndex;
    FData.Platform_Category := cbbCategory.ItemIndex;
//    FData.Platform_Type := cbbType.ItemIndex;
//    FData.HullNumber := edtNoLambung.Text;
//    FData.CallSign := edtCallSign.Text;
    {$ENDREGION}

    {$REGION 'Physical'}
    FData.Length := StrToFloat(edtLengthDimension.Text);
    FData.Width := StrToFloat(edtWidthDimension.Text);
    FData.Height := StrToFloat(edtHeightDimension.Text);
    FData.Draft := StrToFloat(edtDraftDimension.Text);
    FData.DWT := StrToFloat(edtWeightDimension.Text);

    FData.FrontGangway := cbGangwayFront.Checked;
    FData.RearGangway := cbGangwayRear.Checked;
    FData.PortGangway := cbGangwayPort.Checked;
    FData.StarBoardGangway := cbGangwayStarboard.Checked;
    {$ENDREGION}

    if FData.Vehicle_Index = 0 then
    begin
      if dmINWO.InsertVehicleDef(FSelectedAsset.FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateVehicleDef(FSelectedAsset.FData) then
      begin
        ShowMessage('Data has been updated');;
      end;
    end;
  end;

  isOK := True;
  afterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;

end;

procedure TfrmAsset.btnCancelClick(Sender: TObject);
begin
  afterClose := False;
  Close;
end;

procedure TfrmAsset.btnOKClick(Sender: TObject);
begin
//  if btnApply.Enabled then
//    btnApply.Click;

  if isOK then
    Close;
end;

{$REGION 'General'}
procedure TfrmAsset.cbbCategoryChange(Sender: TObject);
begin
  UpdateCbbTypeItems(cbbDomain.ItemIndex, cbbCategory.ItemIndex, 0);
end;

procedure TfrmAsset.cbbDomainChange(Sender: TObject);
begin
  UpdateCbbCategoryItems(cbbDomain.ItemIndex, 0);
  UpdateCbbTypeItems(cbbDomain.ItemIndex,0 ,0);

  btnApply.Enabled := True;
end;

procedure TfrmAsset.cbbTypeChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmAsset.cbxEnduranceTypeChange(Sender: TObject);
begin
  grbCapacity.Visible := (cbxEnduranceType.ItemIndex = 0);
  grbConsumption.Visible := (cbxEnduranceType.ItemIndex = 0);
  grbTime.Visible := (cbxEnduranceType.ItemIndex = 1);
  grbRange.Visible := (cbxEnduranceType.ItemIndex = 2);
end;

{$ENDREGION}

{$REGION 'Model'}
procedure TfrmAsset.btnOpenDialogImageClick(Sender: TObject);
begin
//  if edtModelPath.Text = '' then
//  begin
//    ShowMessage('Please inser vehicle id');
//  end;
//
//  try
////    Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + edtModelPath.Text + '.PNG');
//  except
//    ShowMessage('Model is not found');
//  end;
end;

{$ENDREGION}

{$REGION 'Physical'}

{$ENDREGION}

{$REGION 'Assets'}
procedure TfrmAsset.btnRadarClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmRadarOnBoardPickList := TfrmRadarOnBoardPickList.Create(Self);
  try
    with frmRadarOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmRadarOnBoardPickList.AfterClose;
  finally
    frmRadarOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not AfterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnSonarClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmSonarOnBoardPickList := TfrmSonarOnBoardPickList.Create(Self);
  try
    with frmSonarOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmSonarOnBoardPickList.AfterClose;
  finally
    frmSonarOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnSonobuoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmSonobuoyOnBoardPickList := TfrmSonobuoyOnBoardPickList.Create(Self);
  try
    with frmSonobuoyOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmSonobuoyOnBoardPickList.AfterClose;
  finally
    frmSonobuoyOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnESMClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmESMOnBoardPickList := TfrmESMOnBoardPickList.Create(Self);
  try
    with frmESMOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmESMOnBoardPickList.AfterClose;
  finally
    frmESMOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnIFFClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmIFFOnBoardPickList := TfrmIFFOnBoardPickList.Create(Self);
  try
    with frmIFFOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmIFFOnBoardPickList.AfterClose;
  finally
    frmIFFOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnMADClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmMADOnBoardPickList := TfrmMADOnBoardPickList.Create(Self);
  try
    with frmMADOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmMADOnBoardPickList.AfterClose;
  finally
    frmMADOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnEODClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmEODOnBoardPickList := TfrmEODOnBoardPickList.Create(Self);
  try
    with frmEODOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmEODOnBoardPickList.AfterClose;
  finally
    frmEODOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnVisualDetectorClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmVisualDetectorOnBoardPickList := TfrmVisualDetectorOnBoardPickList.Create(Self);
  try
    with frmVisualDetectorOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmVisualDetectorOnBoardPickList.AfterClose;
  finally
    frmVisualDetectorOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;


procedure TfrmAsset.btnMissilesClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmMissileOnBoardPickList := TfrmMissileOnBoardPickList.Create(Self);
  try
    with frmMissileOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmMissileOnBoardPickList.AfterClose;
  finally
    frmMissileOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnTorpedosClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmTorpedoOnBoardPickList := TfrmTorpedoOnBoardPickList.Create(Self);
  try
    with frmTorpedoOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmTorpedoOnBoardPickList.AfterClose;
  finally
    frmTorpedoOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnMinesClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmMineOnBoardPickList := TfrmMineOnBoardPickList.Create(Self);
  try
    with frmMineOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmMineOnBoardPickList.AfterClose;
  finally
    frmMineOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnGunsClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmGunOnBoardPickList := TfrmGunOnBoardPickList.Create(Self);
  try
    with frmGunOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmGunOnBoardPickList.AfterClose;
  finally
    frmGunOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnBomb_DepthChargesClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmBombOnBoardPickList := TfrmBombOnBoardPickList.Create(Self);
  try
    with frmBombOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmBombOnBoardPickList.AfterClose;
  finally
    frmBombOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;


procedure TfrmAsset.btnAccousticDecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmAcousticDecoyOnBoardPickList := TfrmAcousticDecoyOnBoardPickList.Create(Self);
  try
    with frmAcousticDecoyOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmAcousticDecoyOnBoardPickList.AfterClose;
  finally
    frmAcousticDecoyOnBoardPickList.Free;
  end;

//  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnAirBubbleClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmAirBubbleOnBoardPickList := TfrmAirBubbleOnBoardPickList.Create(Self);
  try
    with frmAirBubbleOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmAirBubbleOnBoardPickList.AfterClose;
  finally
    frmAirBubbleOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnChaffClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmChaffOnBoardPickList := TfrmChaffOnBoardPickList.Create(Self);
  try
    with frmChaffOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmChaffOnBoardPickList.AfterClose;
  finally
    frmChaffOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnDefensiveJummerClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmSelfDefensiveJammerOnBoardPickList := TfrmSelfDefensiveJammerOnBoardPickList.Create(Self);
  try
    with frmSelfDefensiveJammerOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmSelfDefensiveJammerOnBoardPickList.AfterClose;
  finally
    frmSelfDefensiveJammerOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnFloatingDecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmFloatingDecoyOnBoardPickList := TfrmFloatingDecoyOnBoardPickList.Create(Self);
  try
    with frmFloatingDecoyOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmFloatingDecoyOnBoardPickList.AfterClose;
  finally
    frmFloatingDecoyOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnInfraredDecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmInfraredDecoyOnBoardPickList := TfrmInfraredDecoyOnBoardPickList.Create(Self);
  try
    with frmInfraredDecoyOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmInfraredDecoyOnBoardPickList.AfterClose;
  finally
    frmInfraredDecoyOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnRadarJummerClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmRadarNoiseJammerOnBoardPickList := TfrmRadarNoiseJammerOnBoardPickList.Create(Self);
  try
    with frmRadarNoiseJammerOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmRadarNoiseJammerOnBoardPickList.AfterClose;
  finally
    frmRadarNoiseJammerOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnTowedJummer_DecoyClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmTowedJammerDecoyOnBoardPickList := TfrmTowedJammerDecoyOnBoardPickList.Create(Self);
  try
    with frmTowedJammerDecoyOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmTowedJammerDecoyOnBoardPickList.AfterClose;
  finally
    frmTowedJammerDecoyOnBoardPickList.Free;
  end;

  btnCancel.Enabled := not afterClose;
  btnApply.Enabled := afterClose;
end;

procedure TfrmAsset.btnEmbarkedPlatformsClick(Sender: TObject);
begin
  {$REGION 'jika class belum tersimpan'}
  if FSelectedAsset.FData.Vehicle_Index = 0 then
  begin
    ShowMessage('Save data class before continue');
    Exit;
  end;
  {$ENDREGION}

  frmEmbarkedOnBoardPickList := TfrmEmbarkedOnBoardPickList.Create(Self);
  try
    with frmEmbarkedOnBoardPickList do
    begin
      SelectedAsset := FSelectedAsset;
      ShowModal;
    end;

    AfterClose := frmEmbarkedOnBoardPickList.AfterClose;
  finally
    frmEmbarkedOnBoardPickList.Free;
  end;

  btnApply.Enabled := True;
end;

{$ENDREGION}

function TfrmAsset.CekInput: Boolean;
var
  i, chkSpace, numSpace : Integer;
begin
  Result := False;

  {jika inputan kosong}
  if (edtClass.Text = '') then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  {jika inputan spasi semua}
  if Copy(edtClass.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtClass.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtClass.Text[i] = #32 then
      numSpace := numSpace +1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('please use another class name');
      Exit;
    end;
  end;

  {jika class name sudah ada}
  if (dmINWO.GetVehicleDef(edtClass.Text)>0) then
  begin
    {jika inputan baru}
    if FSelectedAsset.FData.Vehicle_Index = 0 then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end
    else if LastName <> edtClass.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmAsset.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmAsset.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

function TfrmAsset.GetNumberOfKoma(s: string): Boolean;
var
  a, i : Integer;
begin
  Result := False;
  a := 0;

  for i := 1 to Length(s) do
  begin
    if s[i] = '.' then
      a := a + 1;
  end;

  if a > 0 then
    Result := True;
end;

procedure TfrmAsset.edtNumeralkeyPress(Sender: TObject; var Key: Char);
var
  value : Double;
begin
  if not (Key in[#48 .. #57, #8, #13, #46]) then
  begin
    Key := #0;
    Exit;
  end;

  if GetNumberOfKoma(TEdit(Sender).Text) then
  begin
    if Key = #46 then
      Key := #0;
  end;

  if Key = #13 then
  begin
    if TEdit(Sender).Text = '' then
      TEdit(Sender).Text := '0';

    value := StrToFloat(TEdit(Sender).Text);

    case TEdit(Sender).Tag of
      0: TEdit(Sender).Text := FormatFloat('0', value);
      1: TEdit(Sender).Text := FormatFloat('0.0', value);
      2: TEdit(Sender).Text := FormatFloat('0.00', value);
      3: TEdit(Sender).Text := FormatFloat('0.000', value);
    end;

    btnApply.Enabled := True;
  end;

end;

procedure TfrmAsset.UpdateCbbCategoryItems(const aDomain, IdCategory: Byte);
begin
  case aDomain of
    0: //Air
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Military');
      cbbCategory.Items.Add('Civilian');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    1: //Surface
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Combatant');
      cbbCategory.Items.Add('Non-combatant');
      cbbCategory.Items.Add('Non-naval');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    2: //Subsurface
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Submarine');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    3: //Land
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Armoured Vehicle');
      cbbCategory.Items.Add('Transport Vehicle');
      cbbCategory.Items.Add('Infantry');
      cbbCategory.Items.Add('Artillery');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
    4: //Amphibious
    begin
      cbbCategory.Items.Clear;
      cbbCategory.Items.Add('Amphibious');
      cbbCategory.Items.Add('Other');

      cbbCategory.ItemIndex := IdCategory;
    end;
  end;

  btnApply.Enabled := True;
end;

procedure TfrmAsset.UpdateCbbTypeItems(const aDomain, aCategory, IdType: Byte);
begin

end;

procedure TfrmAsset.UpdateModelData;
begin

  with FSelectedAsset.FData do
  begin
    try
      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\' + Vbs_Class_Name + '.PNG');
    except
      Image.Picture.LoadFromFile('data\Image DBEditor\Interface\NoModel.bmp');
    end;

  end;
end;

procedure TfrmAsset.UpdateVehicleData;
begin
  with FSelectedAsset do
  begin
    if FData.Vehicle_Index = 0 then
      edtClass.Text := '(unnamed)'
    else
      edtClass.Text := FData.Vehicle_Identifier;

    {$REGION 'General'}
    LastName := edtClass.Text;

    UpdateCbbCategoryItems(FData.Platform_Domain, FData.Platform_Category);
    UpdateCbbTypeItems(FData.Platform_Domain, FData.Platform_Category, FData.Platform_Type);

    cbbDomain.ItemIndex := FData.Platform_Domain;
    cbbCategory.ItemIndex := FData.Platform_Category;
//    FData.HullNumber := edtNoLambung.Text;
//    FData.CallSign := edtCallSign.Text;

    {$ENDREGION}

    {$REGION 'Model'}
    UpdateModelData;
    {$ENDREGION}

    {$REGION 'Physical'}
    edtLengthDimension.Text := FormatFloat('0', FData.Length);
    edtWidthDimension.Text := FormatFloat('0', FData.Width);
    edtHeightDimension.Text := FormatFloat('0', FData.Height);
    edtDraftDimension.Text := FormatFloat('0', FData.Draft);
    edtWeightDimension.Text := FormatFloat('0.0', FData.DWT);

    cbGangwayFront.Checked := FData.FrontGangway;
    cbGangwayRear.Checked := FData.RearGangway;
    cbGangwayPort.Checked := FData.PortGangway;
    cbGangwayStarboard.Checked := FData.StarBoardGangway;

//    edtkecepatanJelajah.Text := FormatFloat('0', FData);
//    edtKecepatanEkonomis.Text := FormatFloat('0', FData);
//    edtKecepatanMaksimal.Text := FormatFloat('0', FData);

//    edtKapasitasAT.Text := FormatFloat('0', FData);
//    edtKapasitasBB.Text := FormatFloat('0', FData);
//    edtKapasitasML.Text := FormatFloat('0', FData);
//    edtFood.Text := FormatFloat('0', FData);

//    edtKonsumsiFuel.Text := FormatFloat('0', FData);
//    edtEndurance.Text := FormatFloat('0', FData);

    {$ENDREGION}
  end;
end;

procedure TfrmAsset.ValidationFormatInput;
var
  i, j: Integer;
  value : Double;
  flag : Boolean;

begin
  for i:= 0 to ComponentCount-1 do
  begin
    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Tag = 4 then
        continue;

      if TEdit(Components[i]).Text = '' then
        TEdit(Components[i]).Text := '0';

      value := StrToFloat(TEdit(Components[i]).Text);

      case TEdit(Components[i]).Tag of
        0: TEdit(Components[i]).Text := FormatFloat('0', value);
        1: TEdit(Components[i]).Text := FormatFloat('0.0', value);
        2: TEdit(Components[i]).Text := FormatFloat('0.00', value);
        3: TEdit(Components[i]).Text := FormatFloat('0.000', value);
      end;

      Continue;
    end;
  end;
end;

end.

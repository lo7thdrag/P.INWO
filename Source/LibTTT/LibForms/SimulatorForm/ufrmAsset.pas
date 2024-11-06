unit ufrmAsset;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ComCtrls,

  {uses project}
   uSimMgr_Client, uLibSetting, uClassData, uDataModule, uRecordData;

type
  TfrmAsset = class(TForm)
    pnlMain: TPanel;
    imgBackgroundForm: TImage;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    lblPlatform: TLabel;
    btnOK: TImage;
    btnApply: TImage;
    btnCancel: TImage;
    pgc: TPageControl;
    tsGeneral: TTabSheet;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl1: TLabel;
    Label3: TLabel;
    cbbCategory: TComboBox;
    cbbType: TComboBox;
    cbbDomain: TComboBox;
    edtQuantityGroupPersonal: TEdit;
    edtNoLambung: TEdit;
    tsModel: TTabSheet;
    lbl23: TLabel;
    Image: TImage;
    grp1: TGroupBox;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    edtSymbolID: TEdit;
    edtVBSClassName: TEdit;
    grp2: TGroupBox;
    btnTacticalSymbol: TSpeedButton;
    lbl14: TLabel;
    lbl24: TLabel;
    lblFontTaktis: TLabel;
    lblKeteranganSymbol: TLabel;
    Label2: TLabel;
    sButton1: TSpeedButton;
    cbbFontType: TComboBox;
    edtFontID: TEdit;
    edtModelPath: TEdit;
    tsPhysical: TTabSheet;
    lblMotionCharacteristic: TLabel;
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
    Label17: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    lbl22: TLabel;
    lbl29: TLabel;
    edtLengthDimension: TEdit;
    edtWidthDimension: TEdit;
    edtHeightDimension: TEdit;
    edtWeightDimension: TEdit;
    edtEngagementRangeDimension: TEdit;
    edtDraftDimension: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    cbGangwayFront: TCheckBox;
    cbGangwayRear: TCheckBox;
    cbGangwayPort: TCheckBox;
    cbGangwayStarboard: TCheckBox;
    edtMotionCharacterictic: TEdit;
    btnMotionCharacteristic: TButton;
    tsAssets: TTabSheet;
    grbSensor: TGroupBox;
    btnRadar: TButton;
    btnMAD: TButton;
    btnESM: TButton;
    btnSonar: TButton;
    btnElectroOpticalDetector: TButton;
    btnIFF: TButton;
    btnVisualDetector: TButton;
    btnSonobuoy: TButton;
    grbWeapons: TGroupBox;
    btnMissiles: TButton;
    btnTorpedos: TButton;
    btnMines: TButton;
    btnGuns: TButton;
    btnBomb_DepthCharges: TButton;
    grbCountermeasures: TGroupBox;
    btnRadarJummer: TButton;
    btnAirBubble: TButton;
    btnAccousticDecoy: TButton;
    btnDefensiveJummer: TButton;
    btnTowedJummer_Decoy: TButton;
    btnFloatingDecoy: TButton;
    btnChaff: TButton;
    btnInfraredDecoy: TButton;
    btnEmbarkedPlatforms: TButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtkecepatanJelajah: TEdit;
    edtKecepatanEkonomis: TEdit;
    edtKecepatanMaksimal: TEdit;
    Label28: TLabel;
    Edit4: TEdit;
    Label32: TLabel;
    Edit8: TEdit;
    GroupBox4: TGroupBox;
    Label29: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Edit7: TEdit;
    Label33: TLabel;
    Edit9: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedAsset : TAsset ;

    function CekInput : Boolean;

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

procedure TfrmAsset.btnApplyClick(Sender: TObject);
begin
  with FSelectedAsset do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;
  end;
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
//
//  if isOK then
//    Close;
end;

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
end;

end.

unit ufrmCreateTab;

interface

uses
  {Delphi Uses}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  {Project Uses}
  uClassData, uT3SimManager, uSimMgr_Client, uRecordData;

type
  TfrmCreateTab = class(TForm)
    lbl1: TLabel;
    Label1: TLabel;
    edtCaption: TEdit;
    cbbType: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmCreateTab: TfrmCreateTab;

implementation

{$R *.dfm}

procedure TfrmCreateTab.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCreateTab.btnOKClick(Sender: TObject);
var
  i : Integer;
  rec : TRecTCPSendSituationBoardTabProperties;
begin

  for i := 1 to 13 do
  begin
    if not SimManager.SimTabProperties.GetActiveTab(simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex, i) then
      Break;
  end;

  rec.OrderID := NEW_TAB;
  rec.TabId := i;
  rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
  rec.TabCaption := edtCaption.Text;
  rec.TabType := cbbType.ItemIndex;

  if cbbType.ItemIndex = 0 then
    rec.TabAddres := '\indonesia-Background\indonesia-Background.gst'
  else
    rec.TabAddres := '\DefaultImage.png';

  simMgrClient.netSend_CmdSituationBoardTabProperties(rec);

  Close;
end;

procedure TfrmCreateTab.cbbTypeChange(Sender: TObject);
begin
  if cbbType.ItemIndex = -1 then
    cbbType.ItemIndex := 0;
end;

end.

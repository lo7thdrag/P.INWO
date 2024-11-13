unit ufrmTacticalDisplay;

interface

uses
  {Delphi Uses}
  Tlhelp32, ShellAPI, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Buttons, ComCtrls, OleCtrls, Menus, ToolWin, ImgList, ActnMan, VrControls, VrAnalog, Keyboard, VrWheel,
  RzButton, jpeg, System.ImageList, Vcl.Imaging.pngimage, RzBmpBtn, Printers, Math,

  {Project Uses}
  uClassData, uRecordData, uConstantaData, uConsoleData,uBaseCoordSystem, uCoordConvertor, uLibSetting, uSimObjects,
  uSimMgr_Client, uT3SimManager, ufrmDisplayArea, ufrmSituationBoard ;

type

  TfrmTacticalDisplay = class(TForm)
    pnlMainLogin: TPanel;
    pnlLeft: TPanel;
    pnlCenter: TPanel;
    pnlLogo: TPanel;
    Image6: TImage;
    Image1: TImage;
    pnlLogin: TPanel;
    btnShowPassword: TImage;
    btnLogin: TButton;
    edtPassword: TEdit;
    edtUsername: TEdit;
    lblGameArea: TLabel;
    lblPlatform: TLabel;
    Label1: TLabel;
    pnlDescription: TPanel;
    imgLoginBackground: TImage;
    lblWelcome: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Image2: TImage;
    btnStart: TButton;
    Label10: TLabel;
    cbbTahapan: TComboBox;
    Panel1: TPanel;
    lblOperasi: TLabel;
    Panel2: TPanel;
    lblKomandoTugas: TLabel;
    Panel3: TPanel;
    lblUserRole: TLabel;
    btnLogout: TButton;
    pnlBackgroundLogin: TPanel;
    imgBackgroundLogin: TImage;
    pnlSituationBoard: TPanel;
    Label3: TLabel;
    Image3: TImage;
    Label7: TLabel;
    btnShow: TButton;
    cbbConsoleName: TComboBox;
    pnlHome: TPanel;
    imgHome: TImage;
    btnPlanning: TRzBmpButton;
    btnPreparation: TRzBmpButton;
    btnImplementation: TRzBmpButton;
    btnTermination: TRzBmpButton;
    cbbSubRole: TComboBox;
    lstUserRoleLogin: TListBox;
    lblUserIdentifier: TLabel;
    btnBack: TButton;
    lblConsoleName: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnShowPasswordClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure cbbConsoleNameDropDown(Sender: TObject);
    procedure btnPlanningClick(Sender: TObject);
    procedure btnPreparationClick(Sender: TObject);
    procedure btnImplementationClick(Sender: TObject);
    procedure btnTerminationClick(Sender: TObject);
    procedure cbbSubRoleSelect(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstUserRoleLoginDblClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FSelectedSubRole : TSubRole;
    FselectedUserRole : TUserRole;

    procedure AddCbbSubRole(tipeTahapan : Integer);
    procedure AddUserRoleLogin(SubRoleId : integer);

  public
    procedure Initialize;

    procedure UpdateGameState(Sender: TObject);
    procedure UpdateClientLogin(Sender: TObject);
    procedure UpdateClientLogout(Sender: TObject);

  end;

var
  frmTacticalDisplay: TfrmTacticalDisplay;

implementation

{$R *.dfm}

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

procedure TfrmTacticalDisplay.btnShowPasswordClick(Sender: TObject);
begin
  if (EdtPassword.PasswordChar = '*') then
  begin
    btnShowPassword.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnShowPassword.png');
    EdtPassword.PasswordChar := #0;
  end
  else
  begin
    btnShowPassword.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnHidePassword.png');
    EdtPassword.PasswordChar := '*';
  end
end;

procedure TfrmTacticalDisplay.btnStartClick(Sender: TObject);
begin
  if cbbTahapan.ItemIndex = -1 then
  begin
    ShowMessage('Silahkan pilih jenis tahapan ');
    Exit;
  end;

  frmDisplayArea := TfrmDisplayArea.Create(Self);
  try
    with frmDisplayArea do
    begin
//      simMgrClient.MyConsoleData.TipeTahapan := Byte(SetTipeTahapanToEnum(cbbTahapan.Text));
//      ShowModal;
      Show;
    end;

  finally
    frmDisplayArea.Free;
  end;
end;

procedure TfrmTacticalDisplay.btnTerminationClick(Sender: TObject);
begin
  if btnTermination.Down then
  begin
    cbbSubRole.Left := 1430;
    lstUserRoleLogin.Left := 1430;

    cbbSubRole.Visible := True;

    AddCbbSubRole(3);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;

end;

procedure TfrmTacticalDisplay.cbbConsoleNameDropDown(Sender: TObject);
var
  i : Integer;
  consoleInfoTemp : TConsoleInfo;
  userRoleTemp : TUserRole;

begin
  cbbConsoleName.Clear;

  for i := 0 to simMgrClient.SimConsole.ConsoleList.Count-1 do
  begin
    consoleInfoTemp := TConsoleInfo(simMgrClient.SimConsole.ConsoleList.Objects[i]);

    userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(consoleInfoTemp.IPAddress);

    if Assigned(userRoleTemp) then
    begin
      if userRoleTemp.isInUse then
      begin
        cbbConsoleName.Items.Add(consoleInfoTemp.ConsoleName);
      end
    end;
  end;

end;

procedure TfrmTacticalDisplay.cbbSubRoleSelect(Sender: TObject);
begin
  if cbbSubRole.ItemIndex = -1 then
    Exit;

  FSelectedSubRole := TSubRole(cbbSubRole.Items.Objects[cbbSubRole.ItemIndex]);

  if Assigned(FSelectedSubRole) then
  begin
    AddUserRoleLogin(FSelectedSubRole.FData.SubRoleIndex);
    lstUserRoleLogin.Visible := True;
  end;

end;

procedure TfrmTacticalDisplay.btnShowClick(Sender: TObject);
var
  ipTemp : string;
  userRoleTemp : TUserRole;

begin
  if (cbbConsoleName.ItemIndex = -1) or (cbbConsoleName.Text = '') then
  begin
    ShowMessage('Console yang dipilih sedang tidak digunakan');
    Exit;
  end;

  ipTemp := simMgrClient.SimConsole.GetIPAddress(cbbConsoleName.Text);
  userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(ipTemp);

  simMgrClient.MyConsoleData.assignUserRoleData(userRoleTemp);

  frmSituationBoard.Show;
end;


procedure TfrmTacticalDisplay.AddCbbSubRole(tipeTahapan : Integer);
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  cbbSubRole.Items.Clear;

  for i := 0 to SimManager.SimSubRole.SubRoleList.Count-1 do
  begin
    subRoleTemp := SimManager.SimSubRole.SubRoleList[i];

    if Assigned(subRoleTemp) then
    begin
      case tipeTahapan of
        0:
        begin
          if subRoleTemp.FData.Perencanaan = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
        1:
        begin
          if subRoleTemp.FData.Persiapan = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
        2:
        begin
          if subRoleTemp.FData.Pelaksanaan = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
        3:
        begin
          if subRoleTemp.FData.Pengakhiran = 1 then
            cbbSubRole.Items.AddObject(subRoleTemp.FData.SubRoleAcronim, subRoleTemp);
        end;
      end;
    end;
  end;
end;

procedure TfrmTacticalDisplay.AddUserRoleLogin(SubRoleId : integer);
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  lstUserRoleLogin.Items.Clear;

  for i := 0 to SimManager.SimUserRole.UserList.Count-1 do
  begin
    userRoleTemp := SimManager.SimUserRole.UserList[i];

    if Assigned(userRoleTemp) then
    begin
      if userRoleTemp.FData.SubRoleIndex = SubRoleId then
        lstUserRoleLogin.Items.AddObject(userRoleTemp.FData.UserRoleAcronim, userRoleTemp);
    end;
  end;
end;

procedure TfrmTacticalDisplay.btnBackClick(Sender: TObject);
begin
  btnPlanning.Down := False;
  btnPreparation.Down := False;
  btnImplementation.Down := False;
  btnTermination.Down := False;

  cbbSubRole.Visible := False;
  lstUserRoleLogin.Visible := False;

  pnlHome.BringToFront;
end;

procedure TfrmTacticalDisplay.btnImplementationClick(Sender: TObject);
begin
  if btnImplementation.Down then
  begin
    cbbSubRole.Left := 1000;
    lstUserRoleLogin.Left := 1000;

    cbbSubRole.Visible := True;

    AddCbbSubRole(2);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;

end;

procedure TfrmTacticalDisplay.btnLoginClick(Sender: TObject);
var
  rec : TRecTCP_UserState;

begin
  if not SimManager.GetGameState then
  begin
    ShowMessage('Your consule is not connecting to the server');
    Exit;
  end;

  if Assigned(FselectedUserRole) then
  begin
    if (FselectedUserRole.FData.Username = edtUsername.Text)  and (FselectedUserRole.FData.Password = edtPassword.Text) then
    begin
      if not FselectedUserRole.isInUse then
      begin
        rec.OrderID       := CORD_ID_LOGIN;
        rec.UserRoleId    := FselectedUserRole.FData.UserRoleIndex;
        rec.ConsoleIP     := simMgrClient.MyConsoleData.IpAdrres;
        rec.UserRoleInUse := True;

        simMgrClient.netSend_CmdUserState(rec);
      end
      else
      begin
        ShowMessage('User Role is in use ');
      end;
    end
    else
    begin
      ShowMessage('Invalid username and password ');
    end;
  end
  else
  begin
    ShowMessage('Role tidak ditemukan, silahkan cek kembali username dan password');
  end;

end;

procedure TfrmTacticalDisplay.btnLogoutClick(Sender: TObject);
var
  rec : TRecTCP_UserState;

begin
  if Assigned(simMgrClient.MyConsoleData) then
  begin
    rec.OrderID := CORD_ID_LOGOUT;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.FData.UserRoleIndex;
    rec.ConsoleIP := simMgrClient.MyConsoleData.IpAdrres;
    rec.UserRoleInUse := False;

    simMgrClient.netSend_CmdUserState(rec);
  end
end;

procedure TfrmTacticalDisplay.btnPlanningClick(Sender: TObject);
begin
  if btnPlanning.Down then
  begin
    cbbSubRole.Left := 137;
    lstUserRoleLogin.Left := 137;

    cbbSubRole.Visible := True;

    AddCbbSubRole(0);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;
end;

procedure TfrmTacticalDisplay.btnPreparationClick(Sender: TObject);
begin
  if btnPreparation.Down then
  begin
    cbbSubRole.Left := 568;
    lstUserRoleLogin.Left := 568;

    cbbSubRole.Visible := True;

    AddCbbSubRole(1);

    if cbbSubRole.Items.Count > 0 then
      cbbSubRole.ItemIndex := 0;

    cbbSubRole.OnSelect(nil);
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;
end;

procedure TfrmTacticalDisplay.FormCreate(Sender: TObject);
begin
  EnableComposited(pnlBackgroundLogin);
  EnableComposited(pnlHome);

  FSelectedSubRole := TSubRole.Create;
  FselectedUserRole := TUserRole.Create;

  Show;
end;

procedure TfrmTacticalDisplay.FormDestroy(Sender: TObject);
begin
  FSelectedSubRole.Free;
  FselectedUserRole.Free;
end;

procedure TfrmTacticalDisplay.FormResize(Sender: TObject);
begin
  lblConsoleName.Left := (pnlHome.Width-lblConsoleName.Width)div 2;
end;

procedure TfrmTacticalDisplay.FormShow(Sender: TObject);
begin
  lblConsoleName.Left := (pnlHome.Width-lblConsoleName.Width)div 2;
end;

procedure TfrmTacticalDisplay.Initialize;
var
  i : Integer;
begin
  width := Screen.Monitors[vGameDataSetting.TacticalScreen].width;
  height := Screen.Monitors[vGameDataSetting.TacticalScreen].height;
  left := Screen.Monitors[vGameDataSetting.TacticalScreen].left;
  top := Screen.Monitors[vGameDataSetting.TacticalScreen].top;
end;

procedure TfrmTacticalDisplay.lstUserRoleLoginDblClick(Sender: TObject);
begin
  if lstUserRoleLogin.ItemIndex = -1 then
    Exit;

  FselectedUserRole := TUserRole(lstUserRoleLogin.Items.Objects[lstUserRoleLogin.ItemIndex]);

  if Assigned(FselectedUserRole) then
    lblUserIdentifier.Caption := FselectedUserRole.FData.UserRoleIdentifier;

  pnlBackgroundLogin.BringToFront;
end;

procedure TfrmTacticalDisplay.UpdateClientLogin(Sender: TObject);
begin
  frmDisplayArea_Instance.Show;
end;

procedure TfrmTacticalDisplay.UpdateClientLogout(Sender: TObject);
begin
  {$REGION ' User Logout '}
  edtUsername.Text := '';
  edtPassword.Text := '';
  lblOperasi.Caption := '';
  lblKomandoTugas.Caption := '';
  lblUserRole.Caption := '';
  cbbTahapan.Items.Clear;

  pnlLogin.BringToFront;
  {$ENDREGION}
end;

procedure TfrmTacticalDisplay.UpdateGameState(Sender: TObject);
begin
  btnPlanning.Visible := SimManager.GetGameState;
  btnPreparation.Visible := SimManager.GetGameState;
  btnImplementation.Visible := SimManager.GetGameState;
  btnTermination.Visible := SimManager.GetGameState;
end;

end.

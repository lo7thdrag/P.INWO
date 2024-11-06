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

    procedure FormCreate(Sender: TObject);
    procedure btnShowPasswordClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure cbbConsoleNameDropDown(Sender: TObject);
    procedure btnPlanningClick(Sender: TObject);
    procedure lstUserRoleLoginClick(Sender: TObject);
    procedure btnPreparationClick(Sender: TObject);
    procedure btnImplementationClick(Sender: TObject);
    procedure btnTerminationClick(Sender: TObject);

  private


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
      simMgrClient.MyConsoleData.TipeTahapan := Byte(SetTipeTahapanToEnum(cbbTahapan.Text));
      ShowModal;
    end;

  finally
    frmDisplayArea.Free;
  end;
end;

procedure TfrmTacticalDisplay.btnTerminationClick(Sender: TObject);
begin
  if btnTermination.Down then
  begin
    cbbSubRole.Left := 1429;
    lstUserRoleLogin.Left := 1429;

    cbbSubRole.Visible := True;
    lstUserRoleLogin.Visible := True;
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
  userRoleTemp : TUser_Role;

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

procedure TfrmTacticalDisplay.btnShowClick(Sender: TObject);
var
  ipTemp : string;
  userRoleTemp : TUser_Role;

begin
  if (cbbConsoleName.ItemIndex = -1) or (cbbConsoleName.Text = '') then
  begin
    ShowMessage('Console yang dipilih sedang tidak digunakan');
    Exit;
  end;

  ipTemp := simMgrClient.SimConsole.GetIPAddress(cbbConsoleName.Text);
  userRoleTemp := SimManager.SimUserRole.getUserRoleByIPAddress(ipTemp);

  simMgrClient.MyConsoleData.assignUserRoleData(userRoleTemp.FData);

  frmSituationBoard.Show;
end;


procedure TfrmTacticalDisplay.btnImplementationClick(Sender: TObject);
begin
  if btnImplementation.Down then
  begin
    cbbSubRole.Left := 998;
    lstUserRoleLogin.Left := 998;

    cbbSubRole.Visible := True;
    lstUserRoleLogin.Visible := True;
  end
  else
  begin
    cbbSubRole.Visible := False;
    lstUserRoleLogin.Visible := False;
  end;

end;

procedure TfrmTacticalDisplay.btnLoginClick(Sender: TObject);
var
  userRoleTemp : TUser_Role;
  rec : TRecTCP_UserState;

begin
  if (vGameDataSetting.DemoMode = False) then
  begin
    if not SimManager.GetGameState then
    begin
      ShowMessage('Console anda tidak terhubung ke server');
      Exit;
    end;

    userRoleTemp := simMgrClient.SimUserRole.getUserRoleByUsernamePassword(edtUsername.Text, edtPassword.Text);

    if Assigned(userRoleTemp) then
    begin
      if not userRoleTemp.isInUse then
      begin
        rec.OrderID       := CORD_ID_LOGIN;
        rec.UserRoleId    := userRoleTemp.FData.UserRoleIndex;
        rec.ConsoleIP     := simMgrClient.MyConsoleData.IpAdrres;
        rec.UserRoleInUse := True;

        simMgrClient.netSend_CmdUserState(rec);
      end
      else
      begin
        ShowMessage('Role sudah digunakan');
      end;
    end
    else
    begin
      ShowMessage('Role tidak ditemukan, silahkan cek kembali username dan password');
    end;
  end
  else
  begin
    frmDisplayArea := TfrmDisplayArea.Create(Self);
    try
      with frmDisplayArea do
      begin
//        simMgrClient.MyConsoleData.TipeTahapan := Byte(SetTipeTahapanToEnum(cbbTahapan.Text));
        ShowModal;
      end;

    finally
      frmDisplayArea.Free;
    end;
    Exit
  end;

end;

procedure TfrmTacticalDisplay.btnLogoutClick(Sender: TObject);
var
  rec : TRecTCP_UserState;

begin
  if Assigned(simMgrClient.MyConsoleData) then
  begin
    rec.OrderID := CORD_ID_LOGOUT;
    rec.UserRoleId := simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex;
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
    lstUserRoleLogin.Visible := True;
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
    lstUserRoleLogin.Visible := True;
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
  Show;
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

procedure TfrmTacticalDisplay.lstUserRoleLoginClick(Sender: TObject);
begin
pnlBackgroundLogin.BringToFront;
end;

procedure TfrmTacticalDisplay.UpdateClientLogin(Sender: TObject);
var
  userRoleTemp : TUser_Role;

begin
  lblWelcome.Caption := 'Selamat datang ' + simMgrClient.MyConsoleData.Identifier;
  userRoleTemp := simMgrClient.SimUserRole.getUserRoleByID(simMgrClient.MyConsoleData.UserRoleData.UserRoleIndex);

  if Assigned(userRoleTemp) then
  begin
    {$REGION ' User Login '}

    cbbTahapan.Items.Clear;

    with simMgrClient.MyConsoleData.UserRoleData do
    begin
      lblOperasi.Caption := SetOrganisasiTugasToString(TOrganisasiTugas(OrganisasiTugas));
      lblKomandoTugas.Caption := SetSubOrganisasiTugasToString(TSubOrganisasiTugas(SubOrganisasiTugas));
      lblUserRole.Caption := UserRoleIdentifier;

      if Perencanaan = 1 then
        cbbTahapan.Items.Add('Perencanaan');

      if Persiapan = 1 then
        cbbTahapan.Items.Add('Persiapan');

      if Pelaksanaan = 1 then
        cbbTahapan.Items.Add('Pelaksanaan');

      if Pengakhiran = 1 then
        cbbTahapan.Items.Add('Pengakhiran');
    end;

    if cbbTahapan.Items.Count > 0 then
      cbbTahapan.ItemIndex := 0;

    pnlDescription.BringToFront;

    {$ENDREGION}
  end;
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
//  if Assigned(frmPause) then
//  begin
//    if SimManager.GetGameState then
//      frmPause.Hide
//    else
//    begin
//      if not frmPause.Showing then
//        frmPause.Show;
//    end;
//  end;
end;

end.

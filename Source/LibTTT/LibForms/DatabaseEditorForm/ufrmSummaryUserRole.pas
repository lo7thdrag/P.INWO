unit ufrmSummaryUserRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uConstantaData, uDataModule, uRecordData;

type
  TfrmSummaryUserRole = class(TForm)
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    cbbRole: TComboBox;
    cbbSubRole: TComboBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtConfirmPassword: TEdit;
    ImgBackgroundForm: TImage;
    pnlUserRole: TPanel;
    Label13: TLabel;
    lblPlatform: TLabel;
    btnShowPassword: TImage;
    btnShowPassword2: TImage;
    Label14: TLabel;
    btnOk: TImage;
    btnCancel: TImage;
    edtUserRole: TEdit;
    imgEdit: TImage;
    btnEdit: TImage;
    Image1: TImage;
    Label3: TLabel;
    procedure cbbRoleChange(Sender: TObject);
    procedure cbbSubRoleChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnShowPasswordClick(Sender: TObject);
    procedure btnShowPassword2Click(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkChangeClick(Sender: TObject);
    procedure edtChange(Sender: TObject);

  private
    FSelectedUserRole : TUser_Role;

    function CekInput: Boolean;
    procedure UpdateUserRoleData;

    procedure AddCbbSubRole;
    procedure AddedtUserRole;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }

    property SelectedUserRole : TUser_Role read FSelectedUserRole write FSelectedUserRole;
  end;

var
  frmSummaryUserRole: TfrmSummaryUserRole;

implementation

{$R *.dfm}

{$REGION ' Form Event '}

procedure TfrmSummaryUserRole.FormShow(Sender: TObject);
begin
  UpdateUserRoleData;

  with FSelectedUserRole.FData do
    btnOk.Enabled := UserRoleIndex = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Event '}

procedure TfrmSummaryUserRole.btnApplyClick(Sender: TObject);
begin
  with FSelectedUserRole.FData do
  begin
    RoleIndex     := Integer(SetOrganisasiTugasToEnum(cbbRole.Text));
    SubRoleIndex  := Integer(SetSubOrganisasiTugasToEnum(cbbSubRole.Text));
    UserRoleIdentifier  := edtUserRole.Text;
    Username            := edtUsername.Text;
    Password            := edtPassword.Text;

    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    if UserRoleIndex = 0 then
    begin
      if dmINWO.InsertUserRole(FSelectedUserRole.FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateUserRole(FSelectedUserRole.FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  isOK := True;
  AfterClose := True;
  btnOk.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryUserRole.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSummaryUserRole.btnOkClick(Sender: TObject);
begin
  if btnOk.Enabled then
    btnOk.OnClick(nil);

  if isOk then
    Close;
end;

procedure TfrmSummaryUserRole.btnShowPassword2Click(Sender: TObject);
begin
  if (edtConfirmPassword.PasswordChar = '*') then
  begin
    btnShowPassword2.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnShowPassword.png');
    edtConfirmPassword.PasswordChar := #0;
  end
  else
  begin
    btnShowPassword2.Picture.LoadFromFile('data\Image DBEditor\Interface\Background\btnHidePassword.png');
    edtConfirmPassword.PasswordChar := '*';
  end
end;

procedure TfrmSummaryUserRole.btnShowPasswordClick(Sender: TObject);
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

{$ENDREGION}

{$REGION ' Additional Event '}

procedure TfrmSummaryUserRole.AddCbbSubRole;
begin
  cbbSubRole.Items.Clear;

  if cbbRole.Text = 'Integrated Naval Warfare Operations' then
  begin
    cbbSubRole.Items.Add('KPL');
    cbbSubRole.Items.Add('STAF LAT');
    cbbSubRole.Items.Add('WASDAL');
    cbbSubRole.Items.Add('KOGAB');
  end
  else if cbbRole.Text = 'Naval Tactical Warfare Operations' then
  begin
    cbbSubRole.Items.Add('KOGASGABLA');
  end
  else if cbbRole.Text = 'Amphibious Tactical Warfare Operations' then
  begin
    cbbSubRole.Items.Add('KOGASGABFIB');
  end
  else if cbbRole.Text = 'Landing Forces Warfare Operations' then
  begin
    cbbSubRole.Items.Add('PASRAT');
  end
  else if cbbRole.Text = 'Administrative Landing Warfare Operations' then
  begin
    cbbSubRole.Items.Add('KOGASRATMIN');
  end
  else if cbbRole.Text = 'Coastal Defence Warfare Operations' then
  begin
    cbbSubRole.Items.Add('KOGASHANTAI');
  end
  else if cbbRole.Text = 'Supporting Unit Warfare Operations' then
  begin
    cbbSubRole.Items.Add('SATGASDUK');
  end;
end;

procedure TfrmSummaryUserRole.AddedtUserRole;
begin
  edtUserRole.Clear;
  if cbbSubRole.Text = 'KPL' then
  begin
    {$REGION ' KPL '}
//    edtUserRole.Items.Add('PIMPINAN');
//    edtUserRole.Items.Add('WAKIL');
//    edtUserRole.Items.Add('DIRLAT');
//    edtUserRole.Items.Add('WADIRLAT');
//    edtUserRole.Items.Add('HATLAT');
//    edtUserRole.Items.Add('TIM EVA');
//    edtUserRole.Items.Add('DESTRA');
//    edtUserRole.Items.Add('DEOYU');
//    edtUserRole.Items.Add('DEKOMLEK');
//    edtUserRole.Items.Add('DEMINLOG');
//    edtUserRole.Items.Add('DELITBANG');
//    edtUserRole.Items.Add('SETLAT');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'STAF LAT' then
  begin
    {$REGION ' STAF LAT '}
//    edtUserRole.Items.Add('PIMPINAN');
//    edtUserRole.Items.Add('WAKIL');
//    edtUserRole.Items.Add('DIRLAT');
//    edtUserRole.Items.Add('WADIRLAT');
//    edtUserRole.Items.Add('HATLAT');
//    edtUserRole.Items.Add('TIM EVA');
//    edtUserRole.Items.Add('DESTRA');
//    edtUserRole.Items.Add('DEOYU');
//    edtUserRole.Items.Add('DEKOMLEK');
//    edtUserRole.Items.Add('DEMINLOG');
//    edtUserRole.Items.Add('DELITBANG');
//    edtUserRole.Items.Add('SETLAT');
//    edtUserRole.Items.Add('DENMALAT');
//    edtUserRole.Items.Add('DENHUBLAT');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'WASDAL' then
  begin
    {$REGION ' WASDAL '}
//    edtUserRole.Items.Add('PIMPINAN');
//    edtUserRole.Items.Add('WAKIL');
//    edtUserRole.Items.Add('KAWASDAL');
//    edtUserRole.Items.Add('WK WASDAL');
//    edtUserRole.Items.Add('KATIM PENILAI');
//    edtUserRole.Items.Add('KATIM EVA');
//    edtUserRole.Items.Add('KTIM LITBANG');
//    edtUserRole.Items.Add('WASDAL INTEL');
//    edtUserRole.Items.Add('WASDAL OPS');
//    edtUserRole.Items.Add('WASDAL REN');
//    edtUserRole.Items.Add('WASDAL PERS');
//    edtUserRole.Items.Add('WASDAL LOG');
//    edtUserRole.Items.Add('WDL KOMLEK');
//    edtUserRole.Items.Add('WDL GASDUK');
//    edtUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGAB' then
  begin
    {$REGION ' KOGAB '}
//    edtUserRole.Items.Add('PANGLIMA');
//    edtUserRole.Items.Add('KASUM');
//    edtUserRole.Items.Add('AS INTEL');
//    edtUserRole.Items.Add('AS OPS');
//    edtUserRole.Items.Add('AS PERS');
//    edtUserRole.Items.Add('AS RENA');
//    edtUserRole.Items.Add('AS KOMLEK');
//    edtUserRole.Items.Add('AS TER/POT');
//    edtUserRole.Items.Add('STF EVABANG');
//    edtUserRole.Items.Add('STF LATIHAN');
//    edtUserRole.Items.Add('LO KEMHAN');
//    edtUserRole.Items.Add('LO AANGKATD');
//    edtUserRole.Items.Add('LO AL');
//    edtUserRole.Items.Add('LO AU');
//    edtUserRole.Items.Add('KASETUM');

    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASGABLA' then
  begin
    {$REGION ' KOGASGABLA '}
//    edtUserRole.Items.Add('PANGLIMA');
//    edtUserRole.Items.Add('KEPALA STAF');
//    edtUserRole.Items.Add('ASINTEL');
//    edtUserRole.Items.Add('ASOPS');
//    edtUserRole.Items.Add('ASRENA');
//    edtUserRole.Items.Add('ASPERS');
//    edtUserRole.Items.Add('ASLOG');
//    edtUserRole.Items.Add('ASKOMLEK');
//    edtUserRole.Items.Add('ASPOTMAR');
//    edtUserRole.Items.Add('DANSATGASLA');
//    edtUserRole.Items.Add('SATGASUD');
//    edtUserRole.Items.Add('DAN UT PUKUL');
//    edtUserRole.Items.Add('DAN UT INTAI');
//    edtUserRole.Items.Add('DAN UT KAWAL');
//    edtUserRole.Items.Add('DAN UT BANTU');
//    edtUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASGABFIB' then
  begin
    {$REGION ' KOGASGABFIB '}
//    edtUserRole.Items.Add('PANGLIMA');
//    edtUserRole.Items.Add('KEPALA STAS');
//    edtUserRole.Items.Add('ASINTEL');
//    edtUserRole.Items.Add('ASOPS');
//    edtUserRole.Items.Add('ASRENA');
//    edtUserRole.Items.Add('ASPERS');
//    edtUserRole.Items.Add('ASLOG');
//    edtUserRole.Items.Add('ASKOMLEK');
//    edtUserRole.Items.Add('ASPOTMAR');
//    edtUserRole.Items.Add('DANSATGASLA');
//    edtUserRole.Items.Add('DAN PASRAT');
//    edtUserRole.Items.Add('DAN SATGASUD');
//    edtUserRole.Items.Add('DAN UT UDARA');
//    edtUserRole.Items.Add('DAN UT TABIR');
//    edtUserRole.Items.Add('DAN UT AJU');
//    edtUserRole.Items.Add('DAN UT BANTU');
//    edtUserRole.Items.Add('DAN UT ANGKT');
//    edtUserRole.Items.Add('DAN UT INTAI');
//    edtUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'PASRAT' then
  begin
    {$REGION ' PASRAT '}
//    edtUserRole.Items.Add('DAN PASRAT');
//    edtUserRole.Items.Add('WAD PASRAT');
//    edtUserRole.Items.Add('ASINTEL');
//    edtUserRole.Items.Add('ASOPS');
//    edtUserRole.Items.Add('ASRENA');
//    edtUserRole.Items.Add('ASPERS');
//    edtUserRole.Items.Add('ASLOG');
//    edtUserRole.Items.Add('ASKOMLEK');
//    edtUserRole.Items.Add('ASPOTMAR');
//    edtUserRole.Items.Add('DAN BRIF MAR');
//    edtUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASRATMIN' then
  begin
    {$REGION ' KOGASRATMIN '}
//    edtUserRole.Items.Add('PANGLIMA');
//    edtUserRole.Items.Add('KEPALA STAF');
//    edtUserRole.Items.Add('ASINTEL');
//    edtUserRole.Items.Add('ASOPS');
//    edtUserRole.Items.Add('ASRENA');
//    edtUserRole.Items.Add('ASPERS');
//    edtUserRole.Items.Add('ASLOG');
//    edtUserRole.Items.Add('ASKOMLEK');
//    edtUserRole.Items.Add('ASPOTMAR');
//    edtUserRole.Items.Add('DAN SATGASLA');
//    edtUserRole.Items.Add('DAN STGASRAT');
//    edtUserRole.Items.Add('DANSATGASUD');
//    edtUserRole.Items.Add('KATERMINAL');
//    edtUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'KOGASHANTAI' then
  begin
    {$REGION ' KOGASHANTAI '}
//    edtUserRole.Items.Add('PANGLIMA');
//    edtUserRole.Items.Add('KEPALA STAF');
//    edtUserRole.Items.Add('ASINTEL');
//    edtUserRole.Items.Add('ASOPS');
//    edtUserRole.Items.Add('ASRENA');
//    edtUserRole.Items.Add('ASPERS');
//    edtUserRole.Items.Add('ASLOG');
//    edtUserRole.Items.Add('ASKOMLEK');
//    edtUserRole.Items.Add('ASPOTMAR');
//    edtUserRole.Items.Add('DAN SATGASLA');
//    edtUserRole.Items.Add('DAN STGASRAT');
//    edtUserRole.Items.Add('DAN SATGASUD');
//    edtUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubRole.Text = 'SATGASDUK' then
  begin
    {$REGION ' SATGASDUK '}
//    edtUserRole.Items.Add('INTELEJEN');
//    edtUserRole.Items.Add('MINLOG');
//    edtUserRole.Items.Add('KOMLEK');
//    edtUserRole.Items.Add('PERNIKA');
//    edtUserRole.Items.Add('HUKUM');
//    edtUserRole.Items.Add('POM');
//    edtUserRole.Items.Add('PENERANGAN');
//    edtUserRole.Items.Add('PSIKOLOGI');
//    edtUserRole.Items.Add('KESEHATAN');
//    edtUserRole.Items.Add('PERS');
//    edtUserRole.Items.Add('INFO');
//    edtUserRole.Items.Add('BAK');
//    edtUserRole.Items.Add('SAR');
//    edtUserRole.Items.Add('ANGKT UDARA');
//    edtUserRole.Items.Add('ANGKT LAUT');
//    edtUserRole.Items.Add('PASSUS GAB');
//    edtUserRole.Items.Add('TERITORIAL');
    {$ENDREGION}
  end
end;

procedure TfrmSummaryUserRole.cbbRoleChange(Sender: TObject);
begin
  AddcbbSubRole;
  cbbSubRole.ItemIndex := 0;
  AddedtUserRole;
//  edtUserRole.ItemIndex := 0;

  btnOk.Enabled := True;
end;

procedure TfrmSummaryUserRole.cbbSubRoleChange(Sender: TObject);
begin
  AddedtUserRole;
//  edtUserRole.ItemIndex := 0;

  btnOk.Enabled := True;
end;

procedure TfrmSummaryUserRole.UpdateUserRoleData;
begin
  with FSelectedUserRole.FData do
  begin
    cbbRole.Text := SetOrganisasiTugasToString(TOrganisasiTugas(RoleIndex));

    AddCbbSubRole;
    cbbSubRole.Text := SetSubOrganisasiTugasToString(TSubOrganisasiTugas(SubRoleIndex));

    AddedtUserRole;
    edtUserRole.Text := UserRoleIdentifier;

//    chkPerencanaan.Checked := Boolean(Perencanaan);
//    chkPersiapan.Checked := Boolean(Persiapan);
//    chkPelaksanaan.Checked := Boolean(Pelaksanaan);
//    chkPengakhiran.Checked := Boolean(Pengakhiran);

    edtUsername.Text := Username;
    edtPassword.Text := Password;
    edtConfirmPassword.Text := Password;
  end;
end;

{$ENDREGION}

{$REGION ' Filter Event '}

function TfrmSummaryUserRole.CekInput: Boolean;
begin
  Result := False;

  {Password tidak sesuai}
  if edtPassword.Text <> edtConfirmPassword.Text then
  begin
    ShowMessage('Cek ulang password anda');
    Exit;
  end;

  {Data ada yg kosong}
  if (cbbRole.Text = '') or (cbbSubRole.Text = '') or (edtUserRole.Text = '') or
     (edtUsername.Text = '') or (edtPassword.Text = '') then
  begin
    ShowMessage('Inputan data tidak lengkap');
    Exit;
  end;

  {Data sudah ada}
  if (dmINWO.GetUserRoleFilterByOrganisasiTugas(FSelectedUserRole.FData)>0) and (FSelectedUserRole.FData.UserRoleIndex = 0)then
  begin
    ShowMessage('Data sudah ada didalam database');
    Exit;
  end;

  {Username sudah digunakan}
  if (dmINWO.GetUserRoleFilterByOrganisasiTugas(FSelectedUserRole.FData)>0) and (FSelectedUserRole.FData.UserRoleIndex = 0) then
  begin
    ShowMessage('Username sudah digunakan');
    Exit;
  end;

  Result := True;
end;

procedure TfrmSummaryUserRole.chkChangeClick(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

procedure TfrmSummaryUserRole.edtChange(Sender: TObject);
begin
  btnOk.Enabled := True;
end;

{$ENDREGION}

end.

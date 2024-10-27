unit ufrmSummaryUserRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uConstantaData, uDataModule, uRecordData;

type
  TfrmSummaryUserRole = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    chkPerencanaan: TCheckBox;
    chkPersiapan: TCheckBox;
    chkPelaksanaan: TCheckBox;
    chkPengakhiran: TCheckBox;
    cbbOrganisasiTugas: TComboBox;
    cbbSubOrganisasiTugas: TComboBox;
    cbbUserRole: TComboBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtConfirmPassword: TEdit;
    ImgBackgroundForm: TImage;
    Panel1: TPanel;
    Label13: TLabel;
    lblPlatform: TLabel;
    btnApply: TImage;
    btnOk: TImage;
    btnCancel: TImage;
    btnShowPassword: TImage;
    btnShowPassword2: TImage;
    Label14: TLabel;
    Label15: TLabel;
    procedure cbbOrganisasiTugasChange(Sender: TObject);
    procedure cbbSubOrganisasiTugasChange(Sender: TObject);
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

    procedure AddCbbSubOrganisasiTugas;
    procedure AddCbbUserRole;

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
    btnApply.Enabled := UserRoleIndex = 0;

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
    OrganisasiTugas     := Integer(SetOrganisasiTugasToEnum(cbbOrganisasiTugas.Text));
    SubOrganisasiTugas  := Integer(SetSubOrganisasiTugasToEnum(cbbSubOrganisasiTugas.Text));
    Perencanaan         := Ord(chkPerencanaan.Checked);
    Persiapan           := Ord(chkPersiapan.Checked);
    Pelaksanaan         := Ord(chkPelaksanaan.Checked);
    Pengakhiran         := Ord(chkPengakhiran.Checked);
    UserRoleIdentifier  := cbbUserRole.Text;
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
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryUserRole.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSummaryUserRole.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.OnClick(nil);

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

procedure TfrmSummaryUserRole.AddCbbSubOrganisasiTugas;
begin
  cbbSubOrganisasiTugas.Items.Clear;

  if cbbOrganisasiTugas.Text = 'Integrated Naval Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('KPL');
    cbbSubOrganisasiTugas.Items.Add('STAF LAT');
    cbbSubOrganisasiTugas.Items.Add('WASDAL');
    cbbSubOrganisasiTugas.Items.Add('KOGAB');
  end
  else if cbbOrganisasiTugas.Text = 'Naval Tactical Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('KOGASGABLA');
  end
  else if cbbOrganisasiTugas.Text = 'Amphibious Tactical Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('KOGASGABFIB');
  end
  else if cbbOrganisasiTugas.Text = 'Landing Forces Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('PASRAT');
  end
  else if cbbOrganisasiTugas.Text = 'Administrative Landing Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('KOGASRATMIN');
  end
  else if cbbOrganisasiTugas.Text = 'Coastal Defence Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('KOGASHANTAI');
  end
  else if cbbOrganisasiTugas.Text = 'Supporting Unit Warfare Operations' then
  begin
    cbbSubOrganisasiTugas.Items.Add('SATGASDUK');
  end;
end;

procedure TfrmSummaryUserRole.AddCbbUserRole;
begin
  cbbUserRole.Clear;
  if cbbSubOrganisasiTugas.Text = 'KPL' then
  begin
    {$REGION ' KPL '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('DIRLAT');
    cbbUserRole.Items.Add('WADIRLAT');
    cbbUserRole.Items.Add('HATLAT');
    cbbUserRole.Items.Add('TIM EVA');
    cbbUserRole.Items.Add('DESTRA');
    cbbUserRole.Items.Add('DEOYU');
    cbbUserRole.Items.Add('DEKOMLEK');
    cbbUserRole.Items.Add('DEMINLOG');
    cbbUserRole.Items.Add('DELITBANG');
    cbbUserRole.Items.Add('SETLAT');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'STAF LAT' then
  begin
    {$REGION ' STAF LAT '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('DIRLAT');
    cbbUserRole.Items.Add('WADIRLAT');
    cbbUserRole.Items.Add('HATLAT');
    cbbUserRole.Items.Add('TIM EVA');
    cbbUserRole.Items.Add('DESTRA');
    cbbUserRole.Items.Add('DEOYU');
    cbbUserRole.Items.Add('DEKOMLEK');
    cbbUserRole.Items.Add('DEMINLOG');
    cbbUserRole.Items.Add('DELITBANG');
    cbbUserRole.Items.Add('SETLAT');
    cbbUserRole.Items.Add('DENMALAT');
    cbbUserRole.Items.Add('DENHUBLAT');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'WASDAL' then
  begin
    {$REGION ' WASDAL '}
    cbbUserRole.Items.Add('PIMPINAN');
    cbbUserRole.Items.Add('WAKIL');
    cbbUserRole.Items.Add('KAWASDAL');
    cbbUserRole.Items.Add('WK WASDAL');
    cbbUserRole.Items.Add('KATIM PENILAI');
    cbbUserRole.Items.Add('KATIM EVA');
    cbbUserRole.Items.Add('KTIM LITBANG');
    cbbUserRole.Items.Add('WASDAL INTEL');
    cbbUserRole.Items.Add('WASDAL OPS');
    cbbUserRole.Items.Add('WASDAL REN');
    cbbUserRole.Items.Add('WASDAL PERS');
    cbbUserRole.Items.Add('WASDAL LOG');
    cbbUserRole.Items.Add('WDL KOMLEK');
    cbbUserRole.Items.Add('WDL GASDUK');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'KOGAB' then
  begin
    {$REGION ' KOGAB '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KASUM');
    cbbUserRole.Items.Add('AS INTEL');
    cbbUserRole.Items.Add('AS OPS');
    cbbUserRole.Items.Add('AS PERS');
    cbbUserRole.Items.Add('AS RENA');
    cbbUserRole.Items.Add('AS KOMLEK');
    cbbUserRole.Items.Add('AS TER/POT');
    cbbUserRole.Items.Add('STF EVABANG');
    cbbUserRole.Items.Add('STF LATIHAN');
    cbbUserRole.Items.Add('LO KEMHAN');
    cbbUserRole.Items.Add('LO AANGKATD');
    cbbUserRole.Items.Add('LO AL');
    cbbUserRole.Items.Add('LO AU');
    cbbUserRole.Items.Add('KASETUM');

    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'KOGASGABLA' then
  begin
    {$REGION ' KOGASGABLA '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAF');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DANSATGASLA');
    cbbUserRole.Items.Add('SATGASUD');
    cbbUserRole.Items.Add('DAN UT PUKUL');
    cbbUserRole.Items.Add('DAN UT INTAI');
    cbbUserRole.Items.Add('DAN UT KAWAL');
    cbbUserRole.Items.Add('DAN UT BANTU');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'KOGASGABFIB' then
  begin
    {$REGION ' KOGASGABFIB '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAS');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DANSATGASLA');
    cbbUserRole.Items.Add('DAN PASRAT');
    cbbUserRole.Items.Add('DAN SATGASUD');
    cbbUserRole.Items.Add('DAN UT UDARA');
    cbbUserRole.Items.Add('DAN UT TABIR');
    cbbUserRole.Items.Add('DAN UT AJU');
    cbbUserRole.Items.Add('DAN UT BANTU');
    cbbUserRole.Items.Add('DAN UT ANGKT');
    cbbUserRole.Items.Add('DAN UT INTAI');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'PASRAT' then
  begin
    {$REGION ' PASRAT '}
    cbbUserRole.Items.Add('DAN PASRAT');
    cbbUserRole.Items.Add('WAD PASRAT');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DAN BRIF MAR');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'KOGASRATMIN' then
  begin
    {$REGION ' KOGASRATMIN '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAF');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DAN SATGASLA');
    cbbUserRole.Items.Add('DAN STGASRAT');
    cbbUserRole.Items.Add('DANSATGASUD');
    cbbUserRole.Items.Add('KATERMINAL');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'KOGASHANTAI' then
  begin
    {$REGION ' KOGASHANTAI '}
    cbbUserRole.Items.Add('PANGLIMA');
    cbbUserRole.Items.Add('KEPALA STAF');
    cbbUserRole.Items.Add('ASINTEL');
    cbbUserRole.Items.Add('ASOPS');
    cbbUserRole.Items.Add('ASRENA');
    cbbUserRole.Items.Add('ASPERS');
    cbbUserRole.Items.Add('ASLOG');
    cbbUserRole.Items.Add('ASKOMLEK');
    cbbUserRole.Items.Add('ASPOTMAR');
    cbbUserRole.Items.Add('DAN SATGASLA');
    cbbUserRole.Items.Add('DAN STGASRAT');
    cbbUserRole.Items.Add('DAN SATGASUD');
    cbbUserRole.Items.Add('PASET');
    {$ENDREGION}
  end
  else if cbbSubOrganisasiTugas.Text = 'SATGASDUK' then
  begin
    {$REGION ' SATGASDUK '}
    cbbUserRole.Items.Add('INTELEJEN');
    cbbUserRole.Items.Add('MINLOG');
    cbbUserRole.Items.Add('KOMLEK');
    cbbUserRole.Items.Add('PERNIKA');
    cbbUserRole.Items.Add('HUKUM');
    cbbUserRole.Items.Add('POM');
    cbbUserRole.Items.Add('PENERANGAN');
    cbbUserRole.Items.Add('PSIKOLOGI');
    cbbUserRole.Items.Add('KESEHATAN');
    cbbUserRole.Items.Add('PERS');
    cbbUserRole.Items.Add('INFO');
    cbbUserRole.Items.Add('BAK');
    cbbUserRole.Items.Add('SAR');
    cbbUserRole.Items.Add('ANGKT UDARA');
    cbbUserRole.Items.Add('ANGKT LAUT');
    cbbUserRole.Items.Add('PASSUS GAB');
    cbbUserRole.Items.Add('TERITORIAL');
    {$ENDREGION}
  end
end;

procedure TfrmSummaryUserRole.cbbOrganisasiTugasChange(Sender: TObject);
begin
  AddCbbSubOrganisasiTugas;
  cbbSubOrganisasiTugas.ItemIndex := 0;
  AddCbbUserRole;
  cbbUserRole.ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryUserRole.cbbSubOrganisasiTugasChange(Sender: TObject);
begin
  AddCbbUserRole;
  cbbUserRole.ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryUserRole.UpdateUserRoleData;
begin
  with FSelectedUserRole.FData do
  begin
    cbbOrganisasiTugas.Text := SetOrganisasiTugasToString(TOrganisasiTugas(OrganisasiTugas));

    AddCbbSubOrganisasiTugas;
    cbbSubOrganisasiTugas.Text := SetSubOrganisasiTugasToString(TSubOrganisasiTugas(SubOrganisasiTugas));

    AddCbbUserRole;
    cbbUserRole.Text := UserRoleIdentifier;

    chkPerencanaan.Checked := Boolean(Perencanaan);
    chkPersiapan.Checked := Boolean(Persiapan);
    chkPelaksanaan.Checked := Boolean(Pelaksanaan);
    chkPengakhiran.Checked := Boolean(Pengakhiran);

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
  if (cbbOrganisasiTugas.Text = '') or (cbbSubOrganisasiTugas.Text = '') or (cbbUserRole.Text = '') or
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
  btnApply.Enabled := True;
end;

procedure TfrmSummaryUserRole.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

{$ENDREGION}

end.

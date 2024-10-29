unit ufrmSimbolTaktis;

interface

uses
  {uses Delphi}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  {uses project}
  uClassData, uDataModule ;

type
  TfrmSimbolTaktis = class(TForm)
    pnlMain: TPanel;
    lbl14: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    imgSimbolTaktis: TImage;
    edtKeterangan: TEdit;
    cbbTipe: TComboBox;
    cbbKategori: TComboBox;
    btnUpload: TButton;
    UploadImage: TOpenDialog;
    ImgBackgroundForm: TImage;
    btnOk: TImage;
    btnApply: TImage;
    btnCancel: TImage;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure cbbTipeChange(Sender: TObject);
    procedure cbbKategoriChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedTacticalSymbol : TTactical_Symbol;
    FPathDirectory : string;

    procedure AddcbbTipeChange;
    procedure AddcbbkategoriChange;
    procedure UpdateTacticalSymbol;

  public
    { Public declarations }
     property SelectedTacticalSymbol : TTactical_Symbol read FSelectedTacticalSymbol write FSelectedTacticalSymbol;
  end;

var
  frmSimbolTaktis: TfrmSimbolTaktis;

implementation

{$R *.dfm}

procedure TfrmSimbolTaktis.AddcbbTipeChange;
begin
  cbbTipe.Items.Clear;

  if cbbTipe.Text = 'Tipe' then
  begin
    cbbTipe.Items.Add('TNI AL');
    cbbTipe.Items.Add('TNI AU');
    cbbTipe.Items.Add('TNI AD');
  end;

end;

procedure TfrmSimbolTaktis.AddcbbkategoriChange;
begin
  cbbKategori.Items.Clear;

  if cbbKategori.Text = 'Kategori' then
  begin
    cbbKategori.Items.Add('TAKTIS TNI AL');
    cbbKategori.Items.Add('TAKTIS TNI AU');
    cbbKategori.Items.Add('TAKTIS TNI AD');
  end;
end;

procedure TfrmSimbolTaktis.btnUploadClick(Sender: TObject);
begin
   if UploadImage.Execute then
   begin
     imgSimbolTaktis.Picture.LoadFromFile(UploadImage.FileName);
     FPathDirectory := ExtractFilePath(UploadImage.FileName);
   end;
end;

procedure TfrmSimbolTaktis.cbbKategoriChange(Sender: TObject);
begin
  if cbbKategori.ItemIndex = -1 then
    cbbKategori.ItemIndex := 0;
//  AddcbbkategoriChange;
//  cbbKategori.ItemIndex := 0;

  btnOk.Enabled := True;
end;

procedure TfrmSimbolTaktis.cbbTipeChange(Sender: TObject);
begin
  if cbbTipe.ItemIndex = -1 then
    cbbTipe.ItemIndex := 0;

//   AddcbbTipeChange;
//   cbbTipe.ItemIndex := 0;

   btnOk.Enabled := True;
end;

procedure TfrmSimbolTaktis.btnApplyClick(Sender: TObject);
begin
  with FSelectedTacticalSymbol.FData do
  begin
    Tipe            := cbbTipe.ItemIndex;
    Kategori        := cbbKategori.ItemIndex;
    Keterangan      := edtKeterangan.Text;
    Path_Directori  := FPathDirectory;

//    if not CekInput then
//    begin
//      isOK := False;
//      Exit;
//    end;

    if Id_Tactical_Symbol = 0 then
    begin
      if dmINWO.InsertTacticalSymbol(FSelectedTacticalSymbol.FData) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateTacticalSymbol(FSelectedTacticalSymbol.FData) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

//  isOK := True;
//  AfterClose := True;
//  btnApply.Enabled := False;
//  btnCancel.Enabled := False;
end;

procedure TfrmSimbolTaktis.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSimbolTaktis.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.OnClick(nil);

//  if isOk then
    Close;
end;

procedure TfrmSimbolTaktis.UpdateTacticalSymbol;
begin
  with FSelectedTacticalSymbol do
  begin
    AddcbbTipeChange;
    AddcbbkategoriChange;
  end;
end;

end.

unit ufrmSimbolTaktis;

interface

uses
  {uses Delphi}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  {uses project}
  uClassData;

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
    btnOk: TButton;
    btnCancel: TButton;
    btnUpload: TButton;
    UploadImage: TOpenDialog;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
  private
    FSelectedTacticalSymbol : TTactical_Symbol;
  public
    { Public declarations }
     property SelectedTacticalSymbol : TTactical_Symbol read FSelectedTacticalSymbol write FSelectedTacticalSymbol;
  end;

var
  frmSimbolTaktis: TfrmSimbolTaktis;

implementation

{$R *.dfm}
procedure TfrmSimbolTaktis.btnUploadClick(Sender: TObject);
begin
   if UploadImage.Execute then
   begin
     imgSimbolTaktis.Picture.LoadFromFile(UploadImage.FileName);
   end;
end;

procedure TfrmSimbolTaktis.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSimbolTaktis.btnOkClick(Sender: TObject);
begin
  ShowMessage('Image berhasil disimpan');
  ModalResult := mrOk;
end;

end.

unit ufrmRole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmSummaryRole = class(TForm)
    btnApply: TImage;
    btnCancel: TImage;
    btnOk: TImage;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;
    pnlRole: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtRole: TEdit;
    edtIdentifier: TEdit;
    lstRole: TListBox;
    btnDelete: TImage;
    btnEdit: TImage;
    btnNew: TImage;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    procedure lstAcousticDecoyClick(Sender: TObject);
    procedure Label17Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSummaryRole: TfrmSummaryRole;

implementation

{$R *.dfm}

end.

procedure TfrmSummaryRole.Label17Click(Sender: TObject);
begin

end;

procedure TfrmSummaryRole.lstAcousticDecoyClick(Sender: TObject);
begin

end;

end.

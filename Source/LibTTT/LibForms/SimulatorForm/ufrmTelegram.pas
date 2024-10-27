unit ufrmTelegram;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, ImageButton, Vcl.ComCtrls, Vcl.Imaging.jpeg;

type
  TfrmTelegram = class(TForm)
    pnlRight: TPanel;
    ListView1: TListView;
    pnlLeft: TPanel;
    imgbtnBeritaMasuk: TImageButton;
    lblBeritaMasuk: TLabel;
    imgbtnBeritaBaruDibaca: TImageButton;
    lblBeritaBaruDibaca: TLabel;
    imgbtnDraft: TImageButton;
    lblDraft: TLabel;
    imgbtnBeritaTerkirim: TImageButton;
    lblBeritaTerkirim: TLabel;
    imgbtnSemuaBerita: TImageButton;
    lblSemuaBerita: TLabel;
    pnlBeritaMasuk: TPanel;
    pnlBeritaBaruDibaca: TPanel;
    pnlDraft: TPanel;
    pnlBeritaTerkirim: TPanel;
    pnlSemuaBerita: TPanel;
    lblTo: TLabel;
    btnKirim: TButton;
    cbbxTo: TComboBox;
    Image2: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTelegram: TfrmTelegram;

implementation

{$R *.dfm}

end.

object frmSimbolTaktis: TfrmSimbolTaktis
  Left = 0
  Top = 0
  Caption = 'frmSimbolTaktis'
  ClientHeight = 435
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 435
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 562
    object lbl14: TLabel
      Left = 22
      Top = 78
      Width = 94
      Height = 18
      Caption = 'Keterangan   :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 22
      Top = 30
      Width = 36
      Height = 18
      Caption = 'Tipe :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 325
      Top = 30
      Width = 64
      Height = 18
      Caption = 'Kategori :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
    end
    object imgSimbolTaktis: TImage
      Left = 190
      Top = 149
      Width = 175
      Height = 169
    end
    object edtKeterangan: TEdit
      Tag = 4
      Left = 22
      Top = 102
      Width = 518
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cbbTipe: TComboBox
      Left = 62
      Top = 26
      Width = 145
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbbKategori: TComboBox
      Left = 395
      Top = 26
      Width = 145
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Berlin Sans FB'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object btnOk: TButton
      Left = 408
      Top = 400
      Width = 75
      Height = 25
      Caption = 'OK'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Berlin Sans FB'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object btnCancel: TButton
      Left = 480
      Top = 400
      Width = 75
      Height = 25
      Caption = 'Cancel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Berlin Sans FB'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object btnUpload: TButton
      Left = 240
      Top = 336
      Width = 75
      Height = 25
      Caption = 'Upload'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Berlin Sans FB'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
  end
  object UploadImage: TOpenDialog
    Left = 264
    Top = 224
  end
end

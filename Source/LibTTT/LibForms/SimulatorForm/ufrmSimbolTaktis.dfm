object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
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
  object lbl14: TLabel
    Left = 22
    Top = 71
    Width = 69
    Height = 13
    Caption = 'Keterangan   :'
  end
  object Label2: TLabel
    Left = 24
    Top = 101
    Width = 67
    Height = 13
    Caption = 'Model ID       :'
  end
  object lblFontTaktis: TLabel
    Left = 104
    Top = 158
    Width = 73
    Height = 56
    Alignment = taCenter
    AutoSize = False
    Caption = 'FontTaktis'
  end
  object lblKeteranganSymbol: TLabel
    Left = 5
    Top = 254
    Width = 270
    Height = 31
    Alignment = taCenter
    AutoSize = False
    Caption = 'Keterangan symbol'
    WordWrap = True
  end
  object edtFontID: TEdit
    Tag = 4
    Left = 97
    Top = 69
    Width = 116
    Height = 23
    Enabled = False
    TabOrder = 0
  end
  object edtModelPath: TEdit
    Tag = 4
    Left = 97
    Top = 98
    Width = 116
    Height = 23
    TabOrder = 1
  end
end

object Form1: TForm1
  Left = 178
  Top = 113
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  Caption = 'Votre grille de jeu'
  ClientHeight = 440
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 440
    Height = 440
    Align = alClient
    OnClick = Image1Click
    OnDblClick = Image1DblClick
  end
  object Timer1: TTimer
    Interval = 10000
    Left = 24
    Top = 24
  end
end

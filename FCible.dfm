object Form3: TForm3
  Left = 666
  Top = 26
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  Caption = 'Grille de jeu adverse'
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
  end
end
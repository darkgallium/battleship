object Form2: TForm2
  Left = 177
  Top = 612
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Battleship'
  ClientHeight = 191
  ClientWidth = 950
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 77
    Height = 16
    Alignment = taCenter
    Caption = 'Score de J1 :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 24
    Width = 13
    Height = 29
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 848
    Top = 8
    Width = 77
    Height = 16
    Alignment = taCenter
    Caption = 'Score de J2 :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 376
    Top = 8
    Width = 88
    Height = 16
    Alignment = taCenter
    Caption = 'Temps '#233'coul'#233' :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 384
    Top = 24
    Width = 59
    Height = 29
    Caption = '00:00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 504
    Top = 8
    Width = 48
    Height = 16
    Alignment = taCenter
    Caption = 'Tour n'#176' :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 520
    Top = 24
    Width = 13
    Height = 29
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 912
    Top = 24
    Width = 13
    Height = 29
    Alignment = taRightJustify
    Caption = '0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TitreEtat: TLabel
    Left = 192
    Top = 72
    Width = 577
    Height = 19
    Alignment = taCenter
    AutoSize = False
    Caption = 'Bienvenue dans le mode multijoueur local'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DescrEtat: TLabel
    Left = 192
    Top = 96
    Width = 572
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Tour '#224' tour, vous allez prendre connaissance des positionnements' +
      ' de vos navires'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 240
    Top = 160
    Width = 32
    Height = 13
    Caption = 'Label9'
    Visible = False
  end
  object Label10: TLabel
    Left = 192
    Top = 128
    Width = 572
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Appuyez sur n'#39'importe quelle touche alphanum'#233'rique pour continue' +
      'r...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Caption = 'L'#233'gende'
    TabOrder = 0
    TabStop = False
  end
  object Button2: TButton
    Left = 864
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Pause'
    TabOrder = 1
    TabStop = False
    Visible = False
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 160
    Top = 8
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 200
    Top = 8
  end
  object Timer3: TTimer
    Enabled = False
    Left = 240
    Top = 8
  end
end

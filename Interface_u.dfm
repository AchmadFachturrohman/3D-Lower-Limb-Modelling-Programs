object InterfaceForm: TInterfaceForm
  Left = -8
  Top = 0
  BorderIcons = []
  Caption = 'Interface Form'
  ClientHeight = 361
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ICCGroup: TGroupBox
    Left = 18
    Top = 250
    Width = 441
    Height = 105
    Caption = 'Initial Condition Control'
    TabOrder = 0
    object Label1: TLabel
      Left = 350
      Top = 21
      Width = 21
      Height = 13
      Caption = 'Yaw'
    end
    object Label2: TLabel
      Left = 350
      Top = 50
      Width = 24
      Height = 13
      Caption = 'Pitch'
    end
    object Label3: TLabel
      Left = 350
      Top = 77
      Width = 18
      Height = 13
      Caption = 'Roll'
    end
    object Label7: TLabel
      Left = 16
      Top = 23
      Width = 16
      Height = 13
      Caption = 'Hip'
    end
    object Label8: TLabel
      Left = 16
      Top = 50
      Width = 25
      Height = 13
      Caption = 'Knee'
    end
    object Label9: TLabel
      Left = 16
      Top = 77
      Width = 27
      Height = 13
      Caption = 'Ankle'
    end
    object SpinEdit1: TSpinEdit
      Left = 384
      Top = 18
      Width = 49
      Height = 22
      MaxValue = 360
      MinValue = 0
      TabOrder = 0
      Value = 90
      OnChange = SpinEdit1Change
    end
    object SpinEdit2: TSpinEdit
      Left = 384
      Top = 46
      Width = 49
      Height = 22
      MaxValue = 360
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = SpinEdit2Change
    end
    object SpinEdit3: TSpinEdit
      Left = 384
      Top = 74
      Width = 49
      Height = 22
      MaxValue = 360
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = SpinEdit3Change
    end
    object ScrollBar1: TScrollBar
      Left = 55
      Top = 20
      Width = 218
      Height = 17
      Max = 90
      Min = -35
      PageSize = 0
      TabOrder = 3
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 55
      Top = 49
      Width = 218
      Height = 17
      Max = 120
      PageSize = 0
      TabOrder = 4
      OnChange = ScrollBar2Change
    end
    object ScrollBar3: TScrollBar
      Left = 55
      Top = 75
      Width = 218
      Height = 17
      Max = 45
      Min = -5
      PageSize = 0
      TabOrder = 5
      OnChange = ScrollBar3Change
    end
    object Edit1: TEdit
      Left = 287
      Top = 18
      Width = 43
      Height = 21
      TabOrder = 6
      Text = '0'
    end
    object Edit2: TEdit
      Left = 287
      Top = 45
      Width = 43
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object Edit3: TEdit
      Left = 287
      Top = 73
      Width = 43
      Height = 21
      TabOrder = 8
      Text = '0'
    end
  end
  object ActiveTestBox: TGroupBox
    Left = 8
    Top = 8
    Width = 108
    Height = 233
    Caption = 'Active Test'
    TabOrder = 1
    object FlexorHip: TButton
      Left = 10
      Top = 20
      Width = 75
      Height = 25
      Caption = 'Hip Flexor'
      TabOrder = 0
      OnClick = FlexorHipClick
    end
    object FlexorKnee: TButton
      Left = 10
      Top = 92
      Width = 86
      Height = 25
      Caption = 'Knee Flexor'
      TabOrder = 1
      OnClick = FlexorKneeClick
    end
    object FlexorAnkle: TButton
      Left = 10
      Top = 164
      Width = 82
      Height = 25
      Caption = 'Ankle Flexor'
      TabOrder = 2
      OnClick = FlexorAnkleClick
    end
    object ExtensorHip: TButton
      Left = 10
      Top = 51
      Width = 75
      Height = 25
      Caption = 'Hip Extensor'
      TabOrder = 3
      OnClick = ExtensorHipClick
    end
    object ExtensorKnee: TButton
      Left = 10
      Top = 123
      Width = 86
      Height = 25
      Caption = 'Knee Extensor'
      TabOrder = 4
      OnClick = ExtensorKneeClick
    end
    object ExtensorAnkle: TButton
      Left = 10
      Top = 195
      Width = 82
      Height = 25
      Caption = 'Ankle Extensor'
      TabOrder = 5
      OnClick = ExtensorAnkleClick
    end
  end
  object PassiveTestBox: TGroupBox
    Left = 371
    Top = 8
    Width = 105
    Height = 50
    Caption = 'Passive Test'
    TabOrder = 2
    object btnRun: TButton
      Left = 15
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Run'
      TabOrder = 0
      OnClick = btnRunClick
    end
  end
  object btnClose: TButton
    Left = 384
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 444
    Top = 104
  end
end

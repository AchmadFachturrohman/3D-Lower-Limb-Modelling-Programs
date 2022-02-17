object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = []
  ClientHeight = 372
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 408
    Height = 411
    Color = 15246038
    ParentBackground = False
    TabOrder = 0
    object Label4: TLabel
      Left = 128
      Top = 28
      Width = 139
      Height = 30
      Caption = 'WELCOME'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Ravie'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 177
      Top = 64
      Width = 35
      Height = 30
      Caption = 'TO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Ravie'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 104
      Top = 100
      Width = 197
      Height = 30
      Caption = 'MY PROGRAM'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Ravie'
      Font.Style = []
      ParentFont = False
    end
    object btnActive: TButton
      Left = 104
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Active'
      TabOrder = 0
      OnClick = btnActiveClick
    end
    object btnPassive: TButton
      Left = 226
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Passive'
      TabOrder = 1
      OnClick = btnPassiveClick
    end
    object btnAbout: TButton
      Left = 104
      Top = 272
      Width = 75
      Height = 25
      Caption = 'About'
      TabOrder = 2
      OnClick = btnAboutClick
    end
    object btnExit: TButton
      Left = 226
      Top = 272
      Width = 75
      Height = 25
      Caption = 'EXIT'
      TabOrder = 3
      OnClick = btnExitClick
    end
  end
  object CommandPanel: TPanel
    Left = 0
    Top = 0
    Width = 1366
    Height = 768
    Color = 15828173
    ParentBackground = False
    TabOrder = 1
    Visible = False
    object btnClose: TButton
      Left = 731
      Top = 89
      Width = 74
      Height = 32
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object MuscleActivationChart: TChart
      Left = 13
      Top = 545
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Muscle Activation')
      View3D = False
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series3: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series4: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series5: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series6: TLineSeries
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object btnReset: TButton
      Left = 731
      Top = 51
      Width = 74
      Height = 32
      Caption = 'Reset'
      TabOrder = 2
      OnClick = btnResetClick
    end
    object HipChart: TChart
      Left = 12
      Top = 5
      Width = 328
      Height = 174
      Title.Text.Strings = (
        'Hip')
      View3D = False
      TabOrder = 4
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object HipTorqueSeries: TLineSeries
        Title = 'Torque'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object HipAngleSeries: TLineSeries
        Title = 'Angle'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object KneeChart: TChart
      Left = 12
      Top = 185
      Width = 328
      Height = 174
      Title.Text.Strings = (
        'Knee')
      View3D = False
      TabOrder = 5
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object KneeTorqueSeries: TLineSeries
        Title = 'Torque'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object KneeAngleSeries: TLineSeries
        Title = 'Angle'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object AnkleChart: TChart
      Left = 12
      Top = 365
      Width = 328
      Height = 174
      Title.Text.Strings = (
        'Ankle')
      View3D = False
      TabOrder = 7
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object AnkleTorqueSeries: TLineSeries
        Title = 'Torque'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object AnkleAngleSeries: TLineSeries
        Title = 'Angle'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object IliopsoasMuscleChart: TChart
      Left = 1015
      Top = 5
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Iliopsoas')
      View3D = False
      TabOrder = 8
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object IloMuscleForceSeries: TLineSeries
        Title = 'Force'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object IloMuscleLenghtSeries: TLineSeries
        Title = 'Lenght'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object IloMuscle_fl_Series: TLineSeries
        Title = 'f(l)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object IloMuscle_fv_Series: TLineSeries
        Title = 'f(v)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object GluteusMuscleChart: TChart
      Left = 1015
      Top = 185
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Gluteus Maximus')
      View3D = False
      TabOrder = 9
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object GluMuscleForceSeries: TLineSeries
        Title = 'Force'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object GluMuscleLenghtSeries: TLineSeries
        Title = 'Lenght'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object GluMuscle_fl_Series: TLineSeries
        Title = 'f(l)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object GluMuscle_fv_Series: TLineSeries
        Title = 'f(v)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object BSFHMuscleChart: TChart
      Left = 1015
      Top = 365
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'BFSH')
      View3D = False
      TabOrder = 10
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object BSFHMuscleForceSeries: TLineSeries
        Title = 'Force'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object BSFHMuscleLenghtSeries: TLineSeries
        Title = 'Lenght'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object BSFHMuscle_fl_Series: TLineSeries
        Title = 'f(l)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object BSFHMuscle_fv_Series: TLineSeries
        Title = 'f(v)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object btnShowInterface: TButton
      Left = 617
      Top = 319
      Width = 120
      Height = 32
      Caption = 'Show Interface'
      TabOrder = 11
      Visible = False
      OnClick = btnShowInterfaceClick
    end
    object TestModeGroup: TRadioGroup
      Left = 554
      Top = 13
      Width = 81
      Height = 105
      Caption = 'Test Mode'
      Items.Strings = (
        'Active'
        'Passive')
      TabOrder = 6
      OnClick = TestModeGroupClick
    end
    object ConditionGroup: TRadioGroup
      Left = 641
      Top = 13
      Width = 84
      Height = 105
      Caption = 'Condition'
      Items.Strings = (
        'Sitting'
        'Standing')
      TabOrder = 3
      OnClick = ConditionGroupClick
    end
    object VastusMuscleChart: TChart
      Left = 1015
      Top = 545
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Vastus Medialis')
      View3D = False
      TabOrder = 12
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object VasMuscleForceSeries: TLineSeries
        Title = 'Force'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object VasMuscleLenghtSeries: TLineSeries
        Title = 'Lenght'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object VasMuscle_fl_Series: TLineSeries
        Title = 'f(l)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object VasMuscle_fv_Series: TLineSeries
        Title = 'f(v)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object SoleusMuscleChart: TChart
      Left = 681
      Top = 545
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Soleus')
      View3D = False
      TabOrder = 13
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object SoleusMuscleForceSeries: TLineSeries
        Title = 'Force'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SoleusMuscleLenghtSeries: TLineSeries
        Title = 'Lenght'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SoleusMuscle_fl_Series: TLineSeries
        Title = 'f(l)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object SoleusMuscle_fv_Series: TLineSeries
        Title = 'f(v)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object TibialisMuscleChart: TChart
      Left = 347
      Top = 545
      Width = 328
      Height = 174
      Legend.CheckBoxes = True
      Title.Text.Strings = (
        'Tibialis Anterior')
      View3D = False
      TabOrder = 14
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object TibialisMuscleForceSeries: TLineSeries
        Title = 'Force'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object TibialisMuscleLenghtSeries: TLineSeries
        Title = 'Lenght'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object TibialisMuscle_fl_Series: TLineSeries
        Title = 'f(l)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object TibialisMuscle_fv_Series: TLineSeries
        Title = 'f(v)'
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
end

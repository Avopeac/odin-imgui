package imgui;

Table_Row_Flags :: enum i32 {
	None    = 0,
	Headers = 1 << 0,
}

Data_Type :: enum i32 {
	S8     = 0,
	U8     = 1,
	S16    = 2,
	U16    = 3,
	S32    = 4,
	U32    = 5,
	S64    = 6,
	U64    = 7,
	Float  = 8,
	Double = 9,
	Bool   = 10,
	Count  = 11,
}

Multi_Select_Flags :: enum i32 {
	None                  = 0,
	SingleSelect          = 1 << 0,
	NoSelectAll           = 1 << 1,
	NoRangeSelect         = 1 << 2,
	NoAutoSelect          = 1 << 3,
	NoAutoClear           = 1 << 4,
	NoAutoClearOnReselect = 1 << 5,
	BoxSelect1d           = 1 << 6,
	BoxSelect2d           = 1 << 7,
	BoxSelectNoScroll     = 1 << 8,
	ClearOnEscape         = 1 << 9,
	ClearOnClickVoid      = 1 << 10,
	ScopeWindow           = 1 << 11,
	ScopeRect             = 1 << 12,
	SelectOnClick         = 1 << 13,
	SelectOnClickRelease  = 1 << 14,
	NavWrapX              = 1 << 16,
}

Col :: enum i32 {
	Text                      = 0,
	TextDisabled              = 1,
	WindowBg                  = 2,
	ChildBg                   = 3,
	PopupBg                   = 4,
	Border                    = 5,
	BorderShadow              = 6,
	FrameBg                   = 7,
	FrameBgHovered            = 8,
	FrameBgActive             = 9,
	TitleBg                   = 10,
	TitleBgActive             = 11,
	TitleBgCollapsed          = 12,
	MenuBarBg                 = 13,
	ScrollbarBg               = 14,
	ScrollbarGrab             = 15,
	ScrollbarGrabHovered      = 16,
	ScrollbarGrabActive       = 17,
	CheckMark                 = 18,
	SliderGrab                = 19,
	SliderGrabActive          = 20,
	Button                    = 21,
	ButtonHovered             = 22,
	ButtonActive              = 23,
	Header                    = 24,
	HeaderHovered             = 25,
	HeaderActive              = 26,
	Separator                 = 27,
	SeparatorHovered          = 28,
	SeparatorActive           = 29,
	ResizeGrip                = 30,
	ResizeGripHovered         = 31,
	ResizeGripActive          = 32,
	TabHovered                = 33,
	Tab                       = 34,
	TabSelected               = 35,
	TabSelectedOverline       = 36,
	TabDimmed                 = 37,
	TabDimmedSelected         = 38,
	TabDimmedSelectedOverline = 39,
	PlotLines                 = 40,
	PlotLinesHovered          = 41,
	PlotHistogram             = 42,
	PlotHistogramHovered      = 43,
	TableHeaderBg             = 44,
	TableBorderStrong         = 45,
	TableBorderLight          = 46,
	TableRowBg                = 47,
	TableRowBgAlt             = 48,
	TextLink                  = 49,
	TextSelectedBg            = 50,
	DragDropTarget            = 51,
	NavHighlight              = 52,
	NavWindowingHighlight     = 53,
	NavWindowingDimBg         = 54,
	ModalWindowDimBg          = 55,
	Count                     = 56,
}

Color_Edit_Flags :: enum i32 {
	None             = 0,
	NoAlpha          = 1 << 1,
	NoPicker         = 1 << 2,
	NoOptions        = 1 << 3,
	NoSmallPreview   = 1 << 4,
	NoInputs         = 1 << 5,
	NoTooltip        = 1 << 6,
	NoLabel          = 1 << 7,
	NoSidePreview    = 1 << 8,
	NoDragDrop       = 1 << 9,
	NoBorder         = 1 << 10,
	AlphaBar         = 1 << 16,
	AlphaPreview     = 1 << 17,
	AlphaPreviewHalf = 1 << 18,
	Hdr              = 1 << 19,
	DisplayRgb       = 1 << 20,
	DisplayHsv       = 1 << 21,
	DisplayHex       = 1 << 22,
	Uint8            = 1 << 23,
	Float            = 1 << 24,
	PickerHueBar     = 1 << 25,
	PickerHueWheel   = 1 << 26,
	InputRgb         = 1 << 27,
	InputHsv         = 1 << 28,
	DefaultOptions   = Uint8 | DisplayRgb | InputRgb | PickerHueBar,
	DisplayMask      = DisplayRgb | DisplayHsv | DisplayHex,
	DataTypeMask     = Uint8 | Float,
	PickerMask       = PickerHueWheel | PickerHueBar,
	InputMask        = InputRgb | InputHsv,
}

Key :: enum i32 {
	None                = 0,
	Tab                 = 512,
	LeftArrow           = 513,
	RightArrow          = 514,
	UpArrow             = 515,
	DownArrow           = 516,
	PageUp              = 517,
	PageDown            = 518,
	Home                = 519,
	End                 = 520,
	Insert              = 521,
	Delete              = 522,
	Backspace           = 523,
	Space               = 524,
	Enter               = 525,
	Escape              = 526,
	LeftCtrl            = 527,
	LeftShift           = 528,
	LeftAlt             = 529,
	LeftSuper           = 530,
	RightCtrl           = 531,
	RightShift          = 532,
	RightAlt            = 533,
	RightSuper          = 534,
	Menu                = 535,
	_0                  = 536,
	_1                  = 537,
	_2                  = 538,
	_3                  = 539,
	_4                  = 540,
	_5                  = 541,
	_6                  = 542,
	_7                  = 543,
	_8                  = 544,
	_9                  = 545,
	A                   = 546,
	B                   = 547,
	C                   = 548,
	D                   = 549,
	E                   = 550,
	F                   = 551,
	G                   = 552,
	H                   = 553,
	I                   = 554,
	J                   = 555,
	K                   = 556,
	L                   = 557,
	M                   = 558,
	N                   = 559,
	O                   = 560,
	P                   = 561,
	Q                   = 562,
	R                   = 563,
	S                   = 564,
	T                   = 565,
	U                   = 566,
	V                   = 567,
	W                   = 568,
	X                   = 569,
	Y                   = 570,
	Z                   = 571,
	F1                  = 572,
	F2                  = 573,
	F3                  = 574,
	F4                  = 575,
	F5                  = 576,
	F6                  = 577,
	F7                  = 578,
	F8                  = 579,
	F9                  = 580,
	F10                 = 581,
	F11                 = 582,
	F12                 = 583,
	F13                 = 584,
	F14                 = 585,
	F15                 = 586,
	F16                 = 587,
	F17                 = 588,
	F18                 = 589,
	F19                 = 590,
	F20                 = 591,
	F21                 = 592,
	F22                 = 593,
	F23                 = 594,
	F24                 = 595,
	Apostrophe          = 596,
	Comma               = 597,
	Minus               = 598,
	Period              = 599,
	Slash               = 600,
	Semicolon           = 601,
	Equal               = 602,
	LeftBracket         = 603,
	Backslash           = 604,
	RightBracket        = 605,
	GraveAccent         = 606,
	CapsLock            = 607,
	ScrollLock          = 608,
	NumLock             = 609,
	PrintScreen         = 610,
	Pause               = 611,
	Keypad0             = 612,
	Keypad1             = 613,
	Keypad2             = 614,
	Keypad3             = 615,
	Keypad4             = 616,
	Keypad5             = 617,
	Keypad6             = 618,
	Keypad7             = 619,
	Keypad8             = 620,
	Keypad9             = 621,
	KeypadDecimal       = 622,
	KeypadDivide        = 623,
	KeypadMultiply      = 624,
	KeypadSubtract      = 625,
	KeypadAdd           = 626,
	KeypadEnter         = 627,
	KeypadEqual         = 628,
	AppBack             = 629,
	AppForward          = 630,
	GamepadStart        = 631,
	GamepadBack         = 632,
	GamepadFaceLeft     = 633,
	GamepadFaceRight    = 634,
	GamepadFaceUp       = 635,
	GamepadFaceDown     = 636,
	GamepadDpadLeft     = 637,
	GamepadDpadRight    = 638,
	GamepadDpadUp       = 639,
	GamepadDpadDown     = 640,
	GamepadL1           = 641,
	GamepadR1           = 642,
	GamepadL2           = 643,
	GamepadR2           = 644,
	GamepadL3           = 645,
	GamepadR3           = 646,
	GamepadLstickLeft   = 647,
	GamepadLstickRight  = 648,
	GamepadLstickUp     = 649,
	GamepadLstickDown   = 650,
	GamepadRstickLeft   = 651,
	GamepadRstickRight  = 652,
	GamepadRstickUp     = 653,
	GamepadRstickDown   = 654,
	MouseLeft           = 655,
	MouseRight          = 656,
	MouseMiddle         = 657,
	MouseX1             = 658,
	MouseX2             = 659,
	MouseWheelX         = 660,
	MouseWheelY         = 661,
	ReservedForModCtrl  = 662,
	ReservedForModShift = 663,
	ReservedForModAlt   = 664,
	ReservedForModSuper = 665,
	Count               = 666,
	ModNone             = 0,
	ModCtrl             = 1 << 12,
	ModShift            = 1 << 13,
	ModAlt              = 1 << 14,
	ModSuper            = 1 << 15,
	ModMask             = 0xF000,
	NamedKeyBegin       = 512,
	NamedKeyEnd         = Count,
	NamedKeyCount       = NamedKeyEnd-NamedKeyBegin,
	KeysDataSize        = NamedKeyCount,
	KeysDataOffset      = NamedKeyBegin,
}

Mouse_Cursor :: enum i32 {
	None       = -1,
	Arrow      = 0,
	TextInput  = 1,
	ResizeAll  = 2,
	ResizeNs   = 3,
	ResizeEw   = 4,
	ResizeNesw = 5,
	ResizeNwse = 6,
	Hand       = 7,
	NotAllowed = 8,
	Count      = 9,
}

Child_Flags :: enum i32 {
	None                   = 0,
	Borders                = 1 << 0,
	AlwaysUseWindowPadding = 1 << 1,
	ResizeX                = 1 << 2,
	ResizeY                = 1 << 3,
	AutoResizeX            = 1 << 4,
	AutoResizeY            = 1 << 5,
	AlwaysAutoResize       = 1 << 6,
	FrameStyle             = 1 << 7,
	NavFlattened           = 1 << 8,
}

Selection_Request_Type :: enum i32 {
	None     = 0,
	SetAll   = 1,
	SetRange = 2,
}

Tab_Item_Flags :: enum i32 {
	None                         = 0,
	UnsavedDocument              = 1 << 0,
	SetSelected                  = 1 << 1,
	NoCloseWithMiddleMouseButton = 1 << 2,
	NoPushId                     = 1 << 3,
	NoTooltip                    = 1 << 4,
	NoReorder                    = 1 << 5,
	Leading                      = 1 << 6,
	Trailing                     = 1 << 7,
	NoAssumedClosure             = 1 << 8,
}

Hovered_Flags :: enum i32 {
	None                         = 0,
	ChildWindows                 = 1 << 0,
	RootWindow                   = 1 << 1,
	AnyWindow                    = 1 << 2,
	NoPopupHierarchy             = 1 << 3,
	AllowWhenBlockedByPopup      = 1 << 5,
	AllowWhenBlockedByActiveItem = 1 << 7,
	AllowWhenOverlappedByItem    = 1 << 8,
	AllowWhenOverlappedByWindow  = 1 << 9,
	AllowWhenDisabled            = 1 << 10,
	NoNavOverride                = 1 << 11,
	AllowWhenOverlapped          = AllowWhenOverlappedByItem | AllowWhenOverlappedByWindow,
	RectOnly                     = AllowWhenBlockedByPopup | AllowWhenBlockedByActiveItem | AllowWhenOverlapped,
	RootAndChildWindows          = RootWindow | ChildWindows,
	ForTooltip                   = 1 << 12,
	Stationary                   = 1 << 13,
	DelayNone                    = 1 << 14,
	DelayShort                   = 1 << 15,
	DelayNormal                  = 1 << 16,
	NoSharedDelay                = 1 << 17,
}

Table_Flags :: enum i32 {
	None                       = 0,
	Resizable                  = 1 << 0,
	Reorderable                = 1 << 1,
	Hideable                   = 1 << 2,
	Sortable                   = 1 << 3,
	NoSavedSettings            = 1 << 4,
	ContextMenuInBody          = 1 << 5,
	RowBg                      = 1 << 6,
	BordersInnerH              = 1 << 7,
	BordersOuterH              = 1 << 8,
	BordersInnerV              = 1 << 9,
	BordersOuterV              = 1 << 10,
	BordersH                   = BordersInnerH | BordersOuterH,
	BordersV                   = BordersInnerV | BordersOuterV,
	BordersInner               = BordersInnerV | BordersInnerH,
	BordersOuter               = BordersOuterV | BordersOuterH,
	Borders                    = BordersInner | BordersOuter,
	NoBordersInBody            = 1 << 11,
	NoBordersInBodyUntilResize = 1 << 12,
	SizingFixedFit             = 1 << 13,
	SizingFixedSame            = 2 << 13,
	SizingStretchProp          = 3 << 13,
	SizingStretchSame          = 4 << 13,
	NoHostExtendX              = 1 << 16,
	NoHostExtendY              = 1 << 17,
	NoKeepColumnsVisible       = 1 << 18,
	PreciseWidths              = 1 << 19,
	NoClip                     = 1 << 20,
	PadOuterX                  = 1 << 21,
	NoPadOuterX                = 1 << 22,
	NoPadInnerX                = 1 << 23,
	ScrollX                    = 1 << 24,
	ScrollY                    = 1 << 25,
	SortMulti                  = 1 << 26,
	SortTristate               = 1 << 27,
	HighlightHoveredColumn     = 1 << 28,
	SizingMask                 = SizingFixedFit | SizingFixedSame | SizingStretchProp | SizingStretchSame,
}

Cond :: enum i32 {
	None         = 0,
	Always       = 1 << 0,
	Once         = 1 << 1,
	FirstUseEver = 1 << 2,
	Appearing    = 1 << 3,
}

Draw_Flags :: enum i32 {
	None                    = 0,
	Closed                  = 1 << 0,
	RoundCornersTopLeft     = 1 << 4,
	RoundCornersTopRight    = 1 << 5,
	RoundCornersBottomLeft  = 1 << 6,
	RoundCornersBottomRight = 1 << 7,
	RoundCornersNone        = 1 << 8,
	RoundCornersTop         = RoundCornersTopLeft | RoundCornersTopRight,
	RoundCornersBottom      = RoundCornersBottomLeft | RoundCornersBottomRight,
	RoundCornersLeft        = RoundCornersBottomLeft | RoundCornersTopLeft,
	RoundCornersRight       = RoundCornersBottomRight | RoundCornersTopRight,
	RoundCornersAll         = RoundCornersTopLeft | RoundCornersTopRight | RoundCornersBottomLeft | RoundCornersBottomRight,
	RoundCornersDefault     = RoundCornersAll,
	RoundCornersMask        = RoundCornersAll | RoundCornersNone,
}

Item_Flags :: enum i32 {
	None              = 0,
	NoTabStop         = 1 << 0,
	NoNav             = 1 << 1,
	NoNavDefaultFocus = 1 << 2,
	ButtonRepeat      = 1 << 3,
	AutoClosePopups   = 1 << 4,
	AllowDuplicateId  = 1 << 5,
}

Table_Column_Flags :: enum i32 {
	None                 = 0,
	Disabled             = 1 << 0,
	DefaultHide          = 1 << 1,
	DefaultSort          = 1 << 2,
	WidthStretch         = 1 << 3,
	WidthFixed           = 1 << 4,
	NoResize             = 1 << 5,
	NoReorder            = 1 << 6,
	NoHide               = 1 << 7,
	NoClip               = 1 << 8,
	NoSort               = 1 << 9,
	NoSortAscending      = 1 << 10,
	NoSortDescending     = 1 << 11,
	NoHeaderLabel        = 1 << 12,
	NoHeaderWidth        = 1 << 13,
	PreferSortAscending  = 1 << 14,
	PreferSortDescending = 1 << 15,
	IndentEnable         = 1 << 16,
	IndentDisable        = 1 << 17,
	AngledHeader         = 1 << 18,
	IsEnabled            = 1 << 24,
	IsVisible            = 1 << 25,
	IsSorted             = 1 << 26,
	IsHovered            = 1 << 27,
	WidthMask            = WidthStretch | WidthFixed,
	IndentMask           = IndentEnable | IndentDisable,
	StatusMask           = IsEnabled | IsVisible | IsSorted | IsHovered,
	NoDirectResize       = 1 << 30,
}

Backend_Flags :: enum i32 {
	None                 = 0,
	HasGamepad           = 1 << 0,
	HasMouseCursors      = 1 << 1,
	HasSetMousePos       = 1 << 2,
	RendererHasVtxOffset = 1 << 3,
}

Tab_Bar_Flags :: enum i32 {
	None                         = 0,
	Reorderable                  = 1 << 0,
	AutoSelectNewTabs            = 1 << 1,
	TabListPopupButton           = 1 << 2,
	NoCloseWithMiddleMouseButton = 1 << 3,
	NoTabListScrollingButtons    = 1 << 4,
	NoTooltip                    = 1 << 5,
	DrawSelectedOverline         = 1 << 6,
	FittingPolicyResizeDown      = 1 << 7,
	FittingPolicyScroll          = 1 << 8,
	FittingPolicyMask            = FittingPolicyResizeDown | FittingPolicyScroll,
	FittingPolicyDefault         = FittingPolicyResizeDown,
}

Combo_Flags :: enum i32 {
	None            = 0,
	PopupAlignLeft  = 1 << 0,
	HeightSmall     = 1 << 1,
	HeightRegular   = 1 << 2,
	HeightLarge     = 1 << 3,
	HeightLargest   = 1 << 4,
	NoArrowButton   = 1 << 5,
	NoPreview       = 1 << 6,
	WidthFitPreview = 1 << 7,
	HeightMask      = HeightSmall | HeightRegular | HeightLarge | HeightLargest,
}

Focused_Flags :: enum i32 {
	None                = 0,
	ChildWindows        = 1 << 0,
	RootWindow          = 1 << 1,
	AnyWindow           = 1 << 2,
	NoPopupHierarchy    = 1 << 3,
	RootAndChildWindows = RootWindow | ChildWindows,
}

Tree_Node_Flags :: enum i32 {
	None                 = 0,
	Selected             = 1 << 0,
	Framed               = 1 << 1,
	AllowOverlap         = 1 << 2,
	NoTreePushOnOpen     = 1 << 3,
	NoAutoOpenOnLog      = 1 << 4,
	DefaultOpen          = 1 << 5,
	OpenOnDoubleClick    = 1 << 6,
	OpenOnArrow          = 1 << 7,
	Leaf                 = 1 << 8,
	Bullet               = 1 << 9,
	FramePadding         = 1 << 10,
	SpanAvailWidth       = 1 << 11,
	SpanFullWidth        = 1 << 12,
	SpanTextWidth        = 1 << 13,
	SpanAllColumns       = 1 << 14,
	NavLeftJumpsBackHere = 1 << 15,
	CollapsingHeader     = Framed | NoTreePushOnOpen | NoAutoOpenOnLog,
}

Sort_Direction :: enum i32 {
	None       = 0,
	Ascending  = 1,
	Descending = 2,
}

Dir :: enum i32 {
	None  = -1,
	Left  = 0,
	Right = 1,
	Up    = 2,
	Down  = 3,
	Count = 4,
}

Slider_Flags :: enum i32 {
	None            = 0,
	Logarithmic     = 1 << 5,
	NoRoundToFormat = 1 << 6,
	NoInput         = 1 << 7,
	WrapAround      = 1 << 8,
	ClampOnInput    = 1 << 9,
	ClampZeroRange  = 1 << 10,
	AlwaysClamp     = ClampOnInput | ClampZeroRange,
	InvalidMask     = 0x7000000F,
}

Table_Bg_Target :: enum i32 {
	None   = 0,
	RowBg0 = 1,
	RowBg1 = 2,
	CellBg = 3,
}

Mouse_Button :: enum i32 {
	Left   = 0,
	Right  = 1,
	Middle = 2,
	Count  = 5,
}

Config_Flags :: enum i32 {
	None                 = 0,
	NavEnableKeyboard    = 1 << 0,
	NavEnableGamepad     = 1 << 1,
	NavEnableSetMousePos = 1 << 2,
	NavNoCaptureKeyboard = 1 << 3,
	NoMouse              = 1 << 4,
	NoMouseCursorChange  = 1 << 5,
	NoKeyboard           = 1 << 6,
	IsSrgb               = 1 << 20,
	IsTouchScreen        = 1 << 21,
}

Input_Text_Flags :: enum i32 {
	None                = 0,
	CharsDecimal        = 1 << 0,
	CharsHexadecimal    = 1 << 1,
	CharsScientific     = 1 << 2,
	CharsUppercase      = 1 << 3,
	CharsNoBlank        = 1 << 4,
	AllowTabInput       = 1 << 5,
	EnterReturnsTrue    = 1 << 6,
	EscapeClearsAll     = 1 << 7,
	CtrlEnterForNewLine = 1 << 8,
	ReadOnly            = 1 << 9,
	Password            = 1 << 10,
	AlwaysOverwrite     = 1 << 11,
	AutoSelectAll       = 1 << 12,
	ParseEmptyRefVal    = 1 << 13,
	DisplayEmptyRefVal  = 1 << 14,
	NoHorizontalScroll  = 1 << 15,
	NoUndoRedo          = 1 << 16,
	CallbackCompletion  = 1 << 17,
	CallbackHistory     = 1 << 18,
	CallbackAlways      = 1 << 19,
	CallbackCharFilter  = 1 << 20,
	CallbackResize      = 1 << 21,
	CallbackEdit        = 1 << 22,
}

Button_Flags :: enum i32 {
	None              = 0,
	MouseButtonLeft   = 1 << 0,
	MouseButtonRight  = 1 << 1,
	MouseButtonMiddle = 1 << 2,
	MouseButtonMask   = MouseButtonLeft | MouseButtonRight | MouseButtonMiddle,
}

Mouse_Source :: enum i32 {
	Mouse       = 0,
	TouchScreen = 1,
	Pen         = 2,
	Count       = 3,
}

Drag_Drop_Flags :: enum i32 {
	None                     = 0,
	SourceNoPreviewTooltip   = 1 << 0,
	SourceNoDisableHover     = 1 << 1,
	SourceNoHoldToOpenOthers = 1 << 2,
	SourceAllowNullId        = 1 << 3,
	SourceExtern             = 1 << 4,
	PayloadAutoExpire        = 1 << 5,
	PayloadNoCrossContext    = 1 << 6,
	PayloadNoCrossProcess    = 1 << 7,
	AcceptBeforeDelivery     = 1 << 10,
	AcceptNoDrawDefaultRect  = 1 << 11,
	AcceptNoPreviewTooltip   = 1 << 12,
	AcceptPeekOnly           = AcceptBeforeDelivery | AcceptNoDrawDefaultRect,
}

Popup_Flags :: enum i32 {
	None                    = 0,
	MouseButtonLeft         = 0,
	MouseButtonRight        = 1,
	MouseButtonMiddle       = 2,
	MouseButtonMask         = 0x1F,
	MouseButtonDefault      = 1,
	NoReopen                = 1 << 5,
	NoOpenOverExistingPopup = 1 << 7,
	NoOpenOverItems         = 1 << 8,
	AnyPopupId              = 1 << 10,
	AnyPopupLevel           = 1 << 11,
	AnyPopup                = AnyPopupId | AnyPopupLevel,
}

Font_Atlas_Flags :: enum i32 {
	None               = 0,
	NoPowerOfTwoHeight = 1 << 0,
	NoMouseCursors     = 1 << 1,
	NoBakedLines       = 1 << 2,
}

Style_Var :: enum i32 {
	Alpha                       = 0,
	DisabledAlpha               = 1,
	WindowPadding               = 2,
	WindowRounding              = 3,
	WindowBorderSize            = 4,
	WindowMinSize               = 5,
	WindowTitleAlign            = 6,
	ChildRounding               = 7,
	ChildBorderSize             = 8,
	PopupRounding               = 9,
	PopupBorderSize             = 10,
	FramePadding                = 11,
	FrameRounding               = 12,
	FrameBorderSize             = 13,
	ItemSpacing                 = 14,
	ItemInnerSpacing            = 15,
	IndentSpacing               = 16,
	CellPadding                 = 17,
	ScrollbarSize               = 18,
	ScrollbarRounding           = 19,
	GrabMinSize                 = 20,
	GrabRounding                = 21,
	TabRounding                 = 22,
	TabBorderSize               = 23,
	TabBarBorderSize            = 24,
	TabBarOverlineSize          = 25,
	TableAngledHeadersAngle     = 26,
	TableAngledHeadersTextAlign = 27,
	ButtonTextAlign             = 28,
	SelectableTextAlign         = 29,
	SeparatorTextBorderSize     = 30,
	SeparatorTextAlign          = 31,
	SeparatorTextPadding        = 32,
	Count                       = 33,
}

Input_Flags :: enum i32 {
	None                 = 0,
	Repeat               = 1 << 0,
	RouteActive          = 1 << 10,
	RouteFocused         = 1 << 11,
	RouteGlobal          = 1 << 12,
	RouteAlways          = 1 << 13,
	RouteOverFocused     = 1 << 14,
	RouteOverActive      = 1 << 15,
	RouteUnlessBgFocused = 1 << 16,
	RouteFromRootWindow  = 1 << 17,
	Tooltip              = 1 << 18,
}

Window_Flags :: enum i32 {
	None                      = 0,
	NoTitleBar                = 1 << 0,
	NoResize                  = 1 << 1,
	NoMove                    = 1 << 2,
	NoScrollbar               = 1 << 3,
	NoScrollWithMouse         = 1 << 4,
	NoCollapse                = 1 << 5,
	AlwaysAutoResize          = 1 << 6,
	NoBackground              = 1 << 7,
	NoSavedSettings           = 1 << 8,
	NoMouseInputs             = 1 << 9,
	MenuBar                   = 1 << 10,
	HorizontalScrollbar       = 1 << 11,
	NoFocusOnAppearing        = 1 << 12,
	NoBringToFrontOnFocus     = 1 << 13,
	AlwaysVerticalScrollbar   = 1 << 14,
	AlwaysHorizontalScrollbar = 1<< 15,
	NoNavInputs               = 1 << 16,
	NoNavFocus                = 1 << 17,
	UnsavedDocument           = 1 << 18,
	NoNav                     = NoNavInputs | NoNavFocus,
	NoDecoration              = NoTitleBar | NoResize | NoScrollbar | NoCollapse,
	NoInputs                  = NoMouseInputs | NoNavInputs | NoNavFocus,
	ChildWindow               = 1 << 24,
	Tooltip                   = 1 << 25,
	Popup                     = 1 << 26,
	Modal                     = 1 << 27,
	ChildMenu                 = 1 << 28,
}

Draw_List_Flags :: enum i32 {
	None                   = 0,
	AntiAliasedLines       = 1 << 0,
	AntiAliasedLinesUseTex = 1 << 1,
	AntiAliasedFill        = 1 << 2,
	AllowVtxOffset         = 1 << 3,
}

Viewport_Flags :: enum i32 {
	None              = 0,
	IsPlatformWindow  = 1 << 0,
	IsPlatformMonitor = 1 << 1,
	OwnedByApp        = 1 << 2,
}

Selectable_Flags :: enum i32 {
	None              = 0,
	NoAutoClosePopups = 1 << 0,
	SpanAllColumns    = 1 << 1,
	AllowDoubleClick  = 1 << 2,
	Disabled          = 1 << 3,
	AllowOverlap      = 1 << 4,
	Highlight         = 1 << 5,
}


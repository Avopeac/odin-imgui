package imgui_impl_win32

import "core:dynlib"
import "core:math"
import "core:sys/windows"

import imgui "../.."

// Constants for gamepad buttons
XINPUT_GAMEPAD_DPAD_UP :: 0x0001
XINPUT_GAMEPAD_DPAD_DOWN :: 0x0002
XINPUT_GAMEPAD_DPAD_LEFT :: 0x0004
XINPUT_GAMEPAD_DPAD_RIGHT :: 0x0008
XINPUT_GAMEPAD_START :: 0x0010
XINPUT_GAMEPAD_BACK :: 0x0020
XINPUT_GAMEPAD_LEFT_THUMB :: 0x0040
XINPUT_GAMEPAD_RIGHT_THUMB :: 0x0080
XINPUT_GAMEPAD_LEFT_SHOULDER :: 0x0100
XINPUT_GAMEPAD_RIGHT_SHOULDER :: 0x0200
XINPUT_GAMEPAD_A :: 0x1000
XINPUT_GAMEPAD_B :: 0x2000
XINPUT_GAMEPAD_X :: 0x4000
XINPUT_GAMEPAD_Y :: 0x8000

// Gamepad thresholds
XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE :: 7849
XINPUT_GAMEPAD_RIGHT_THUMB_DEADZONE :: 8689
XINPUT_GAMEPAD_TRIGGER_THRESHOLD :: 30

// Flags to pass to XInputGetCapabilities
XINPUT_FLAG_GAMEPAD :: 0x00000001

XInput_Gamepad :: struct {
	w_buttons:       windows.WORD,
	b_left_trigger:  windows.BYTE,
	b_right_trigger: windows.BYTE,
	s_thumb_lx:      windows.SHORT,
	s_thumb_ly:      windows.SHORT,
	s_thumb_rx:      windows.SHORT,
	s_thumb_ry:      windows.SHORT,
}

XInput_State :: struct {
	packet_number: windows.DWORD,
	gamepad:       XInput_Gamepad,
}

XInput_Vibration :: struct {
	w_left_motor_speed:  windows.WORD,
	w_right_motor_speed: windows.WORD,
}

XInput_Capabilities :: struct {
	type:      windows.BYTE,
	sub_type:  windows.BYTE,
	flags:     windows.WORD,
	gamepad:   XInput_Gamepad,
	vibration: XInput_Vibration,
}

foreign _ {
	xinput_get_state :: proc "stdcall" (user_index: windows.DWORD, state: ^XInput_State) -> windows.DWORD ---
	xinput_get_capabilities :: proc "stdcall" (user_index: windows.DWORD, flags: windows.DWORD, capabilities: ^XInput_Capabilities) -> windows.DWORD ---
}

foreign import user32 "system:User32.lib"
@(default_calling_convention = "system")
foreign user32 {
	GetMessageExtraInfo :: proc() -> windows.LPARAM ---
	IsWindowUnicode :: proc(hwnd: windows.HWND) -> windows.BOOL ---
}

Win32_Data :: struct {
	hwnd:                    windows.HWND,
	mouse_hwnd:              windows.HWND,
	mouse_tracked_area:      i32,
	mouse_buttons_down:      i32,
	time:                    i64,
	ticks_per_second:        i64,
	last_mouse_cursor:       imgui.Mouse_Cursor,
	keyboard_code_page:      u32,
	has_gamepad:             bool,
	want_update_has_gamepad: bool,
	xinput_dll:              dynlib.Library,
	xinput_get_capabilities: type_of(xinput_get_capabilities),
	xinput_get_state:        type_of(xinput_get_state),
}

@(private = "file")
get_backend_data :: proc() -> ^Win32_Data {
	if imgui.get_current_context() != nil {
		return cast(^Win32_Data)imgui.get_io().backend_platform_user_data
	}
	return nil
}

@(private = "file")
update_keyboard_code_page :: proc() {
	// Assume UTF-8
	bd := get_backend_data()
	bd.keyboard_code_page = windows.CP_UTF8
}

@(private = "file")
init_ex :: proc(hwnd: rawptr, platform_has_own_hdc: bool) -> bool {
	io := imgui.get_io()
	imgui.igDebugCheckVersionAndDataLayout(
		imgui.get_version(),
		size_of(imgui.IO),
		size_of(imgui.Style),
		size_of(imgui.Vec2),
		size_of(imgui.Vec4),
		size_of(imgui.Draw_Vert),
		size_of(imgui.Draw_Idx),
	)
	assert(io.backend_platform_user_data == nil, "Already initialized a platform backend!")

	perf_frequency, perf_counter: windows.INT64
	if !windows.QueryPerformanceFrequency(cast(^windows.LARGE_INTEGER)&perf_frequency) {
		return false
	}
	if !windows.QueryPerformanceCounter(cast(^windows.LARGE_INTEGER)&perf_counter) {
		return false
	}

	bd := new(Win32_Data)
	io.backend_platform_user_data = rawptr(bd)
	io.backend_platform_name = "imgui_impl_win32"
	io.backend_flags |= imgui.Backend_Flags.HasMouseCursors
	io.backend_flags |= imgui.Backend_Flags.HasSetMousePos

	bd.hwnd = cast(windows.HWND)hwnd
	bd.ticks_per_second = perf_frequency
	bd.time = perf_counter
	bd.last_mouse_cursor = imgui.Mouse_Cursor.Count
	update_keyboard_code_page()

	// Set platform dependent data in viewport
	main_viewport := imgui.get_main_viewport()
	main_viewport.platform_handle = rawptr(bd.hwnd)
	main_viewport.platform_handle_raw = rawptr(bd.hwnd)

	bd.want_update_has_gamepad = true
	xinput_dll_names := []string {
		"xinput1_4.dll",
		"xinput1_3.dll",
		"xinput9_1_0.dll",
		"xinput1_2.dll",
		"xinput1_1.dll",
	}
	for name in xinput_dll_names {
		dll, ok := dynlib.load_library(name)
		if ok {
			bd.xinput_dll = dll
			bd.xinput_get_capabilities =
			cast(type_of(bd.xinput_get_capabilities))dynlib.symbol_address(
				dll,
				"XInputGetCapabilities",
			)
			bd.xinput_get_state =
			cast(type_of(bd.xinput_get_state))dynlib.symbol_address(dll, "XInputGetState")
			break
		}
	}

	return true
}

init :: proc(hwnd: rawptr) -> bool {
	return init_ex(hwnd, false)
}

init_for_opengl :: proc(hwnd: rawptr) -> bool {
	return init_ex(hwnd, true)
}

shutdown :: proc() {
	bd := get_backend_data()
	assert(bd != nil, "No platform backend to shutdown, or already shutdown?")
	io := imgui.get_io()

	if bd.xinput_dll != nil {
		dynlib.unload_library(bd.xinput_dll)
	}

	io.backend_platform_name = nil
	io.backend_platform_user_data = nil
	io.backend_flags &~=
		imgui.Backend_Flags.HasMouseCursors |
		imgui.Backend_Flags.HasSetMousePos |
		imgui.Backend_Flags.HasGamepad
	free(bd)
}

@(private = "file")
update_mouse_cursor :: proc() -> bool {
	io := imgui.get_io()
	if (io.config_flags & imgui.Config_Flags.NoMouseCursorChange) != imgui.Config_Flags.None {
		return false
	}

	imgui_cursor := imgui.get_mouse_cursor()
	if imgui_cursor == imgui.Mouse_Cursor.None || io.mouse_draw_cursor {
		// Hide OS mouse cursor if imgui is drawing it or if it wants no cursor
		windows.SetCursor(nil)
	} else {
		// Show OS mouse cursor
		win32_cursor := windows.IDC_ARROW
		#partial switch imgui_cursor {
		case .Arrow:
			{win32_cursor = windows.IDC_ARROW}
		case .TextInput:
			{win32_cursor = windows.IDC_IBEAM}
		case .ResizeAll:
			{win32_cursor = windows.IDC_SIZEALL}
		case .ResizeEw:
			{win32_cursor = windows.IDC_SIZEWE}
		case .ResizeNs:
			{win32_cursor = windows.IDC_SIZENS}
		case .ResizeNesw:
			{win32_cursor = windows.IDC_SIZENESW}
		case .ResizeNwse:
			{win32_cursor = windows.IDC_SIZENWSE}
		case .Hand:
			{win32_cursor = windows.IDC_HAND}
		case .NotAllowed:
			{win32_cursor = windows.IDC_NO}
		}
		windows.SetCursor(windows.LoadCursorA(nil, win32_cursor))
	}

	return true
}

@(private = "file")
is_vk_down :: proc(vk: i32) -> bool {
	return u32(windows.GetKeyState(vk)) & u32(0x8000) != 0
}

@(private = "file")
add_key_event :: proc(key: imgui.Key, down: bool, native_keycode: i32, native_scancode: i32 = -1) {
	io := imgui.get_io()
	imgui.io_add_key_event(io, key, down)
	imgui.io_set_key_event_native_data(io, key, native_keycode, native_scancode) // To support legacy indexing (<1.87 user code)
}

@(private = "file")
process_key_events_workarounds :: proc() {
	// Left & right Shift keys: when both are pressed together, Windows tend to not generate the WM_KEYUP event for the first released one.
	if imgui.is_key_down(imgui.Key.LeftShift) && !is_vk_down(windows.VK_LSHIFT) {
		add_key_event(imgui.Key.LeftShift, false, windows.VK_LSHIFT)
	}
	if imgui.is_key_down(imgui.Key.RightShift) && !is_vk_down(windows.VK_RSHIFT) {
		add_key_event(imgui.Key.RightShift, false, windows.VK_RSHIFT)
	}
	// Sometimes WM_KEYUP for Win key is not passed down to the app (e.g. for Win+V on some setups, according to GLFW).
	if imgui.is_key_down(imgui.Key.LeftSuper) && !is_vk_down(windows.VK_LWIN) {
		add_key_event(imgui.Key.LeftSuper, false, windows.VK_LWIN)
	}
	if imgui.is_key_down(imgui.Key.RightSuper) && !is_vk_down(windows.VK_RWIN) {
		add_key_event(imgui.Key.RightSuper, false, windows.VK_RWIN)
	}
}

@(private = "file")
update_key_modifiers :: proc() {
	io := imgui.get_io()
	imgui.io_add_key_event(io, imgui.Key.ModCtrl, is_vk_down(windows.VK_CONTROL))
	imgui.io_add_key_event(io, imgui.Key.ModShift, is_vk_down(windows.VK_SHIFT))
	imgui.io_add_key_event(io, imgui.Key.ModAlt, is_vk_down(windows.VK_MENU))
	imgui.io_add_key_event(
		io,
		imgui.Key.ModSuper,
		is_vk_down(windows.VK_LWIN) | is_vk_down(windows.VK_RWIN),
	)
}

@(private = "file")
update_mouse_data :: proc() {
	bd := get_backend_data()
	io := imgui.get_io()
	assert(bd.hwnd != nil)

	focused_window := windows.GetForegroundWindow()
	is_app_focused := focused_window == bd.hwnd
	if is_app_focused {
		// (Optional) Set OS mouse position from Dear ImGui if requested (rarely used, only when ImGuiConfigFlags_NavEnableSetMousePos is enabled by user)
		if io.want_set_mouse_pos {
			pos: windows.POINT = {i32(io.mouse_pos.x), i32(io.mouse_pos.y)}
			if windows.ClientToScreen(bd.hwnd, &pos) {
				windows.SetCursorPos(pos.x, pos.y)
			}
		}

		// (Optional) Fallback to provide mouse position when focused (WM_MOUSEMOVE already provides this when hovered or captured)
		// This also fills a short gap when clicking non-client area: WM_NCMOUSELEAVE -> modal OS move -> gap -> WM_NCMOUSEMOVE
		if !io.want_set_mouse_pos && bd.mouse_tracked_area == 0 {
			pos: windows.POINT
			if windows.GetCursorPos(&pos) && windows.ScreenToClient(bd.hwnd, &pos) {
				imgui.io_add_mouse_pos_event(io, f32(pos.x), f32(pos.y))
			}
		}
	}
}

@(private = "file")
map_button :: proc(io: ^imgui.IO, gamepad: ^XInput_Gamepad, key: imgui.Key, button_enum: int) {
	imgui.io_add_key_event(io, key, (gamepad.w_buttons & u16(button_enum & 0xffff)) != 0)
}

@(private = "file")
map_analog :: proc(io: ^imgui.IO, key: imgui.Key, value, v0, v1: int) {
	vn := f32(value - v0) / f32(v1 - v0)
	imgui.io_add_key_analog_event(io, key, vn > 0.10, math.saturate(vn))
}


@(private = "file")
update_gamepads :: proc() {
	io := imgui.get_io()
	bd := get_backend_data()
	// Calling XInputGetState() every frame on disconnected gamepads is unfortunately too slow.
	// Instead we refresh gamepad availability by calling XInputGetCapabilities() _only_ after receiving WM_DEVICECHANGE.
	if bd.want_update_has_gamepad {
		caps: XInput_Capabilities
		bd.has_gamepad =
			bd.xinput_get_capabilities != nil ? bd.xinput_get_capabilities(0, XINPUT_FLAG_GAMEPAD, &caps) == windows.ERROR_SUCCESS : false
		bd.want_update_has_gamepad = false
	}

	io.backend_flags &~= imgui.Backend_Flags.HasGamepad
	xinput_state: XInput_State
	gamepad := &xinput_state.gamepad
	if bd.has_gamepad ||
	   bd.xinput_get_state == nil ||
	   bd.xinput_get_state(0, &xinput_state) != windows.ERROR_SUCCESS {
		return
	}
	io.backend_flags |= imgui.Backend_Flags.HasGamepad
	map_button(io, gamepad, imgui.Key.GamepadStart, XINPUT_GAMEPAD_START)
	map_button(io, gamepad, imgui.Key.GamepadBack, XINPUT_GAMEPAD_BACK)
	map_button(io, gamepad, imgui.Key.GamepadFaceLeft, XINPUT_GAMEPAD_X)
	map_button(io, gamepad, imgui.Key.GamepadFaceRight, XINPUT_GAMEPAD_B)
	map_button(io, gamepad, imgui.Key.GamepadFaceUp, XINPUT_GAMEPAD_Y)
	map_button(io, gamepad, imgui.Key.GamepadFaceDown, XINPUT_GAMEPAD_A)
	map_button(io, gamepad, imgui.Key.GamepadDpadLeft, XINPUT_GAMEPAD_DPAD_LEFT)
	map_button(io, gamepad, imgui.Key.GamepadDpadRight, XINPUT_GAMEPAD_DPAD_RIGHT)
	map_button(io, gamepad, imgui.Key.GamepadDpadUp, XINPUT_GAMEPAD_DPAD_UP)
	map_button(io, gamepad, imgui.Key.GamepadDpadDown, XINPUT_GAMEPAD_DPAD_DOWN)
	map_button(io, gamepad, imgui.Key.GamepadL1, XINPUT_GAMEPAD_LEFT_SHOULDER)
	map_button(io, gamepad, imgui.Key.GamepadR1, XINPUT_GAMEPAD_RIGHT_SHOULDER)
	map_analog(
		io,
		imgui.Key.GamepadL2,
		int(gamepad.b_left_trigger),
		XINPUT_GAMEPAD_TRIGGER_THRESHOLD,
		255,
	)
	map_analog(
		io,
		imgui.Key.GamepadR2,
		int(gamepad.b_right_trigger),
		XINPUT_GAMEPAD_TRIGGER_THRESHOLD,
		255,
	)
	map_button(io, gamepad, imgui.Key.GamepadL3, XINPUT_GAMEPAD_LEFT_THUMB)
	map_button(io, gamepad, imgui.Key.GamepadR3, XINPUT_GAMEPAD_RIGHT_THUMB)
	map_analog(
		io,
		imgui.Key.GamepadLstickLeft,
		int(gamepad.s_thumb_lx),
		-XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		-32768,
	)
	map_analog(
		io,
		imgui.Key.GamepadLstickRight,
		int(gamepad.s_thumb_lx),
		+XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		+32767,
	)
	map_analog(
		io,
		imgui.Key.GamepadLstickUp,
		int(gamepad.s_thumb_ly),
		+XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		+32767,
	)
	map_analog(
		io,
		imgui.Key.GamepadLstickDown,
		int(gamepad.s_thumb_ly),
		-XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		-32768,
	)
	map_analog(
		io,
		imgui.Key.GamepadRstickLeft,
		int(gamepad.s_thumb_rx),
		-XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		-32768,
	)
	map_analog(
		io,
		imgui.Key.GamepadRstickRight,
		int(gamepad.s_thumb_rx),
		+XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		+32767,
	)
	map_analog(
		io,
		imgui.Key.GamepadRstickUp,
		int(gamepad.s_thumb_ry),
		+XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		+32767,
	)
	map_analog(
		io,
		imgui.Key.GamepadRstickDown,
		int(gamepad.s_thumb_ry),
		-XINPUT_GAMEPAD_LEFT_THUMB_DEADZONE,
		-32768,
	)
}

new_frame :: proc() {
	bd := get_backend_data()
	assert(bd != nil, "Context or backend not initialized? Did you call init()?")
	io := imgui.get_io()

	// Setup display size (every frame to accommodate for window resizing)
	rect: windows.RECT
	windows.GetClientRect(bd.hwnd, &rect)
	io.display_size = {f32(rect.right - rect.left), f32(rect.bottom - rect.top)}

	// Setup time step
	current_time: windows.INT64
	windows.QueryPerformanceCounter(cast(^windows.LARGE_INTEGER)&current_time)
	io.delta_time = f32(current_time - bd.time) / f32(bd.ticks_per_second)
	bd.time = current_time

	// Update OS mouse position
	update_mouse_data()

	// Process workarounds for known Windows key handling issues
	process_key_events_workarounds()

	// Update OS mouse cursor with the cursor requested by imgui
	mouse_cursor := io.mouse_draw_cursor ? imgui.Mouse_Cursor.None : imgui.get_mouse_cursor()
	if bd.last_mouse_cursor != mouse_cursor {
		bd.last_mouse_cursor = mouse_cursor
		update_mouse_cursor()
	}

	// Update game controllers (if enabled and available)
	update_gamepads()
}

// Map VK_xxx to ImGuiKey_xxx.
key_event_to_imgui_key :: proc(w_param: windows.WPARAM, l_param: windows.LPARAM) -> imgui.Key {

	// There is no distinct VK_xxx for keypad enter, instead it is VK_RETURN + KF_EXTENDED.
	if w_param == windows.VK_RETURN && (windows.HIWORD(l_param) & windows.KF_EXTENDED) != 0 {
		return imgui.Key.Enter
	}

	switch w_param {
	case windows.VK_TAB:
		return imgui.Key.Tab
	case windows.VK_LEFT:
		return imgui.Key.LeftArrow
	case windows.VK_RIGHT:
		return imgui.Key.RightArrow
	case windows.VK_UP:
		return imgui.Key.UpArrow
	case windows.VK_DOWN:
		return imgui.Key.DownArrow
	case windows.VK_PRIOR:
		return imgui.Key.PageUp
	case windows.VK_NEXT:
		return imgui.Key.PageDown
	case windows.VK_HOME:
		return imgui.Key.Home
	case windows.VK_END:
		return imgui.Key.End
	case windows.VK_INSERT:
		return imgui.Key.Insert
	case windows.VK_DELETE:
		return imgui.Key.Delete
	case windows.VK_BACK:
		return imgui.Key.Backspace
	case windows.VK_SPACE:
		return imgui.Key.Space
	case windows.VK_RETURN:
		return imgui.Key.Enter
	case windows.VK_ESCAPE:
		return imgui.Key.Escape
	case windows.VK_OEM_7:
		return imgui.Key.Apostrophe
	case windows.VK_OEM_COMMA:
		return imgui.Key.Comma
	case windows.VK_OEM_MINUS:
		return imgui.Key.Minus
	case windows.VK_OEM_PERIOD:
		return imgui.Key.Period
	case windows.VK_OEM_2:
		return imgui.Key.Slash
	case windows.VK_OEM_1:
		return imgui.Key.Semicolon
	case windows.VK_OEM_PLUS:
		return imgui.Key.Equal
	case windows.VK_OEM_4:
		return imgui.Key.LeftBracket
	case windows.VK_OEM_5:
		return imgui.Key.Backslash
	case windows.VK_OEM_6:
		return imgui.Key.RightBracket
	case windows.VK_OEM_3:
		return imgui.Key.GraveAccent
	case windows.VK_CAPITAL:
		return imgui.Key.CapsLock
	case windows.VK_SCROLL:
		return imgui.Key.ScrollLock
	case windows.VK_NUMLOCK:
		return imgui.Key.NumLock
	case windows.VK_SNAPSHOT:
		return imgui.Key.PrintScreen
	case windows.VK_PAUSE:
		return imgui.Key.Pause
	case windows.VK_NUMPAD0:
		return imgui.Key.Keypad0
	case windows.VK_NUMPAD1:
		return imgui.Key.Keypad1
	case windows.VK_NUMPAD2:
		return imgui.Key.Keypad2
	case windows.VK_NUMPAD3:
		return imgui.Key.Keypad3
	case windows.VK_NUMPAD4:
		return imgui.Key.Keypad4
	case windows.VK_NUMPAD5:
		return imgui.Key.Keypad5
	case windows.VK_NUMPAD6:
		return imgui.Key.Keypad6
	case windows.VK_NUMPAD7:
		return imgui.Key.Keypad7
	case windows.VK_NUMPAD8:
		return imgui.Key.Keypad8
	case windows.VK_NUMPAD9:
		return imgui.Key.Keypad9
	case windows.VK_DECIMAL:
		return imgui.Key.KeypadDecimal
	case windows.VK_DIVIDE:
		return imgui.Key.KeypadDivide
	case windows.VK_MULTIPLY:
		return imgui.Key.KeypadMultiply
	case windows.VK_SUBTRACT:
		return imgui.Key.KeypadSubtract
	case windows.VK_ADD:
		return imgui.Key.KeypadAdd
	case windows.VK_LSHIFT:
		return imgui.Key.LeftShift
	case windows.VK_LCONTROL:
		return imgui.Key.LeftCtrl
	case windows.VK_LMENU:
		return imgui.Key.LeftAlt
	case windows.VK_LWIN:
		return imgui.Key.LeftSuper
	case windows.VK_RSHIFT:
		return imgui.Key.RightShift
	case windows.VK_RCONTROL:
		return imgui.Key.RightCtrl
	case windows.VK_RMENU:
		return imgui.Key.RightAlt
	case windows.VK_RWIN:
		return imgui.Key.RightSuper
	case windows.VK_APPS:
		return imgui.Key.Menu
	case '0':
		return imgui.Key._0
	case '1':
		return imgui.Key._1
	case '2':
		return imgui.Key._2
	case '3':
		return imgui.Key._3
	case '4':
		return imgui.Key._4
	case '5':
		return imgui.Key._5
	case '6':
		return imgui.Key._6
	case '7':
		return imgui.Key._7
	case '8':
		return imgui.Key._8
	case '9':
		return imgui.Key._9
	case 'A':
		return imgui.Key.A
	case 'B':
		return imgui.Key.B
	case 'C':
		return imgui.Key.C
	case 'D':
		return imgui.Key.D
	case 'E':
		return imgui.Key.E
	case 'F':
		return imgui.Key.F
	case 'G':
		return imgui.Key.G
	case 'H':
		return imgui.Key.H
	case 'I':
		return imgui.Key.I
	case 'J':
		return imgui.Key.J
	case 'K':
		return imgui.Key.K
	case 'L':
		return imgui.Key.L
	case 'M':
		return imgui.Key.M
	case 'N':
		return imgui.Key.N
	case 'O':
		return imgui.Key.O
	case 'P':
		return imgui.Key.P
	case 'Q':
		return imgui.Key.Q
	case 'R':
		return imgui.Key.R
	case 'S':
		return imgui.Key.S
	case 'T':
		return imgui.Key.T
	case 'U':
		return imgui.Key.U
	case 'V':
		return imgui.Key.V
	case 'W':
		return imgui.Key.W
	case 'X':
		return imgui.Key.X
	case 'Y':
		return imgui.Key.Y
	case 'Z':
		return imgui.Key.Z
	case windows.VK_F1:
		return imgui.Key.F1
	case windows.VK_F2:
		return imgui.Key.F2
	case windows.VK_F3:
		return imgui.Key.F3
	case windows.VK_F4:
		return imgui.Key.F4
	case windows.VK_F5:
		return imgui.Key.F5
	case windows.VK_F6:
		return imgui.Key.F6
	case windows.VK_F7:
		return imgui.Key.F7
	case windows.VK_F8:
		return imgui.Key.F8
	case windows.VK_F9:
		return imgui.Key.F9
	case windows.VK_F10:
		return imgui.Key.F10
	case windows.VK_F11:
		return imgui.Key.F11
	case windows.VK_F12:
		return imgui.Key.F12
	case windows.VK_F13:
		return imgui.Key.F13
	case windows.VK_F14:
		return imgui.Key.F14
	case windows.VK_F15:
		return imgui.Key.F15
	case windows.VK_F16:
		return imgui.Key.F16
	case windows.VK_F17:
		return imgui.Key.F17
	case windows.VK_F18:
		return imgui.Key.F18
	case windows.VK_F19:
		return imgui.Key.F19
	case windows.VK_F20:
		return imgui.Key.F20
	case windows.VK_F21:
		return imgui.Key.F21
	case windows.VK_F22:
		return imgui.Key.F22
	case windows.VK_F23:
		return imgui.Key.F23
	case windows.VK_F24:
		return imgui.Key.F24
	case windows.VK_BROWSER_BACK:
		return imgui.Key.AppBack
	case windows.VK_BROWSER_FORWARD:
		return imgui.Key.AppForward
	}

	return imgui.Key.None
}

DBT_DEVNODES_CHANGE :: 0x0007
MB_PRECOMPOSED :: 0x00000001

// See https://learn.microsoft.com/en-us/windows/win32/tablet/system-events-and-mouse-messages
// Prefer to call this at the top of the message handler to avoid the possibility of other Win32 calls interfering with this.
@(private = "file")
get_mouse_source_from_message_extra_info :: proc() -> imgui.Mouse_Source {
	extra_info := GetMessageExtraInfo()
	if (extra_info & 0xFFFFFF80) == 0xFF515700 {
		return imgui.Mouse_Source.Pen
	}
	if (extra_info & 0xFFFFFF80) == 0xFF515780 {
		return imgui.Mouse_Source.TouchScreen
	}
	return imgui.Mouse_Source.Mouse
}

// Win32 message handler (process Win32 mouse/keyboard inputs, etc.)
// Call from your application's message handler. Keep calling your message handler unless this function returns TRUE.
// When implementing your own backend, you can read the io.WantCaptureMouse, io.WantCaptureKeyboard flags to tell if Dear ImGui wants to use your inputs.
// - When io.WantCaptureMouse is true, do not dispatch mouse input data to your main application, or clear/overwrite your copy of the mouse data.
// - When io.WantCaptureKeyboard is true, do not dispatch keyboard input data to your main application, or clear/overwrite your copy of the keyboard data.
// Generally you may always pass all inputs to Dear ImGui, and hide them from your application based on those two flags.
// PS: In this Win32 handler, we use the capture API (GetCapture/SetCapture/ReleaseCapture) to be able to read mouse coordinates when dragging mouse outside of our window bounds.
// PS: We treat DBLCLK messages as regular mouse down messages, so this code will work on windows classes that have the CS_DBLCLKS flag set. Our own example app code doesn't set this flag.
wnd_proc_handler :: proc(
	hwnd: windows.HWND,
	msg: windows.UINT,
	w_param: windows.WPARAM,
	l_param: windows.LPARAM,
) -> windows.LRESULT {
	// Most backends don't have silent checks like this one, but we need it because WndProc are called early in CreateWindow().
	// We silently allow both context or just only backend data to be nullptr.
	bd := get_backend_data()
	if bd == nil {
		return 0
	}

	io := imgui.get_io()
	switch msg {
	case windows.WM_MOUSEMOVE, windows.WM_NCMOUSEMOVE:
		// We need to call TrackMouseEvent in order to receive WM_MOUSELEAVE events
		mouse_source := get_mouse_source_from_message_extra_info()
		area: i32 = (msg == windows.WM_MOUSEMOVE) ? 1 : 2
		bd.mouse_hwnd = hwnd
		if bd.mouse_tracked_area != area {
			tme_cancel: windows.TRACKMOUSEEVENT = {
				size_of(windows.TRACKMOUSEEVENT),
				windows.TME_CANCEL,
				hwnd,
				0,
			}
			tme_track: windows.TRACKMOUSEEVENT = {
				size_of(windows.TRACKMOUSEEVENT),
				cast(windows.DWORD)(area == 2 ? (windows.TME_LEAVE | windows.TME_NONCLIENT) : windows.TME_LEAVE),
				hwnd,
				0,
			}
			if bd.mouse_tracked_area != 0 {
				windows.TrackMouseEvent(&tme_cancel)
			}
			windows.TrackMouseEvent(&tme_track)
			bd.mouse_tracked_area = area
		}
		mouse_pos: windows.POINT = {
			cast(windows.LONG)windows.GET_X_LPARAM(l_param),
			cast(windows.LONG)windows.GET_Y_LPARAM(l_param),
		}
		// WM_NCMOUSEMOVE are provided in absolute coordinates.
		if msg == windows.WM_NCMOUSEMOVE &&
		   windows.ScreenToClient(hwnd, &mouse_pos) == windows.FALSE {
			return 0
		}
		imgui.io_add_mouse_source_event(io, mouse_source)
		imgui.io_add_mouse_pos_event(io, f32(mouse_pos.x), f32(mouse_pos.y))
		return 0
	case windows.WM_MOUSELEAVE, windows.WM_NCMOUSELEAVE:
		area: i32 = (msg == windows.WM_MOUSELEAVE) ? 1 : 2
		if bd.mouse_tracked_area == area {
			if bd.mouse_hwnd == hwnd {
				bd.mouse_hwnd = nil
			}
			bd.mouse_tracked_area = 0
			imgui.io_add_mouse_pos_event(io, -math.F32_MAX, -math.F32_MAX)
		}
		return 0
	case windows.WM_DESTROY:
		if bd.mouse_hwnd == hwnd && bd.mouse_tracked_area != 0 {
			tme_cancel: windows.TRACKMOUSEEVENT = {
				size_of(windows.TRACKMOUSEEVENT),
				windows.TME_CANCEL,
				hwnd,
				0,
			}
			windows.TrackMouseEvent(&tme_cancel)
			bd.mouse_hwnd = nil
			bd.mouse_tracked_area = 0
			imgui.io_add_mouse_pos_event(io, -math.F32_MAX, -math.F32_MAX)
		}
		return 0
	case windows.WM_LBUTTONDOWN,
	     windows.WM_LBUTTONDBLCLK,
	     windows.WM_RBUTTONDOWN,
	     windows.WM_RBUTTONDBLCLK,
	     windows.WM_MBUTTONDOWN,
	     windows.WM_MBUTTONDBLCLK,
	     windows.WM_XBUTTONDOWN,
	     windows.WM_XBUTTONDBLCLK:
		mouse_source := get_mouse_source_from_message_extra_info()
		button: i32 = 0
		if msg == windows.WM_LBUTTONDOWN || msg == windows.WM_LBUTTONDBLCLK do button = 0
		if msg == windows.WM_RBUTTONDOWN || msg == windows.WM_RBUTTONDBLCLK do button = 1
		if msg == windows.WM_MBUTTONDOWN || msg == windows.WM_MBUTTONDBLCLK do button = 2
		if msg == windows.WM_XBUTTONDOWN || msg == windows.WM_XBUTTONDBLCLK do button = (windows.GET_XBUTTON_WPARAM(w_param) == windows.XBUTTON1 ? 3 : 4)
		if bd.mouse_buttons_down == 0 && windows.GetCapture() == nil {
			windows.SetCapture(hwnd)
		}
		bd.mouse_buttons_down |= 1 << u32(button)
		imgui.io_add_mouse_source_event(io, mouse_source)
		imgui.io_add_mouse_button_event(io, button, true)
		return 0
	case windows.WM_LBUTTONUP, windows.WM_RBUTTONUP, windows.WM_MBUTTONUP, windows.WM_XBUTTONUP:
		mouse_source := get_mouse_source_from_message_extra_info()
		button: i32 = 0
		if msg == windows.WM_LBUTTONUP do button = 0
		if msg == windows.WM_RBUTTONUP do button = 1
		if msg == windows.WM_MBUTTONUP do button = 2
		if msg == windows.WM_XBUTTONUP do button = (windows.GET_XBUTTON_WPARAM(w_param) == windows.XBUTTON1) ? 3 : 4
		bd.mouse_buttons_down &~= 1 << u32(button)
		if bd.mouse_buttons_down == 0 && windows.GetCapture() == hwnd {
			windows.ReleaseCapture()
		}
		imgui.io_add_mouse_source_event(io, mouse_source)
		imgui.io_add_mouse_button_event(io, button, false)
		return 0
	case windows.WM_MOUSEWHEEL:
		imgui.io_add_mouse_wheel_event(
			io,
			0.0,
			f32(windows.GET_WHEEL_DELTA_WPARAM(w_param)) / f32(windows.WHEEL_DELTA),
		)
		return 0
	case windows.WM_MOUSEHWHEEL:
		imgui.io_add_mouse_wheel_event(
			io,
			-f32(windows.GET_WHEEL_DELTA_WPARAM(w_param)) / f32(windows.WHEEL_DELTA),
			0.0,
		)
		return 0
	case windows.WM_KEYDOWN, windows.WM_KEYUP, windows.WM_SYSKEYDOWN, windows.WM_SYSKEYUP:
		is_key_down := (msg == windows.WM_KEYDOWN || msg == windows.WM_SYSKEYDOWN)
		if w_param < 256 {
			// Submit modifiers
			update_key_modifiers()

			// Obtain virtual key code and convert to ImGuiKey
			key := key_event_to_imgui_key(w_param, l_param)
			vk := i32(w_param)
			scancode := i32(windows.LOBYTE(windows.HIWORD(l_param)))

			// Special behavior for VK_SNAPSHOT / ImGuiKey_PrintScreen as Windows doesn't emit the key down event.
			if key == imgui.Key.PrintScreen && !is_key_down {
				add_key_event(key, true, vk, scancode)
			}

			// Submit key event
			if key != imgui.Key.None {
				add_key_event(key, is_key_down, vk, scancode)
			}

			// Submit individual left/right modifier events
			if vk == windows.VK_SHIFT {
				// Important: Shift keys tend to get stuck when pressed together, missing key-up events are corrected in ImGui_ImplWin32_ProcessKeyEventsWorkarounds()
				if is_vk_down(windows.VK_LSHIFT) ==
				   is_key_down {add_key_event(imgui.Key.LeftShift, is_key_down, windows.VK_LSHIFT, scancode)}
				if is_vk_down(windows.VK_RSHIFT) ==
				   is_key_down {add_key_event(imgui.Key.RightShift, is_key_down, windows.VK_RSHIFT, scancode)}
			} else if vk == windows.VK_CONTROL {
				if is_vk_down(windows.VK_LCONTROL) ==
				   is_key_down {add_key_event(imgui.Key.LeftCtrl, is_key_down, windows.VK_LCONTROL, scancode)}
				if is_vk_down(windows.VK_RCONTROL) ==
				   is_key_down {add_key_event(imgui.Key.RightCtrl, is_key_down, windows.VK_RCONTROL, scancode)}
			} else if (vk == windows.VK_MENU) {
				if is_vk_down(windows.VK_LMENU) ==
				   is_key_down {add_key_event(imgui.Key.LeftAlt, is_key_down, windows.VK_LMENU, scancode)}
				if is_vk_down(windows.VK_RMENU) ==
				   is_key_down {add_key_event(imgui.Key.RightAlt, is_key_down, windows.VK_RMENU, scancode)}
			}
		}
		return 0
	case windows.WM_SETFOCUS, windows.WM_KILLFOCUS:
		imgui.io_add_focus_event(io, msg == windows.WM_SETFOCUS)
		return 0
	case windows.WM_INPUTLANGCHANGE:
		update_keyboard_code_page()
		return 0
	case windows.WM_CHAR:
		if IsWindowUnicode(hwnd) {
			// You can also use ToAscii()+GetKeyboardState() to retrieve characters.
			if w_param > 0 && w_param < 0x10000 {
				imgui.io_add_input_character_utf16(io, imgui.Wchar16(w_param))
			}
		} else {
			wch: windows.wchar_t
			windows.MultiByteToWideChar(
				bd.keyboard_code_page,
				MB_PRECOMPOSED,
				cast(^u8)w_param,
				1,
				&wch,
				1,
			)
			imgui.io_add_input_character(io, u32(wch))
		}
		return 0
	case windows.WM_SETCURSOR:
		// This is required to restore cursor when transitioning from e.g resize borders to client area.
		if windows.LOWORD(l_param) == windows.HTCLIENT && update_mouse_cursor() {
			return 1
		}
		return 0

	case windows.WM_DEVICECHANGE:
		if u32(w_param) == DBT_DEVNODES_CHANGE {
			bd.want_update_has_gamepad = true
		}
		return 0
	}
	return 0
}

//--------------------------------------------------------------------------------------------------------
// DPI-related helpers (optional)
// Assume Windows 10 or greated
//--------------------------------------------------------------------------------------------------------
enable_dpi_awareness :: proc() {
	windows.SetThreadDpiAwarenessContext(windows.DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2)
}

get_dpi_scale_for_monitor :: proc(monitor: rawptr) -> f32 {
	xdpi: windows.UINT = 96
	ydpi: windows.UINT = 96
	windows.GetDpiForMonitor(
		cast(windows.HMONITOR)monitor,
		windows.MONITOR_DPI_TYPE.MDT_EFFECTIVE_DPI,
		&xdpi,
		&ydpi,
	)
	assert(xdpi == ydpi)
	return f32(xdpi) / 96.0
}

get_dpi_scale_for_hwnd :: proc(hwnd: rawptr) -> f32 {
	monitor := windows.MonitorFromWindow(
		cast(windows.HWND)hwnd,
		windows.Monitor_From_Flags.MONITOR_DEFAULTTONEAREST,
	)
	return get_dpi_scale_for_monitor(monitor)
}

//---------------------------------------------------------------------------------------------------------
// Transparency related helpers (optional)
//--------------------------------------------------------------------------------------------------------
enable_alpha_compositing :: proc(hwnd: rawptr) {
	// Don't care
}
